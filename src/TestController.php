<?php

class TestController
{
    private PDO $conn;

    public function __construct(Database $database)
    {
        $this->conn = $database->getConnection();
    }

    public function processRequest(string $http_req_type, string $method): void
    {
        $method = explode("?", $method)[0];

        if ($http_req_type == 'GET') {
            switch ($method) {
                case "/test/validate":
                    echo json_encode($this->getByCode($_GET["value"]));
                    break;
                case "/test/generate":
                    echo json_encode($this->getRandomizedQuestions($_GET["value"]));
                    break;
                default:
                    http_response_code(501);
                    exit;
            }
        }
        if ($http_req_type == 'PUT') {
            $id = explode("/", $method)[3];
            $method = "/" . explode("/", $method)[1] . "/" . explode("/", $method)[2];
            switch ($method) {
                case "/test/right-answer": {
                    echo json_encode($this->setRightAnswer($id));
                    break;
                }
                case "/test/wrong-answer": {
                    echo json_encode($this->setWrongAnswer($id));
                    break;
                }
                case "/test/oot": {
                    echo json_encode($this->setOOT($id));
                    break;
                }
                case "/test/finished": {
                    echo json_encode($this->setFinished($id));
                    break;
                }
                default:
                    http_response_code(501);
                    exit;
            }
        }
    }

    private function getByCode(string $code): array|false
    {
        $sql = "SELECT * FROM tests
        WHERE CODE = ?
        AND FINISHED = 0";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$code]);

        $data = false;

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if($row) {
            $data = [];
            $data["id"] = $row["ID"];
            $data["code"] = $row["CODE"];
            $data["right"] = $row["RIGHT"];
            $data["wrong"] = $row["WRONG"];
            $data["created"] = $row["CREATED"];
            $data["oot"] = (bool) $row["OOT"];
            $data["finished"] = (bool) $row["FINISHED"];
            $data["time"] = $row["TIME"];
            $data["question_nb"] = $row["QUESTION_NB"];
        }

        return $data;
    }

    private function getRandomizedQuestions(int $count): array
    {
        $sql = "SELECT RQ.ID, RQ.DESCRIPTION AS QUESTION, RQ.IMAGE AS IMAGE, A.DESCRIPTION AS ANSWER, A.VARIANT AS VARIANT, A.IS_RIGHT FROM (SELECT * FROM questions ORDER BY RAND() LIMIT ? ) AS RQ JOIN answers AS A ON RQ.ID = A.QUESTION_ID ORDER BY A.VARIANT";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$count]);

        $data = [];

        while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            if (!isset($data[$row["ID"]]["correctAnswer"])) {
                $data[$row["ID"]]["correctAnswer"] = "";
            }
            if($row["IMAGE"]) {
                $data[$row["ID"]]["image"] = $row["IMAGE"];
            }
            $data[$row["ID"]]["id"] = $row["ID"];
            $data[$row["ID"]]["question"] = $row["QUESTION"];
            $data[$row["ID"]]["answers"][$row["VARIANT"]] = $row["ANSWER"];
            $data[$row["ID"]]["correctAnswer"] = $row["IS_RIGHT"] ? $data[$row["ID"]]["correctAnswer"].$row["VARIANT"] : $data[$row["ID"]]["correctAnswer"];
        }

        return array_values($data);
    }

    private function setRightAnswer(int $id): bool
    {
        $sql = "UPDATE tests T SET T.RIGHT = T.RIGHT + 1 WHERE ID = ?";

        $stmt = $this->conn->prepare($sql);
        
        return $stmt->execute([$id]);
    }

    private function setWrongAnswer(int $id): bool
    {
        $sql = "UPDATE tests T SET T.WRONG = T.WRONG + 1 WHERE ID = ?";

        $stmt = $this->conn->prepare($sql);
        
        return $stmt->execute([$id]);
    }

    private function setOOT(int $id): bool
    {
        $sql = "UPDATE tests T SET T.OOT = 1 WHERE ID = ?";

        $stmt = $this->conn->prepare($sql);
        
        return $stmt->execute([$id]);
    }

    private function setFinished(int $id): bool
    {
        $sql = "UPDATE tests T SET T.FINISHED = 1 WHERE ID = ?";

        $stmt = $this->conn->prepare($sql);
        
        return $stmt->execute([$id]);
    }
}
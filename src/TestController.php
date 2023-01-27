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
        if ($http_req_type == 'GET') {
            $method = explode("?", $method)[0];
            switch ($method) {
                case "/test/code":
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
    }

    private function getByCode(string $code)
    {
        $sql = "SELECT * FROM tests
        WHERE CODE='$code'
        AND FINISHED=0";

        $stmt = $this->conn->query($sql);

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
        }

        return $data;
    }

    private function getRandomizedQuestions(int $count): array
    {
        $sql = "SELECT RQ.ID, RQ.DESCRIPTION AS QUESTION, RQ.IMAGE AS IMAGE, A.DESCRIPTION AS ANSWER, A.VARIANT AS VARIANT, A.IS_RIGHT FROM (SELECT * FROM questions ORDER BY RAND() LIMIT $count) AS RQ JOIN answers AS A ON RQ.ID = A.QUESTION_ID ORDER BY A.VARIANT";


        $stmt = $this->conn->query($sql);

        $data = [];

        while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            if (!isset($data[$row["ID"]]["correctAnswer"])) {
                $data[$row["ID"]]["correctAnswer"] = "";
            }
            $data[$row["ID"]]["id"] = $row["ID"];
            $data[$row["ID"]]["question"] = $row["QUESTION"];
            $data[$row["ID"]]["answers"][$row["VARIANT"]] = $row["ANSWER"];
            $data[$row["ID"]]["correctAnswer"] = $row["IS_RIGHT"] ? $data[$row["ID"]]["correctAnswer"].$row["VARIANT"] : $data[$row["ID"]]["correctAnswer"];
        }

        return $data;
    }
}
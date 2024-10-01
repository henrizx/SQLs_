SELECT 
A.CODUSUR,
E.NOME,
A.CODCLI,
C.FANTASIA,
D.NOMECIDADE,
TRUNC (SUM(A.QT * A.PVENDA),2) AS VALOR,
CASE
    WHEN G.CODFORNEC = 550969 THEN 'PRAT�S / AGROPRATINHA '
    WHEN G.CODFORNEC = 551492 THEN 'AQUA / DD GASPAR'
    WHEN G.CODFORNEC = 551779 THEN 'PRODUTOS BALY / BEBIDAS GRASSI' 
    ELSE
    G.FORNECEDOR END AS FORNECEDOR,
:DATAI AS data_inicio,
:DATAF AS data_final


FROM PCPEDI A
JOIN PCPEDC B  ON A.NUMPED = B.NUMPED
LEFT JOIN PCCLIENT C ON C.CODCLI = B.CODCLI 
LEFT JOIN PCCIDADE D ON D.CODCIDADE = C.CODCIDADE
LEFT JOIN PCUSUARI E ON E.CODUSUR = A.CODUSUR 
LEFT JOIN PCPRODUT F ON F.CODPROD = A.CODPROD
JOIN PCFORNEC G ON G.CODFORNEC = F.CODFORNEC

WHERE B.CONDVENDA IN (1,14)
AND B.CODUSUR = :RCA
AND A.DATA BETWEEN :DATAI AND :DATAF
--AND A.DATA = TRUNC(SYSDATE)
AND G.CODFORNEC IN (551779,550969,551492)


GROUP BY
A.CODUSUR,
E.NOME,
A.CODCLI,
C.FANTASIA,
D.NOMECIDADE,
G.CODFORNEC,
G.FORNECEDOR

ORDER BY
A.CODUSUR DESC,
G.CODFORNEC,
VALOR DESC
-- Qual é o nome do professor que ministra a disciplina com código "BD201"?

select professores.nome, disciplinas.codigo_disciplina from disciplinas 
INNER JOIN turmas ON disciplinas.disciplina_id = turmas.disciplina_id
INNER JOIN professores ON turmas.professor_id = professores.professor_id
WHERE codigo_disciplina = 'BD201';

-- Para a disciplina com código "PC101", obtenha a lista de alunos que obtiveram notas maiores que 80.

select disciplinas.codigo_disciplina, alunos.nome, notas.nota from notas
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id
INNER JOIN alunos ON notas.aluno_id = alunos.aluno_id
WHERE notas.nota > 80 AND disciplinas.codigo_disciplina = 'PC101';

-- Quais alunos estiveram presentes na aula da turma com ID 101 na data '2023-03-10'?

select alunos.nome, turmas.turma_id, presenca.data_aula from presenca
INNER JOIN turmas ON presenca.turma_id = turmas.turma_id
INNER JOIN alunos ON presenca.aluno_id = alunos.aluno_id
WHERE presenca.turma_id = 101 AND data_aula = '2023-03-10';

-- Calcule a média das notas dos alunos na disciplina com código "IA501".

select disciplinas.codigo_disciplina, AVG(notas.nota) from notas
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id
WHERE disciplinas.codigo_disciplina = 'IA501';

-- Liste todos os alunos e as disciplinas que eles estão matriculados. Inclua os alunos que não estão matriculados em nenhuma disciplina.

select alunos.nome, disciplinas.nome_disciplina from notas
RIGHT JOIN alunos ON notas.aluno_id = alunos.aluno_id
RIGHT JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id;

-- Liste todos os alunos que não têm notas registradas.

SELECT alunos.nome, notas.nota from notas
INNER JOIN alunos ON notas.aluno_id = alunos.aluno_id
WHERE notas.nota is null;

-- Quais disciplinas têm menos de 40 horas de carga horária ou mais de 100 horas de carga horária?

select disciplinas.nome_disciplina, disciplinas.carga_horaria from disciplinas
where disciplinas.carga_horaria < 40 OR disciplinas.carga_horaria > 100;

-- Encontre o nome dos professores que não estão ministrando a disciplina "IA501"

select professores.nome, disciplinas.nome_disciplina from turmas
INNER JOIN disciplinas ON turmas.disciplina_id = disciplinas.disciplina_id
INNER JOIN professores ON turmas.professor_id = professores.professor_id
WHERE disciplinas.codigo_disciplina NOT IN ('IA501');

-- Quais turmas não têm professores atribuídos?

select turmas.turma_id, professores.nome from turmas
INNER JOIN professores ON turmas.professor_id = professores.professor_id
WHERE turmas.professor_id IS NULL;

-- Liste as disciplinas e seus códigos onde pelo menos um aluno obteve uma nota menor que 60.

select disciplinas.nome_disciplina, disciplinas.codigo_disciplina, alunos.nome, notas.nota from notas
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id
INNER JOIN alunos ON notas.aluno_id = alunos.aluno_id
WHERE notas.nota < 60;

-- Qual é a média das notas dos alunos na disciplina com código "DW301" entre '2023-03-01' e '2023-03-31'?

select disciplinas.codigo_disciplina,AVG(notas.nota) as média_das_notas from notas
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id
WHERE disciplinas.codigo_disciplina = 'DW301' AND notas.data_avaliacao between '2023-03-01' and '2023-03-31' ;

-- Liste todos os alunos que estão matriculados em mais de uma disciplina.

select alunos.nome from alunos
INNER JOIN presenca ON alunos.aluno_id = presenca.aluno_id
INNER JOIN turmas ON presenca.turma_id = turmas.turma_id
INNER JOIN disciplinas ON turmas.disciplina_id = disciplinas.disciplina_id
GROUP BY nome
HAVING COUNT(presenca.turma_id) > 1;

-- Quais são os anos escolares distintos das turmas onde pelo menos um aluno faltou?

select turmas.ano_escolar, presenca.data_aula, turmas.turma_id, presenca.presenca, alunos.nome from presenca
INNER JOIN turmas ON presenca.turma_id = turmas.turma_id
INNER JOIN alunos ON presenca.aluno_id = alunos.aluno_id
WHERE presenca.presenca = 'ausente';

-- Mostre o nome dos professores que estão ministrando a disciplina "PC101" ou "BD201".

select professores.nome, disciplinas.codigo_disciplina from turmas
INNER JOIN disciplinas ON turmas.disciplina_id = disciplinas.disciplina_id
INNER JOIN professores ON turmas.professor_id = professores.professor_id
WHERE disciplinas.codigo_disciplina IN ('PC101', 'BD201');

-- Qual é o nome do aluno que faltou em todas as aulas?

select alunos.nome from presenca
INNER JOIN alunos ON presenca.aluno_id = alunos.aluno_id
WHERE presenca.presenca like 'a%';

-- Liste as disciplinas e seus códigos onde todos os alunos obtiveram uma nota maior ou igual a 70.

select disciplinas.nome_disciplina, disciplinas.codigo_disciplina from notas
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id
WHERE notas.nota >= 70;

-- Quais alunos obtiveram notas entre 80 e 90 na disciplina "IA501" ou "DW301"?

select alunos.nome from notas
INNER JOIN disciplinas ON notas.disciplina_id = disciplinas.disciplina_id
INNER JOIN alunos ON notas.aluno_id = alunos.aluno_id
WHERE disciplinas.codigo_disciplina IN ('IA501', 'DW301') AND notas.nota between 80 and 90;

-- Encontre o nome dos professores que não estão ministrando nenhuma disciplina com carga horária superior a 60 horas.

select professores.nome, disciplinas.carga_horaria from professores
INNER JOIN turmas ON professores.professor_id = turmas.professor_id
INNER JOIN disciplinas ON turmas.disciplina_id = disciplinas.disciplina_id
WHERE disciplinas.carga_horaria <= 60;

-- Quais são as datas de aulas para a disciplina com código "AA401" 
-- entre '2023-04-01' e '2023-04-30' onde pelo menos um aluno faltou?

select presenca.data_aula from turmas
INNER JOIN presenca ON turmas.turma_id = presenca.turma_id
INNER JOIN disciplinas ON turmas.disciplina_id = disciplinas.disciplina_id
WHERE disciplinas.codigo_disciplina = 'AA401' AND presenca.data_aula between '2023-04-01' and '2023-04-30'
 AND presenca.presenca = 'ausente';
 
 -- Liste os nomes dos alunos que não faltaram em nenhuma aula.

select alunos.nome from presenca
INNER JOIN alunos ON presenca.aluno_id = alunos.aluno_id
WHERE presenca.presenca not like 'a%';
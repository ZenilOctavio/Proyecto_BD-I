const fs = require('fs');

let string = `insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (1, '2022-02-22 10:14:07', 'nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', 'opcion1');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (2, '2021-11-23 03:10:44', 'amet consectetuer', 'opcion2');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (3, '2022-07-12 02:22:34', 'viverra dapibus', 'opcion3');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (4, '2022-04-05 21:10:36', 'sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at', 'opcion4');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (5, '2022-10-18 03:45:12', 'consequat nulla nisl nunc nisl duis', 'opcion1');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (6, '2022-05-19 03:37:14', 'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum', 'opcion2');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (7, '2022-07-03 04:29:38', 'lectus suspendisse potenti in eleifend quam a odio', 'opcion3');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (8, '2022-08-11 04:25:13', 'morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet', 'opcion4');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (9, '2022-02-28 21:02:06', 'iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', 'opcion1');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (10, '2021-11-26 03:13:09', 'morbi porttitor lorem id ligula suspendisse ornare consequat', 'opcion2');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (11, '2022-03-06 06:02:24', 'nulla pede ullamcorper augue a suscipit nulla elit ac nulla', 'opcion3');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (12, '2022-03-31 03:30:54', 'elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', 'opcion4');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (13, '2022-10-29 03:35:36', 'donec odio justo sollicitudin', 'opcion1');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (14, '2022-04-19 09:34:26', 'hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat', 'opcion2');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (15, '2022-02-17 19:01:48', 'diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 'opcion3');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (16, '2021-12-31 14:44:07', 'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris', 'opcion4');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (17, '2021-12-01 21:07:30', 'ut odio cras mi pede malesuada in imperdiet et commodo', 'opcion1');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (18, '2021-11-25 06:18:51', 'sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec', 'opcion2');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (19, '2022-01-02 21:56:59', 'et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean', 'opcion3');
insert into student_answer (student_answer_id, date_of_answer, comments, student_answer_text) values (20, '2022-03-01 04:48:33', 'justo', 'opcion4');`

let arr = string.split("\n");

// console.log(arr);

arr = arr.map((x) => {
    let inicio = x.lastIndexOf("(");
    let final = x.lastIndexOf(")");

    return x.substring(inicio,final+1);
});

let final = arr.join(",\n");

console.log(final);

fs.writeFile('./Documents/output.txt', final, err => {
    if (err) {
      console.error(err);
    }
  });
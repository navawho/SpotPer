const db = require('../client');

async function create3b() {
  await db.connect();

  await db.query(`create function qnt_faixas_album(faixa_album_id integer) returns bigint as $$
  begin
  return (select count(album.id) from album join faixa on album.id=faixa.album_id where album_id=faixa_album_id group by faixa.album_id);
  end; $$
language plpgsql;`);

  await db.query(`create function check_3b() returns trigger as $$
	begin
	if (qnt_faixas_album(new.album_id) >= 64) then
		raise exception 'Um álbum não pode ter mais que 64 faixas (músicas).';
	end if;
	return new;
	end; $$
  language plpgsql;`);
  
  await db.query(`create trigger check_3b
  before insert or update on faixa
  for each row execute procedure check_3b();`);

  await db.end();

  console.log('Restrição 3b criada com sucesso');
}

create3b();

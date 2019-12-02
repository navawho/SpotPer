create table Gravadora (
    id serial primary key,
    nome varchar(50) not null unique,
    homepage varchar(50) not null,
    cep integer not null,
    rua varchar(50) not null,
    numero integer not null
 );
 
 create table Telefone_Gravadora (
    id serial primary key,
    gravadora_id integer not null,
    telefone varchar(50) not null,
    foreign key (gravadora_id) references Gravadora (id)
  );
  
  create table Album (
    id serial primary key,
    gravadora_id integer not null,
    descricao varchar(100) not null,
    data_gravacao date not null,
    data_compra date,
    tipo_compra varchar(50) not null,
    preco_compra real,
    foreign key (gravadora_id) references Gravadora (id)
  );
  
  create table Playlist (
    id serial primary key,
    nome varchar(50) not null,
    data_criacao timestamp default current_timestamp,
    tempo_total time default '00:00:00'
  );
  
  create table Composicao (
    id serial primary key,
    tipo varchar(50) not null
  );
  
  create table Faixa (
    id serial primary key,
    album_id integer not null,
    composicao_id integer not null,
    descricao varchar(50) not null,
    tipo_gravacao varchar(50) not null check (tipo_gravacao ILIKE 'ADD' or tipo_gravacao ILIKE 'DDD'),
    tempo_execucao time not null,
    numero_faixa integer not null,
    foreign key (album_id) references Album (id),
    foreign key (composicao_id) references Composicao (id)
  );
  
  create table Faixa_Playlist (
    faixa_id integer not null,
    playlist_id integer not null,
    primary key (faixa_id, playlist_id),
    foreign key (faixa_id) references Faixa (id) on delete cascade,
    foreign key (playlist_id) references Playlist (id) on delete cascade
  );
  
  create table Interprete (
    id serial primary key,
    nome varchar(50) not null,
    tipo varchar(50) not null
  );
  
  create table Faixa_Interprete (
    faixa_id integer not null,
    interprete_id integer not null,
    primary key (faixa_id, interprete_id),
    foreign key (faixa_id) references Faixa (id),
    foreign key (interprete_id) references Interprete (id)
  );
  
  create table Periodo_Musical (
    id serial primary key,
    descricao varchar(50) not null,
    intervalo_tempo varchar(50)
  );
  
  create table Compositor (
    id serial primary key,
    periodo_id integer not null,
    nome varchar(50) not null,
    local_nasc_cidade varchar(50) not null,
    local_nasc_pais varchar(50) not null,
    data_nasc date not null,
    data_morte date,
    foreign key (periodo_id) references Periodo_Musical (id)
  );
  
  create table Faixa_Compositor (
    faixa_id integer not null,
    compositor_id integer not null,
    primary key (faixa_id, compositor_id),
    foreign key (faixa_id) references Faixa (id),
    foreign key (compositor_id) references Compositor (id)
  );
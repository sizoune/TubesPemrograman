{	File Name 	 : Tubes.pas
	Author 		 : M.Wildan.I ; Jonathan Marihot P ; Mahersya Eva H ; Assad Imam T.
	Date Created : 
	Description	 :
}



program tubes;
uses crt,sysutils;
type
	log = record
	id,stok:longint;
	nama,tanggal:string;
end;

var
	user,kata2,kata,tambah,yorno,urut,pilurt,nama,tanggal,bulan,nama1,cekpas,sss:string;
	ii,i,j,x,madmin,stok,idtmp,p,u,id,update:integer;
	login,ceknama,cektgl,cekstok,cekid2:boolean;
	ch:char;
	berkas,tmp : file Of log;
	arrlog : array [1..100] of log;
	arrtmp : array [1..100] of log;
	tes : log;
	
label
	a,b,w,cc,aa,ab,aw;
procedure header;
	begin
		gotoxy(1,1);write('================================================================================');
		gotoxy(39,3);write('HOTEL DAP');
		gotoxy(36,4);write('BAGIAN LOGISTIK');
		gotoxy(40,5);write('BANDUNG');
		gotoxy(1,7);write('================================================================================');
	end;

function pass (sss:string) : string;
begin
	pass:='';
	repeat
		ch:=readkey;
		if (ch <> #8) and (ch <> #13) then
		begin
			ii:=ord(ch);
			if ((ii > 31) and (ii < 127)) then
				write('*');
			pass:=pass+ch;
		end;
	    if ch = #8 then
		begin
			if pass <> '' then
			begin
				Write(#8+' '+#8);
            	delete(pass,length(pass),1);
            end;
		end;
	until(ch = #13);
end;

procedure refresh;
begin
	for i:=1 to 100 do
	begin
		arrtmp[i].id:=0;
	end;
end;
	
Procedure menuadmin;
	var
		a:integer;
	begin
		//assign(berkas,'database.dat');
		clrscr;
			header;
			gotoxy(1,9);write('                                -----MENU UTAMA-----                         ');
			gotoxy(19,11);write('------------------------------------------------');
			for a:=12 to 21 do
				begin
					gotoxy(21,a);write('|');gotoxy(64,a);write('|');
				end;
			gotoxy(29,13);writeln('1. Tambah Data Logistik');
			gotoxy(29,14);writeln('2. Lihat Data Logistik');
			gotoxy(29,15);writeln('3. Cari Data Logistik');
			gotoxy(29,16);writeln('4. Gunakan Barang Logistik');
			gotoxy(29,17);writeln('5. Hapus Barang Logistik');
			gotoxy(29,18);writeln('6. Update Data Logistik');
			gotoxy(29,19);writeln('7. Credit');
			gotoxy(29,20);writeln('8. Exit');
			gotoxy(19,22);write('------------------------------------------------');
			gotoxy(21,23);write('|');gotoxy(64,23);write('|');
			gotoxy(19,24);write('------------------------------------------------');
	end;
	
Procedure menusearch;
	begin
		gotoxy(10,1);writeln('Ingin mencari data berdasarkan apa ? ');
		gotoxy(18,3);writeln('1. Nama');
		gotoxy(18,4);writeln('2. Tanggal');
		gotoxy(18,5);writeln('3. Stok');
		gotoxy(18,6);writeln('4. ID');
	end;
	
{procedure view2;
begin
	textcolor(black);
	j:=1;
	assign(berkas,'database.dat');
	reset(berkas);
	while not (eof(berkas)) do
	begin
		inc(j);
		read(berkas,arrlog[i]);
		gotoxy(3,2+j);writeln(arrlog[i].id);
		gotoxy(10,2+j);writeln(arrlog[i].nama);
		gotoxy(26,2+j);writeln(arrlog[i].tanggal);
		gotoxy(50,2+j);writeln(arrlog[i].stok);
	end;
	close(berkas);
end;}

procedure view1;
begin
	j:=1;
	assign(berkas,'database.dat');
	reset(berkas);
	while not (eof(berkas)) do
	begin
		inc(j);
		read(berkas,tes);
		gotoxy(3,2+j);writeln(tes.id);
		gotoxy(10,2+j);writeln(tes.nama);
		gotoxy(26,2+j);writeln(tes.tanggal);
		gotoxy(50,2+j);writeln(tes.stok);
	end;
	close(berkas);
end;

procedure utama;
begin
	//gotoxy(29,1);writeln('Menu Tambah Logistik Ke Gudang');
	gotoxy(3,2);writeln('ID');
	gotoxy(10,2);writeln('Nama Barang');
	gotoxy(26,2);writeln('Tanggal Masuk Barang');
	gotoxy(50,2);writeln('Jumlah Stok');
end;
	
procedure sortid (j:integer);
var
	tmp1,tmp2,x:integer;
	tmp,tmp3:string;
begin
	for i:=2 to j do
		begin
			x:=i;
			tmp:=arrtmp[i].nama;
			tmp1:=arrtmp[i].id;
			tmp2:=arrtmp[i].stok;
			tmp3:=arrtmp[i].tanggal;
			while ((x>1) and (tmp1 < arrtmp[x-1].id)) do
				begin
					arrtmp[x].id := arrtmp[x-1].id;
					arrtmp[x].nama := arrtmp[x-1].nama;
					arrtmp[x].stok := arrtmp[x-1].stok;
					arrtmp[x].tanggal := arrtmp[x-1].tanggal;
					x:=x-1;
				end;
			arrtmp[x].nama:=tmp;
			arrtmp[x].id:=tmp1;
			arrtmp[x].stok:=tmp2;
			arrtmp[x].tanggal := tmp3;
		end;
end;
	
function cekid (x:integer) : boolean;
var
	i:integer;
	
	begin
		assign(berkas,'database.dat');
		reset(berkas);
		i:=0;
		while not(eof(berkas)) do
		begin
			read(berkas,arrlog[idtmp]);
			if x = arrlog[idtmp].id then
				i:=i+1;
		end;
		if i = 1 then
		begin
			cekid:=true;
			close(berkas);
		end
		else
		begin
			cekid:=false;
			close(berkas);
		end;
	end;

procedure loading;
	begin
		assign(berkas,'database.dat');
		{$I-}
		reset(berkas);
		{$I+}
		if IOResult <> 0 then
		begin
			rewrite(berkas);
		end;
		close(berkas);
	end;

begin
	i:=3;
	loading;
	login := false;
a:	clrscr;
	textbackground(black);textcolor(white);
	gotoxy(25,2);write('--------------------------------');
	gotoxy(25,3);write('|');
	gotoxy(35,3);write('LOGIN ADMIN');
	gotoxy(56,3);write('|');
	gotoxy(25,4);write('--------------------------------');
	gotoxy(25,5);write('|');gotoxy(37,5);write('|');gotoxy(56,5);write('|');
	gotoxy(25,6);write('--------------------------------');
	gotoxy(25,7);write('|');gotoxy(37,7);write('|');gotoxy(56,7);write('|');
	gotoxy(25,8);write('--------------------------------');
	gotoxy(27,5);write('Username');
	gotoxy(27,7);write('Password');
	gotoxy(39,5);readln(user);
	gotoxy(39,7);
	cekpas:=pass(sss);
	while (login = false) do
		begin
			if cekpas='123456'  then
			begin
				login := true;
			end
			else if	i=1 then
				begin
				gotoxy(27,10);write('                               ');
				gotoxy(26,10);
				kata:='P R O G R A M  E X I T E D . .';
				p:=length(kata);
				for u:=1 to p do
					begin
						write(kata[u]);
						delay(100);
					end;
				delay(200);
				exit;
				end
			else
				begin
					gotoxy(27,10);textcolor(red);write('Username dan Password Salah!');
					readln;
					i:=i-1;
					goto a;
				end;
		end;
	w:clrscr;
	textcolor(white);
	menuadmin;
	gotoxy(37,23);write('Pilih Menu : ');readln(madmin);
	if madmin = 1 then
		begin
			clrscr;
			repeat
			    b:clrscr;
			    textcolor(white);
				gotoxy(20,2);write('--------------------------------------');
				gotoxy(20,3);write('|');
				gotoxy(24,3);writeln('Menu Tambah Logistik Ke Gudang');
				gotoxy(57,3);write('|');
				gotoxy(20,4);write('--------------------------------------');
				gotoxy(1,6);write('--------------------------------------------------------------------------------');
				gotoxy(20,5);write('|');
				gotoxy(57,5);write('|');
				gotoxy(25,5);write('Masukkan no ID barang : ');readln(idtmp);
				if cekid(idtmp) = true then
				begin
					gotoxy(25,7);textcolor(red);writeln('ID Duplicate Detected !!!');
					readln;
					textcolor(white);
					gotoxy(5,9);write('Barang dengan ID tersebut sudah ada, ingin menambahkan stok (y/t) : '); readln(tambah);
					if (tambah = 'Y') or (tambah='y') then
					begin
						{$i-}
						assign(berkas,'database.dat');
						reset(berkas);
						{$i+}
						 if ioresult <> 0 then
							writeln('Data tidak ada.')
						 else
							begin
								gotoxy(20,11);write('--------------------------------------');
								gotoxy(20,12);write('|');
								gotoxy(57,12);write('|');
								gotoxy(20,13);write('--------------------------------------');
								gotoxy(25,12);write('Masukkan Jumlah Stok : ');readln(x);
								while not (eof(berkas))  do
								begin
									read(berkas,arrlog[idtmp]);
									if idtmp = arrlog[idtmp].id then
									begin
										arrlog[idtmp].stok:=arrlog[idtmp].stok+x;
										seek(berkas,filepos(berkas)-1);
										write(berkas,arrlog[idtmp]);
									end
								end;
								close(berkas);
							end;
					end
					else
					begin
						goto b;
					end;
				end
				else
				begin
					assign(berkas,'database.dat');
					reset(berkas);
					while (not (eof (berkas))) do
					begin
						read(berkas,arrlog[idtmp]);
					end;
					arrlog[idtmp].id := idtmp;
					gotoxy(3,7);write('|');
					gotoxy(72,7);write('|');
					gotoxy(3,8);write('----------------------------------------------------------------------');
					gotoxy(5,7);write('Masukkan Nama Barang : ');
					gotoxy(3,9);write('|');
					gotoxy(72,9);write('|');
					gotoxy(3,10);write('----------------------------------------------------------------------');
					gotoxy(5,9);write('Masukkan Tanggal (tgl/bln/thn) ex: 12/12/2012 : ');
					gotoxy(3,11);write('|');
					gotoxy(72,11);write('|');
					gotoxy(3,12);write('----------------------------------------------------------------------');
					gotoxy(5,11);write('Masukkan Stok Barang : ');
					gotoxy(28,7);readln(nama1);
					arrlog[idtmp].nama:=lowercase(nama1);
					gotoxy(53,9);readln(arrlog[idtmp].tanggal);
					kata:=copy(arrlog[idtmp].tanggal,3,1);
					kata2:=copy(arrlog[idtmp].tanggal,6,1);
					bulan:=copy(arrlog[idtmp].tanggal,4,2);
					if (length(arrlog[idtmp].tanggal) < 10 ) or (length(arrlog[idtmp].tanggal) > 10 ) then
					begin
						gotoxy(18,14);textcolor(red);write('Format Pengisisan Salah, Ulangi pengisian');
						readln;
						close(berkas);
						goto b;
					end
					else if (kata <> '/') or (kata2 <> '/') then
					begin
						gotoxy(18,14);textcolor(red);write('Format Pengisian Salah, Ulangi pengisian');
						readln;
						close(berkas);
						goto b;
					end
					else if (leftstr(arrlog[idtmp].tanggal,2) > '31') or (leftstr(arrlog[idtmp].tanggal,2) < '01') then
					begin
						gotoxy(18,14);textcolor(red);write('Tanggal Anda Salah, Ulangi pengisian');
						readln;
						close(berkas);
						goto b;
					end
					else if (bulan > '12') or (bulan < '01') then
					begin
						gotoxy(18,14);textcolor(red);write('Bulan Anda Salah, Ulangi pengisian');
						readln;
						close(berkas);
						goto b;
					end
					else
					begin
						gotoxy(28,11);readln(arrlog[idtmp].stok);
						write(berkas,arrlog[idtmp]);
						close(berkas);
					end;
				end;
			gotoxy(18,14);textcolor(green);writeln('Barang Berhasil Di tambahkan Ke Gudang');
			readln;
			textcolor(white);
			gotoxy(20,16);write('Masukkan data lagi (y/t): ');readln(yorno);
			until ((yorno = 't') or (yorno = 'T'));	
			goto w;
		end
	else if (madmin=2) then
		begin
			i:=0;
			cc:clrscr;
			textcolor(white);
			gotoxy(29,1);writeln('Data Logistik yang ada Di Gudang');
			utama;
			view1;
			writeln;
			if i = 0 then
			begin
				gotoxy(22,6+j);textcolor(black);writeln('Sorting Data Sukes !!!');
			end
			else
			begin
				gotoxy(22,6+j);textcolor(green);writeln('Sorting Data Sukes !!!');
			end;
			textcolor(white);
			gotoxy(18,4+j);write('Apakah anda ingin mengurutkan data ? (y/t) ');readln(urut);
			if (urut='y') or (urut='Y') then
				begin
					i:=1;
					j:=0;
					assign(berkas,'database.dat');
					reset(berkas);
					while not (eof(berkas)) do
					begin
						read(berkas,arrlog[i]);
						inc(j);
						arrtmp[j].id:=arrlog[i].id;
						arrtmp[j].nama:=arrlog[i].nama;
						arrtmp[j].tanggal:=arrlog[i].tanggal;
						arrtmp[j].stok:=arrlog[i].stok;
					end;
					close(berkas);
					sortid(j);
					assign(berkas,'database.dat');
					rewrite(berkas);
					for i:=1 to j do
					begin
						arrlog[i].id:=arrtmp[i].id;
						arrlog[i].nama:=arrtmp[i].nama;
						arrlog[i].tanggal:=arrtmp[i].tanggal;
						arrlog[i].stok:=arrtmp[i].stok;
						write(berkas,arrlog[i]);
					end;
					close(berkas);
					refresh;
					goto cc;
					for i:=1 to j do
					begin
						writeln('id ',arrtmp[i].id);
						writeln('nama ',arrtmp[i].nama);
						writeln('tanggal ',arrtmp[i].tanggal);
						writeln('stok ',arrtmp[i].stok);
					end;
				end
			else
				goto w;
		end
	else if madmin=3 then
		begin
			clrscr;
			textcolor(white);
			menusearch;
			gotoxy(20,8);write('Pilihan: ');readln(pilurt);
			case pilurt of 
			'1' : begin
					gotoxy(12,10);write('Masukkan nama barang yang ingin dicari: ');readln(nama);
					nama1:=lowercase(nama);
					{$i-}
					assign(berkas,'database.dat');
					reset(berkas);
					{$i+}
				    if ioresult <> 0 then
						writeln('Data tidak ada.')
				    else
					begin
						ceknama:=false;
						while not (eof(berkas)) and not ceknama do
						begin
							read(berkas,tes);
							if tes.nama = nama1 then
								ceknama:=true;
						end;
						if ceknama then
						begin
							i:=0;
							reset (berkas);
							while not (eof (berkas)) do
							begin
								read(berkas,tes);
								inc(i);
								if tes.nama = nama1 then
								begin
									arrtmp[i].id:=tes.id;
									arrtmp[i].nama:=tes.nama;
									arrtmp[i].tanggal:=tes.tanggal;
									arrtmp[i].stok:=tes.stok;
								end;
							end;
							gotoxy(3,12);writeln('ID');
							gotoxy(10,12);writeln('Nama Barang');
							gotoxy(26,12);writeln('Tanggal Masuk Barang');
							gotoxy(50,12);writeln('Jumlah Stok');
							j:=0;
							for x:=1 to i do
							begin
								if arrtmp[x].id = 0 then
									continue
								else
								begin
									inc(j);
									gotoxy(3,13+j);write(arrtmp[x].id);
									gotoxy(10,13+j);write(arrtmp[x].nama);
									gotoxy(26,13+j);write(arrtmp[x].tanggal);
									gotoxy(50,13+j);write(arrtmp[x].stok);
								end;
							end;
						end
						else
							begin
								gotoxy(21,12);textcolor(red);writeln('Data tidak di temukan');
							end;
					end;
					close(berkas);
				  end;
			'2' : begin
					gotoxy(12,10);write('Masukkan Tanggal barang yang ingin dicari ex : 08 : ');readln(tanggal);
					{$i-}
					assign(berkas,'database.dat');
					reset(berkas);
					{$i+}
				    if ioresult <> 0 then
						writeln('Data tidak ada.')
				    else
					begin
						cektgl:=false;
						while not (eof(berkas)) and not cektgl do
						begin
							read(berkas,tes);
							if leftstr(tes.tanggal,2) = leftstr(tanggal,2) then
								cektgl:=true;
						end;
						if cektgl then
						begin
							i:=0;
							reset (berkas);
							while not (eof (berkas)) do
							begin
								read(berkas,tes);
								inc(i);
								if leftstr(tes.tanggal,2) = leftstr(tanggal,2) then
								begin
									arrtmp[i].id:=tes.id;
									arrtmp[i].nama:=tes.nama;
									arrtmp[i].tanggal:=tes.tanggal;
									arrtmp[i].stok:=tes.stok;
								end;
							end;
							gotoxy(3,12);writeln('ID');
							gotoxy(10,12);writeln('Nama Barang');
							gotoxy(26,12);writeln('Tanggal Masuk Barang');
							gotoxy(50,12);writeln('Jumlah Stok');
							j:=0;
							for x:=1 to i do
							begin
								if arrtmp[x].id = 0 then
									continue
								else
								begin
									inc(j);
									gotoxy(3,13+j);write(arrtmp[x].id);
									gotoxy(10,13+j);write(arrtmp[x].nama);
									gotoxy(26,13+j);write(arrtmp[x].tanggal);
									gotoxy(50,13+j);write(arrtmp[x].stok);
								end;
							end;
						end
						else
							begin
								gotoxy(21,12);textcolor(red);writeln('Data tidak di temukan');
							end;
					end;
					close(berkas);
				  end;
			'3' : begin
					gotoxy(12,10);write('Masukkan stok barang yang ingin dicari: ');readln(stok);
					{$i-}
					assign(berkas,'database.dat');
					reset(berkas);
					{$i+}
				    if ioresult <> 0 then
						writeln('Data tidak ada.')
				    else
					begin
						cekstok:=false;
						while not (eof(berkas)) and not cekstok do
						begin
							read(berkas,tes);
							if tes.stok = stok then
								cekstok:=true;
						end;
						if cekstok then
						begin
							i:=0;
							reset (berkas);
							refresh;
							while not (eof (berkas)) do
							begin
								read(berkas,tes);
								inc(i);
								if tes.stok = stok then
								begin
									arrtmp[i].id:=tes.id;
									arrtmp[i].nama:=tes.nama;
									arrtmp[i].tanggal:=tes.tanggal;
									arrtmp[i].stok:=tes.stok;
								end;
							end;
							gotoxy(3,12);writeln('ID');
							gotoxy(10,12);writeln('Nama Barang');
							gotoxy(26,12);writeln('Tanggal Masuk Barang');
							gotoxy(50,12);writeln('Jumlah Stok');
							j:=0;
							for x:=1 to i do
							begin
								if arrtmp[x].id = 0 then
									continue
								else
								begin
									inc(j);
									gotoxy(3,13+j);write(arrtmp[x].id);
									gotoxy(10,13+j);write(arrtmp[x].nama);
									gotoxy(26,13+j);write(arrtmp[x].tanggal);
									gotoxy(50,13+j);write(arrtmp[x].stok);
								end;
							end;
						end
						else
							begin
								gotoxy(21,12);textcolor(red);writeln('Data tidak di temukan');
							end;
					end;
					close(berkas);
				  end;
			'4' : begin
					gotoxy(12,10);write('Masukkan ID barang yang ingin dicari: ');readln(id);
					{$i-}
					assign(berkas,'database.dat');
					reset(berkas);
					{$i+}
				    if ioresult <> 0 then
						writeln('Data tidak ada.')
				    else
					begin
						cekid2:=false;
						while not (eof(berkas)) and not cekid2 do
						begin
							read(berkas,tes);
							if tes.id = id then
								cekid2:=true;
						end;
						if cekid2 then
						begin
							reset (berkas);
							gotoxy(3,12);writeln('ID');
							gotoxy(10,12);writeln('Nama Barang');
							gotoxy(26,12);writeln('Tanggal Masuk Barang');
							gotoxy(50,12);writeln('Jumlah Stok');
							while not (eof (berkas)) do
							begin
								read(berkas,tes);
								if tes.id = id then
								begin
									gotoxy(3,13);write(tes.id);
									gotoxy(10,13);write(tes.nama);
									gotoxy(26,13);write(tes.tanggal);
									gotoxy(50,13);write(tes.stok);
								end;
							end;
						end
						else
							begin
								gotoxy(21,12);textcolor(red);writeln('Data tidak di temukan');
							end;					
					end;
					close(berkas);
				  end
			else
				begin
					gotoxy(21,12);textcolor(red);writeln('Pilihan tidak ditemukan');
				end;
			end;{end of case}
			readln;
			refresh;
			goto w;
		end
	else if madmin = 4 then
		begin
			aa:clrscr;
			textcolor(white);
			gotoxy(29,1);writeln('Menu Ambil Logistik Dari Gudang');
			utama;
			view1;
			gotoxy(15,4+j);write('Masukkan ID Barang yang akan di ambil: ');readln(id);
			assign(berkas,'database.dat');
			reset(berkas);
			cekid2:=false;
			while not (eof(berkas)) and not cekid2 do
			begin
				read(berkas,tes);
				if tes.id = id then
					cekid2:=true;
			end;
			if cekid2 then
			begin
				gotoxy(15,5+j);write('Masukkan Jumlah Barang yang akan di ambil: ');readln(x);
				reset(berkas);
				while not (eof(berkas))  do
				begin
					read(berkas,tes);
					if id = tes.id then
					begin
						if x > tes.stok then
						begin
							write('Jumlah barang yang akan anda ambil terlalu banyak');
							readln;
							close(berkas);
							goto aa;
						end
						else
						begin
							tes.stok:=tes.stok-x;
							seek(berkas,filepos(berkas)-1);
							write(berkas,tes);
						end;
					end;
				end;
			end
			else
			begin
				gotoxy(21,15);textcolor(red);writeln('ID Barang tidak ditemukan');
				readln;
				close(berkas);
				goto aa;
			end;
			close(berkas);
			clrscr;
			gotoxy(29,3+j);textcolor(green);writeln('Barang Berhasil Diambil');
			readln;
			goto w;
		end
	else if madmin=5 then
		begin
			ab:clrscr;
			textcolor(white);
			gotoxy(29,1);writeln('Menu Delete Logistik Dari Gudang');
			utama;
			view1;
			gotoxy(15,4+j);write('Masukkan ID Barang yang akan di hapus: ');readln(id);
			assign(berkas,'database.dat');
			reset(berkas);
			cekid2:=false;
			while not (eof(berkas)) and not cekid2 do
			begin
				read(berkas,tes);
				if tes.id = id then
					cekid2:=true;
			end;
			if cekid2 then
			begin
				assign(tmp,'tmp.dat'); 
				rewrite(tmp);
				reset(berkas);
				while not (eof(berkas)) do
				begin
					read(berkas,tes);
					if not (tes.id = id) then
						write(tmp,tes);
				end;
				close(berkas);
				erase(berkas);
				close(tmp);
				assign(tmp,'tmp.dat');
				rename(tmp,'database.dat');
				clrscr;
				gotoxy(20,3);textcolor(green);writeln('Data Barang Berhasil Di Hapus');
				readln;
				goto w;
			end
			else
			begin
				gotoxy(21,12);textcolor(red);writeln('ID Barang tidak ditemukan');
				readln;
				close(berkas);
				goto ab;
			end;
		end
	else if madmin = 6 then
		begin
			aw:clrscr;
			textcolor(white);
			gotoxy(20,2);write('--------------------------------------');
			gotoxy(20,3);write('|');
			gotoxy(24,3);writeln('Menu Update Logistik di Gudang');
			gotoxy(57,3);write('|');
			gotoxy(12,4);write('------------------------------------------------------');
			gotoxy(1,6);write('--------------------------------------------------------------------------------');
			gotoxy(12,5);write('|');
			gotoxy(65,5);write('|');
			gotoxy(18,5);write('Masukkan ID Barang yang ingin di update : ');readln(update);
			assign(berkas,'database.dat');
			reset(berkas);
			cekid2:=false;
			i:=0;
			while not eof (berkas) and not cekid2 do
			begin
				read(berkas,tes);
				inc(i);
				if tes.id = update then
					cekid2:=true;
			end;
			if cekid2 then
			begin
				tes.id := update;
				gotoxy(3,7);write('|');
				gotoxy(74,7);write('|');
				gotoxy(3,8);write('------------------------------------------------------------------------');
				gotoxy(5,7);write('Masukkan Nama barang yang baru (before : ',tes.nama,') : ');
				gotoxy(3,9);write('|');
				gotoxy(74,9);write('|');
				gotoxy(3,10);write('------------------------------------------------------------------------');
				gotoxy(5,9);write('Masukkan Tanggal barang yang baru (before : ',tes.tanggal,') : ');
				gotoxy(3,11);write('|');
				gotoxy(74,11);write('|');
				gotoxy(3,12);write('------------------------------------------------------------------------');
				gotoxy(5,11);write('Masukkan Stok barang yang baru (before : ',tes.stok,') : ');
				gotoxy(50+length(tes.nama),7);readln(nama);
				tes.nama:=lowercase(nama);
				gotoxy(63,9);readln(tes.tanggal);
				kata:=copy(tes.tanggal,3,1);
				kata2:=copy(tes.tanggal,6,1);
				bulan:=copy(tes.tanggal,4,2);
				if (length(tes.tanggal) < 10 ) or (length(tes.tanggal) > 10) then
				begin
					gotoxy(18,14);textcolor(red);write('Format Pengisisan Salah, Ulangi pengisian');
					readln;
					close(berkas);
					goto aw;
				end
				else if (kata <> '/') or (kata2 <> '/') then
				begin
					gotoxy(18,14);textcolor(red);write('Format Pengisian Salah, Ulangi pengisian');
					readln;
					close(berkas);
					goto aw;
				end
				else if (leftstr(tes.tanggal,2) > '31') or (leftstr(tes.tanggal,2) < '01') then
				begin
					gotoxy(18,14);textcolor(red);write('Tanggal Anda Salah, Ulangi pengisian');
					readln;
					close(berkas);
					goto aw;
				end
				else if (bulan > '12') or (bulan < '01') then
				begin
					gotoxy(18,14);textcolor(red);write('Bulan Anda Salah, Ulangi pengisian');
					readln;
					close(berkas);
					goto aw;
				end
				else
				begin
					gotoxy(50+length(inttostr(tes.stok)),11);readln(tes.stok);
					seek(berkas,filepos(berkas)-1);
					write(berkas,tes);
					close(berkas);
					gotoxy(18,14);textcolor(green);write('Data Berhasil di Update');
					readln;
					goto w;
				end;
			end
			else
			begin
				gotoxy(30,8);textcolor(red);write('ID tidak ditemukan');
				close(berkas);
				readln;
				goto aw;
			end;
		end
	else if madmin = 7 then
		begin
			clrscr;
			for i:=1 to 20 do
			begin
				gotoxy(17,25-i);write('--==--==--Aplikasi Logistik Hotel--==--==--');
				delay(100);
				if i <> 20 then
					gotoxy(17,25-i);write('                                                       ');
			end;
			for i:=1 to 18 do
			begin
				gotoxy(28,25-i);write('Thanks to Pa Andit');
				delay(100);
				if i <> 18 then
					gotoxy(28,25-i);write('                   ');
			end;
			for i:=1 to 16 do
			begin
				gotoxy(24,25-i);write('And thanks to this team : ');
				delay(100);
				if i <> 16 then
					gotoxy(24,25-i);write('                           ');
			end;
			for i:=1 to 14 do
			begin
				gotoxy(28,25-i);write('1. Assad Imam. T ');
				delay(100);
				if i <> 14 then
					gotoxy(28,25-i);write('                           ');
			end;
			for i:=1 to 12 do
			begin
				gotoxy(28,25-i);write('2. Jonathan Marihot. P ');
				delay(100);
				if i <> 12 then
					gotoxy(28,25-i);write('                           ');
			end;
			for i:=1 to 10 do
			begin
				gotoxy(28,25-i);write('3. Mahersya Eva. H ');
				delay(100);
				if i <> 10 then
					gotoxy(28,25-i);write('                           ');
			end;
			for i:=1 to 8 do
			begin
				gotoxy(28,25-i);write('4. Muhammad Wildan. I ');
				delay(100);
				if i <> 8 then
					gotoxy(28,25-i);write('                           ');
			end;
			readln;
			goto w;
		end
	else if madmin=8 then
		begin
			clrscr;
			gotoxy(27,10);write('                               ');
			gotoxy(26,10);
			kata:='E X I T I N G . . . .';
			p:=length(kata);
			for u:=1 to p do
				begin
					write(kata[u]);
					delay(100);
				end;
			delay(200);
			exit;
		end
	else
		begin
			clrscr;
			gotoxy(20,3);writeln('Pilihan Anda Tidak Terdeteksi');
			readln;
			goto w;
		end;
	readln;
end.

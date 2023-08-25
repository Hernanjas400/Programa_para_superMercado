{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  dolaresApesos: Double; // Variable convierte dolar a pesos
  valorDolar: Double;   // variable dolar dia
  NumeroFactura: Integer; //idem
  opcionMenu: Integer;      //idem
  opcionSubMenu: Integer;  // idem
  numeroTicket: Integer;   // idem
  tipoPago: string;      // indem
  numeroPago: Integer; // Variable para contar el número de pagos realizados
  numeroSocio: Integer; // Variable para almacenar el número de socio
  numeroCajero: Integer; // Variable para almacenar el número de cajero
  nombreCajero: string; // Variable para almacenar el nombre del cajero
  totalArticulos: Integer; // Variable para almacenar el total de artículos comprados
  totalPrecioCosto: Double; // Variable para almacenar el total del precio de costo
  totalIVA: Double; // Variable para almacenar el total del IVA
  totalFinal: Double; // Variable para almacenar el total final
  totalLuz,totalAgua,totalMunicipales,totalGas,totalCable,totalExpensas, totalGeneralservicios:double; // totales servicio
  descuento: Double;  // idem
  totalVentasPesos,totalVentasDolares:double;    // totales
  numeroTicketMayorMonto:integer;           //     TicketMayorMonto
  montoMayor:double;                 //  idem
  totalVentasCredito,totalVentasDebito:double;    // totales


  procedure MostrarTotalServicios;         // proceso Totales
  begin

    Writeln('');
    Writeln('');
    Writeln('------------Total de servicios cobrados------------');
    Writeln('');
    Writeln('');
    writeln('luz:$',totalLuz:0:2);
    writeln('Agua:$',totalAgua:0:2);
    writeln('Municipales:$',totalMunicipales:0:2);
    writeln('Gas:$',totalGas:0:2);
    writeln('Cable:$',totalCable:0:2);
    writeln('Expensas:$',totalExpensas:0:2);

    totalGeneralservicios:=totalLuz + totalAgua + totalMunicipales + totalGas + totalCable + totalExpensas;
    Writeln('');
    Writeln('');
    Writeln('Total de servicios cobrados: ', totalGeneralservicios:0:2);
  end;

  procedure RealizarPago(servicio: string);                  // proceso de pago
var
  importeAPagar, importePagado, cambio: Double;
  respuesta: string;

begin
  if numeroPago >= 3 then // Verifica límite de pagos

  begin

    Writeln('');
    Write('Solo 3 servicios por socio');
    Writeln('');
    Writeln('');
    numeroPago:=0;
    Exit; // Salir  sin realizar el pago

  end;

  Write('Ingrese el importe a pagar: ');
  ReadLn(importeAPagar);

  Write('Ingrese el importe pagado: ');
  ReadLn(importePagado);

  cambio := importePagado - importeAPagar;

  if cambio = 0 then
  begin
    WriteLn('Pago completo. No hay cambio.');
  end
  else if cambio > 0 then
  begin
    WriteLn('Pago completo. Su cambio es de: ', cambio:0:2);
  end
  else
  begin
    WriteLn('Pago incompleto. Faltan: ', Abs(cambio):0:2, ' para completar el importe.');

    Write('Desea completar el pago ? (S/N): ');
    ReadLn(respuesta);
    if UpperCase(respuesta) = 'S' then
    begin
      cambio := -cambio;
      WriteLn('Pago completo. Su cambio es de: ', cambio:0:2);
    end;
  end;

  //totales de servicios

  if servicio = 'Luz' then
  begin
    totalLuz := totalLuz + importeAPagar;
  end
  else if servicio = 'Agua' then
  begin
    totalAgua := totalAgua + importeAPagar;
  end
  else if servicio = 'Municipales' then
  begin
    totalMunicipales := totalMunicipales + importeAPagar;
  end
  else if servicio = 'Gas' then
  begin
    totalGas := totalGas + importeAPagar;
  end
  else if servicio = 'Cable' then
  begin
    totalCable := totalCable + importeAPagar;
  end
  else if servicio = 'Expensas' then
  begin
    totalExpensas := totalExpensas + importeAPagar;
  end;



  WriteLn('------------------------------');
  WriteLn('   ***TICKET:', numeroPago + 1);
  WriteLn('------------------------------');
  WriteLn('Servicio Cobrado: ', servicio);
  WriteLn('Fecha: ', FormatDateTime('dd/mm/yyyy', Now));
  WriteLn('Importe a abonar: ', importeAPagar:0:2);
  WriteLn('Imorte abonado: ', importePagado:0:2);
  WriteLn('Vuelto cliente: ', cambio:0:2);
  WriteLn('Numero de caja: ', numeroCajero); // Mostrar el número de cajero
  WriteLn('Cajero: ', nombreCajero); // Mostrar el nombre del cajero
  WriteLn('--------------------------------');
  WriteLn('');

  Inc(numeroPago); // Incrementar contador pagos

  if numeroPago <= 3 then // Verificar si se pueden realizar más pagos
  begin
    exit;
    if UpperCase(respuesta) = 'S' then
      RealizarPago(servicio);
  end;
end;

procedure RealizarFacturacion;         // proceso facturacion 
var

  nombreProducto: string;
  precioCosto, importeAPagar, importePagado, cambio: Double;
  respuesta: string;

  begin
  valorDolar:= 0;
  descuento :=0;
  totalArticulos := 0;
  totalPrecioCosto := 0;
  totalIVA := 0;
  totalFinal := 0;
                                // ingresa articulos y valor
  repeat
    Write('Ingrese el nombre del producto: ');
    ReadLn(nombreProducto);

    Write('Ingrese el precio costo del producto: ');
    ReadLn(precioCosto);

    totalArticulos := totalArticulos + 1;
    totalPrecioCosto := totalPrecioCosto + precioCosto;
    totalIVA := totalIVA + (precioCosto * 0.21);


    Write('Desea anexar otro producto (S/N): ');
    ReadLn(respuesta);
    WriteLn;

  until UpperCase(respuesta) = 'N';
   //descuento:= 0;
  numeroTicket := numeroTicket + 1;

  totalFinal := totalPrecioCosto + totalIVA;
  if tipoPago = 'Efectivo' then
    totalVentasPesos := totalVentasPesos + totalFinal
  else if tipoPago = 'Dolares' then
    totalVentasDolares := totalVentasDolares + totalFinal
  else if (tipoPago = 'Tarjeta de credito') then
    totalVentasCredito := totalVentasCredito + totalFinal
  else if (tipoPago = 'Tarjeta de debito') then
    totalVentasDebito := totalVentasDebito + totalFinal;

  if totalFinal > montoMayor then
  begin
  montoMayor := totalFinal;
  numeroTicketMayorMonto := NumeroFactura;    // aca tambien puede ser Ticket ( factura acumula )

  end;                                                       // comienza proceso tiket
  Writeln('');
  WriteLn('---------------------------');
  WriteLn(' *TICKET DE COMPRA: ', NumeroFactura);   //ojo
  WriteLn('---------------------------');
  Writeln('');
  WriteLn('Fecha: ', FormatDateTime('dd/mm/yyyy', Now));
  WriteLn('Cajero: ', nombreCajero);
  WriteLn('Numero de caja: ', numeroCajero);
  WriteLn('Tipo de pago: ', tipoPago);
  WriteLn('Numero de socio: ', numeroSocio);
  WriteLn('Total de articulos comprados: ', totalArticulos);
  WriteLn('Total precio costo: ', totalPrecioCosto:0:2);
  WriteLn('Total IVA 21%: ', totalIVA:0:2);
  WriteLn('Total: ', totalFinal:0:2);                          // dias y promociones descuentos metodo de pago

   if tipoPago = 'Tarjeta Banco Blanca' then
   if (DayOfWeek(Now) = 3) or (DayOfWeek(Now) = 5) or (DayOfWeek(Now) = 6) then
  begin

    descuento :=  totalPrecioCosto* 0.15;
    WriteLn('Promo banco blanca: -', descuento:0:2);
    WriteLn('Total final: ', totalFinal - descuento:0:2);
   // importeAPagar := totalFinal - descuento;

    end;
    if tipoPago = 'Tarjeta de credito' then
   if (DayOfWeek(Now) = 2) or (DayOfWeek(Now) = 3) then
  begin

    descuento :=  totalPrecioCosto* 0.10;
    WriteLn('Promo Tarjeta de credito: -', descuento:0:2);
    WriteLn('Total final: ', totalFinal - descuento:0:2);
  //  importeAPagar := totalFinal - descuento;

    end;

    if tipoPago = 'Tarjeta de debito' then
   if (DayOfWeek(Now) = 2) or (DayOfWeek(Now) = 3) then
  begin

    descuento :=  totalPrecioCosto* 0.10;
    WriteLn('Promo Tarjeta de debito: -', descuento:0:2);
    WriteLn('Total final: ', totalFinal - descuento:0:2);
   // importeAPagar := totalFinal - descuento;

    end;

     if tipoPago = 'Efectivo' then
   if (DayOfWeek(Now) = 2) or (DayOfWeek(Now) = 3) then
  begin

    descuento :=  totalPrecioCosto* 0.10;
    WriteLn('Promo Pago Efectivo: -', descuento:0:2);
    WriteLn('Total final: ', totalFinal - descuento:0:2);
   // importeAPagar := totalFinal - descuento;

    end;

    if tipoPago = 'Dolares' then
   if (DayOfWeek(Now) = 1) or (DayOfWeek(Now) = 2)or (DayOfWeek(Now) = 3)or (DayOfWeek(Now) = 4)or (DayOfWeek(Now) = 5)or (DayOfWeek(Now) = 6)or (DayOfWeek(Now) = 7) then
  begin

    descuento :=  (totalPrecioCosto* 1/100);
    WriteLn('Recargo Pago Dolares: ', descuento:0:2);
    WriteLn('Total final: ', totalFinal + descuento:0:2);


    Write('Valor Dolar ', FormatDateTime('dd/mm/yyyy : ', Now));

    ReadLn(valorDolar);
    totalFinal := totalFinal / valorDolar;
    WriteLn('Total final u$s: ', totalFinal:0:2);


    end;



  WriteLn('---------------------------');
  WriteLn('');

  Inc(numeroPago); // Incrementar contador pagos

  Write('Ingrese el importe a pagar: ');
  ReadLn(importeAPagar);

  Write('Ingrese el importe pagado: ');
  ReadLn(importePagado);

  cambio := importePagado - importeAPagar;

  if cambio = 0 then
  begin
    WriteLn('Pago completo. No hay cambio.');
  end
  else if cambio > 0 then
  begin
    WriteLn('Pago completo. Su cambio es de: ', cambio:0:2);
  end
  else
  begin
    WriteLn('Pago incompleto. Faltan: ', Abs(cambio):0:2, ' para completar el importe.');

    Write('Desea completar el pago ? (S/N): ');
    ReadLn(respuesta);
    if UpperCase(respuesta) = 'S' then
    begin
      cambio := -cambio;
      WriteLn('Pago completo. Su cambio es de: ', cambio:0:2);
    end;

    end;                                                         // proceso de factura

  Writeln('');
  WriteLn('--------------------------');
  WriteLn(' FACTURA CLIENTE');
  WriteLn('--------------------------');
  Writeln('');
  WriteLn('Fecha: ', FormatDateTime('dd/mm/yyyy', Now));
  WriteLn('Numero de caja: ', numeroCajero); // Mostrar el número de cajero
  WriteLn('Cajero: ', nombreCajero); // Mostrar el nombre del cajero
  WriteLn('Numero de Factura: ', NumeroFactura);
   WriteLn('Tipo de pago: ', tipoPago);
  WriteLn('Total de articulos comprados: ', totalArticulos);
  WriteLn('Importe a abonar: ', importeAPagar:0:2);
  WriteLn('Importe abonado: ', importePagado:0:2);

  dolaresApesos := (cambio * ValorDolar);

  WriteLn('Vuelto cliente: ', cambio:0:2);

  writeLn('Vuelto Dolares a Pesos: ', dolaresApesos:0:2);
  WriteLn('');
  WriteLn('----------------------------');
  WriteLn('');
end;

procedure GenerarFactura;
begin
  // generar la factura utilizando el número de factura actual

end;                      // almacena y incremata la factura " Secuencial "


procedure IncrementarNumeroFactura;
var
  Archivo: TextFile;
  Numero: string;
begin
  AssignFile(Archivo, 'numerofactura.txt');
  try
    if FileExists('numerofactura.txt') then
    begin
      Reset(Archivo);
      Readln(Archivo, Numero);
      NumeroFactura := StrToInt(Numero);
      CloseFile(Archivo);
    end
    else
    begin
      NumeroFactura := 1;
      Rewrite(Archivo);
      Writeln(Archivo, IntToStr(NumeroFactura));
      CloseFile(Archivo);
    end;
  except
    on E: Exception do
    begin
      CloseFile(Archivo);
      raise;
    end;
  end;

  Inc(NumeroFactura);

  AssignFile(Archivo, 'numerofactura.txt');
  Rewrite(Archivo);
  Writeln(Archivo, IntToStr(NumeroFactura));
  CloseFile(Archivo);
end;
 begin
  try
    //IncrementarNumeroFactura;
    //GenerarFactura;
  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;


begin                                         // inicio variables

  dolaresApesos:=0;
  descuento := 0;
  numeroTicket := 0;
  tipoPago := '';
  numeroPago := 0;
  numeroSocio := 0;
  numeroCajero := 0;
  nombreCajero := '';
  totalArticulos := 0;
  totalPrecioCosto := 0;
  totalIVA := 0;
  totalFinal := 0;
  totalVentasPesos:=0;
  totalVentasDolares:=0;
  numeroTicketMayorMonto:=0;
  montoMayor:=0;
  totalVentasCredito:=0;
  totalVentasDebito:=0;
  Writeln('***************************');
  Writeln('*                         *');
  Writeln('*    SUPERMARKET 1.0      *');
  Writeln('*   By Hernan Costanzi,   *');
  Writeln('*    Agustin Gonzalez     *');
  Writeln('*                         *');
  Writeln('***************************');

  Writeln('');                                 // ingreso socio,cajero, caja
  Writeln('');
  Write('Ingrese numero de socio: ');
  ReadLn(numeroSocio);
  Write('Ingrese el nombre del cajero: ');
  ReadLn(nombreCajero);

  Write('numero de caja: ');
  ReadLn(numeroCajero);

  repeat
    // Mostrar el menú principal
    Writeln('');
    Writeln('--- Menu Principal ---');
    Writeln('');
    Writeln('Numero de socio: ', numeroSocio);
    Writeln('Nombre del cajero: ', nombreCajero);
    Writeln('Numero de Caja: ', numeroCajero);
    Writeln('');
    Writeln('1. Cobro de servicios');
    Writeln('2. Facturar una compra');
    Writeln('3. Listado de totales');
    Writeln('4. Salir');
    Writeln('');
    Write('Seleccione una opcion: ');
    Readln(opcionMenu);
    numeroPago := 0;     //inicia en 0 despues de los tres servicios


    // Manejar menú de servicios
    case opcionMenu of

      1:

      begin
        repeat
          //numeroPago := 0;
          // Submenú cobro de servicios
          Writeln('');
          Writeln('');
          Writeln('--- COBRO DE SERVICIOS ---');
          Writeln('');
          Writeln('1. Luz');
          Writeln('2. Agua');
          Writeln('3. Municipales');
          Writeln('4. Gas');
          Writeln('5. Cable');
          Writeln('6. Expensas');
          Writeln('7. Ingrese Nuevo Socio');
          Writeln('8. Volver al menu principal');
          Writeln('');
          Writeln('');
          Write('Seleccione una opcion: ');
          Readln(opcionSubMenu);

          // submenu de servicios
          case opcionSubMenu of

            1:
            begin
              //  1 (Luz)
              RealizarPago('Luz');
            end;

            2:
            begin
              //  2 (Agua)
              RealizarPago('Agua');
            end;

            3:
            begin
              //  3 (Municipales)
              RealizarPago('Municipales');
            end;

            4:
            begin
              //  4 (Gas)
              RealizarPago('Gas');
            end;

            5:
            begin
              //  5 (Cable)
              RealizarPago('Cable');
            end;

             6:
            begin
              //  6 (Expensas)
              RealizarPago('Cable');
            end;

            7:
            begin
              // 7(nuevo socio renueva contador)
            numeroPago := 0;
            Writeln('');
            Writeln('');
            Write('Ingrese numero de socio: ');     //( ingrsa nuevo socio)
            ReadLn(numeroSocio);
            end;
          end;

        until opcionSubMenu = 8; //  "Volver al menú principal"
      end;

      2:
      begin
        repeat
          // Submenú facturar compra
          numeroPago := 0;
          Writeln('');
          Writeln('--- FACTURAR UNA COMPRA ---');
          Writeln('');
          Writeln('1. Metodo de pago');
          Writeln('2. Datos para la factura');
          Writeln('3. Volver al menu principal');
          Writeln('');
          Writeln('');
          Write('Seleccione una opcion: ');
          Readln(opcionSubMenu);

          // Manejar submenú facturar compra
          case opcionSubMenu of
            1:
            begin
              //  (Metodo de pago)
              // Generar el número de ticket
              numeroTicket := numeroTicket + 1;
              Writeln('');
              Writeln('');
              Writeln('--- METODO DE PAGO ---');
              Writeln('');
              Writeln('1. Tarjeta banco blanca');
              Writeln('2. Tarjeta de credito');
              Writeln('3. Tarjeta de debito');
              Writeln('4. Efectivo');
              Writeln('5. Dolares');
              Writeln('');

              Readln(opcionSubMenu);

              // Validar el tipo de pago ingresado
              while (opcionSubMenu < 1) or (opcionSubMenu > 5) do
                begin
                Writeln('');
                WriteLn('Tipo de pago inválido. Por favor, ingrese nuevamente: ');
                ReadLn(opcionSubMenu);
              end;
              descuento := 0;
              case opcionSubMenu of

                1:

                begin
                  tipoPago := 'Tarjeta Banco Blanca';

                  // Verifica si es martes jueves o viernes
                  if (DayOfWeek(Now) = 3) or (DayOfWeek(Now) = 5) or (DayOfWeek(Now) = 6) then
                  begin

                    descuento := totalPrecioCosto - (descuento * 0.15);
                    totalFinal := totalFinal - descuento;
                    WriteLn('');
                    WriteLn('    Descuento del -15% aplicado para tarjeta Banco Blanca');
                  end;
                end;

                2:
                  begin
                  tipoPago := 'Tarjeta de credito';
                   // Verifica si es lunes  o martes
                  if (DayOfWeek(Now) = 2) or (DayOfWeek(Now) = 3) then
                  begin

                    descuento := totalPrecioCosto - (descuento * 0.10);
                    totalFinal := totalFinal - descuento;
                    WriteLn('');
                    WriteLn('    Descuento del -10% aplicado para tarjeta de credito');

                end;
                end;


                3:
                  begin
                  tipoPago := 'Tarjeta de debito';
                   // Verifica si es lunes  o martes
                  if (DayOfWeek(Now) = 2) or (DayOfWeek(Now) = 3) then
                  begin

                    descuento := totalPrecioCosto - (descuento * 0.10);
                    totalFinal := totalFinal - descuento;
                    WriteLn('');
                    WriteLn('    Descuento del -10% aplicado para tarjeta de debito');

                end;
                end;

                4:
                  begin
                  tipoPago := 'Efectivo';
                   // Verifica si es lunes  o martes
                  if (DayOfWeek(Now) = 2) or (DayOfWeek(Now) = 3) then
                  begin

                    descuento := totalPrecioCosto - (descuento * 0.10);
                    totalFinal := totalFinal - descuento;
                    WriteLn('');
                    WriteLn('    Descuento del -10% pago Efectivo');

                end;
                end;

                5:
                 begin
                  tipoPago := 'Dolares';

                   // todos los dias
                  if (DayOfWeek(Now) = 1) or (DayOfWeek(Now) = 2)or (DayOfWeek(Now) = 3)or (DayOfWeek(Now) = 4)or (DayOfWeek(Now) = 5)or (DayOfWeek(Now) = 6)or (DayOfWeek(Now) = 7) then
                  begin
                    descuento := totalPrecioCosto - (descuento * 0.1);
                    totalFinal := totalFinal - descuento;
                    WriteLn('');
                    WriteLn('    Recargo del 1% pago en Dolares');

               end;
               end;
                 end;

              // muestra tipo de pago
              WriteLn('');
              WriteLn('----------------------------------------');
              WriteLn('  Tipo de pago: ', tipoPago);
              WriteLn('----------------------------------------');

              end;

            2:
            begin
              // (Datos para la factura)

              Writeln('');
              IncrementarNumeroFactura;       // incrementa factura
              GenerarFactura;                 // genera en el txt
              Writeln('Seleccionaste la opcion 2 Datos para la factura');
              RealizarFacturacion;
            end;
          end;

        until opcionSubMenu = 3; // "Volver al menú principal"
      end;

      3:
      begin
        repeat
          // Menú listado de totales
          Writeln('');
          Writeln('--- Listado de totales ---');
          Writeln('');
          Writeln('1. Total de servicios cobrados');
          Writeln('2. Total de ventas realizadas');
          Writeln('3. Ticket de mayor facturacion');
          Writeln('4. Volver al menu principal');
          Writeln('');
          Write('Seleccione una opcion: ');
          Readln(opcionSubMenu);

          // Manejar menú listado de totales
         
          case opcionSubMenu of

            1:
            begin
              //  1 (Total de servicios cobrados)

              Writeln('');
              Writeln('');
              MostrarTotalServicios;

            end;

            2:
            begin
              // 2 (Total de ventas realizadas)
              Writeln('');
              Writeln('-------Seleccionaste Total de ventas realizadas---------');
              Writeln('');
              Writeln('');
              Writeln('Total de ventas en pesos: ', totalVentasPesos:0:2);
              Writeln('Total de ventas en dolares convertido a pesos: ', totalVentasDolares:0:2);
              Writeln('Total de ventas con tarjeta de credito: ', totalVentasCredito:0:2);
              Writeln('Total de ventas con tarjeta de debito: ', totalVentasDebito:0:2);
              // ...
            end;

            3:
            begin
              // 3 (Ticket de mayor facturacion)
              Writeln('');
              Writeln('---------Seleccionaste Ticket de mayor facturacion-------------');
              Writeln('');
              Writeln('');
              if numeroTicketMayorMonto > 0 then                             // factura mayor
               begin
                Writeln('La Factura de mayor monto es la numero: ', numeroTicketMayorMonto, ' con un Total de: ', montoMayor:0:2);
               end
               else
               begin
                Writeln('No se ha realizado ninguna factura aun.');
               end;
              // ...
            end;
          end;

        until opcionSubMenu = 4; // Volver al menú principal
      end;
    end;

  until opcionMenu = 4; // Salir del programa
  Writeln('');
  Writeln('Gracias por usar el programa');
  Readln;
  end;
end.

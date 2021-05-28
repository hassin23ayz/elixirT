defmodule I2C do
  def i2c_comm_process do
    receive do
      {:i2c_send, add, val} ->
        IO.puts("writing #{val} at address #{add}")
        i2c_comm_process()

      {:i2c_recv, add} ->
        IO.puts("reading from address #{add}")
        i2c_comm_process()

      _ ->
        IO.puts("error")
        i2c_comm_process()
    end
  end
end

# PID = Process Identifier
# use the following command to invoke GUI to see process IDs
# iex(1)> :observer.start
proc_i2c_com = spawn(fn -> I2C.i2c_comm_process() end)


send proc_i2c_com, {:i2c_send, 0x45, 0x22}
send proc_i2c_com, {:i2c_recv, 0x45}
send proc_i2c_com, {:i2c_recv}
send proc_i2c_com, {:spi_recv, 0x45}

# there is also Port Identifier used for communicating with external programs

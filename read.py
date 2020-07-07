import asyncio

async def tcp_echo_client():
    reader, writer = await asyncio.open_connection(
        'localhost', 7878)

    #writer.write('* PING\n'.encode('utf8'))
    writer.write('* manufacturer: XXX'.encode())
    await writer.drain()

    async for line in reader:
        print(f'line: {line}')

    writer.close()
    await writer.wait_closed()

asyncio.run(tcp_echo_client())

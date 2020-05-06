import asyncio

async def tcp_echo_client():
    reader, writer = await asyncio.open_connection(
        '127.0.0.1', 7878)

    async for line in reader:
        print(f'line: {line}')

    writer.close()
    await writer.wait_closed()

asyncio.run(tcp_echo_client())

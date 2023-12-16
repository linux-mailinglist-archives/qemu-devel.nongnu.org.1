Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B4815BE3
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 22:33:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEcGD-0007Sk-AJ; Sat, 16 Dec 2023 16:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEcGA-0007SQ-5O
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 16:31:46 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEcG4-0008U5-EK
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 16:31:44 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1400D75A4BA;
 Sat, 16 Dec 2023 22:31:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YX8Q23wh2uTO; Sat, 16 Dec 2023 22:31:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 31D8B75A406; Sat, 16 Dec 2023 22:31:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3078675607B;
 Sat, 16 Dec 2023 22:31:35 +0100 (CET)
Date: Sat, 16 Dec 2023 22:31:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <huth@tuxfamily.org>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Subject: Re: [PATCH 11/12] next-cube.c: replace sysmem with get_system_memory()
 in next_cube_init()
In-Reply-To: <20231216212038.45ece9fb@fedora>
Message-ID: <40d000e3-a5d2-d63f-8cb8-46a73810a9e1@eik.bme.hu>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-12-mark.cave-ayland@ilande.co.uk>
 <20231216212038.45ece9fb@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, 16 Dec 2023, Thomas Huth wrote:
> Am Fri, 15 Dec 2023 20:00:08 +0000
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>
>> Removing the intermediate variable helps simplify the code in next_cube_init().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/m68k/next-cube.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index d9a1f234ec..73deef25ca 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -974,7 +974,6 @@ static void next_cube_init(MachineState *machine)
>>      MemoryRegion *dmamem = g_new(MemoryRegion, 1);
>>      MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
>>      MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
>> -    MemoryRegion *sysmem = get_system_memory();
>>      const char *bios_name = machine->firmware ?: ROM_FILE;
>>      DeviceState *pcdev;
>>
>> @@ -996,7 +995,8 @@ static void next_cube_init(MachineState *machine)
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(pcdev), &error_fatal);
>>
>>      /* 64MB RAM starting at 0x04000000  */
>> -    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
>> +    memory_region_add_subregion(get_system_memory(), 0x04000000,
>> +                                machine->ram);
>>
>>      /* Framebuffer */
>>      sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
>> @@ -1010,19 +1010,19 @@ static void next_cube_init(MachineState *machine)
>>      /* BMAP memory */
>>      memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
>>                                             RAM_SHARED, &error_fatal);
>> -    memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);
>> +    memory_region_add_subregion(get_system_memory(), 0x020c0000, bmapm1);
>>      /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
>>      memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
>> -    memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
>> +    memory_region_add_subregion(get_system_memory(), 0x820c0000, bmapm2);
>>
>>      /* KBD */
>>      sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
>>
>>      /* Load ROM here */
>>      memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
>> -    memory_region_add_subregion(sysmem, 0x01000000, rom);
>> +    memory_region_add_subregion(get_system_memory(), 0x01000000, rom);
>>      memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
>> -    memory_region_add_subregion(sysmem, 0x0, rom2);
>> +    memory_region_add_subregion(get_system_memory(), 0x0, rom2);
>>      if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
>>          if (!qtest_enabled()) {
>>              error_report("Failed to load firmware '%s'.", bios_name);
>> @@ -1051,7 +1051,7 @@ static void next_cube_init(MachineState *machine)
>>      /* DMA */
>>      memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
>>                            0x5000);
>> -    memory_region_add_subregion(sysmem, 0x02000000, dmamem);
>> +    memory_region_add_subregion(get_system_memory(), 0x02000000, dmamem);
>>  }
>
> Mostly a matter of taste, but I'd prefer to keep it like it was before - I
> dislike calling functions multiple times if one time is sufficient.

The get_system_memory() function will only return a pointer to a static 
variable though so it's not expensive to call it multiple times and 
introducing a local variable just adds one more name for it to look up 
when reading the code so I generally prefer using it directly as it would 
likely be inlined by the compiler anyway.

That's also matter of taste but all the memory regions the next patch 
moves to machine state aren't really needed as these are only used for 
creating a mem region and adding it as subregion to system memory so one 
MemoryRegion *mr variable would be enough (and a meybe one more for alias 
regions) that are reused for all of these without storing them in machine 
state where they aren't used any more so no need to srore them.

Also I think in memory region call backs the void *opaque parameter don't 
need a QOM cast as these are registered here with already the wanted type 
for opaque so no need to check that every time the memory region is accessed.

Regards,
BALATON Zoltan


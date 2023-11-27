Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072C7F9ED8
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:43:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7a1V-0001kJ-0F; Mon, 27 Nov 2023 06:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7a1S-0001jk-Fz; Mon, 27 Nov 2023 06:43:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7a1Q-0006D8-JE; Mon, 27 Nov 2023 06:43:30 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 800AC75A4BC;
 Mon, 27 Nov 2023 12:43:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 31D8l7j0hblc; Mon, 27 Nov 2023 12:43:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 930D675607B; Mon, 27 Nov 2023 12:43:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 906AA756078;
 Mon, 27 Nov 2023 12:43:24 +0100 (CET)
Date: Mon, 27 Nov 2023 12:43:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
In-Reply-To: <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
Message-ID: <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Mon, 27 Nov 2023, Nicholas Piggin wrote:
> On Sun Nov 26, 2023 at 2:34 AM AEST, BALATON Zoltan wrote:
>> The machine uses a modified U-Boot under GPL license but the sources
>> of it are lost with only a binary available so it cannot be included
>> in QEMU. Allow running without the firmware image with -bios none
>> which can be used when calling a boot loader directly and thus
>> simplifying booting guests. We need a small routine that AmigaOS calls
>> from ROM which is added in this case to allow booting AmigaOS without
>> external firmware image.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v2: Unfortunately AmigaOS needs some additional ROM part which is added
>> Please merge for 8.2 as it allows booting AmigaOS simpler without
>> having to download separate firmware.
>
> How to test this?

You can check with -M amigaone -bios none then from QEMU monitor
(qemu) xp/10i 0xfff7ff80

>>  hw/ppc/amigaone.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>> index 992a55e632..a11d2d5556 100644
>> --- a/hw/ppc/amigaone.c
>> +++ b/hw/ppc/amigaone.c
>> @@ -40,6 +40,16 @@
>>  #define PROM_ADDR 0xfff00000
>>  #define PROM_SIZE (512 * KiB)
>>
>> +/* AmigaOS calls this routine from ROM, use this if -bios none */
>> +static const char dummy_fw[] = {
>> +    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
>> +    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
>> +    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
>> +    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
>> +    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
>> +    0x4e, 0x80, 0x00, 0x20, /* blr */
>> +};
>
> This is clever, but does anything else create blobs like this?

There are some examples in hw/mips/{loongson3_virt.c, malta.c} at least 
and maybe others that put code in guest memory. If this was longer than 
this few instructions I'd consider putting it in a binary but this seems 
simpler for such small code.

> It could be put into a .S in pc-bios, which might be a bit more
> consistent.
>
> We might make a ppc/ subdirectory under there, but that's for
> another time.

Maybe later we could reorganise these unless it's really necessary to 
change this for 8.2 now. (The mips boards and some arm and riscv machines 
seem to use rom_add_blob_fixed() which sould show up in info roms under 
monitor so maybe I could look at changing to use that now if you think it 
would be better that way.)

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>> +
>>  static void amigaone_cpu_reset(void *opaque)
>>  {
>>      PowerPCCPU *cpu = opaque;
>> @@ -94,17 +104,21 @@ static void amigaone_init(MachineState *machine)
>>      }
>>
>>      /* allocate and load firmware */
>> +    rom = g_new(MemoryRegion, 1);
>> +    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
>> +    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
>>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
>>      if (filename) {
>> -        rom = g_new(MemoryRegion, 1);
>> -        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
>> -        memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
>>          sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
>>          if (sz <= 0 || sz > PROM_SIZE) {
>>              error_report("Could not load firmware '%s'", filename);
>>              exit(1);
>>          }
>>          g_free(filename);
>> +    } else if (!strcmp(fwname, "none")) {
>> +        address_space_write_rom(&address_space_memory, 0xfff7ff80,
>> +                                MEMTXATTRS_UNSPECIFIED, dummy_fw,
>> +                                ARRAY_SIZE(dummy_fw));
>>      } else if (!qtest_enabled()) {
>>          error_report("Could not find firmware '%s'", fwname);
>>          exit(1);
>
>
>


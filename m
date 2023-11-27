Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A944D7FA15C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 14:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7bzv-0001eG-Ja; Mon, 27 Nov 2023 08:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7bzs-0001dd-Vo; Mon, 27 Nov 2023 08:50:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7bzq-00076I-LL; Mon, 27 Nov 2023 08:50:00 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BC5575A4BF;
 Mon, 27 Nov 2023 14:49:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MmzbxkoiqsRa; Mon, 27 Nov 2023 14:49:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4ECEC75A4BE; Mon, 27 Nov 2023 14:49:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4CCB775A4BC;
 Mon, 27 Nov 2023 14:49:54 +0100 (CET)
Date: Mon, 27 Nov 2023 14:49:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
In-Reply-To: <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
Message-ID: <ab2ffd58-1ace-8f9d-977b-ed6935017f6a@eik.bme.hu>
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
 <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
 <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
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
> On Mon Nov 27, 2023 at 9:43 PM AEST, BALATON Zoltan wrote:
>> On Mon, 27 Nov 2023, Nicholas Piggin wrote:
>>> On Sun Nov 26, 2023 at 2:34 AM AEST, BALATON Zoltan wrote:
>>>> The machine uses a modified U-Boot under GPL license but the sources
>>>> of it are lost with only a binary available so it cannot be included
>>>> in QEMU. Allow running without the firmware image with -bios none
>>>> which can be used when calling a boot loader directly and thus
>>>> simplifying booting guests. We need a small routine that AmigaOS calls
>>>> from ROM which is added in this case to allow booting AmigaOS without
>>>> external firmware image.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> v2: Unfortunately AmigaOS needs some additional ROM part which is added
>>>> Please merge for 8.2 as it allows booting AmigaOS simpler without
>>>> having to download separate firmware.
>>>
>>> How to test this?
>>
>> You can check with -M amigaone -bios none then from QEMU monitor
>> (qemu) xp/10i 0xfff7ff80
>
> Okay, so to fully test it you really need a non-free AmigaOS image?

I'm afraid yes, it's hard to test without AmigaOS otherwise as that's the 
only thing that seems to need this.

> And, how does a user know how or when to use this? Should it just be
> default if there is no bios binary found?

It could be the default without -bios, that could also allow removing the 
qtest special case than. Maybe it's easier for users so I'll change that 
in v2.

>>>>  hw/ppc/amigaone.c | 20 +++++++++++++++++---
>>>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>>> index 992a55e632..a11d2d5556 100644
>>>> --- a/hw/ppc/amigaone.c
>>>> +++ b/hw/ppc/amigaone.c
>>>> @@ -40,6 +40,16 @@
>>>>  #define PROM_ADDR 0xfff00000
>>>>  #define PROM_SIZE (512 * KiB)
>>>>
>>>> +/* AmigaOS calls this routine from ROM, use this if -bios none */
>>>> +static const char dummy_fw[] = {
>>>> +    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
>>>> +    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
>>>> +    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
>>>> +    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
>>>> +    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
>>>> +    0x4e, 0x80, 0x00, 0x20, /* blr */
>>>> +};
>>>
>>> This is clever, but does anything else create blobs like this?
>>
>> There are some examples in hw/mips/{loongson3_virt.c, malta.c} at least
>> and maybe others that put code in guest memory. If this was longer than
>> this few instructions I'd consider putting it in a binary but this seems
>> simpler for such small code.
>
> Thanks, compiling blob inline looks fine then.
>
> It's 0x80 bytes from the end of prom AFAIKS. Should you make that
> PROM_ADDR + PROM_SIZE - 0x80 instead of hard coding it?

I thought about that after sending the patch, I'll change it too.

>>> It could be put into a .S in pc-bios, which might be a bit more
>>> consistent.
>>>
>>> We might make a ppc/ subdirectory under there, but that's for
>>> another time.
>>
>> Maybe later we could reorganise these unless it's really necessary to
>> change this for 8.2 now.
>
> Nah that's fine.
>
>> (The mips boards and some arm and riscv machines
>> seem to use rom_add_blob_fixed() which sould show up in info roms under
>> monitor so maybe I could look at changing to use that now if you think it
>> would be better that way.)
>
> I'm not sure, I don't think it's necessary if your minimal patch works.

It works but just for consistency with other similar machines I'll 
consider trying rom_add_blob_fixed() now that there will be another 
iteration.

> I'll do a PR for 8.2 for SLOF and Skiboot updates, so happy to include
> this as well.

Thanks, I'll only have time to do a v2 later but still before the next rc 
due tomorrow.

There are some more data around this function in ROM that I'm not sure 
would be needed but don't know how to verify what AmigaOS accesses. I've 
tried enabling memory_region* traces but those only seem to log io 
regions, ram and rom region accesses are probably just memory reads so not 
traced. Then I've tried adding watch points in gdb like this:

(gdb) watch *(char [0x80000])*0xfff00000
value requires 524288 bytes, which is more than max-value-size
(gdb) show max-value-size
Maximum value size is 65536 bytes.
(gdb) watch *(char [0x10000])*0xfff00000
Hardware watchpoint 1: *(char [0x10000])*0xfff00000
(gdb) watch *(char [0x10000])*0xfff10000
Hardware watchpoint 2: *(char [0x10000])*0xfff10000
(gdb) watch *(char [0x10000])*0xfff20000
Hardware watchpoint 3: *(char [0x10000])*0xfff20000
(gdb) watch *(char [0x10000])*0xfff30000
Hardware watchpoint 4: *(char [0x10000])*0xfff30000
(gdb) watch *(char [0x10000])*0xfff40000
Hardware watchpoint 5: *(char [0x10000])*0xfff40000
(gdb) watch *(char [0x10000])*0xfff50000
Hardware watchpoint 6: *(char [0x10000])*0xfff50000
(gdb) watch *(char [0x10000])*0xfff60000
Hardware watchpoint 7: *(char [0x10000])*0xfff60000
(gdb) watch *(char [0x10000])*0xfff70000
Hardware watchpoint 8: *(char [0x10000])*0xfff70000

but they are not firing even for the code known to be accessed so not sure 
how to trace rom access. Maybe I'll need to temporarily make it an io 
region to be able to trace access to it. Any better idea for that? That 
way I could check that no other parts of the rom are needed. With just 
this routine it boots but wanted to make sure nothing else is needed 
later.

Regards,
BALATON Zoltan


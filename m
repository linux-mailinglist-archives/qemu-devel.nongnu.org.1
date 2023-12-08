Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E580997B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:46:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQsI-0004AX-Gk; Thu, 07 Dec 2023 21:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rBQs6-00048t-UC
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 21:45:49 -0500
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rBQs3-0007C1-KP
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 21:45:46 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0Vy1PYZ1_1702003531; 
Received: from 30.198.1.84(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0Vy1PYZ1_1702003531) by smtp.aliyun-inc.com;
 Fri, 08 Dec 2023 10:45:32 +0800
Message-ID: <a9b9379c-6238-4611-a577-079c31514f76@linux.alibaba.com>
Date: Fri, 8 Dec 2023 10:44:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] accel/tcg: Fix the comment for CPUTLBEntryFull
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com
References: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
 <765b3a0c-05b4-4059-b915-7818099c3743@ilande.co.uk>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <765b3a0c-05b4-4059-b915-7818099c3743@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_SPF_WL=-7.5,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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


On 2023/11/28 21:04, Mark Cave-Ayland wrote:
> On 01/09/2023 07:01, LIU Zhiwei wrote:
>
>> When memory region is ram, the lower TARGET_PAGE_BITS is not the
>> physical section number. Instead, its value is always 0.
>>
>> Add comment and assert to make it clear.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   accel/tcg/cputlb.c      | 11 +++++++----
>>   include/exec/cpu-defs.h | 12 ++++++------
>>   2 files changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index d68fa6867c..a1ebf75068 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -1192,6 +1192,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>>       write_flags = read_flags;
>>       if (is_ram) {
>>           iotlb = memory_region_get_ram_addr(section->mr) + xlat;
>> +        assert(!(iotlb & ~TARGET_PAGE_MASK));
>>           /*
>>            * Computing is_clean is expensive; avoid all that unless
>>            * the page is actually writable.
>> @@ -1254,10 +1255,12 @@ void tlb_set_page_full(CPUState *cpu, int 
>> mmu_idx,
>>         /* refill the tlb */
>>       /*
>> -     * At this point iotlb contains a physical section number in the 
>> lower
>> -     * TARGET_PAGE_BITS, and either
>> -     *  + the ram_addr_t of the page base of the target RAM (RAM)
>> -     *  + the offset within section->mr of the page base (I/O, ROMD)
>> +     * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
>> +     * aligned ram_addr_t of the page base of the target RAM.
>> +     * Otherwise, iotlb contains
>> +     *  - a physical section number in the lower TARGET_PAGE_BITS
>> +     *  - the offset within section->mr of the page base (I/O, ROMD) 
>> with the
>> +     *    TARGET_PAGE_BITS masked off.
>>        * We subtract addr_page (which is page aligned and thus won't
>>        * disturb the low bits) to give an offset which can be added 
>> to the
>>        * (non-page-aligned) vaddr of the eventual memory access to get
>> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
>> index fb4c8d480f..350287852e 100644
>> --- a/include/exec/cpu-defs.h
>> +++ b/include/exec/cpu-defs.h
>> @@ -100,12 +100,12 @@
>>   typedef struct CPUTLBEntryFull {
>>       /*
>>        * @xlat_section contains:
>> -     *  - in the lower TARGET_PAGE_BITS, a physical section number
>> -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
>> -     *    must be added to the virtual address to obtain:
>> -     *     + the ram_addr_t of the target RAM (if the physical section
>> -     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
>> -     *     + the offset within the target MemoryRegion (otherwise)
>> +     *  - For ram, an offset which must be added to the virtual address
>> +     *    to obtain the ram_addr_t of the target RAM
>> +     *  - For other memory regions,
>> +     *     + in the lower TARGET_PAGE_BITS, the physical section number
>> +     *     + with the TARGET_PAGE_BITS masked off, the offset within
>> +     *       the target MemoryRegion
>>        */
>>       hwaddr xlat_section;
>
> Someone sent me a test case that triggers the assert() introduced by 
> this commit dff1ab6 ("accel/tcg: Fix the comment for CPUTLBEntryFull") 
> for qemu-system-m68k which is still present in git master. The 
> reproducer is easy:
>
> 1. Grab the machine ROM file from 
> https://www.ilande.co.uk/tmp/qemu/tQuadra800.rom
>
> 2. Create an empty declaration ROM greater than 4K:
>
>    dd if=/dev/zero of=/tmp/badrom bs=512 count=12
>
> 3. Start QEMU like this:
>
>    qemu-system-m68k -M q800 -bios tQuadra800.rom \
>        -device nubus-macfb,romfile=/tmp/badrom
>
> The QEMU process hits the assert() with the following backtrace:
>
> (gdb) bt
> #0  0x00007ffff58a9d3c in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x00007ffff585af32 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #2  0x00007ffff5845472 in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #3  0x00007ffff5845395 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #4  0x00007ffff5853e32 in __assert_fail () from 
> /lib/x86_64-linux-gnu/libc.so.6
> #5  0x0000555555942e0a in tlb_set_page_full (cpu=0x55555618d4a0, 
> mmu_idx=0, addr=4244631552, full=0x7fffe7d7f7c0) at 
> ../accel/tcg/cputlb.c:1171
> #6  0x00005555559432a0 in tlb_set_page_with_attrs (cpu=0x55555618d4a0, 
> addr=4244631552, paddr=4244631552, attrs=..., prot=7, mmu_idx=0, 
> size=4096) at ../accel/tcg/cputlb.c:1290
> #7  0x0000555555943305 in tlb_set_page (cpu=0x55555618d4a0, 
> addr=4244631552, paddr=4244631552, prot=7, mmu_idx=0, size=4096) at 
> ../accel/tcg/cputlb.c:1297
> #8  0x000055555588aade in m68k_cpu_tlb_fill (cs=0x55555618d4a0, 
> address=4244635647, size=1, qemu_access_type=MMU_DATA_LOAD, mmu_idx=0, 
> probe=false, retaddr=140734805255937) at ../target/m68k/helper.c:1018
> #9  0x0000555555943367 in tlb_fill (cpu=0x55555618d4a0, 
> addr=4244635647, size=1, access_type=MMU_DATA_LOAD, mmu_idx=0, 
> retaddr=140734805255937) at ../accel/tcg/cputlb.c:1315
> #10 0x0000555555945d78 in mmu_lookup1 (cpu=0x55555618d4a0, 
> data=0x7fffe7d7fa00, mmu_idx=0, access_type=MMU_DATA_LOAD, 
> ra=140734805255937) at ../accel/tcg/cputlb.c:1713
> #11 0x0000555555946081 in mmu_lookup (cpu=0x55555618d4a0, 
> addr=4244635647, oi=3712, ra=140734805255937, type=MMU_DATA_LOAD, 
> l=0x7fffe7d7fa00) at ../accel/tcg/cputlb.c:1803
> #12 0x000055555594742b in do_ld1_mmu (cpu=0x55555618d4a0, 
> addr=4244635647, oi=3712, ra=140734805255937, 
> access_type=MMU_DATA_LOAD) at ../accel/tcg/cputlb.c:2377
> #13 0x0000555555948f17 in helper_ldub_mmu (env=0x55555618fc60, 
> addr=4244635647, oi=3712, retaddr=140734805255937) at 
> ../accel/tcg/ldst_common.c.inc:19
> #14 0x00007fff6013286c in code_gen_buffer ()
> #15 0x00005555559308ff in cpu_tb_exec (cpu=0x55555618d4a0, 
> itb=0x7fffa0132480, tb_exit=0x7fffe7d80030) at 
> ../accel/tcg/cpu-exec.c:458
> #16 0x000055555593160a in cpu_loop_exec_tb (cpu=0x55555618d4a0, 
> tb=0x7fffa0132480, pc=1082158370, last_tb=0x7fffe7d80040, 
> tb_exit=0x7fffe7d80030) at ../accel/tcg/cpu-exec.c:920
> #17 0x000055555593196a in cpu_exec_loop (cpu=0x55555618d4a0, 
> sc=0x7fffe7d800c0) at ../accel/tcg/cpu-exec.c:1041
> #18 0x0000555555931a28 in cpu_exec_setjmp (cpu=0x55555618d4a0, 
> sc=0x7fffe7d800c0) at ../accel/tcg/cpu-exec.c:1058
> #19 0x0000555555931aaf in cpu_exec (cpu=0x55555618d4a0) at 
> ../accel/tcg/cpu-exec.c:1084
> #20 0x00005555559560ad in tcg_cpus_exec (cpu=0x55555618d4a0) at 
> ../accel/tcg/tcg-accel-ops.c:76
> #21 0x00005555559575c2 in rr_cpu_thread_fn (arg=0x55555618d4a0) at 
> ../accel/tcg/tcg-accel-ops-rr.c:261
> #22 0x0000555555b61f25 in qemu_thread_start (args=0x555556347a10) at 
> ../util/qemu-thread-posix.c:541
> #23 0x00007ffff58a8044 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #24 0x00007ffff592861c in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>
Hi Mark,

The  nubus-macfb device create a section not aligned to the 
TARGET_PAGE_BITS. That is the reason why it fails the assert. But that's 
OK. It is my error. I have sent a patch to de-assert it.  I am not sure 
whether it can be merged into the 8.2.

Thanks,
Zhiwei

>
> ATB,
>
> Mark.


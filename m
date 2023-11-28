Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4A7FBADC
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:06:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xlh-0000zC-3v; Tue, 28 Nov 2023 08:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r7xle-0000yn-Ok
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:04:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r7xlc-0000rR-P0
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KVQoas+93zbEqwQdZ0IZn1L2wblmcQhP7myxM6AodKY=; b=WDnJiufJJLOd4VPYf+ny3X5/cC
 x6DuYJV3GkE7NZzlUvrf+HpIxLW66P+sMxT4AuL4TU7bP9xKS0RFag2ZM4LRHioLOqjLjefCDETl8
 In7HJJNa54QmtuTlyuYc0lgtJYkRMGMeNr5uy7+m/bAr4D1h5qzuBXI3c/SrvV+4SLhtfRb8+Wgwe
 zmVDK1320Zzu7+OZoGPZsVezlimI3b/RkkI2gIqe8VtjDLl3ZP+4bwCDzXr0UetvT+kf1hdQVlpd9
 a//ekr94tNyXk4lVktjMgJ4iXg80BFg1lEhKIFXGAe0frxG3Ft/6/MzBTGuYR0umPFThnU9t0D7DU
 feDpNw3U2O5iEpacwfMDGPHKW1551BonHi14bz6qcGzTu4iNsj/H6Z9nbaHwLxYLBqErryb2FS3dC
 qWWOCmnD1htNv971Sfy2YnUDwzeixpu3IXjT+BowwKqB0BR7AgDhyk/oJnL7xITA/dqB5HcR/ZbYv
 1Kb6G7ryQWWI3a/eZ5IcfN4cCNqiZQ9iV18yzXyKdb9Aqx2vFrdvlY82eirVgLm8sVGSFCmcipRkN
 fvtS0V4mQlupUSrjncfLjTEwfyoSM8QPsDWiTpcUanzn/ggchN2TSw1P/wEgvRgpo9FDniXqSMp5G
 otH8LxCJCvPyIeU3Q9jymv4UJPnuz1QK8wS+zAVdI=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r7xlB-00098D-Sh; Tue, 28 Nov 2023 13:04:21 +0000
Message-ID: <765b3a0c-05b4-4059-b915-7818099c3743@ilande.co.uk>
Date: Tue, 28 Nov 2023 13:04:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com
References: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20230901060118.379-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/1] accel/tcg: Fix the comment for CPUTLBEntryFull
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

On 01/09/2023 07:01, LIU Zhiwei wrote:

> When memory region is ram, the lower TARGET_PAGE_BITS is not the
> physical section number. Instead, its value is always 0.
> 
> Add comment and assert to make it clear.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   accel/tcg/cputlb.c      | 11 +++++++----
>   include/exec/cpu-defs.h | 12 ++++++------
>   2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d68fa6867c..a1ebf75068 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1192,6 +1192,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       write_flags = read_flags;
>       if (is_ram) {
>           iotlb = memory_region_get_ram_addr(section->mr) + xlat;
> +        assert(!(iotlb & ~TARGET_PAGE_MASK));
>           /*
>            * Computing is_clean is expensive; avoid all that unless
>            * the page is actually writable.
> @@ -1254,10 +1255,12 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>   
>       /* refill the tlb */
>       /*
> -     * At this point iotlb contains a physical section number in the lower
> -     * TARGET_PAGE_BITS, and either
> -     *  + the ram_addr_t of the page base of the target RAM (RAM)
> -     *  + the offset within section->mr of the page base (I/O, ROMD)
> +     * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
> +     * aligned ram_addr_t of the page base of the target RAM.
> +     * Otherwise, iotlb contains
> +     *  - a physical section number in the lower TARGET_PAGE_BITS
> +     *  - the offset within section->mr of the page base (I/O, ROMD) with the
> +     *    TARGET_PAGE_BITS masked off.
>        * We subtract addr_page (which is page aligned and thus won't
>        * disturb the low bits) to give an offset which can be added to the
>        * (non-page-aligned) vaddr of the eventual memory access to get
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index fb4c8d480f..350287852e 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -100,12 +100,12 @@
>   typedef struct CPUTLBEntryFull {
>       /*
>        * @xlat_section contains:
> -     *  - in the lower TARGET_PAGE_BITS, a physical section number
> -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> -     *    must be added to the virtual address to obtain:
> -     *     + the ram_addr_t of the target RAM (if the physical section
> -     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> -     *     + the offset within the target MemoryRegion (otherwise)
> +     *  - For ram, an offset which must be added to the virtual address
> +     *    to obtain the ram_addr_t of the target RAM
> +     *  - For other memory regions,
> +     *     + in the lower TARGET_PAGE_BITS, the physical section number
> +     *     + with the TARGET_PAGE_BITS masked off, the offset within
> +     *       the target MemoryRegion
>        */
>       hwaddr xlat_section;

Someone sent me a test case that triggers the assert() introduced by this commit 
dff1ab6 ("accel/tcg: Fix the comment for CPUTLBEntryFull") for qemu-system-m68k which 
is still present in git master. The reproducer is easy:

1. Grab the machine ROM file from https://www.ilande.co.uk/tmp/qemu/tQuadra800.rom

2. Create an empty declaration ROM greater than 4K:

    dd if=/dev/zero of=/tmp/badrom bs=512 count=12

3. Start QEMU like this:

    qemu-system-m68k -M q800 -bios tQuadra800.rom \
        -device nubus-macfb,romfile=/tmp/badrom

The QEMU process hits the assert() with the following backtrace:

(gdb) bt
#0  0x00007ffff58a9d3c in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007ffff585af32 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007ffff5845472 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007ffff5845395 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#4  0x00007ffff5853e32 in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
#5  0x0000555555942e0a in tlb_set_page_full (cpu=0x55555618d4a0, mmu_idx=0, 
addr=4244631552, full=0x7fffe7d7f7c0) at ../accel/tcg/cputlb.c:1171
#6  0x00005555559432a0 in tlb_set_page_with_attrs (cpu=0x55555618d4a0, 
addr=4244631552, paddr=4244631552, attrs=..., prot=7, mmu_idx=0, size=4096) at 
../accel/tcg/cputlb.c:1290
#7  0x0000555555943305 in tlb_set_page (cpu=0x55555618d4a0, addr=4244631552, 
paddr=4244631552, prot=7, mmu_idx=0, size=4096) at ../accel/tcg/cputlb.c:1297
#8  0x000055555588aade in m68k_cpu_tlb_fill (cs=0x55555618d4a0, address=4244635647, 
size=1, qemu_access_type=MMU_DATA_LOAD, mmu_idx=0, probe=false, 
retaddr=140734805255937) at ../target/m68k/helper.c:1018
#9  0x0000555555943367 in tlb_fill (cpu=0x55555618d4a0, addr=4244635647, size=1, 
access_type=MMU_DATA_LOAD, mmu_idx=0, retaddr=140734805255937) at 
../accel/tcg/cputlb.c:1315
#10 0x0000555555945d78 in mmu_lookup1 (cpu=0x55555618d4a0, data=0x7fffe7d7fa00, 
mmu_idx=0, access_type=MMU_DATA_LOAD, ra=140734805255937) at ../accel/tcg/cputlb.c:1713
#11 0x0000555555946081 in mmu_lookup (cpu=0x55555618d4a0, addr=4244635647, oi=3712, 
ra=140734805255937, type=MMU_DATA_LOAD, l=0x7fffe7d7fa00) at ../accel/tcg/cputlb.c:1803
#12 0x000055555594742b in do_ld1_mmu (cpu=0x55555618d4a0, addr=4244635647, oi=3712, 
ra=140734805255937, access_type=MMU_DATA_LOAD) at ../accel/tcg/cputlb.c:2377
#13 0x0000555555948f17 in helper_ldub_mmu (env=0x55555618fc60, addr=4244635647, 
oi=3712, retaddr=140734805255937) at ../accel/tcg/ldst_common.c.inc:19
#14 0x00007fff6013286c in code_gen_buffer ()
#15 0x00005555559308ff in cpu_tb_exec (cpu=0x55555618d4a0, itb=0x7fffa0132480, 
tb_exit=0x7fffe7d80030) at ../accel/tcg/cpu-exec.c:458
#16 0x000055555593160a in cpu_loop_exec_tb (cpu=0x55555618d4a0, tb=0x7fffa0132480, 
pc=1082158370, last_tb=0x7fffe7d80040, tb_exit=0x7fffe7d80030) at 
../accel/tcg/cpu-exec.c:920
#17 0x000055555593196a in cpu_exec_loop (cpu=0x55555618d4a0, sc=0x7fffe7d800c0) at 
../accel/tcg/cpu-exec.c:1041
#18 0x0000555555931a28 in cpu_exec_setjmp (cpu=0x55555618d4a0, sc=0x7fffe7d800c0) at 
../accel/tcg/cpu-exec.c:1058
#19 0x0000555555931aaf in cpu_exec (cpu=0x55555618d4a0) at ../accel/tcg/cpu-exec.c:1084
#20 0x00005555559560ad in tcg_cpus_exec (cpu=0x55555618d4a0) at 
../accel/tcg/tcg-accel-ops.c:76
#21 0x00005555559575c2 in rr_cpu_thread_fn (arg=0x55555618d4a0) at 
../accel/tcg/tcg-accel-ops-rr.c:261
#22 0x0000555555b61f25 in qemu_thread_start (args=0x555556347a10) at 
../util/qemu-thread-posix.c:541
#23 0x00007ffff58a8044 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#24 0x00007ffff592861c in ?? () from /lib/x86_64-linux-gnu/libc.so.6


ATB,

Mark.



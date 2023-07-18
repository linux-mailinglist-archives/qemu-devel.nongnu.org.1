Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB5757761
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgg3-0002Mo-3u; Tue, 18 Jul 2023 05:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qLgg1-0002MF-F6
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:07:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qLgfz-0004b4-JV
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:07:25 -0400
Received: from [192.168.100.28] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1MUok5-1qUjDS0mEz-00Qik9; Tue, 18 Jul 2023 11:07:19 +0200
Message-ID: <30185dea-cab4-3b01-4fb2-bf1f87de2351@vivier.eu>
Date: Tue, 18 Jul 2023 11:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 35/47] linux-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-36-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230715135317.7219-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xKureVphTlicgJNuEuPN/nkcR9E/Ga5h7pj2M5/Loqlx7nFKBgQ
 JE6MaqzNi5/aafaayALbE8dPJK91v/405slKRRg97wcbtFpZmnr2wQt/+nS4g+6d71U3O/0
 APyjU6TBa3+mRX7YpXGizHoM02HfDniUu327kHkqFQgsthxbSTLJprF9dx7ImgVoiGjIkp9
 rOPoN+BpWnmYe0IrrmTJA==
UI-OutboundReport: notjunk:1;M01:P0:AWcY5YzeYoA=;+JE4AzuVD/qcn9JgWFT0Za+R2zA
 fQ9j/f7wr0NYAvkuCm2DX4i/7BfR1FK8a2RGqarxtebDkzQh0N2sRCwI3ROVL2tmH64Zf8t7q
 uJmvUEBlajXa4mysktar8r06ngm6uvnqoDFxe1ykS8nG4wWqiWVAwMHYKHEmuFEuLEUuxnrpv
 XebpQ773DONtISYNqjBNyoFFKF5OMg6s4E0dgx7ShSe49GG5qxxOo5P4hPgZbYFn09Pik6SWT
 16SJnARJvkzn3TVOA2C4S5B5fszJpUIPcrCX667YSZsCAMfE0RP5wXBmg6cmGJCNuEX/CKcuR
 awIxTZk00ZpBH/y1Em+4+hyu3zqtL+a6TF4cB7uS1r7uDluha6olnSkK6BqmE0mFrUS+ZbeHW
 XhkTIu7KUdXjAOwB8zTPjPdYpvBQAiFXWdK95uoovMqHjPv2DJxSXIN7re9dDVqAzJQcIfLX7
 jghTjV86IjqcJpp+dMFRj114bfKDMDC//w0tPgxkftvB/4YyNDEbPj9XGKXfVINJTEaG55FON
 O1cmGMQcrk2IbM4km4boo28e9wDg9aJMA20xhGN20Mig4KSaiMtWCqFIXJKbodJCauS7onTX8
 PmCiIvFt+PNnKYG3wffgR/n8cN1z+NNdYGVmvsKxtPW5GfyIkOnZQyjev1RkoSKdWIXDptYbT
 Xv+DECydzjHZ0tli0jgeb4fmC29lbc5L1PyRv/dG2A==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.097,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

thank you for the linux-user PR (I have really no time to do that).

I've  run the LTP test suite (20230127) on master and found some problems introduced by 
this patch.

With armhf and Debian bionic and stretch, brk01 brk02 recvmsg01 fail:

tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
brk01.c:24: TINFO: Testing libc variant
brk01.c:54: TFAIL: brk() failed: ENOMEM (12)
brk01.c:61: TFAIL: brk() failed to set address have 0x40049000 expected 0x4004afff
brk01.c:21: TINFO: Testing syscall variant
brk01.c:61: TFAIL: brk() failed to set address have 0x40049000 expected 0x4004afff

tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
brk02.c:42: TINFO: Testing libc variant
brk02.c:27: TFAIL: brk() failed: ENOMEM (12)
brk02.c:60: TFAIL: Cannot expand brk() by page size: ENOMEM (12)
brk02.c:39: TINFO: Testing syscall variant
brk02.c:60: TFAIL: Cannot expand brk() by page size: EFAULT (14)

recvmsg01    1  TPASS  :  bad file descriptor successful
recvmsg01    2  TPASS  :  invalid socket successful
recvmsg01    3  TPASS  :  invalid socket buffer successful
recvmsg01    4  TPASS  :  invalid socket length successful
recvmsg01    5  TPASS  :  invalid recv buffer successful
recvmsg01    6  TPASS  :  invalid iovec buffer successful
recvmsg01    7  TPASS  :  invalid iovec count successful
recvmsg01    8  TPASS  :  rights reception successful
recvmsg01    9  TPASS  :  invalid MSG_OOB flag set successful
recvmsg01   10  TPASS  :  invalid MSG_ERRQUEUE flag set successful
recvmsg01   11  TPASS  :  invalid cmsg length successful
recvmsg01   12  TFAIL  :  recvmsg01.c:236: large cmesg length ; returned -1 (expected 0), 
errno 14 (expected 0)

With mips/stretch and mipsel/stretch I have one more, sbrk01:

sbrk01      1  TFAIL  :  sbrk01.c:102: sbrk - Increase by 8192 bytes failed: 
TEST_ERRNO=ENOMEM(12): Cannot allocate memory
sbrk01      2  TPASS  :  sbrk - Increase by -8192 bytes returned 0x4005f000

Thanks,
Laurent

On 7/15/23 15:53, Richard Henderson wrote:
> Use the interval tree to find empty space, rather than
> probing each page in turn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230707204054.8792-19-richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 52 ++++++-----------------------------------------
>   1 file changed, 6 insertions(+), 46 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index c4b2515271..738b9b797d 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -318,55 +318,15 @@ unsigned long last_brk;
>   static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
>                                           abi_ulong align)
>   {
> -    abi_ulong addr, end_addr, incr = qemu_host_page_size;
> -    int prot;
> -    bool looped = false;
> +    target_ulong ret;
>   
> -    if (size > reserved_va) {
> -        return (abi_ulong)-1;
> +    ret = page_find_range_empty(start, reserved_va, size, align);
> +    if (ret == -1 && start > mmap_min_addr) {
> +        /* Restart at the beginning of the address space. */
> +        ret = page_find_range_empty(mmap_min_addr, start - 1, size, align);
>       }
>   
> -    /* Note that start and size have already been aligned by mmap_find_vma. */
> -
> -    end_addr = start + size;
> -    /*
> -     * Start at the top of the address space, ignoring the last page.
> -     * If reserved_va == UINT32_MAX, then end_addr wraps to 0,
> -     * throwing the rest of the calculations off.
> -     * TODO: rewrite using last_addr instead.
> -     * TODO: use the interval tree instead of probing every page.
> -     */
> -    if (start > reserved_va - size) {
> -        end_addr = ((reserved_va - size) & -align) + size;
> -        looped = true;
> -    }
> -
> -    /* Search downward from END_ADDR, checking to see if a page is in use.  */
> -    addr = end_addr;
> -    while (1) {
> -        addr -= incr;
> -        if (addr > end_addr) {
> -            if (looped) {
> -                /* Failure.  The entire address space has been searched.  */
> -                return (abi_ulong)-1;
> -            }
> -            /* Re-start at the top of the address space (see above). */
> -            addr = end_addr = ((reserved_va - size) & -align) + size;
> -            looped = true;
> -        } else {
> -            prot = page_get_flags(addr);
> -            if (prot) {
> -                /* Page in use.  Restart below this page.  */
> -                addr = end_addr = ((addr - size) & -align) + size;
> -            } else if (addr && addr + size == end_addr) {
> -                /* Success!  All pages between ADDR and END_ADDR are free.  */
> -                if (start == mmap_next_start) {
> -                    mmap_next_start = addr;
> -                }
> -                return addr;
> -            }
> -        }
> -    }
> +    return ret;
>   }
>   
>   /*



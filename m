Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB5275FEE0
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 20:17:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO07E-0001Ri-KV; Mon, 24 Jul 2023 14:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qO07A-0001RJ-Kc
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:17:00 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qO078-0006Yw-JS
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690222614; x=1690827414; i=deller@gmx.de;
 bh=aUnOH2SleZ5UB+KJeruke/ECsxZVKpHhVMbtZzwkKTY=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=MFhAyd75+/U3+M5HjmftFwuWevl8xlWQk4Q1NdbDuPDcZ5FOCZ48hZmwEmw/wrfYhwSHRUx
 olNzJFXTCgVEfT9eKapTdx1eJWNxhW/8vdsIhYFOr8T3n4ymYTqmWVhrGtRhmjnHbxgxejIFE
 NsjSZksl51vRyQz2pEiPqH+ZLVa6q/qpsNq60qTTf1VHIN04h9s7t5WXtbsLbDf3OIqGH34y8
 wdDqQ00Nqbhnr/txFK9L0bN1oS7pPS7kqy7aEBZ/m5va+1x65g9JsSAhdjFHg3e7ShGuSldI8
 Y6Ibq/C44gAYjMHOWnY8Pd6XorYxpnIx2Ar3FWBmZ8b3uekM7X6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1qeADa47Db-00JezS; Mon, 24
 Jul 2023 20:16:54 +0200
Message-ID: <8c6268e5-5379-fe3a-a54a-0331e2e2eef4@gmx.de>
Date: Mon, 24 Jul 2023 20:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] linux-user: Fix qemu-arm to run static armhf binaries
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <ZL65b1xvYXLQtDgZ@p100>
In-Reply-To: <ZL65b1xvYXLQtDgZ@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOud4c/dzTMiXi/nJNVizr1MuMxy1f/yTEOdu+hB1+gfYjQhjEj
 ke9I+kBetqB8B7kFGOL9NAriB6wBVpXLoA+HHoVOHBzXGCV8s5ushwktB9TAQiZQwopFGR2
 tp3nye4AQsTdfaPXRSpUIjZgFmObHm8HSqSLrIkl4rH/3Fbdl1f8cZYm2mGqZ7Y84DYjdA1
 8Fp35lhsifakyORI8HPAQ==
UI-OutboundReport: notjunk:1;M01:P0:H4O6IinxiAU=;9ud2ZM6tMsIrHWklYro8GDGXz1F
 RAZHPXM+H9bMVEMi9IIV4xFvROed65J2sU6GKcIhslycN9qyj+w0Xn8BG8CxPDGB6LVwaaqL0
 0H0Jt1AQHwC1OFtuftiU+CNrMUuqPhVLnJj1EzFAMtuff/ZxRW+cj+OspvFniaIXvrFqHQwzC
 /rIWgPdNgfCCb40+//h8OurJRX3euH86Y46yzOO8c3J5AE9ASr6HXdopPbDEtFWAHc8uytuxa
 qZhhWgVL3Y0cRxFTmBi/+jss1CQGhovK1XLzHI2RoZZVn4a19f5YMXbPzVnoA5acwkjh1VmKQ
 5bk2aN41ugkm0UChzN/trhrrZKm/vQNL8aFsaYnIo7QOf9FM49/zTJV2VjiGc/cAFLrzLLohk
 ue1FIqxxUxW3CQa6f+pl7vhuM3Nnlzh1dKCrIZ4y6oxV2DoXoJYOaXRM5oupBE+HXHoumk5no
 52mPjaBrURy8cpw9TnqOusQfeTaN4XTOyxkB2UF8R5VQi0vyDR6OgIr+YC8rtfcmTh+Z/Ok8R
 2UkBFYO8BP3MAsX8z+XIxC/ROQQf7vA0JegcgYZ2wx00JwV5BzT/BiGncDN4Bys1wPmxUhQmB
 z0a7bzaWMu/2MmQWho3K02Jk8UTeOvdZP9cAKQrsUn6Hod7NHjA8ZpOOWNIDpknQjDM5RtmqI
 IfbhIIKKYXi/9gfX8nUis/FYfgOQYkMoSUUUyz8iaIuVGG2eYGUOcCN8IsPCbweUQFTWhbTco
 rqx3FPN3/YrTCI4YsZv8lN8kfAsJdniOV32cXjwrG4pqI886zLEdsI9bpxBRnbkRB5gVYGltg
 Mcyx2DtfdsRQP/d2YhAbZ7cr6A+L3RIydIejX1miqT1b89a2sydVPJGg/q9X4KDhpwgEutTkP
 RFNHReR3IoI6h34DpqSS1vVKrE0Y0aOIzR7HHUx340PsYIbL774SaZuVfCl0hZdYxUnmYvOQE
 L6OA0aNXWR0q6Witl2vAtSlYyAg=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/24/23 19:48, Helge Deller wrote:
> The last attempt to fix linux-user to be able to run static armhf
> binaries fixed armhf, but broke arm64, ppc64el and s390x.
>
> This patch takes another approach to fix the issue.
> Instead of pre-allocatig a 16/32 MiB memory region for heap, the loader
> tracks the highest address of both executable and interpreter.
>
> Then it compares both values and chooses the highest address from the
> executable as brk starting point, if the starting address of the
> interpreter leaves at least 16 MiB for the heap.
>
> If not, qemu will choose the highest address of the interpreter
> as brk start.
>
> I've tested this patch on arm64 and hppa (both with chroot), and with a
> static armhf binary.  It applies on top of git head, where the previous
> patch was reverted.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 861ec07abc..710ba03862 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3107,27 +3107,6 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>       }
>
>       if (pinterp_name !=3D NULL) {
> -        /*
> -         * This is the main executable.
> -         *
> -         * Reserve extra space for brk.
> -         * We hold on to this space while placing the interpreter
> -         * and the stack, lest they be placed immediately after
> -         * the data segment and block allocation from the brk.
> -         *
> -         * 16MB is chosen as "large enough" without being so large as
> -         * to allow the result to not fit with a 32-bit guest on a
> -         * 32-bit host. However some 64 bit guests (e.g. s390x)
> -         * attempt to place their heap further ahead and currently
> -         * nothing stops them smashing into QEMUs address space.
> -         */
> -#if TARGET_LONG_BITS =3D=3D 64
> -        info->reserve_brk =3D 32 * MiB;
> -#else
> -        info->reserve_brk =3D 16 * MiB;
> -#endif
> -        hiaddr +=3D info->reserve_brk;
> -
>           if (ehdr->e_type =3D=3D ET_EXEC) {
>               /*
>                * Make sure that the low address does not conflict with
> @@ -3194,7 +3173,8 @@ static void load_elf_image(const char *image_name,=
 int image_fd,
>       info->end_code =3D 0;
>       info->start_data =3D -1;
>       info->end_data =3D 0;
> -    info->brk =3D 0;
> +    /* put possible start for brk behind all sections of this ELF file.=
 */
> +    info->brk =3D load_bias + TARGET_PAGE_ALIGN(hiaddr);
>       info->elf_flags =3D ehdr->e_flags;
>
>       prot_exec =3D PROT_EXEC;
> @@ -3288,9 +3268,6 @@ static void load_elf_image(const char *image_name,=
 int image_fd,
>                       info->end_data =3D vaddr_ef;
>                   }
>               }
> -            if (vaddr_em > info->brk) {
> -                info->brk =3D vaddr_em;
> -            }
>   #ifdef TARGET_MIPS
>           } else if (eppnt->p_type =3D=3D PT_MIPS_ABIFLAGS) {
>               Mips_elf_abiflags_v0 abiflags;
> @@ -3618,6 +3595,15 @@ int load_elf_binary(struct linux_binprm *bprm, st=
ruct image_info *info)
>
>       if (elf_interpreter) {
>           load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
> +        /*
> +         * Use brk address of interpreter if it was loaded above the
> +         * executable and leaves less than 16 MB for heap.
> +         * This happens e.g. with static binaries on armhf.
> +         */
> +        if (interp_info.brk > info->brk &&
> +            info->load_bias + interp_info.load_addr - info->brk < 16 * =
MiB)  {

^^^
"info" is wrong here. should be interp_info.
I'll recheck and then send a v4.

Helge


> +            info->brk =3D interp_info.brk;
> +        }
>
>           /* If the program interpreter is one of these two, then assume
>              an iBCS2 image.  Otherwise assume a native linux image.  */
> @@ -3672,17 +3658,6 @@ int load_elf_binary(struct linux_binprm *bprm, st=
ruct image_info *info)
>       bprm->core_dump =3D &elf_core_dump;
>   #endif
>
> -    /*
> -     * If we reserved extra space for brk, release it now.
> -     * The implementation of do_brk in syscalls.c expects to be able
> -     * to mmap pages in this space.
> -     */
> -    if (info->reserve_brk) {
> -        abi_ulong start_brk =3D HOST_PAGE_ALIGN(info->brk);
> -        abi_ulong end_brk =3D HOST_PAGE_ALIGN(info->brk + info->reserve=
_brk);
> -        target_munmap(start_brk, end_brk - start_brk);
> -    }
> -
>       return 0;
>   }
>
>



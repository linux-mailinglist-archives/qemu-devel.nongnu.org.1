Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C310D76D82F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 21:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRHso-0003rn-Kd; Wed, 02 Aug 2023 15:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRHsm-0003rc-Q4
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:51:44 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRHsk-0002AU-HU
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691005896; x=1691610696; i=deller@gmx.de;
 bh=ZiFAQZpq+9imhw/keXdXJ5RGcUxG7Joy3gW7gNbNv+U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CbN61vxMmfe6ukA89tBFij0Gtj4WCEB+/ucIHNmi1Bi/7FAvKtAPf7V11gIbKY9O+cbXSSR
 Dtv/unMzQcOPHv0EFRBUMy/mjLzNMH4RzfK2oWJJruad9krOpYSWViF74EcYM+7Y98RPthiUW
 lqdFr8vwshyn3DKtDQ+A5YV6mdRKpCf7Uaa2zz9sECkFBFym4tPDWxL8RY9oPA3PmJBkg36E6
 nQKUQBd41198YeJdfOZl/uLQlio9iyjRxQhu9r5pNuanh2S7jEbGeCJZs6anIACQXgUsHOVlM
 AMYnjsqgJ3/SslAOk5ovw7AvrTkJBfTQ/5EvGQQ67OKMivKPcxvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1qLolP3T4e-00Y8ZK; Wed, 02
 Aug 2023 21:51:35 +0200
Message-ID: <07af035f-8ce0-7002-2fda-ab89cc2853d4@gmx.de>
Date: Wed, 2 Aug 2023 21:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 7/8] linux-user: Optimize memory layout for static and
 dynamic executables
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-8-deller@gmx.de>
 <bdf9ebc2-ef7a-7dd4-a742-8bbf5e836aea@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <bdf9ebc2-ef7a-7dd4-a742-8bbf5e836aea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c60St0m2anEUiVhWkB5oAYAyNFM8UBJCek+CfzrmG6kLwPldzXd
 EIilfsfi91pKL2DdbyhONYZJelVDe7qTcnp9VyiWMJzmrkqGGGoZbJHZTFO1gIf3k4NCGpV
 MNRq9bxZPw2OHW3uNTzPyn11H5ZjH063fAVxkjQ0nEBNu22Bsg9vSNyJBcxdaF/UvXtuuyy
 KVe+n8SPLh7UUxLJhF1hw==
UI-OutboundReport: notjunk:1;M01:P0:mf2tnyU6Kb0=;7R6YiZm6Wcjfg8BwGlhFIrxZxDK
 jP6CTbUeKQwzQ3K0urJEUotW0R8yTLaNqW2BRXQRY+sJm8Ssz12c/9AbtBJzyVUeZHEHyCoHM
 MYdiYJ9YkcA6VFLHUL53eQl3xbcdrTUJ0ULeO7mmznQcVJqnSSg4iszHS90gwrILk65tuRm7V
 Z7Xb4nNZna36iimv0wzkDpPYRFgHqtqRHhzyUxIQwH9CRhG3hQZdwf+JMHVNHaIKNy3/+Pxvj
 3m0mJlzXCUzKLfHFojwzE00vDR3sDwQMA0dXtDGH3LBskc4WxfNyPOzkudT/DiMMekM1iefdI
 6gQSJsPMaILiMDF78AZwlJIAxxjYycq5Fd/CgwVlvpsYpcyRIxJGXhom/welw5ML3D/0ruPhO
 cBhJDZd2jlbLNgoOMPoZjnBR/OXD1sMHpVyXDhFd1w1Bg9UnW0tx1hMGt86LfPeRSfwFE8Dgo
 8lE3x7L+PIG5yABAi7hPaBSbGUNrnPMrkQOjqhdrozmaxfKxvluT5J9FQsPryVnnNdSOmNQZC
 +RZEImMEP95fhq+8h7j36fQGLbYN2sArmvfQV7svgft+NZBs+1lC9GIMkABuGc/W5sspGU7bS
 XRBvfAyg8zFhhqzZidN6Ks97eSB1LGG2Su3S6FYnqyAb2BOBMoOojXZRo0Jr0IZO1R5Pba7nD
 1g5PgDvDCqYxUwzvl8ThpDnfos1dOst6TrIlgMiRAmX00E9Gl36tpdkMwOgL1w7kMquu31jpd
 TfqJqjc4fZQf6vE4HcXouezkdrsJO9khTCh1FwPWyVQLRsA+fgpQxXjVl02zWwzNJq2FtXKql
 EPz/P2/qFI8DupFxv5zb/3pnHPnSdUQsx+1xDfo/ZZ1G0yozspHz3Na7ATkqZUp+fPoXIRwct
 hQF/JPeNWCpmfo6dPe4IALTLcqsZzN4b4y0XzAeMnxOIgLsme57I9sf3r/PXCwyGFR+vB/uOL
 QjZY5uSGQltB4LFaqfcfTDlKXZU=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/2/23 20:25, Richard Henderson wrote:
> On 8/1/23 16:27, Helge Deller wrote:
>> Reorganize the guest memory layout to get as much memory as possible fo=
r
>> heap for the guest application.
>>
>> This patch optimizes the memory layout by loading pie executables
>> into lower memory and shared libs into higher memory (at
>> TASK_UNMAPPED_BASE). This leaves a bigger memory area usable for heap
>> space which will be located directly after the executable.
>> Up to now, pie executable and shared libs were loaded directly behind
>> each other in the area at TASK_UNMAPPED_BASE, which leaves very little
>> space for heap.
>>
>> I tested this patchset with chroots of alpha, arm, armel, arm64, hppa, =
m68k,
>> mips64el, mipsel, powerpc, ppc64, ppc64el, s390x, sh4 and sparc64 on a =
x86-64
>> host, and with a static armhf binary (which fails to run without this p=
atch).
>>
>> This patch temporarily breaks the Thread Sanitizer (TSan) application
>> which expects specific boundary definitions for memory mappings on
>> different platforms [1], see commit aab613fb9597 ("linux-user: Update
>> TASK_UNMAPPED_BASE for aarch64") for aarch64. The follow-up patch fixes=
 it
>> again.
>>
>> [1] https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/ts=
an/rtl/tsan_platform.h
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 linux-user/elfload.c | 55 +++++++++++++-------------------------=
------
>> =C2=A0 linux-user/mmap.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++---
>> =C2=A0 2 files changed, 21 insertions(+), 42 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 2aee2298ec..47a118e430 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3023,6 +3023,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong load_addr, load_bias, loaddr, =
hiaddr, error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, retval, prot_exec;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 bool is_main_executable;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* First of all, some simple consistency=
 checks */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!elf_check_ident(ehdr)) {
>> @@ -3106,28 +3107,8 @@ static void load_elf_image(const char *image_nam=
e, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 if (pinterp_name !=3D NULL) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is the main ex=
ecutable.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Reserve extra space=
 for brk.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We hold on to this =
space while placing the interpreter
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and the stack, lest=
 they be placed immediately after
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the data segment an=
d block allocation from the brk.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 16MB is chosen as "=
large enough" without being so large as
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to allow the result=
 to not fit with a 32-bit guest on a
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 32-bit host. Howeve=
r some 64 bit guests (e.g. s390x)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * attempt to place th=
eir heap further ahead and currently
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nothing stops them =
smashing into QEMUs address space.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -#if TARGET_LONG_BITS =3D=3D 64
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->reserve_brk =3D 32 * =
MiB;
>> -#else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->reserve_brk =3D 16 * =
MiB;
>> -#endif
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hiaddr +=3D info->reserve_b=
rk;
>> -
>> +=C2=A0=C2=A0=C2=A0 is_main_executable =3D (pinterp_name !=3D NULL);
>
> This will be false for static main executables.

[deller@p100 qemu-helge-user-armhf]$ file fstype
fstype: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically=
 linked, interpreter /lib/klibc-PupSAGgtpafMlSLXOLgje1kXFo8.so, BuildID[sh=
a1]=3D45aac32edcd204fd6fa06febf3abff274ab39b26, stripped

And for real static binaries (without interpreter), the "loadaddr" is set =
in the mmap below,
and MAP_FIX isn't needed then.

>> +=C2=A0=C2=A0=C2=A0 if (is_main_executable) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ehdr->e_type=
 =3D=3D ET_EXEC) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * Make sure that the low address does not conflict with
>> @@ -3136,7 +3117,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 probe_guest_base(image_name, loaddr, hiaddr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * The binary is dynamic, but we still need to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * The binary is dynamic (pie-executabe), but we still need to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * select guest_base.=C2=A0 In this case we pass a size.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 probe_guest_base(image_name, 0, hiaddr - loaddr);
>> @@ -3159,7 +3140,7 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_addr =3D target_mmap(loaddr, (size_=
t)hiaddr - loaddr + 1, PROT_NONE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED : 0),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (is_main_executable ? MAP_FIXED : 0),
>
> This is definitely wrong, as all ET_EXEC require FIXED.

Not if the PIE flag is set too and even here the loadaddr defines where
it will be loaded then.

> (In addition to static, it is possible to write an ET_EXEC interpreter.)
>
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -299,14 +299,16 @@ static bool mmap_frag(abi_ulong real_start, abi_u=
long start, abi_ulong last,
>> =C2=A0 #ifdef TARGET_AARCH64
>> =C2=A0 # define TASK_UNMAPPED_BASE=C2=A0 0x5500000000
>> =C2=A0 #else
>> -# define TASK_UNMAPPED_BASE=C2=A0 (1ul << 38)
>> +# define TASK_UNMAPPED_BASE=C2=A0 0x4000000000
>> =C2=A0 #endif
>> -#else
>> +#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
>> =C2=A0 #ifdef TARGET_HPPA
>> =C2=A0 # define TASK_UNMAPPED_BASE=C2=A0 0xfa000000
>> =C2=A0 #else
>> -# define TASK_UNMAPPED_BASE=C2=A0 0x40000000
>> +# define TASK_UNMAPPED_BASE=C2=A0 0xe0000000
>> =C2=A0 #endif
>> +#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
>> +# define TASK_UNMAPPED_BASE=C2=A0 0x40000000
>> =C2=A0 #endif
>> =C2=A0 abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
>
> This should be a separate change.
>
> While we're at it, we should move this to e.g.
> linux-user/$GUEST/target_mman.h, and make this match each guest
> kernel's TASK_UNMAPPED_BASE.  It really shouldn't depend on the host
> at all.

I think it matters if you want to run a 32-bit guest on 32-bit host?
Those TASK_UNMAPPED_BASE are actually TARGET_TASK_UNMAPPED_BASE values.

Helge


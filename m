Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC27BA6FD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRSa-0007eL-Do; Thu, 05 Oct 2023 12:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRSX-0007YX-Rn
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:44:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRSP-0003zh-1S
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:44:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so1097944f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696524251; x=1697129051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BswUoAb4byZr1JE2WOnVQoC33Y+Qe/W5KnxKYz9MPWs=;
 b=zuo2JWRtkJwBpTBx04u+G8pphT6R6PTY8vbq9QF9hSgtItXQ1vNDuAmrw4R36tK8o9
 RNY8lgd970LMITC64y1VtuYLAcRNVbFybMN0jAtziaPQeL/54xA/5FVzeWF6rufF3pX9
 6o9R3M3znhv/ifMbhpU763XPOgt/d5Gtiio9AsYG2BVBXx3dDb1VOOBYSNpEw4WQBhTo
 kxXAAln6f5YkxR+CzfoByCGwDFqa2xp8KrKUsOpszm1BCf7Y7wovH/71EpVtLBJHNW79
 hDULipSFNzOYqJO8Zx/UCQp/3j+php9uufQC0/vROLIbyHAf/mb8h50oTK5tXfcbgaTP
 FbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696524251; x=1697129051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BswUoAb4byZr1JE2WOnVQoC33Y+Qe/W5KnxKYz9MPWs=;
 b=tMyizIadVv7DbviJdSiVwqCPmQYNLlJbacFR1ZzqQzZlwFNgm3c8C1LPJyEThJ1Cpq
 sVYr2KI4REL4RGowcS2g4covMTc7VYHnnWpgB4E+/7nhWAFrlKcgecsRhcS+mUJwzntl
 19cgWMx8/CXAj/nmnnfC1+7gOct42jUqR1rW4URBriqnJoCBVRTa2M6/LxOw8vc03ABG
 sRVMho4mdoRogzZUONlZWdJ76Sjri1o2EmyDmhy8ziuJ15sYiGsIMs0N+IOLQN/mxlei
 /K1R82yoFYU13H0/aBOQWRreq4nre1kOKOFDfDeeSrWIhTu8aKKeir58NTO24wzmo4eJ
 UfHw==
X-Gm-Message-State: AOJu0Yy5lV91onh9dEaEsFNw7/QZoDdVIca9hAwCML8uhVA01jddMvr4
 xUQo13XsQheOE7+Uby6bH0Gl9g==
X-Google-Smtp-Source: AGHT+IF/Frj5t9NvmG0ww7plpAzzsfuBiYTU+J2Ec6C0Y5Y2uNnbk1uTqj6+ZWj7E1qO/nP0ZUs94Q==
X-Received: by 2002:a05:6000:186:b0:324:8353:940e with SMTP id
 p6-20020a056000018600b003248353940emr5389795wrx.34.1696524251341; 
 Thu, 05 Oct 2023 09:44:11 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a5d4d92000000b00327cd5e5ac1sm2196735wru.1.2023.10.05.09.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:44:10 -0700 (PDT)
Message-ID: <f92b0503-a922-76d8-7daf-c1bffd5c7641@linaro.org>
Date: Thu, 5 Oct 2023 18:44:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 10/19] linux-user/x86_64: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/9/23 04:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c            |   4 +-
>   linux-user/x86_64/Makefile.vdso |  11 +++++
>   linux-user/x86_64/meson.build   |   4 ++
>   linux-user/x86_64/vdso.S        |  78 ++++++++++++++++++++++++++++++++
>   linux-user/x86_64/vdso.ld       |  73 ++++++++++++++++++++++++++++++
>   linux-user/x86_64/vdso.so       | Bin 0 -> 2968 bytes
>   6 files changed, 168 insertions(+), 2 deletions(-)
>   create mode 100644 linux-user/x86_64/Makefile.vdso
>   create mode 100644 linux-user/x86_64/vdso.S
>   create mode 100644 linux-user/x86_64/vdso.ld
>   create mode 100755 linux-user/x86_64/vdso.so

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 314ae7cacf..1e1fdce656 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -318,10 +318,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
>           }                                               \
>       } while (0)
>   
> -#define VDSO_HEADER "vdso.c.inc"
> -
>   #endif /* TARGET_X86_64 */
>   
> +#define VDSO_HEADER "vdso.c.inc"
> +
>   #define USE_ELF_CORE_DUMP
>   #define ELF_EXEC_PAGESIZE       4096
>   
> diff --git a/linux-user/x86_64/Makefile.vdso b/linux-user/x86_64/Makefile.vdso
> new file mode 100644
> index 0000000000..26552b66db
> --- /dev/null
> +++ b/linux-user/x86_64/Makefile.vdso
> @@ -0,0 +1,11 @@
> +include $(BUILD_DIR)/tests/tcg/x86_64-linux-user/config-target.mak
> +
> +SUBDIR = $(SRC_PATH)/linux-user/x86_64
> +VPATH += $(SUBDIR)
> +
> +all: $(SUBDIR)/vdso.so
> +
> +$(SUBDIR)/vdso.so: vdso.S vdso.ld
> +	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
> +	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
> +	  -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/x86_64/meson.build b/linux-user/x86_64/meson.build
> index 203af9a60c..8c60da7a60 100644
> --- a/linux-user/x86_64/meson.build
> +++ b/linux-user/x86_64/meson.build
> @@ -3,3 +3,7 @@ syscall_nr_generators += {
>                         arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
>                         output: '@BASENAME@_nr.h')
>   }
> +
> +vdso_inc = gen_vdso.process('vdso.so')
> +
> +linux_user_ss.add(when: 'TARGET_X86_64', if_true: vdso_inc)
> diff --git a/linux-user/x86_64/vdso.S b/linux-user/x86_64/vdso.S
> new file mode 100644
> index 0000000000..47d16c00ab
> --- /dev/null
> +++ b/linux-user/x86_64/vdso.S
> @@ -0,0 +1,78 @@
> +/*
> + * x86-64 linux replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <asm/unistd.h>
> +
> +.macro endf name
> +	.globl	\name
> +	.type	\name, @function
> +	.size	\name, . - \name
> +.endm
> +
> +.macro weakalias name
> +\name	= __vdso_\name
> +	.weak	\name
> +.endm
> +
> +.macro vdso_syscall name, nr
> +__vdso_\name:
> +	mov	$\nr, %eax
> +	syscall
> +	ret
> +endf	__vdso_\name
> +weakalias \name
> +.endm
> +
> +	.cfi_startproc
> +
> +vdso_syscall clock_gettime, __NR_clock_gettime
> +vdso_syscall clock_getres, __NR_clock_getres
> +vdso_syscall gettimeofday, __NR_gettimeofday
> +vdso_syscall time, __NR_time
> +
> +__vdso_getcpu:
> +	/*
> +         * There is no syscall number for this allocated on x64.
> +	 * We can handle this several ways:
> +         *
> +	 * (1) Invent a syscall number for use within qemu.
> +         *     It should be easy enough to pick a number that
> +         *     is well out of the way of the kernel numbers.
> +         *
> +         * (2) Force the emulated cpu to support the rdtscp insn,
> +	 *     and initialize the TSC_AUX value the appropriate value.
> +         *
> +	 * (3) Pretend that we're always running on cpu 0.
> +         *
> +	 * This last is the one that's implemented here, with the
> +	 * tiny bit of extra code to support rdtscp in place.
> +         */
> +	xor	%ecx, %ecx		/* rdtscp w/ tsc_aux = 0 */
> +
> +	/* if (cpu != NULL) *cpu = (ecx & 0xfff); */
> +	test	%rdi, %rdi
> +	jz	1f
> +	mov	%ecx, %eax
> +	and	$0xfff, %eax
> +	mov	%eax, (%rdi)
> +
> +	/* if (node != NULL) *node = (ecx >> 12); */
> +1:	test	%rsi, %rsi
> +	jz	2f
> +	shr	$12, %ecx
> +	mov	%ecx, (%rsi)
> +
> +2:	xor	%eax, %eax
> +	ret
> +endf	__vdso_getcpu
> +
> +weakalias getcpu
> +
> +	.cfi_endproc
> +
> +/* TODO: Add elf note for LINUX_VERSION_CODE */
> diff --git a/linux-user/x86_64/vdso.ld b/linux-user/x86_64/vdso.ld
> new file mode 100644
> index 0000000000..ca6001cc3c
> --- /dev/null
> +++ b/linux-user/x86_64/vdso.ld
> @@ -0,0 +1,73 @@
> +/*
> + * Linker script for linux x86-64 replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +VERSION {
> +        LINUX_2.6 {
> +        global:
> +                clock_gettime;
> +                __vdso_clock_gettime;
> +                gettimeofday;
> +                __vdso_gettimeofday;
> +                getcpu;
> +                __vdso_getcpu;
> +                time;
> +                __vdso_time;
> +                clock_getres;
> +                __vdso_clock_getres;
> +
> +        local: *;
> +        };
> +}
> +
> +
> +PHDRS {
> +        phdr            PT_PHDR         FLAGS(4) PHDRS;
> +        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS; /* FLAGS=RWX */
> +        dynamic         PT_DYNAMIC      FLAGS(4);
> +        eh_frame_hdr    PT_GNU_EH_FRAME;
> +        note            PT_NOTE         FLAGS(4);
> +}
> +
> +SECTIONS {
> +        . = SIZEOF_HEADERS;
> +
> +        /*
> +         * The following, including the FILEHDRS and PHDRS, are modified
> +         * when we relocate the binary.  We want them to be initially
> +         * writable for the relocation; we'll force them read-only after.
> +         */
> +        .note           : { *(.note*) }         :load :note
> +        .dynamic        : { *(.dynamic) }       :load :dynamic
> +        .dynsym         : { *(.dynsym) }        :load
> +        .data           : {
> +                /*
> +                 * There ought not be any real read-write data.
> +                 * But since we manipulated the segment layout,
> +                 * we have to put these sections somewhere.
> +                 */
> +                *(.data*)
> +                *(.sdata*)
> +                *(.got.plt) *(.got)
> +                *(.gnu.linkonce.d.*)
> +                *(.bss*)
> +                *(.dynbss*)
> +                *(.gnu.linkonce.b.*)
> +        }
> +
> +        .rodata         : { *(.rodata*) }
> +        .hash           : { *(.hash) }
> +        .gnu.hash       : { *(.gnu.hash) }
> +        .dynstr         : { *(.dynstr) }
> +        .gnu.version    : { *(.gnu.version) }
> +        .gnu.version_d  : { *(.gnu.version_d) }
> +        .gnu.version_r  : { *(.gnu.version_r) }
> +        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
> +        .eh_frame       : { *(.eh_frame) }      :load
> +
> +        .text           : { *(.text*) }         :load   =0x90909090
> +}
> diff --git a/linux-user/x86_64/vdso.so b/linux-user/x86_64/vdso.so
> new file mode 100755
> index 0000000000000000000000000000000000000000..c873d6ea580b393825506d2ffbddcf9827d89e14
> GIT binary patch
> literal 2968
> zcmcgtO=w(I6uvKUOl$t7l}J=nY6?Lgol-PVEvcEL6HP)om@-1c>vZO|6VjQnGcRQ#
> zQlk(xE{v3}x(Eh$E+iYFJ0pdXxDr=E=&lLvMs(4vwBz~aoiCl-j=CuHBzL}hzkANP
> z=iPhmJs%H_3^h28p){If=E2CAex2B8q6WA=6OrF`(`KF&`Uz?MI&EW@IwS5;J<v5S
> zm3;u8M8ZDNbcEvu0jxKter?<dUgx>q_-2rSodh0=h5M8yR&|8~q9xUzjR(|@2weye
> zz8a;S7@IIXlUIKD#o1b1+rN5odUE>L=z;rh$dv40C`m=ye*;62d-p2^;2j+^>^@b*
> z{zK-lF(OZeV2X;(id~9-RYHGjYX7&6)!h7{<L?-V+C6T-xxH+fO-w(S=h!R!)55=J
> z@z1ONh{Zpn`Zga`ecR75)jw_d8B~3nM_M2rJI<`|o#xMqz%F@5M$pfwf5Z(rDGlFi
> z^EmbvX*g$?a37>=_DaLK@yv17h==zIwme4kF^2|U3rG4QL%vz2K73uCxOLI|+`aN!
> z$F-%z;-Tzk@6K<ve)YnqSIbKuJ^SrI{>$E*Jv}RD{ao_%it)TlnNq<^Unr!fz4Lw$
> zOy&HC$f92&rz(YWnba(~S{s>9e=uV%Oyy_Fufeq||4}nCJT{T^4!f^Qd<}K~WJ1Kz
> zzvUl)Z^gZPP8#nNzOg~(w`aa@<o(9^K%DNzqu`(ulXgfNgnG`03FDMIobHyUJzt9w
> zo+0?gnY<+pa{adav`21S-&8!KxE^A3Jw9Iv_AacwQfZf+Z;H=v2a%udwk)(oS8s^Q
> ze+lApB>FjYY9u^!IW^5APGzK1@7^HK>gD4>;p^R}arI;0o1?04=jpKWw!W)=?0Yt=
> zynUbER^IkMss3a7y}So_=McZ`$9S>#$BvH<4@j=b`|AzHy`jYM(LpaBOVlKlW^ujb
> z)P%J2ye6gV=6*G&ja!<{1*x-wK{3QEd-+1(8#gnXPvxf4)sE;I_k4cF&8AA(kO_(*
> zbIC83rV9C8121D-KkJ<<rgFZQ&4?yP#tr;(AUpEt(k(9Vj<7ELTixSId}la*Nji9E
> z@a{mEzeGvus<3|XJhjXlyz_X^xc;1Wh%eUIqf2|%IlLE07230&5^>idjF0yGj>9sy
> zEwzyLtiMFu4~T6avc|lrbF^o@CbB+LUq6S#>RVK)S)cWo$nWI(T!)Byg4)h8>pihg
> zSHk{7hu^QXIU^m!MEjk0M(-crN9uFmIL=%4U1~>sm5Pe?`en6ee(>HC`S#L{y??u6
> vr;^|o8ppUAv<ink<oeuK)I;vAba!M!1G>D!gdKbRPND1BpVH#|fA;?X5$6$T
> 
> literal 0
> HcmV?d00001
> 



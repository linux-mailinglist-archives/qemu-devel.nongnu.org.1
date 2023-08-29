Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F278D03C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nx-0001uF-97; Tue, 29 Aug 2023 19:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nR-0002R0-CM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:51 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nL-00049h-C4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:47 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a88ef953adso3442793b6e.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346562; x=1693951362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeodzQae6xgscra1MOigH7Kir+wMGq9VLUD6APjis3k=;
 b=MpM4tcEAt6KKfGBWgeH9Kl7o0ROQVVsCLLCWhidU7dTQ4FY5D213QeDphznixmux89
 GoJR9d1tt7ns5SAqTI+gwbwdm41l2SkphI97ttvkPTMcvgRIKm6KAcAwE//TiioPg7JZ
 f9IQJ5yGymV8k1BStUTE9CcDBIsLrz6t9Q1kDGOxVzxajsXLp7NwxGaLthCpRSr73on5
 MizGt3LzWwwy4b6dvzWfGjwQ0IJxGctelgwOovQB49P8IUVg56K5Z26oiYLraPzam+/Y
 vYTlq0R4hzNFgIJGFgzhGfOxa5pWd9ilFuYJ3srHIpy9tW91qhQM78ajPvc2C29EPBE3
 kNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346562; x=1693951362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeodzQae6xgscra1MOigH7Kir+wMGq9VLUD6APjis3k=;
 b=F0TmykmYL/Rih+fn0ydsh4HQGiHJSLVQpWoqXSjzfym6tWtJ5WVWakFlIRtu2dE7TV
 fTLTGzoINVtbHVG/7s6XBNNNdUYoSL6oxbygFRW4+QdcbSVROP6CpySQgtgC457GIda6
 iUo6Xh3wj+HOZSVFomyR/1r84JFy/bv54i8ttlR0vxub49ouFXz3r4HTxuvwMLb3iK/p
 ty/zU8Pcvfuc4hq7AnAPllc6XIChaCKdq0dzuaCbL+J0VI3xhv46znMIjOFDRR+NCoHN
 5SDhYr/QqeP1sdppVGDm3t/lVC/eg83RHLG4HOircAjnTrjFntBBTNNt5ffGpiLalI/V
 27Xw==
X-Gm-Message-State: AOJu0YwmpyylPlJpCcMSiig9SAKyiT2peCJalSOx+IA5pcguLGYPsifv
 zcqTargLgrTUOzQl8XF8Lh8C5wmnD6ciEtNfsPY=
X-Google-Smtp-Source: AGHT+IGvB5vl2wY3mepkyCZo4rt/jGJZptxDN5k1wb52Q8VjdGQ0BtFAngzVl0R1qKJuXEBA0RTBmQ==
X-Received: by 2002:a54:4413:0:b0:3a7:af4c:2406 with SMTP id
 k19-20020a544413000000b003a7af4c2406mr304177oiw.44.1693346561762; 
 Tue, 29 Aug 2023 15:02:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 12/20] linux-user/x86_64: Add vdso
Date: Tue, 29 Aug 2023 15:02:20 -0700
Message-Id: <20230829220228.928506-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c          |   4 +-
 linux-user/x86_64/meson.build |  20 +++++++++
 linux-user/x86_64/vdso.S      |  78 ++++++++++++++++++++++++++++++++++
 linux-user/x86_64/vdso.ld     |  73 +++++++++++++++++++++++++++++++
 linux-user/x86_64/vdso.so     | Bin 0 -> 2968 bytes
 5 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/x86_64/vdso.S
 create mode 100644 linux-user/x86_64/vdso.ld
 create mode 100755 linux-user/x86_64/vdso.so

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fb876ae30a..b421f04675 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -317,12 +317,12 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define DLINFO_ARCH_ITEMS 1
 #define ARCH_DLINFO       NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);
 
+#endif /* TARGET_X86_64 */
+
 #include "vdso.c.inc"
 
 #define vdso_image_info()    &vdso_image_info
 
-#endif /* TARGET_X86_64 */
-
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
diff --git a/linux-user/x86_64/meson.build b/linux-user/x86_64/meson.build
index 203af9a60c..6744563a11 100644
--- a/linux-user/x86_64/meson.build
+++ b/linux-user/x86_64/meson.build
@@ -3,3 +3,23 @@ syscall_nr_generators += {
                       arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                       output: '@BASENAME@_nr.h')
 }
+
+vdso_so = custom_target(output: 'vdso.so',
+                        input: files('vdso.S', 'vdso.ld'),
+                        command: [
+                            build_vdso_cmd,
+                            '-B', meson.project_build_root(),
+                            '-C', meson.current_source_dir(),
+                            '-T', 'x86_64-linux-user',
+                            '-o', '@OUTPUT@',
+	                    '--', '-nostdlib', '-shared',
+	                    '-Wl,-h,linux-vdso.so.1',
+                            '-Wl,--build-id=sha1',
+                            '-Wl,--hash-style=both',
+                            '-Wl,-T,@INPUT1@',
+                            '@INPUT0@'
+                        ])
+
+vdso_inc = gen_vdso.process(vdso_so)
+
+linux_user_ss.add(when: 'TARGET_X86_64', if_true: vdso_inc)
diff --git a/linux-user/x86_64/vdso.S b/linux-user/x86_64/vdso.S
new file mode 100644
index 0000000000..47d16c00ab
--- /dev/null
+++ b/linux-user/x86_64/vdso.S
@@ -0,0 +1,78 @@
+/*
+ * x86-64 linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+.macro weakalias name
+\name	= __vdso_\name
+	.weak	\name
+.endm
+
+.macro vdso_syscall name, nr
+__vdso_\name:
+	mov	$\nr, %eax
+	syscall
+	ret
+endf	__vdso_\name
+weakalias \name
+.endm
+
+	.cfi_startproc
+
+vdso_syscall clock_gettime, __NR_clock_gettime
+vdso_syscall clock_getres, __NR_clock_getres
+vdso_syscall gettimeofday, __NR_gettimeofday
+vdso_syscall time, __NR_time
+
+__vdso_getcpu:
+	/*
+         * There is no syscall number for this allocated on x64.
+	 * We can handle this several ways:
+         *
+	 * (1) Invent a syscall number for use within qemu.
+         *     It should be easy enough to pick a number that
+         *     is well out of the way of the kernel numbers.
+         *
+         * (2) Force the emulated cpu to support the rdtscp insn,
+	 *     and initialize the TSC_AUX value the appropriate value.
+         *
+	 * (3) Pretend that we're always running on cpu 0.
+         *
+	 * This last is the one that's implemented here, with the
+	 * tiny bit of extra code to support rdtscp in place.
+         */
+	xor	%ecx, %ecx		/* rdtscp w/ tsc_aux = 0 */
+
+	/* if (cpu != NULL) *cpu = (ecx & 0xfff); */
+	test	%rdi, %rdi
+	jz	1f
+	mov	%ecx, %eax
+	and	$0xfff, %eax
+	mov	%eax, (%rdi)
+
+	/* if (node != NULL) *node = (ecx >> 12); */
+1:	test	%rsi, %rsi
+	jz	2f
+	shr	$12, %ecx
+	mov	%ecx, (%rsi)
+
+2:	xor	%eax, %eax
+	ret
+endf	__vdso_getcpu
+
+weakalias getcpu
+
+	.cfi_endproc
+
+/* TODO: Add elf note for LINUX_VERSION_CODE */
diff --git a/linux-user/x86_64/vdso.ld b/linux-user/x86_64/vdso.ld
new file mode 100644
index 0000000000..ca6001cc3c
--- /dev/null
+++ b/linux-user/x86_64/vdso.ld
@@ -0,0 +1,73 @@
+/*
+ * Linker script for linux x86-64 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6 {
+        global:
+                clock_gettime;
+                __vdso_clock_gettime;
+                gettimeofday;
+                __vdso_gettimeofday;
+                getcpu;
+                __vdso_getcpu;
+                time;
+                __vdso_time;
+                clock_getres;
+                __vdso_clock_getres;
+
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS; /* FLAGS=RWX */
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
+        . = SIZEOF_HEADERS;
+
+        /*
+         * The following, including the FILEHDRS and PHDRS, are modified
+         * when we relocate the binary.  We want them to be initially
+         * writable for the relocation; we'll force them read-only after.
+         */
+        .note           : { *(.note*) }         :load :note
+        .dynamic        : { *(.dynamic) }       :load :dynamic
+        .dynsym         : { *(.dynsym) }        :load
+        .data           : {
+                /*
+                 * There ought not be any real read-write data.
+                 * But since we manipulated the segment layout,
+                 * we have to put these sections somewhere.
+                 */
+                *(.data*)
+                *(.sdata*)
+                *(.got.plt) *(.got)
+                *(.gnu.linkonce.d.*)
+                *(.bss*)
+                *(.dynbss*)
+                *(.gnu.linkonce.b.*)
+        }
+
+        .rodata         : { *(.rodata*) }
+        .hash           : { *(.hash) }
+        .gnu.hash       : { *(.gnu.hash) }
+        .dynstr         : { *(.dynstr) }
+        .gnu.version    : { *(.gnu.version) }
+        .gnu.version_d  : { *(.gnu.version_d) }
+        .gnu.version_r  : { *(.gnu.version_r) }
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :load
+
+        .text           : { *(.text*) }         :load   =0x90909090
+}
diff --git a/linux-user/x86_64/vdso.so b/linux-user/x86_64/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..c873d6ea580b393825506d2ffbddcf9827d89e14
GIT binary patch
literal 2968
zcmcgtO=w(I6uvKUOl$t7l}J=nY6?Lgol-PVEvcEL6HP)om@-1c>vZO|6VjQnGcRQ#
zQlk(xE{v3}x(Eh$E+iYFJ0pdXxDr=E=&lLvMs(4vwBz~aoiCl-j=CuHBzL}hzkANP
z=iPhmJs%H_3^h28p){If=E2CAex2B8q6WA=6OrF`(`KF&`Uz?MI&EW@IwS5;J<v5S
zm3;u8M8ZDNbcEvu0jxKter?<dUgx>q_-2rSodh0=h5M8yR&|8~q9xUzjR(|@2weye
zz8a;S7@IIXlUIKD#o1b1+rN5odUE>L=z;rh$dv40C`m=ye*;62d-p2^;2j+^>^@b*
z{zK-lF(OZeV2X;(id~9-RYHGjYX7&6)!h7{<L?-V+C6T-xxH+fO-w(S=h!R!)55=J
z@z1ONh{Zpn`Zga`ecR75)jw_d8B~3nM_M2rJI<`|o#xMqz%F@5M$pfwf5Z(rDGlFi
z^EmbvX*g$?a37>=_DaLK@yv17h==zIwme4kF^2|U3rG4QL%vz2K73uCxOLI|+`aN!
z$F-%z;-Tzk@6K<ve)YnqSIbKuJ^SrI{>$E*Jv}RD{ao_%it)TlnNq<^Unr!fz4Lw$
zOy&HC$f92&rz(YWnba(~S{s>9e=uV%Oyy_Fufeq||4}nCJT{T^4!f^Qd<}K~WJ1Kz
zzvUl)Z^gZPP8#nNzOg~(w`aa@<o(9^K%DNzqu`(ulXgfNgnG`03FDMIobHyUJzt9w
zo+0?gnY<+pa{adav`21S-&8!KxE^A3Jw9Iv_AacwQfZf+Z;H=v2a%udwk)(oS8s^Q
ze+lApB>FjYY9u^!IW^5APGzK1@7^HK>gD4>;p^R}arI;0o1?04=jpKWw!W)=?0Yt=
zynUbER^IkMss3a7y}So_=McZ`$9S>#$BvH<4@j=b`|AzHy`jYM(LpaBOVlKlW^ujb
z)P%J2ye6gV=6*G&ja!<{1*x-wK{3QEd-+1(8#gnXPvxf4)sE;I_k4cF&8AA(kO_(*
zbIC83rV9C8121D-KkJ<<rgFZQ&4?yP#tr;(AUpEt(k(9Vj<7ELTixSId}la*Nji9E
z@a{mEzeGvus<3|XJhjXlyz_X^xc;1Wh%eUIqf2|%IlLE07230&5^>idjF0yGj>9sy
zEwzyLtiMFu4~T6avc|lrbF^o@CbB+LUq6S#>RVK)S)cWo$nWI(T!)Byg4)h8>pihg
zSHk{7hu^QXIU^m!MEjk0M(-crN9uFmIL=%4U1~>sm5Pe?`en6ee(>HC`S#L{y??u6
vr;^|o8ppUAv<ink<oeuK)I;vAba!M!1G>D!gdKbRPND1BpVH#|fA;?X5$6$T

literal 0
HcmV?d00001

-- 
2.34.1



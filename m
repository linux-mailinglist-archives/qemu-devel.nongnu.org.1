Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413307DC1C2
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:20:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeV-0001hO-U2; Mon, 30 Oct 2023 17:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdv-00010O-Sp
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdm-0006Ut-AI
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so37448415ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700659; x=1699305459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rKwQXQ2qQHHnqM2GXf0sWy0oFd+5mMN8UFsU+MjJSA=;
 b=FNkZxC5mSfN7ZF8c0XS+WTxUh+B2mmwVPIWhXe7UEgNorQlTBQrcBPsMJ62V4IQp7q
 TqnAIWBsxM7wE31y78yV0qrmScOivAjV42JUxKotP7Ro7svIG+i+i5TJ/4jwuWIcdYEA
 Dex7gZbZ2zk3EKJaU1YxBjV6j2iA4SUeXqQGq0AF0bVyLltHhF0n3BUH2m5WC7zesP0v
 BIm1C3ioI5Mx4+zBe5SBawXa2Z0HnxosSnbPD3sB3yhvO+tpO/heFRAGclI1ptF1M5Yf
 0RlRqjgE3DdAqXWktHw8nEGAwenC62to6npEEgDM1h0XlPO1m4Os7utaizim6FBQ6ScA
 VLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700659; x=1699305459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rKwQXQ2qQHHnqM2GXf0sWy0oFd+5mMN8UFsU+MjJSA=;
 b=PTb3zRJrNCGgd4b8A2tz2JfDOZbBvFdrRVukOMDmiAMy3zSfEheBhiUI/cNMeuw7AK
 QCWo9TgUdPJz35NHgM6xN+gBr7HQPzcKVN6Y3dIkRizag/YPMoo3lfTcw4Q/vbRUj23e
 QtRrL+fY4cn8TwYvwqEyf6+GJYdu9Jx6hNLXwLArp3Q3AN27pw9HnI/4FywT+BxGtz8H
 tY2iYSlTEECl3F7Fp7x9H9t3Mt+7/QcGjMr9133k5Td4Z8oDZWHVFbwkNKxT5JwadRbm
 kvddox0FZ+kFHMZ1b/k4Zh2CYimI0msInqWifD0OcWB+FrHnbdytabbdH5piETey9h6/
 kbJg==
X-Gm-Message-State: AOJu0YwPjcTIVGhpsrokpu3Nup5atn2PDYlgTzjGVoCMuAswmsJ4mCY2
 eL9993BJeDhdI44ZsKOrT2on+gQbwJN46np2aQo=
X-Google-Smtp-Source: AGHT+IEKtB3/+kbZq6Q8LKUN+r84eS1rjVm8WYhahC2+Y0o0QRDBFiaSZ0THK43tdkfnDrIywBiJWw==
X-Received: by 2002:a17:902:e845:b0:1cc:3fce:8aa8 with SMTP id
 t5-20020a170902e84500b001cc3fce8aa8mr4597429plg.6.1698700658602; 
 Mon, 30 Oct 2023 14:17:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/21] linux-user/x86_64: Add vdso
Date: Mon, 30 Oct 2023 14:17:17 -0700
Message-Id: <20231030211727.165090-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c            |   4 +-
 linux-user/x86_64/Makefile.vdso |  11 +++++
 linux-user/x86_64/meson.build   |   4 ++
 linux-user/x86_64/vdso.S        |  78 ++++++++++++++++++++++++++++++++
 linux-user/x86_64/vdso.ld       |  73 ++++++++++++++++++++++++++++++
 linux-user/x86_64/vdso.so       | Bin 0 -> 2968 bytes
 6 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/x86_64/Makefile.vdso
 create mode 100644 linux-user/x86_64/vdso.S
 create mode 100644 linux-user/x86_64/vdso.ld
 create mode 100755 linux-user/x86_64/vdso.so

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 46f73a4166..62a33481e1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -318,10 +318,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
         }                                               \
     } while (0)
 
-#define VDSO_HEADER "vdso.c.inc"
-
 #endif /* TARGET_X86_64 */
 
+#define VDSO_HEADER "vdso.c.inc"
+
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
diff --git a/linux-user/x86_64/Makefile.vdso b/linux-user/x86_64/Makefile.vdso
new file mode 100644
index 0000000000..26552b66db
--- /dev/null
+++ b/linux-user/x86_64/Makefile.vdso
@@ -0,0 +1,11 @@
+include $(BUILD_DIR)/tests/tcg/x86_64-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/x86_64
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso.so
+
+$(SUBDIR)/vdso.so: vdso.S vdso.ld
+	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/x86_64/meson.build b/linux-user/x86_64/meson.build
index 203af9a60c..8c60da7a60 100644
--- a/linux-user/x86_64/meson.build
+++ b/linux-user/x86_64/meson.build
@@ -3,3 +3,7 @@ syscall_nr_generators += {
                       arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                       output: '@BASENAME@_nr.h')
 }
+
+vdso_inc = gen_vdso.process('vdso.so')
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



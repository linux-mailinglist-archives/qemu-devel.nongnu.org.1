Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCC779523
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVM2-0005mw-Iu; Fri, 11 Aug 2023 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLw-0005mW-Uf
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:09 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLu-0001O3-Dy
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:08 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-564b8ea94c1so1454120a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772665; x=1692377465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pis+qqfCW8P86dzUIrowDFT2z37u/MYmMlvty1DjFqk=;
 b=CjtY0PZW0gujjUuxB0VbtFU2w0IV+0dCDZqYId44L4FpfsE74T38m4SjHM70xMZkKz
 g2NRbI1iYfrGwNWGaeqQCNrfl2JUgxoENUfO+Rdz3v7HtO6vPBpbsPVQ/YJEjuxkltal
 OsCFBgvvcK+d+d0YdZezPq4gZF1KRhAWtYDPd3R70gZEs7RXi0bxhVkaEJ93LFlQRD6S
 LrjuH2QOMKbZnhAi6rE3vRL44LDsnyCRkK1bDmeVnELBSW9BXdXWltpDXu25H0WU/igf
 NQbRFjs2MohONQofOiAm9Q8Fr/BvEUA5HghOIiYLaY2vbiAFG+eXxsh6qMj4ULIwgr6w
 xxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772665; x=1692377465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pis+qqfCW8P86dzUIrowDFT2z37u/MYmMlvty1DjFqk=;
 b=UYsdUBFT7XbRFbc3/Z2FJn2DcJ6fmxqsgPz0YNHlzJLlBli3jjXCVcpt9t9NqQB+0/
 bV/djw5g7E+wCSlv9C7B/Eof3MuiqmHxLTQGpxAy214SdV9tCd+Rqp70z1iEVuH6FIP/
 lPCFlPtRCFaGGlHSUtOpATL7wnaTlJYp6d5lBIkZjVIk73CoYCznqLmtBITHVEfE6c9T
 pj25Vp4wrPpAL+Buq9pua487ZYkD0IogTNsFzE37282HBpTypascB9Y9Hi0lApN3QaGg
 VeGv/PiRyVTGYGD3gqptWhgp2asaNNBCVgF06ZT0lwb8w9TY6h+QQ2yq4nwMAEgkBx7k
 AiNg==
X-Gm-Message-State: AOJu0YyYkjFGuVJz0wSV22p69Jc7p+EC6Go+5k3kRvrLH0+ji3DWiWNc
 7evJ4eRWJ3quR3U5B4FLjszpDrBbovxQLqAFCXE=
X-Google-Smtp-Source: AGHT+IHfPj33fJOtqfT0lfNd3/j/ZJbW89Rwo2DGtJ9oj44iXUiLwB2Ea3mV89jfUuvxV0XHJjm5eA==
X-Received: by 2002:a17:90b:400a:b0:268:2311:e8d8 with SMTP id
 ie10-20020a17090b400a00b002682311e8d8mr1714523pjb.17.1691772665107; 
 Fri, 11 Aug 2023 09:51:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:51:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 12/15] linux-user/hppa: Add vdso and use it for rt_sigreturn
Date: Fri, 11 Aug 2023 09:50:49 -0700
Message-Id: <20230811165052.161080-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Building the vdso itself is not actually wired up to anything, since
we require a cross-compiler.  Just check in that file for now.

Drop the now-unused 9 trampoline words, and describe the frame
without the trampoline in __kernel_rt_sigreturn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c          |   4 +
 linux-user/hppa/signal.c      |   1 -
 linux-user/hppa/Makefile.vdso |   6 ++
 linux-user/hppa/meson.build   |   6 ++
 linux-user/hppa/vdso.S        | 149 ++++++++++++++++++++++++++++++++++
 linux-user/hppa/vdso.ld       |  75 +++++++++++++++++
 linux-user/hppa/vdso.so       | Bin 0 -> 5196 bytes
 7 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/hppa/Makefile.vdso
 create mode 100644 linux-user/hppa/vdso.S
 create mode 100644 linux-user/hppa/vdso.ld
 create mode 100755 linux-user/hppa/vdso.so

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8e03bb6d76..e389295b8d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1778,6 +1778,10 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
+#include "vdso.c.inc"
+
+#define vdso_image_info()    &vdso_image_info
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index f253a15864..881269f1ac 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -41,7 +41,6 @@ struct target_ucontext {
 };
 
 struct target_rt_sigframe {
-    abi_uint tramp[2];  /* syscall restart return address */
     target_siginfo_t info;
     struct target_ucontext uc;
     /* hidden location of upper halves of pa2.0 64-bit gregs */
diff --git a/linux-user/hppa/Makefile.vdso b/linux-user/hppa/Makefile.vdso
new file mode 100644
index 0000000000..d4362c4961
--- /dev/null
+++ b/linux-user/hppa/Makefile.vdso
@@ -0,0 +1,6 @@
+CROSS_CC ?= hppa-linux-gnu-gcc
+
+vdso.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) -nostdlib -shared -Wl,-T,vdso.ld \
+	  -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
+	  -Wl,--hash-style=sysv vdso.S -o $@
diff --git a/linux-user/hppa/meson.build b/linux-user/hppa/meson.build
index 4709508a09..e065a16a96 100644
--- a/linux-user/hppa/meson.build
+++ b/linux-user/hppa/meson.build
@@ -3,3 +3,9 @@ syscall_nr_generators += {
                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                     output: '@BASENAME@_nr.h')
 }
+
+gen = [
+  gen_vdso.process('vdso.so', extra_args: ['-r', '__kernel_rt_sigreturn'])
+]
+
+linux_user_ss.add(when: 'TARGET_HPPA', if_true: gen)
diff --git a/linux-user/hppa/vdso.S b/linux-user/hppa/vdso.S
new file mode 100644
index 0000000000..eeae2c999a
--- /dev/null
+++ b/linux-user/hppa/vdso.S
@@ -0,0 +1,149 @@
+/*
+ * hppa linux kernel vdso replacement.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+	.text
+
+#define sizeof_rt_sigframe		696
+#define offsetof_sigcontext		152
+#define offsetof_sigcontext_gr		offsetof_sigcontext + 4
+#define offsetof_sigcontext_fr		offsetof_sigcontext_gr + 32 * 4
+#define offsetof_sigcontext_iasq	offsetof_sigcontext_fr + 32 * 8
+#define offsetof_sigcontext_iaoq	offsetof_sigcontext_iasq + 8
+#define offsetof_sigcontext_sar		offsetof_sigcontext_iaoq + 8
+
+	/*
+	 * While this frame is marked as a signal frame, that only applies
+	 * to how this return address is handled for the outer frame.
+	 * The return address that arrived here, from the inner frame, is
+	 * not marked as a signal frame and so the unwinder still tries to
+	 * subtract 1 to examine the presumed call insn.  Thus we must
+	 * extend the unwind info to a nop before the start.
+	 */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+	/* Compare pa32_fallback_frame_state from libgcc. */
+
+	/* Record the size of the stack frame. */
+	.cfi_def_cfa	30, -sizeof_rt_sigframe
+
+	/* Record save offset of general registers. */
+	.cfi_offset	1, offsetof_sigcontext_gr + 1 * 4
+	.cfi_offset	2, offsetof_sigcontext_gr + 2 * 4
+	.cfi_offset	3, offsetof_sigcontext_gr + 3 * 4
+	.cfi_offset	4, offsetof_sigcontext_gr + 4 * 4
+	.cfi_offset	5, offsetof_sigcontext_gr + 5 * 4
+	.cfi_offset	6, offsetof_sigcontext_gr + 6 * 4
+	.cfi_offset	7, offsetof_sigcontext_gr + 7 * 4
+	.cfi_offset	8, offsetof_sigcontext_gr + 8 * 4
+	.cfi_offset	9, offsetof_sigcontext_gr + 9 * 4
+	.cfi_offset	10, offsetof_sigcontext_gr + 10 * 4
+	.cfi_offset	11, offsetof_sigcontext_gr + 11 * 4
+	.cfi_offset	12, offsetof_sigcontext_gr + 12 * 4
+	.cfi_offset	13, offsetof_sigcontext_gr + 13 * 4
+	.cfi_offset	14, offsetof_sigcontext_gr + 14 * 4
+	.cfi_offset	15, offsetof_sigcontext_gr + 15 * 4
+	.cfi_offset	16, offsetof_sigcontext_gr + 16 * 4
+	.cfi_offset	17, offsetof_sigcontext_gr + 17 * 4
+	.cfi_offset	18, offsetof_sigcontext_gr + 18 * 4
+	.cfi_offset	19, offsetof_sigcontext_gr + 19 * 4
+	.cfi_offset	20, offsetof_sigcontext_gr + 20 * 4
+	.cfi_offset	21, offsetof_sigcontext_gr + 21 * 4
+	.cfi_offset	22, offsetof_sigcontext_gr + 22 * 4
+	.cfi_offset	23, offsetof_sigcontext_gr + 23 * 4
+	.cfi_offset	24, offsetof_sigcontext_gr + 24 * 4
+	.cfi_offset	25, offsetof_sigcontext_gr + 25 * 4
+	.cfi_offset	26, offsetof_sigcontext_gr + 26 * 4
+	.cfi_offset	27, offsetof_sigcontext_gr + 27 * 4
+	.cfi_offset	28, offsetof_sigcontext_gr + 28 * 4
+	.cfi_offset	29, offsetof_sigcontext_gr + 29 * 4
+	.cfi_offset	30, offsetof_sigcontext_gr + 30 * 4
+	.cfi_offset	31, offsetof_sigcontext_gr + 31 * 4
+
+	/* Record save offset of fp registers, left and right halves. */
+	.cfi_offset	32, offsetof_sigcontext_fr + 4 * 8
+	.cfi_offset	33, offsetof_sigcontext_fr + 4 * 8 + 4
+	.cfi_offset	34, offsetof_sigcontext_fr + 5 * 8
+	.cfi_offset	35, offsetof_sigcontext_fr + 5 * 8 + 4
+	.cfi_offset	36, offsetof_sigcontext_fr + 6 * 8
+	.cfi_offset	37, offsetof_sigcontext_fr + 6 * 8 + 4
+	.cfi_offset	38, offsetof_sigcontext_fr + 7 * 8
+	.cfi_offset	39, offsetof_sigcontext_fr + 7 * 8 + 4
+	.cfi_offset	40, offsetof_sigcontext_fr + 8 * 8
+	.cfi_offset	41, offsetof_sigcontext_fr + 8 * 8 + 4
+	.cfi_offset	42, offsetof_sigcontext_fr + 9 * 8
+	.cfi_offset	43, offsetof_sigcontext_fr + 9 * 8 + 4
+	.cfi_offset	44, offsetof_sigcontext_fr + 10 * 8
+	.cfi_offset	45, offsetof_sigcontext_fr + 10 * 8 + 4
+	.cfi_offset	46, offsetof_sigcontext_fr + 11 * 8
+	.cfi_offset	47, offsetof_sigcontext_fr + 11 * 8 + 4
+	.cfi_offset	48, offsetof_sigcontext_fr + 12 * 8
+	.cfi_offset	49, offsetof_sigcontext_fr + 12 * 8 + 4
+	.cfi_offset	50, offsetof_sigcontext_fr + 13 * 8
+	.cfi_offset	51, offsetof_sigcontext_fr + 13 * 8 + 4
+	.cfi_offset	52, offsetof_sigcontext_fr + 14 * 8
+	.cfi_offset	53, offsetof_sigcontext_fr + 14 * 8 + 4
+	.cfi_offset	54, offsetof_sigcontext_fr + 15 * 8
+	.cfi_offset	55, offsetof_sigcontext_fr + 15 * 8 + 4
+	.cfi_offset	56, offsetof_sigcontext_fr + 16 * 8
+	.cfi_offset	57, offsetof_sigcontext_fr + 16 * 8 + 4
+	.cfi_offset	58, offsetof_sigcontext_fr + 17 * 8
+	.cfi_offset	59, offsetof_sigcontext_fr + 17 * 8 + 4
+	.cfi_offset	60, offsetof_sigcontext_fr + 18 * 8
+	.cfi_offset	61, offsetof_sigcontext_fr + 18 * 8 + 4
+	.cfi_offset	62, offsetof_sigcontext_fr + 19 * 8
+	.cfi_offset	63, offsetof_sigcontext_fr + 19 * 8 + 4
+	.cfi_offset	64, offsetof_sigcontext_fr + 20 * 8
+	.cfi_offset	65, offsetof_sigcontext_fr + 20 * 8 + 4
+	.cfi_offset	66, offsetof_sigcontext_fr + 21 * 8
+	.cfi_offset	67, offsetof_sigcontext_fr + 21 * 8 + 4
+	.cfi_offset	68, offsetof_sigcontext_fr + 22 * 8
+	.cfi_offset	69, offsetof_sigcontext_fr + 22 * 8 + 4
+	.cfi_offset	70, offsetof_sigcontext_fr + 23 * 8
+	.cfi_offset	71, offsetof_sigcontext_fr + 23 * 8 + 4
+	.cfi_offset	72, offsetof_sigcontext_fr + 24 * 8
+	.cfi_offset	73, offsetof_sigcontext_fr + 24 * 8 + 4
+	.cfi_offset	74, offsetof_sigcontext_fr + 25 * 8
+	.cfi_offset	75, offsetof_sigcontext_fr + 25 * 8 + 4
+	.cfi_offset	76, offsetof_sigcontext_fr + 26 * 8
+	.cfi_offset	77, offsetof_sigcontext_fr + 26 * 8 + 4
+	.cfi_offset	78, offsetof_sigcontext_fr + 27 * 8
+	.cfi_offset	79, offsetof_sigcontext_fr + 27 * 8 + 4
+	.cfi_offset	80, offsetof_sigcontext_fr + 28 * 8
+	.cfi_offset	81, offsetof_sigcontext_fr + 28 * 8 + 4
+	.cfi_offset	82, offsetof_sigcontext_fr + 29 * 8
+	.cfi_offset	83, offsetof_sigcontext_fr + 29 * 8 + 4
+	.cfi_offset	84, offsetof_sigcontext_fr + 30 * 8
+	.cfi_offset	85, offsetof_sigcontext_fr + 30 * 8 + 4
+	.cfi_offset	86, offsetof_sigcontext_fr + 31 * 8
+	.cfi_offset	87, offsetof_sigcontext_fr + 31 * 8 + 4
+
+	/* Record save offset of %sar */
+	.cfi_offset	88, offsetof_sigcontext_sar
+
+	/* Record save offset of return address, iaoq[0]. */
+	.cfi_return_column 89
+	.cfi_offset	89, offsetof_sigcontext_iaoq
+
+	nop
+
+__kernel_rt_sigreturn:
+
+	ldi	0, %r25
+	ldi	__NR_rt_sigreturn, %r20
+	be,l	0x100(%sr2, %r0), %sr0, %r31
+	nop
+
+	.cfi_endproc
+
+	.size	__kernel_rt_sigreturn, . - __kernel_rt_sigreturn
+	.type	__kernel_rt_sigreturn, @function
+	.globl	__kernel_rt_sigreturn
diff --git a/linux-user/hppa/vdso.ld b/linux-user/hppa/vdso.ld
new file mode 100644
index 0000000000..fed994c3eb
--- /dev/null
+++ b/linux-user/hppa/vdso.ld
@@ -0,0 +1,75 @@
+/*
+ * Linker script for linux hppa vdso.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Note that the kernel does not implement a vdso for hppa.
+ * Mirror the symbol that other targets use for this, e.g. i386.
+ */
+
+VERSION {
+        QEMU {
+        global:
+                __kernel_rt_sigreturn;
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        data            PT_LOAD         FLAGS(6) FILEHDR PHDRS;
+        text            PT_LOAD         FLAGS(5);
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        note            PT_NOTE         FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+}
+
+SECTIONS {
+        . = SIZEOF_HEADERS;
+
+        /* The following, including the FILEHDRS and PHDRS, are modified
+           when we relocate the binary.  We want them to be initially
+           writable for the relocation; we'll force them read-only after.  */
+        .note           : { *(.note*) }         :data :note
+        .dynamic        : { *(.dynamic) }       :data :dynamic
+        .dynsym         : { *(.dynsym) }        :data
+        .data           : {
+                /* There ought not be any real read-write data.
+                   But since we manipulated the segment layout,
+                   we have to put these sections somewhere.  */
+                *(.data*)
+                *(.sdata*)
+                *(.got.plt) *(.got)
+                *(.gnu.linkonce.d.*)
+                *(.bss*)
+                *(.dynbss*)
+                *(.gnu.linkonce.b.*)
+        }
+
+        .rodata         : { *(.rodata) }
+        .hash           : { *(.hash) }
+        .gnu.hash       : { *(.gnu.hash) }
+        .dynstr         : { *(.dynstr) }
+        .gnu.version    : { *(.gnu.version) }
+        .gnu.version_d  : { *(.gnu.version_d) }
+        .gnu.version_r  : { *(.gnu.version_r) }
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :data :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :data
+
+        . = ALIGN(4096);
+        .text           : { *(.text*) }         :text
+}
diff --git a/linux-user/hppa/vdso.so b/linux-user/hppa/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..bd77b8a5c33d66380a79b2f816237568998c8af3
GIT binary patch
literal 5196
zcmeHLTX2&_6y8m`h?i>1Fr!Y<(V03TLgZ2vMX_m{v|xHmQlRzno08B(+64dnt!Y&#
zrJ#tSAYi?V;vMhzD?akzLq~o0rOYtnjH5H?lUl!T|9?q4!-F$E`0}6R%h_|;v%6<E
z59e%)#G*1FgThcyT!5hzqKcY2A*xRa5vaoGGBHOig!O#r=eRc7HNFKWDm-BRObTX&
zAUIFQ_2P4^<@p#8%98`w!bN3>QP>C*pB(!-jarNeZBIKVI<V(t89FxOYrDrO2b<fv
z#Mtj0rSTI#{Pf3xiK*{Ke*U}EIrSrKJm-b3ubc$O-sDMeoIy^2p93rg&INb~<WNo)
zrl<eJx(mSnf-V65D;U@MuXLpeP%Wl^!<aebd8+2=JuqLIn0wwQa(J4gu&m7)JD=&d
zY{x3*`s|D|Xy-+LE<adWGL$YBLijEdosrfqP73JR5^La7`OC4x(D4il0Omxm4j(C0
z&lQl&`Sc!TO>h--%n9~VdDL|l%$<-U@r0<T=$19}F8zM%_Jw0t?N~H^_0Gk+mOL1G
z=$hS2A6~X+`6DYHt=oI;W7j=?{l1m^Z+POy1FH_+bm-<MS5MsXRQ=Q8XBwVue6H#F
z$P3XI+YfiV)cJD!NaB^`t6i_Hdwu;I8{X`GtLNx#Z{PmT9q-=xp7s7+AEZ9){b=LI
z=}$7BZu+e6^XwP7FYo?p^Vj{~3>?d=`hp5?Q4RN~Mq4!%Rm4%zLDf8@TJBYAN^0$}
zx^+aw?o+MztF{MJ`&QMlO?8e+72hsZVoa*!4yn4vrCPUBs`b01+OS8e?%hnkK0EIH
zydxN!+)(e6p8-Dueg^yu_!;ms;Ag<kfS&<B1AYenw+ze`f%>|OQN+)eJyT*#P!?yV
zQ&h9ab<J+Q3E8VNbxlk=Yfq3o&R+<uQ9-(fri?mT%eo$f%w7V>t&t(0<;koy=|9(#
zlb(FGCucpGbvTISruJt&jy<~jlWwgHpMahZ8|PnQ_UGAGK&Q#8tydymxwf{Ny4%97
zYZ_5RqhDY}TC8Y1+#0c3n&QH0j<q+0V^(`KnusK=WVj&~vD`ZP%q6!76^93$R4=$=
zyF6<~`GS)Xq4aP*HIUn=2k-??IVlm!rixit=h!0DmmdrbW$a?Eke?-3X%Wg~txa}n
zAY*0I@HCPLIhm4U4*KtS4cvGiykp)!Q41LI?p9n51@95pW%@Q^)YF0KH^6&b1n_>?
z-$4&WznP_wIhXHB=Nx>wCo|r07v>$nQtsp6p7eWSyh#^=eGtsk#CXJNfI9k}bfJ4U
zP-*hsw1}c#GYt*=_#X9}^v<RIpx3!bnEnn#yi-DOFZ87k*Ch1<jLmpS7qj{S#&63E
zKfLPzV73HHIo^ophjsYgiCOW?ByUZcNmV$Dq;n;}{vOw*%>RPP6^7Nd_-O+SnRwMu
O%=EJ%j~XX%?e`Db?gR4x

literal 0
HcmV?d00001

-- 
2.34.1



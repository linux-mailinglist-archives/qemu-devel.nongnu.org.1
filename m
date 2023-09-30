Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA17B3D9A
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWN-0000Gc-SS; Fri, 29 Sep 2023 22:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWI-0000Ek-0k
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:50 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWE-00020P-0c
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27740ce6c76so7673053a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040143; x=1696644943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsAVxFrViuZh0oU7yn+p7tNp6qZeXDvUiqmxP7VIDOM=;
 b=E1c2dVVAILSOJrPN/VJ3xK1xAE3yTDpImmcoTHjBr9lHX0ZJTe6H5TmxrOmnPJ9AgE
 qbrRW+zMyAVAH8sZxTJA/RotCenXYp+QMVXpM6A8OMIIOGKUSD3dyTxb/Loa2llBDuXd
 AeqrybIDwUtiVM6SBbMU+9NOt8b6H4uzfSXeNVTv2dq3HMiWo6HAtWaFW4mfS5IJ1geT
 3l8s0eqbHKRensqCpc6R4xS5VeyFJPXjoZ7xWICjnw85VSGLo8cblmhJwgWweC5SoT+C
 j6ZbNsRodtEYiIoqfsi6nu0PHamQz/I3ljM1ed75qOLesVJN9y6rBnzZ80M3IOZGrWMk
 MZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040143; x=1696644943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsAVxFrViuZh0oU7yn+p7tNp6qZeXDvUiqmxP7VIDOM=;
 b=aYijjXGf9TVKlwoe6Ue/jXcGH1Uqm6Cb2CGy0Rj0oIl7zwINHELytuQ6BkBNW+yMyY
 4qw0de7pgPBI4w08KWYsfB2oc8LZWfPy2INIiiZKyOHeuVuwQbp3kPmdjOxMve+4ZckL
 GGotxSFmJWBGg3AG3L1W1cdC4EuwxnqS0mO4iSLPHbZrykZJWEbUcSoAOt8YPfauL/+E
 wRvt41AhfvQMiLVM6NLW1njduvKGmepprI6RrMFJojbxlR34nFAUaVBR0rgfUtafPEsN
 JBu0Kg32TJ0zbqVCGFD/fYj0pvBYqN70CptSa0h9AKRCH97N4kNLr57iv3yc8vF9x2kL
 pZGg==
X-Gm-Message-State: AOJu0YyaabEVAjxoJPD1/tAMLL/XOZ4x4iHwNFdajdZb+/T8iQfKcB/7
 mWgCdf7N0aIlEXa7omWlDRKG7FwS3q6RawOd4ao=
X-Google-Smtp-Source: AGHT+IH03mSp9uFtRDL9gY9+0dQmnLzroFTeTZZEcl28eEBM8Jz4DhB8SVppiVJ+F540uZA1bvlpig==
X-Received: by 2002:a17:90a:fa97:b0:277:5652:cb00 with SMTP id
 cu23-20020a17090afa9700b002775652cb00mr5023756pjb.24.1696040143312; 
 Fri, 29 Sep 2023 19:15:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v6 13/19] linux-user/hppa: Add vdso
Date: Fri, 29 Sep 2023 19:15:23 -0700
Message-Id: <20230930021529.987950-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 linux-user/hppa/vdso-asmoffset.h |  12 +++
 linux-user/elfload.c             |   2 +
 linux-user/hppa/signal.c         |  24 +++--
 linux-user/hppa/Makefile.vdso    |  11 +++
 linux-user/hppa/meson.build      |   5 +
 linux-user/hppa/vdso.S           | 165 +++++++++++++++++++++++++++++++
 linux-user/hppa/vdso.ld          |  77 +++++++++++++++
 linux-user/hppa/vdso.so          | Bin 0 -> 2104 bytes
 8 files changed, 286 insertions(+), 10 deletions(-)
 create mode 100644 linux-user/hppa/vdso-asmoffset.h
 create mode 100644 linux-user/hppa/Makefile.vdso
 create mode 100644 linux-user/hppa/vdso.S
 create mode 100644 linux-user/hppa/vdso.ld
 create mode 100755 linux-user/hppa/vdso.so

diff --git a/linux-user/hppa/vdso-asmoffset.h b/linux-user/hppa/vdso-asmoffset.h
new file mode 100644
index 0000000000..c8b40c0332
--- /dev/null
+++ b/linux-user/hppa/vdso-asmoffset.h
@@ -0,0 +1,12 @@
+#define sizeof_rt_sigframe              584
+#define offsetof_sigcontext             160
+#define offsetof_sigcontext_gr          0x4
+#define offsetof_sigcontext_fr          0x88
+#define offsetof_sigcontext_iaoq        0x190
+#define offsetof_sigcontext_sar         0x198
+
+/* arch/parisc/include/asm/rt_sigframe.h */
+#define SIGFRAME                        64
+#define FUNCTIONCALLFRAME               48
+#define PARISC_RT_SIGFRAME_SIZE32 \
+    (((sizeof_rt_sigframe) + FUNCTIONCALLFRAME + SIGFRAME) & -SIGFRAME)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a65401f8d5..ccf8a1dc78 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1921,6 +1921,8 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
+#define VDSO_HEADER "vdso.c.inc"
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index bda6e54655..741dac79b6 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "vdso-asmoffset.h"
 
 struct target_sigcontext {
     abi_ulong sc_flags;
@@ -47,6 +48,19 @@ struct target_rt_sigframe {
     /* hidden location of upper halves of pa2.0 64-bit gregs */
 };
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_rt_sigframe) != sizeof_rt_sigframe);
+QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.tuc_mcontext)
+                  != offsetof_sigcontext);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_gr)
+                  != offsetof_sigcontext_gr);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_fr)
+                  != offsetof_sigcontext_fr);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_iaoq)
+                  != offsetof_sigcontext_iaoq);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_sar)
+                  != offsetof_sigcontext_sar);
+
+
 static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
 {
     int i;
@@ -91,16 +105,6 @@ static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
     __get_user(env->cr[CR_SAR], &sc->sc_sar);
 }
 
-#if TARGET_ABI_BITS == 32
-#define SIGFRAME                64
-#define FUNCTIONCALLFRAME       48
-#else
-#define SIGFRAME                128
-#define FUNCTIONCALLFRAME       96
-#endif
-#define PARISC_RT_SIGFRAME_SIZE32 \
-    ((sizeof(struct target_rt_sigframe) + FUNCTIONCALLFRAME + SIGFRAME) & -SIGFRAME)
-
 void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUArchState *env)
diff --git a/linux-user/hppa/Makefile.vdso b/linux-user/hppa/Makefile.vdso
new file mode 100644
index 0000000000..f4537ae716
--- /dev/null
+++ b/linux-user/hppa/Makefile.vdso
@@ -0,0 +1,11 @@
+include $(BUILD_DIR)/tests/tcg/hppa-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/hppa
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso.so
+
+$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso32.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/hppa/meson.build b/linux-user/hppa/meson.build
index 4709508a09..aa2d9a87a6 100644
--- a/linux-user/hppa/meson.build
+++ b/linux-user/hppa/meson.build
@@ -3,3 +3,8 @@ syscall_nr_generators += {
                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                     output: '@BASENAME@_nr.h')
 }
+
+vdso_inc = gen_vdso.process('vdso.so',
+                            extra_args: [ '-r', '__kernel_sigtramp_rt' ])
+
+linux_user_ss.add(when: 'TARGET_HPPA', if_true: vdso_inc)
diff --git a/linux-user/hppa/vdso.S b/linux-user/hppa/vdso.S
new file mode 100644
index 0000000000..5be14d2f70
--- /dev/null
+++ b/linux-user/hppa/vdso.S
@@ -0,0 +1,165 @@
+/*
+ * hppa linux kernel vdso replacement.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include "vdso-asmoffset.h"
+
+	.text
+
+
+/*
+ * arch/parisc/kernel/vdso32/sigtramp.S:
+ * Gdb expects the trampoline is on the stack and the pc is offset from
+ * a 64-byte boundary by 0, 4 or 5 instructions. Since the vdso trampoline
+ * is not on the stack, we need a new variant with different offsets and
+ * data to tell gdb where to find the signal context on the stack.
+ *
+ * Here we put the offset to the context data at the start of the trampoline
+ * region and offset the first trampoline by 2 instructions. Please do
+ * not change the trampoline as the code in gdb depends on the following
+ * instruction sequence exactly.
+ */
+
+/* arch/parisc/kernel/asm-offsets.c */
+#define SIGFRAME_CONTEXT_REGS32 \
+    (offsetof_sigcontext - PARISC_RT_SIGFRAME_SIZE32)
+
+        .align	64
+        .word	SIGFRAME_CONTEXT_REGS32
+
+/*
+ * All that said, we can provide a proper unwind record, which means that
+ * GDB should not actually need the offset magic.
+ *
+ * The return address that arrived here, from the inner frame, is
+ * not marked as a signal frame and so the unwinder still tries to
+ * subtract 1 to examine the presumed call insn.  Thus we must
+ * extend the unwind info to a nop before the start.
+ */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+	/* Compare pa32_fallback_frame_state from libgcc. */
+
+	/*
+	 * Place the CFA at the start of sigcontext for convenience.
+	 * The previous CFA will be restored from the saved stack pointer.
+	 */
+	.cfi_def_cfa	30, -PARISC_RT_SIGFRAME_SIZE32 + offsetof_sigcontext
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
+__kernel_sigtramp_rt:
+	ldi	0, %r25
+	ldi	__NR_rt_sigreturn, %r20
+	be,l	0x100(%sr2, %r0), %sr0, %r31
+	nop
+
+	.cfi_endproc
+	.size	__kernel_sigtramp_rt, . - __kernel_sigtramp_rt
+	.type	__kernel_sigtramp_rt, @function
+	.globl	__kernel_sigtramp_rt
diff --git a/linux-user/hppa/vdso.ld b/linux-user/hppa/vdso.ld
new file mode 100644
index 0000000000..b17ad974f3
--- /dev/null
+++ b/linux-user/hppa/vdso.ld
@@ -0,0 +1,77 @@
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
+VERSION {
+        /*
+         * The kernel's vdso32.lds.S attempts to export
+         *     __kernel_sigtramp_rt32
+         *     __kernel_restart_syscall32
+         * except that those symbols don't exist.  The actual symbols are
+         *     __kernel_sigtramp_rt
+         *     __kernel_restart_syscall
+         * which means that nothing is exported at all.
+         * QEMU handles syscall restart internally, so we don't
+         * need to implement __kernel_restart_syscall at all.
+         */
+        LINUX_5.18 {
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS;
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
+        .note           : { *(.note*) }         :load :note
+        .dynamic        : { *(.dynamic) }       :load :dynamic
+        .dynsym         : { *(.dynsym) }        :load
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
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :load
+
+        .text           : { *(.text*) }         :load
+}
diff --git a/linux-user/hppa/vdso.so b/linux-user/hppa/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..e1ddd70c37e9eb6871c21d538dcce0a1e736a918
GIT binary patch
literal 2104
zcmbtVTXR!Y6kaFkhEgcBP%l`hafWdil!Lv1RY03GNz;<1rD<u4mqRou?Lbo}Ntxn<
z6hy2j;=SIj_j<pgs8u`u1|EIrgN{DxgO1|}@%#2U8(N>7>6(0JUG~~*U)EYXM<Vg4
z<+J=^$S<oPTAtb<qRxu=Dx^UIqGY2~=<y{O$Jj+oK_*H(nE6mi{#h5YR1g5<1OA$a
z3CM(*PkwG5Hb5ryc)IX&Cqgt{f>dFQ(BmGb?r%x-$mIFC+3xTU<+0?(1N%-~JGte|
zwo#0&1h`Mkv8G3g7ybaBfv&)R1jiYzaqu#r23QVo^SCSe7yscgz|X_x1OE;7zacM{
z)|dd5Qv4k<?}@~{^4{j(t<h=2zNONP7f%I_%E6)R=-B2%>HJ82ot+=CYbD;A=;?E|
z+O@bm6U{<ItNi3nuEjfB2e@mvD_Uj0oF4PWz(nuQs`hV(%=>_s6$j@&=K!(p?Mg~X
zNxxOSx@O|YQQtBD{UyiM14~XUeXw+5*+XR~mp{DXk@8b3A6<32;<3udS3j}l$*QL=
zd;0Qcu9&>?*|pDI^?daU>t0;{Qq9X(zY>_*^y+o5UH|&#H|#gJymiCdwbOO))W6&C
z-q!cGeQ@K4jUV0g@y(xX|8&P^J3qhW%&lKEeHlC(`l|Ws@Hdf}=(jE3#lCM<O>HW;
zONHX9xm|@5D$=2%ovLNGigl^hq-yI{yLwc7k81B#i9XfQuR8at-M6W(+g0)o)qSVx
zanzoDsyC(j22_8Vr_*Qt6`W`0eJzTL#S4K_@ijH9MKe`ddw-H+LR}U|=Qy2(>V?rY
z1fBH)(sj*o{IovBFBJ9<$eQLCI%^7~`+_?Ao;v%3I{KO9);;u6S9h0zzRc5gxj|<y
zfqc9>&Sy_i8rNTu72w>n-mm4>KjyI4HF5rW`17r(z$)~w!;~p-Ow|1nqfFBM<AnPY
z!S>c>aU8q_P9)|;yMpZzCl>C4=|Coz%^Y;{L;DN4)bKq{t{_fJydxBhI~~zzGScmI
z2Sf3Qv!HS8{Ndq3>MpVKg`CR=jg%cJWW-J%&ZdTk?$!c)!Bd5l*!#1i_FyVM=-LZ8
z*K#P6%MXoY7bs3z?98AufIVfL!8AOLCUzk+R&dYvKfl%RW1g54)&;QvFy!T2u7QF1
zMOrSt&AewX$GSF{-%SAXhIp(aT}uJz^keQAkM9EVqIJY$eh5<^kS@K|J0P>p7;oBz
z?knzt#CSv_-q=6E={Ms-0?_~K7xHZML!Ihc<@;@jdnC0XUJ;yrc(-*8a~%^8c8*D}
zdE;G`CSg6AJLMeG0KnLAF#k;p-Us8y>={4wf$jxe@351M-+hqjhn)DwT}TsjLrtFG
t#WH69ET#p-{eR>C0pl?r>_u}nn&<FI0)`le#5wc)R6X?L9Pmi{{R?cl2WkKS

literal 0
HcmV?d00001

-- 
2.34.1



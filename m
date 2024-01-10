Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6870182959C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:03:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUU9-0004FQ-O5; Wed, 10 Jan 2024 04:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSk-0003Hy-LX
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:32 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSh-0005a6-He
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:26 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6dc83674972so2442842a34.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877282; x=1705482082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQyjFxjTeASOtbPXLUyqKs2s2q/OWgMCkyxBKSDeIH4=;
 b=Qlie3Dq2xKbc8PeIc9EFeehyXrsH/UKAyA0gRYAD9lpQd9uobNGNsel7zRpvEifEO9
 Lj9X+whkvvTo+1KQftL9IJ80RKH+Ldtvc1mFhjQMu9TpsyojidVk23y/Wod+QshhmF76
 G2HEwplnqoiHY72z2Mqo7/1KRCCfp9rpiEqw+zuFwG3yNCSmmuMFzInH5Y2bSC2JXFzJ
 JNooSNTfoex4aZYp22Jx0NmPbSksOvAcxTf8uzc3q8g++OpQLW6SPVXxr9pqvNO9osf+
 JreUtGYyEhbrpLazadtgBW/LxRpTposDcofviKyyU2RDqy/cry+55D2dVCbA6D3gIMeS
 EhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877282; x=1705482082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQyjFxjTeASOtbPXLUyqKs2s2q/OWgMCkyxBKSDeIH4=;
 b=MagzN6OBTlT17QqgFHLz6q4PaVkOERZtxGvRiLloyEM09aiZ/GfN84dCk/edZ3+v+p
 gMB3tjzs4gE91hNCJxNCMgB7UokX8c5b26nWjhSXgdJNaSHQWi4u88GBhvREFl0EvIGL
 4bu67UZ05gmBpekRQNU9BDsMwRY/zoV/ALRAXJvykdBk+ELsOcfiZ9btIA75bevkr1EC
 xIVRmP1nYZPVnSdgSUG/rKdjN6j59uQFngFSNukWX2KFdiSgSEePwYh7+CJWtf+H4Ok9
 DeKk04Y3RLEgJj8rz0m1Pd/GsdLxqafHMGw6mKgIUwxEQNUJHTsMcO9GEGplLrIfwjJR
 eYgA==
X-Gm-Message-State: AOJu0Yy1HlOJVsz/0AEMqoGL/lavPNAvSF6DnVwLBR/gkZaLMeQeP4o3
 hGig6KWn12D/U1Fq7R3XKk5BhFlITr24Rx3B
X-Google-Smtp-Source: AGHT+IH6zfTA0PGO7UKE3lB7Nn6eVSxfE7EsEHywJp9YirClkr/8L8yVUWvB2oApztb9FwLy4adflQ==
X-Received: by 2002:a05:6358:6f98:b0:175:9763:6918 with SMTP id
 s24-20020a0563586f9800b0017597636918mr949570rwn.51.1704877282075; 
 Wed, 10 Jan 2024 01:01:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 57/65] linux-headers: riscv: add ptrace.h
Date: Wed, 10 Jan 2024 18:57:25 +1000
Message-ID: <20240110085733.1607526-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

KVM vector support for RISC-V requires the linux-header ptrace.h.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218204321.75757-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-headers/asm-riscv/ptrace.h | 132 +++++++++++++++++++++++++++++++
 scripts/update-linux-headers.sh  |   3 +
 2 files changed, 135 insertions(+)
 create mode 100644 linux-headers/asm-riscv/ptrace.h

diff --git a/linux-headers/asm-riscv/ptrace.h b/linux-headers/asm-riscv/ptrace.h
new file mode 100644
index 0000000000..1e3166caca
--- /dev/null
+++ b/linux-headers/asm-riscv/ptrace.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ */
+
+#ifndef _ASM_RISCV_PTRACE_H
+#define _ASM_RISCV_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#define PTRACE_GETFDPIC		33
+
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+
+/*
+ * User-mode register state for core dumps, ptrace, sigcontext
+ *
+ * This decouples struct pt_regs from the userspace ABI.
+ * struct user_regs_struct must form a prefix of struct pt_regs.
+ */
+struct user_regs_struct {
+	unsigned long pc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+};
+
+struct __riscv_f_ext_state {
+	__u32 f[32];
+	__u32 fcsr;
+};
+
+struct __riscv_d_ext_state {
+	__u64 f[32];
+	__u32 fcsr;
+};
+
+struct __riscv_q_ext_state {
+	__u64 f[64] __attribute__((aligned(16)));
+	__u32 fcsr;
+	/*
+	 * Reserved for expansion of sigcontext structure.  Currently zeroed
+	 * upon signal, and must be zero upon sigreturn.
+	 */
+	__u32 reserved[3];
+};
+
+struct __riscv_ctx_hdr {
+	__u32 magic;
+	__u32 size;
+};
+
+struct __riscv_extra_ext_header {
+	__u32 __padding[129] __attribute__((aligned(16)));
+	/*
+	 * Reserved for expansion of sigcontext structure.  Currently zeroed
+	 * upon signal, and must be zero upon sigreturn.
+	 */
+	__u32 reserved;
+	struct __riscv_ctx_hdr hdr;
+};
+
+union __riscv_fp_state {
+	struct __riscv_f_ext_state f;
+	struct __riscv_d_ext_state d;
+	struct __riscv_q_ext_state q;
+};
+
+struct __riscv_v_ext_state {
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	unsigned long vlenb;
+	void *datap;
+	/*
+	 * In signal handler, datap will be set a correct user stack offset
+	 * and vector registers will be copied to the address of datap
+	 * pointer.
+	 */
+};
+
+struct __riscv_v_regset_state {
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	unsigned long vlenb;
+	char vreg[];
+};
+
+/*
+ * According to spec: The number of bits in a single vector register,
+ * VLEN >= ELEN, which must be a power of 2, and must be no greater than
+ * 2^16 = 65536bits = 8192bytes
+ */
+#define RISCV_MAX_VLENB (8192)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PTRACE_H */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 34295c0fe5..a0006eec6f 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -156,6 +156,9 @@ for arch in $ARCHLIST; do
         cp_portable "$tmpdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
     fi
+    if [ $arch = riscv ]; then
+        cp "$tmpdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
+    fi
 done
 
 rm -rf "$output/linux-headers/linux"
-- 
2.43.0



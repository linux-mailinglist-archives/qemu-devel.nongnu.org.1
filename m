Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E997FF95B
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:29:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8llf-0007U8-Qs; Thu, 30 Nov 2023 13:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r8llc-0007SG-Tn
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:28:04 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r8lla-00021F-Kz
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:28:04 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5bcfc508d14so996879a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701368881; x=1701973681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzKG6jVOGDYD52yHvhC4O9jAaUzKCa3KiHTIquPkCRg=;
 b=jnPCDMlcyfbZdsaw2kHSj7AGjTMAZseLiO+TAZ2qr/0meKhcyb2UtcrsGbXKEvhOEh
 9uvAI0D7Hk6pgAY7lh1mZ/yrrPcsJWdo3alkKWtTEd4cbqK2RKO3Sn+JykSahPIe0SzH
 yYyhO5R+YJFxqS90FuVUpsHddAOH6Zq0JWvogUwSzNBAzNITb8HdUKrpDO1zgmiDXTMr
 WWu2m0/QAcPm3hbe1FKaWxqPl5gNpLBsPttrKlX50LTXO/outn94ODb8AnrmCxN0lqXs
 cgeCXb4RcQ0EnRx2wsW18ie0cyiWLf+z7qTkKxx0bpbbSWhLdIz0CYAIJ069CNu9apBx
 fOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701368881; x=1701973681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzKG6jVOGDYD52yHvhC4O9jAaUzKCa3KiHTIquPkCRg=;
 b=CbFMoVZyoPB+g6Dvi9CSqt36ic2IP9FYYLsE/3LZBQFF8lWx+XWzY4UlTY8D/fbVqj
 7pK1RRLir7kialznh4REhPwieSAatbUs3fcqUA0Gzvn0VUNjVFOVY9u93PgUx5hWaPdA
 ClyHFe3MgtDrTyi2pn7JQJrli3dAerjLbVCUBxlc3N8J5JaimkAtlSj/67+r2rXFrutJ
 ROWK55IsL7NkEzbbyN7rdGIxNG194JqYZcJQEWlHmVVbxjR2nsEdR3DMl56SVrtdzhu7
 +v6zzkw1W9mbq76abmuN69CT7pBAdwefuDemnEZTaDHkyFUotxY48L0KaljLyljJhVVF
 X4WQ==
X-Gm-Message-State: AOJu0YzpGpcjKvhCT+ccODzPh9yJYJTO3DKlLDdTPN2wYaOpEkMFxecH
 RykeAJahQ565/SQIW+mwSi9SIkHNpjruOPxwouw=
X-Google-Smtp-Source: AGHT+IHe6ZuY0keMYsy/toG6UV/EkoLzFrevw6cC+sPchspZsO28bry/npUiIJXV3UUzvpazH9K4bw==
X-Received: by 2002:a05:6a20:a10a:b0:18b:4632:af0b with SMTP id
 q10-20020a056a20a10a00b0018b4632af0bmr27215618pzk.17.1701368880814; 
 Thu, 30 Nov 2023 10:28:00 -0800 (PST)
Received: from grind.. (200-206-229-234.dsl.telesp.net.br. [200.206.229.234])
 by smtp.gmail.com with ESMTPSA id
 b24-20020aa78718000000b0068fece22469sm1517451pfo.4.2023.11.30.10.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 10:28:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 2/4] linux-headers: riscv: add ptrace.h
Date: Thu, 30 Nov 2023 15:27:46 -0300
Message-ID: <20231130182748.1894790-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130182748.1894790-1-dbarboza@ventanamicro.com>
References: <20231130182748.1894790-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

KVM vector support for RISC-V requires the linux-header ptrace.h.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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
2.41.0



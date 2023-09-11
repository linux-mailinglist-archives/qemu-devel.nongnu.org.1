Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 636FB79A3A6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaep-0000aq-3O; Mon, 11 Sep 2023 02:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaen-0000a5-7w
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:25 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaek-0004Vh-48
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:25 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57355a16941so2730226eaf.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414660; x=1695019460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eCj/NCScyqByJ/iYRppRDzEwAdB3DuVsfWQAxGoaj4=;
 b=Ju7wRtTzf5mBN/FD4NX/r+YpTtQgXq5JMWn/ceYrI7lv0MOWuuC+d9ItVM4Ob9Xs3o
 zBw9ryvP7KL+sPmqJRNLRLPv6ZNUExFeJv2ljIBaNuNAXKrl6wpEtsVGm8kikJ2Z1EiM
 Ay1no/v7QmvXcckMijRMpKbYn1QyL3mRzdqHJE5YLhBuKB4PIoaUDucZDJuVmmCPV5KY
 C4OgYjALWo6II5YDCEw6X+k2k0s7UL6RPLVn8qiZyRWo6DM20ju3ls98L4H7y+hXBnqs
 4naa+DR7QFqDRDXdT2TOGLzq1uAXQK95kSNcpvl5AptZw3tjPFTaTH8HumXnQPCHcSPA
 DXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414660; x=1695019460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eCj/NCScyqByJ/iYRppRDzEwAdB3DuVsfWQAxGoaj4=;
 b=podi6wczEPiLMTSkAEzo/BCQB/pZXrYCUrfrmqAcTFEYpygXWWZYSy480mHr7sSNrd
 elNXr9Wrn26X0xpPyQQ4cLa9yCx2O+myjcIMy7p9+4uMw9fT4lEMdKCdHDpsfwxuLhVy
 BBuVkuFP000rNWcAGoLJr907F1qtX7bqFPmlQRbevyKnkou41OQ4VvjQFLIu1dAbQOLS
 VpWiN2mvoDbrCytpYTKJywAt9ZZD1xqQ39C7y4HpU3Wsx440D1RxBGISINacOCPUYN19
 Z3x8WBTnBS7mEXlvmGQc7XGLyNPI6QEoAhw8tg/tDHdQK/9O5MfTmAFOyu9Fh+SawbZh
 62YA==
X-Gm-Message-State: AOJu0YxTnJCQXF6ptO25EGc6ME/fwkBXwcg97sxS5iPlsLfpI0SvaRtf
 Dnuo0AWp7v9zoeFMiWThkH5xjmUwuiEXgA==
X-Google-Smtp-Source: AGHT+IHHK6556Z7H0jgiji6760Yve5zWDurBQ813PoEfsExAlT67H+oC9qw0UGpK16ngoZhblAI39Q==
X-Received: by 2002:a05:6358:5e1a:b0:13f:3368:92b4 with SMTP id
 q26-20020a0563585e1a00b0013f336892b4mr7708350rwn.27.1694414660279; 
 Sun, 10 Sep 2023 23:44:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:44:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 11/45] target/riscv: Add Zvbc ISA extension support
Date: Mon, 11 Sep 2023 16:42:46 +1000
Message-ID: <20230911064320.939791-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Lawrence Hunter <lawrence.hunter@codethink.co.uk>

This commit adds support for the Zvbc vector-crypto extension, which
consists of the following instructions:

* vclmulh.[vx,vv]
* vclmul.[vx,vv]

Translation functions are defined in
`target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
`target/riscv/vcrypto_helper.c`.

Co-authored-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Co-authored-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Signed-off-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
Signed-off-by: Max Chou <max.chou@sifive.com>
[max.chou@sifive.com: Exposed x-zvbc property]
Message-ID: <20230711165917.2629866-5-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                   |  1 +
 target/riscv/helper.h                    |  6 +++
 target/riscv/insn32.decode               |  6 +++
 target/riscv/cpu.c                       |  9 ++++
 target/riscv/translate.c                 |  1 +
 target/riscv/vcrypto_helper.c            | 59 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvvk.c.inc | 62 ++++++++++++++++++++++++
 target/riscv/meson.build                 |  3 +-
 8 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/vcrypto_helper.c
 create mode 100644 target/riscv/insn_trans/trans_rvvk.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2bd9510ba3..d25b36a512 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -85,6 +85,7 @@ struct RISCVCPUConfig {
     bool ext_zve32f;
     bool ext_zve64f;
     bool ext_zve64d;
+    bool ext_zvbc;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c95adaf08a..6776777c4e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1182,3 +1182,9 @@ DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_6(vfwmaccbf16_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmaccbf16_vf, void, ptr, ptr, i64, ptr, env, i32)
+
+/* Vector crypto functions */
+DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vclmulh_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vclmulh_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e341fa9213..dd50d5a48c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -946,3 +946,9 @@ vfwcvtbf16_f_f_v  010010 . ..... 01101 001 ..... 1010111 @r2_vm
 # *** Zvfbfwma Standard Extension ***
 vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
+
+# *** Zvbc vector crypto extension ***
+vclmul_vv   001100 . ..... ..... 010 ..... 1010111 @r_vm
+vclmul_vx   001100 . ..... ..... 110 ..... 1010111 @r_vm
+vclmulh_vv  001101 . ..... ..... 010 ..... 1010111 @r_vm
+vclmulh_vx  001101 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 921c19e6cd..f74e0926c2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -120,6 +120,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zksed, PRIV_VERSION_1_12_0, ext_zksed),
     ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
     ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
+    ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
@@ -1271,6 +1272,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvbc && !cpu->cfg.ext_zve64f) {
+        error_setg(errp, "Zvbc extension requires V or Zve64{f,d} extensions");
+        return;
+    }
+
     if (cpu->cfg.ext_zk) {
         cpu->cfg.ext_zkn = true;
         cpu->cfg.ext_zkr = true;
@@ -1853,6 +1859,9 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
     DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
 
+    /* Vector cryptography extensions */
+    DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 697df1be9e..7dbf173adb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1094,6 +1094,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
+#include "insn_trans/trans_rvvk.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
new file mode 100644
index 0000000000..8b7c63d499
--- /dev/null
+++ b/target/riscv/vcrypto_helper.c
@@ -0,0 +1,59 @@
+/*
+ * RISC-V Vector Crypto Extension Helpers for QEMU.
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Written by Codethink Ltd and SiFive.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "exec/memop.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "internals.h"
+#include "vector_internals.h"
+
+static uint64_t clmul64(uint64_t y, uint64_t x)
+{
+    uint64_t result = 0;
+    for (int j = 63; j >= 0; j--) {
+        if ((y >> j) & 1) {
+            result ^= (x << j);
+        }
+    }
+    return result;
+}
+
+static uint64_t clmulh64(uint64_t y, uint64_t x)
+{
+    uint64_t result = 0;
+    for (int j = 63; j >= 1; j--) {
+        if ((y >> j) & 1) {
+            result ^= (x >> (64 - j));
+        }
+    }
+    return result;
+}
+
+RVVCALL(OPIVV2, vclmul_vv, OP_UUU_D, H8, H8, H8, clmul64)
+GEN_VEXT_VV(vclmul_vv, 8)
+RVVCALL(OPIVX2, vclmul_vx, OP_UUU_D, H8, H8, clmul64)
+GEN_VEXT_VX(vclmul_vx, 8)
+RVVCALL(OPIVV2, vclmulh_vv, OP_UUU_D, H8, H8, H8, clmulh64)
+GEN_VEXT_VV(vclmulh_vv, 8)
+RVVCALL(OPIVX2, vclmulh_vx, OP_UUU_D, H8, H8, clmulh64)
+GEN_VEXT_VX(vclmulh_vx, 8)
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
new file mode 100644
index 0000000000..552b08a2fd
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -0,0 +1,62 @@
+/*
+ * RISC-V translation routines for the vector crypto extension.
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Written by Codethink Ltd and SiFive.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Zvbc
+ */
+
+#define GEN_VV_MASKED_TRANS(NAME, CHECK)                     \
+    static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+    {                                                        \
+        if (CHECK(s, a)) {                                   \
+            return opivv_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                               gen_helper_##NAME, s);        \
+        }                                                    \
+        return false;                                        \
+    }
+
+static bool vclmul_vv_check(DisasContext *s, arg_rmrr *a)
+{
+    return opivv_check(s, a) &&
+           s->cfg_ptr->ext_zvbc == true &&
+           s->sew == MO_64;
+}
+
+GEN_VV_MASKED_TRANS(vclmul_vv, vclmul_vv_check)
+GEN_VV_MASKED_TRANS(vclmulh_vv, vclmul_vv_check)
+
+#define GEN_VX_MASKED_TRANS(NAME, CHECK)                     \
+    static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+    {                                                        \
+        if (CHECK(s, a)) {                                   \
+            return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                               gen_helper_##NAME, s);        \
+        }                                                    \
+        return false;                                        \
+    }
+
+static bool vclmul_vx_check(DisasContext *s, arg_rmrr *a)
+{
+    return opivx_check(s, a) &&
+           s->cfg_ptr->ext_zvbc == true &&
+           s->sew == MO_64;
+}
+
+GEN_VX_MASKED_TRANS(vclmul_vx, vclmul_vx_check)
+GEN_VX_MASKED_TRANS(vclmulh_vx, vclmul_vx_check)
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index c3801ee5e0..660078bda1 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -21,7 +21,8 @@ riscv_ss.add(files(
   'translate.c',
   'm128_helper.c',
   'crypto_helper.c',
-  'zce_helper.c'
+  'zce_helper.c',
+  'vcrypto_helper.c'
 ))
 riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
 
-- 
2.41.0



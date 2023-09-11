Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEEA79A3AA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaec-0000EW-D5; Mon, 11 Sep 2023 02:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeb-0000EM-9w
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:13 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeX-0004Si-TN
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:13 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3aa1254fb45so2806714b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414648; x=1695019448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSeyTQyuBwnxsxZ+/qUq8xyLuzir65M8yR4fVevxw4Y=;
 b=Flt98cr2J/HfVnRdsWAeMLnFC3xbypVYHjNraFenfjn9Vlw3qSupy6lQEWIcXzIooP
 dfoJxBcNLo7K5TlDlMRhW1GX1E2ZCthg8kIWssYSps0/BHfvotL69lvK5HepfTAJyYPh
 GO3/lr5+ZqSPtp+AWw6WKoVZyeYnVMiGmOKRH5mzfNPmF0o/+19N6cXNiG+PDG1GTfzv
 IliVIEsllhZafm+rr1oTxisBHzBkOxgmRJkIZpp0F5ClLclTt+ZkSbDoakwViOyoyrlQ
 2B+z9aZ8XCJzvPao26J2WqOHGbulB9a6U9gyt8ukXcQDSe/6wGSKKh/SUhHLC4gANyQ0
 MlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414648; x=1695019448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSeyTQyuBwnxsxZ+/qUq8xyLuzir65M8yR4fVevxw4Y=;
 b=sNkTUZQSniIhfpAvBwCYFiA9JIGD1NpkNS1fqrttefvsMFn1liCAQGI6swuX+hVFla
 1m6DALTfNgno/9i5VE56LRzdD9hd0ipSa1Xd+0i+/Kk8nvw8xPyutmgWDmjEKQEX7mZ9
 hnpQ4Ief8UDjNC37kAi9V0oWySrjgW6SVndCRJIbTfFolhsERoq+Zj+lAe5LQRAR+sgM
 B2CinSQxXXChRAbPJqfgn9gKHT3wG0XW40OqP+OsEqHecFfe5uEXWPk5IxojlEGXKkSJ
 0tD4dT6B8xTqEdvD365DKICrNFK2LSql4NAb4yvx4WlrE+raFB0D+Lak+HxhyvuHxdPf
 T2Nw==
X-Gm-Message-State: AOJu0YyezQwpOt+wtpFLE1WWJGBl2UqwrfZWuyqTuAamm7YZWqFarmBV
 Js0TDeUEMwM0J8FxJrB240xaEK67YVDZvQ==
X-Google-Smtp-Source: AGHT+IFBobHmAR4J0REG2OB8c4OnMjqnY12rk9ilUmyGGwVkYomkqDl/+TnICAOmVcii7AefIW5zyA==
X-Received: by 2002:a05:6870:e408:b0:1bf:8c9a:9a2c with SMTP id
 n8-20020a056870e40800b001bf8c9a9a2cmr10726296oag.15.1694414648164; 
 Sun, 10 Sep 2023 23:44:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:44:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/45] target/riscv: Refactor some of the generic vector
 functionality
Date: Mon, 11 Sep 2023 16:42:43 +1000
Message-ID: <20230911064320.939791-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x232.google.com
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

From: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>

Take some functions/macros out of `vector_helper` and put them in a new
module called `vector_internals`. This ensures they can be used by both
vector and vector-crypto helpers (latter implemented in proceeding
commits).

Signed-off-by: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230711165917.2629866-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_internals.h | 182 +++++++++++++++++++++++++++++
 target/riscv/vector_helper.c    | 201 +-------------------------------
 target/riscv/vector_internals.c |  81 +++++++++++++
 target/riscv/meson.build        |   1 +
 4 files changed, 265 insertions(+), 200 deletions(-)
 create mode 100644 target/riscv/vector_internals.h
 create mode 100644 target/riscv/vector_internals.c

diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
new file mode 100644
index 0000000000..749d138beb
--- /dev/null
+++ b/target/riscv/vector_internals.h
@@ -0,0 +1,182 @@
+/*
+ * RISC-V Vector Extension Internals
+ *
+ * Copyright (c) 2020 T-Head Semiconductor Co., Ltd. All rights reserved.
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
+#ifndef TARGET_RISCV_VECTOR_INTERNALS_H
+#define TARGET_RISCV_VECTOR_INTERNALS_H
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "internals.h"
+
+static inline uint32_t vext_nf(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, NF);
+}
+
+/*
+ * Note that vector data is stored in host-endian 64-bit chunks,
+ * so addressing units smaller than that needs a host-endian fixup.
+ */
+#if HOST_BIG_ENDIAN
+#define H1(x)   ((x) ^ 7)
+#define H1_2(x) ((x) ^ 6)
+#define H1_4(x) ((x) ^ 4)
+#define H2(x)   ((x) ^ 3)
+#define H4(x)   ((x) ^ 1)
+#define H8(x)   ((x))
+#else
+#define H1(x)   (x)
+#define H1_2(x) (x)
+#define H1_4(x) (x)
+#define H2(x)   (x)
+#define H4(x)   (x)
+#define H8(x)   (x)
+#endif
+
+/*
+ * Encode LMUL to lmul as following:
+ *     LMUL    vlmul    lmul
+ *      1       000       0
+ *      2       001       1
+ *      4       010       2
+ *      8       011       3
+ *      -       100       -
+ *     1/8      101      -3
+ *     1/4      110      -2
+ *     1/2      111      -1
+ */
+static inline int32_t vext_lmul(uint32_t desc)
+{
+    return sextract32(FIELD_EX32(simd_data(desc), VDATA, LMUL), 0, 3);
+}
+
+static inline uint32_t vext_vm(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VM);
+}
+
+static inline uint32_t vext_vma(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VMA);
+}
+
+static inline uint32_t vext_vta(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VTA);
+}
+
+static inline uint32_t vext_vta_all_1s(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, VTA_ALL_1S);
+}
+
+/*
+ * Earlier designs (pre-0.9) had a varying number of bits
+ * per mask value (MLEN). In the 0.9 design, MLEN=1.
+ * (Section 4.5)
+ */
+static inline int vext_elem_mask(void *v0, int index)
+{
+    int idx = index / 64;
+    int pos = index  % 64;
+    return (((uint64_t *)v0)[idx] >> pos) & 1;
+}
+
+/*
+ * Get number of total elements, including prestart, body and tail elements.
+ * Note that when LMUL < 1, the tail includes the elements past VLMAX that
+ * are held in the same vector register.
+ */
+static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
+                                            uint32_t esz)
+{
+    uint32_t vlenb = simd_maxsz(desc);
+    uint32_t sew = 1 << FIELD_EX64(env->vtype, VTYPE, VSEW);
+    int8_t emul = ctzl(esz) - ctzl(sew) + vext_lmul(desc) < 0 ? 0 :
+                  ctzl(esz) - ctzl(sew) + vext_lmul(desc);
+    return (vlenb << emul) / esz;
+}
+
+/* set agnostic elements to 1s */
+void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
+                       uint32_t tot);
+
+/* expand macro args before macro */
+#define RVVCALL(macro, ...)  macro(__VA_ARGS__)
+
+/* (TD, T1, T2, TX1, TX2) */
+#define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
+#define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
+#define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
+#define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
+
+/* operation of two vector elements */
+typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
+
+#define OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)    \
+{                                                               \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                             \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                             \
+    *((TD *)vd + HD(i)) = OP(s2, s1);                           \
+}
+
+void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
+                CPURISCVState *env, uint32_t desc,
+                opivv2_fn *fn, uint32_t esz);
+
+/* generate the helpers for OPIVV */
+#define GEN_VEXT_VV(NAME, ESZ)                            \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    do_vext_vv(vd, v0, vs1, vs2, env, desc,               \
+               do_##NAME, ESZ);                           \
+}
+
+typedef void opivx2_fn(void *vd, target_long s1, void *vs2, int i);
+
+/*
+ * (T1)s1 gives the real operator type.
+ * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
+ */
+#define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1);                      \
+}
+
+void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
+                CPURISCVState *env, uint32_t desc,
+                opivx2_fn fn, uint32_t esz);
+
+/* generate the helpers for OPIVX */
+#define GEN_VEXT_VX(NAME, ESZ)                            \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    do_vext_vx(vd, v0, s1, vs2, env, desc,                \
+               do_##NAME, ESZ);                           \
+}
+
+#endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 379f03df06..1f29236a63 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -27,6 +27,7 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
+#include "vector_internals.h"
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
@@ -73,68 +74,6 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     return vl;
 }
 
-/*
- * Note that vector data is stored in host-endian 64-bit chunks,
- * so addressing units smaller than that needs a host-endian fixup.
- */
-#if HOST_BIG_ENDIAN
-#define H1(x)   ((x) ^ 7)
-#define H1_2(x) ((x) ^ 6)
-#define H1_4(x) ((x) ^ 4)
-#define H2(x)   ((x) ^ 3)
-#define H4(x)   ((x) ^ 1)
-#define H8(x)   ((x))
-#else
-#define H1(x)   (x)
-#define H1_2(x) (x)
-#define H1_4(x) (x)
-#define H2(x)   (x)
-#define H4(x)   (x)
-#define H8(x)   (x)
-#endif
-
-static inline uint32_t vext_nf(uint32_t desc)
-{
-    return FIELD_EX32(simd_data(desc), VDATA, NF);
-}
-
-static inline uint32_t vext_vm(uint32_t desc)
-{
-    return FIELD_EX32(simd_data(desc), VDATA, VM);
-}
-
-/*
- * Encode LMUL to lmul as following:
- *     LMUL    vlmul    lmul
- *      1       000       0
- *      2       001       1
- *      4       010       2
- *      8       011       3
- *      -       100       -
- *     1/8      101      -3
- *     1/4      110      -2
- *     1/2      111      -1
- */
-static inline int32_t vext_lmul(uint32_t desc)
-{
-    return sextract32(FIELD_EX32(simd_data(desc), VDATA, LMUL), 0, 3);
-}
-
-static inline uint32_t vext_vta(uint32_t desc)
-{
-    return FIELD_EX32(simd_data(desc), VDATA, VTA);
-}
-
-static inline uint32_t vext_vma(uint32_t desc)
-{
-    return FIELD_EX32(simd_data(desc), VDATA, VMA);
-}
-
-static inline uint32_t vext_vta_all_1s(uint32_t desc)
-{
-    return FIELD_EX32(simd_data(desc), VDATA, VTA_ALL_1S);
-}
-
 /*
  * Get the maximum number of elements can be operated.
  *
@@ -153,21 +92,6 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
     return scale < 0 ? vlenb >> -scale : vlenb << scale;
 }
 
-/*
- * Get number of total elements, including prestart, body and tail elements.
- * Note that when LMUL < 1, the tail includes the elements past VLMAX that
- * are held in the same vector register.
- */
-static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
-                                            uint32_t esz)
-{
-    uint32_t vlenb = simd_maxsz(desc);
-    uint32_t sew = 1 << FIELD_EX64(env->vtype, VTYPE, VSEW);
-    int8_t emul = ctzl(esz) - ctzl(sew) + vext_lmul(desc) < 0 ? 0 :
-                  ctzl(esz) - ctzl(sew) + vext_lmul(desc);
-    return (vlenb << emul) / esz;
-}
-
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
     return (addr & ~env->cur_pmmask) | env->cur_pmbase;
@@ -200,20 +124,6 @@ static void probe_pages(CPURISCVState *env, target_ulong addr,
     }
 }
 
-/* set agnostic elements to 1s */
-static void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
-                              uint32_t tot)
-{
-    if (is_agnostic == 0) {
-        /* policy undisturbed */
-        return;
-    }
-    if (tot - cnt == 0) {
-        return;
-    }
-    memset(base + cnt, -1, tot - cnt);
-}
-
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
@@ -223,18 +133,6 @@ static inline void vext_set_elem_mask(void *v0, int index,
     ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
-/*
- * Earlier designs (pre-0.9) had a varying number of bits
- * per mask value (MLEN). In the 0.9 design, MLEN=1.
- * (Section 4.5)
- */
-static inline int vext_elem_mask(void *v0, int index)
-{
-    int idx = index / 64;
-    int pos = index  % 64;
-    return (((uint64_t *)v0)[idx] >> pos) & 1;
-}
-
 /* elements operations for load and store */
 typedef void vext_ldst_elem_fn(CPURISCVState *env, abi_ptr addr,
                                uint32_t idx, void *vd, uintptr_t retaddr);
@@ -729,18 +627,11 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
  * Vector Integer Arithmetic Instructions
  */
 
-/* expand macro args before macro */
-#define RVVCALL(macro, ...)  macro(__VA_ARGS__)
-
 /* (TD, T1, T2, TX1, TX2) */
 #define OP_SSS_B int8_t, int8_t, int8_t, int8_t, int8_t
 #define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
 #define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
 #define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
-#define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
-#define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
-#define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
-#define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
 #define OP_SUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
 #define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
 #define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
@@ -764,16 +655,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
 #define NOP_UUU_H uint16_t, uint16_t, uint32_t, uint16_t, uint32_t
 #define NOP_UUU_W uint32_t, uint32_t, uint64_t, uint32_t, uint64_t
 
-/* operation of two vector elements */
-typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
-
-#define OPIVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
-static void do_##NAME(void *vd, void *vs1, void *vs2, int i)    \
-{                                                               \
-    TX1 s1 = *((T1 *)vs1 + HS1(i));                             \
-    TX2 s2 = *((T2 *)vs2 + HS2(i));                             \
-    *((TD *)vd + HD(i)) = OP(s2, s1);                           \
-}
 #define DO_SUB(N, M) (N - M)
 #define DO_RSUB(N, M) (M - N)
 
@@ -786,40 +667,6 @@ RVVCALL(OPIVV2, vsub_vv_h, OP_SSS_H, H2, H2, H2, DO_SUB)
 RVVCALL(OPIVV2, vsub_vv_w, OP_SSS_W, H4, H4, H4, DO_SUB)
 RVVCALL(OPIVV2, vsub_vv_d, OP_SSS_D, H8, H8, H8, DO_SUB)
 
-static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
-                       CPURISCVState *env, uint32_t desc,
-                       opivv2_fn *fn, uint32_t esz)
-{
-    uint32_t vm = vext_vm(desc);
-    uint32_t vl = env->vl;
-    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vta = vext_vta(desc);
-    uint32_t vma = vext_vma(desc);
-    uint32_t i;
-
-    for (i = env->vstart; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, i)) {
-            /* set masked-off elements to 1s */
-            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
-            continue;
-        }
-        fn(vd, vs1, vs2, i);
-    }
-    env->vstart = 0;
-    /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
-}
-
-/* generate the helpers for OPIVV */
-#define GEN_VEXT_VV(NAME, ESZ)                            \
-void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
-                  void *vs2, CPURISCVState *env,          \
-                  uint32_t desc)                          \
-{                                                         \
-    do_vext_vv(vd, v0, vs1, vs2, env, desc,               \
-               do_##NAME, ESZ);                           \
-}
-
 GEN_VEXT_VV(vadd_vv_b, 1)
 GEN_VEXT_VV(vadd_vv_h, 2)
 GEN_VEXT_VV(vadd_vv_w, 4)
@@ -829,18 +676,6 @@ GEN_VEXT_VV(vsub_vv_h, 2)
 GEN_VEXT_VV(vsub_vv_w, 4)
 GEN_VEXT_VV(vsub_vv_d, 8)
 
-typedef void opivx2_fn(void *vd, target_long s1, void *vs2, int i);
-
-/*
- * (T1)s1 gives the real operator type.
- * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
- */
-#define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
-static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
-{                                                                   \
-    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
-    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1);                      \
-}
 
 RVVCALL(OPIVX2, vadd_vx_b, OP_SSS_B, H1, H1, DO_ADD)
 RVVCALL(OPIVX2, vadd_vx_h, OP_SSS_H, H2, H2, DO_ADD)
@@ -855,40 +690,6 @@ RVVCALL(OPIVX2, vrsub_vx_h, OP_SSS_H, H2, H2, DO_RSUB)
 RVVCALL(OPIVX2, vrsub_vx_w, OP_SSS_W, H4, H4, DO_RSUB)
 RVVCALL(OPIVX2, vrsub_vx_d, OP_SSS_D, H8, H8, DO_RSUB)
 
-static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
-                       CPURISCVState *env, uint32_t desc,
-                       opivx2_fn fn, uint32_t esz)
-{
-    uint32_t vm = vext_vm(desc);
-    uint32_t vl = env->vl;
-    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vta = vext_vta(desc);
-    uint32_t vma = vext_vma(desc);
-    uint32_t i;
-
-    for (i = env->vstart; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, i)) {
-            /* set masked-off elements to 1s */
-            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
-            continue;
-        }
-        fn(vd, s1, vs2, i);
-    }
-    env->vstart = 0;
-    /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
-}
-
-/* generate the helpers for OPIVX */
-#define GEN_VEXT_VX(NAME, ESZ)                            \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
-                  void *vs2, CPURISCVState *env,          \
-                  uint32_t desc)                          \
-{                                                         \
-    do_vext_vx(vd, v0, s1, vs2, env, desc,                \
-               do_##NAME, ESZ);                           \
-}
-
 GEN_VEXT_VX(vadd_vx_b, 1)
 GEN_VEXT_VX(vadd_vx_h, 2)
 GEN_VEXT_VX(vadd_vx_w, 4)
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
new file mode 100644
index 0000000000..9cf5c17cde
--- /dev/null
+++ b/target/riscv/vector_internals.c
@@ -0,0 +1,81 @@
+/*
+ * RISC-V Vector Extension Internals
+ *
+ * Copyright (c) 2020 T-Head Semiconductor Co., Ltd. All rights reserved.
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
+#include "vector_internals.h"
+
+/* set agnostic elements to 1s */
+void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
+                       uint32_t tot)
+{
+    if (is_agnostic == 0) {
+        /* policy undisturbed */
+        return;
+    }
+    if (tot - cnt == 0) {
+        return ;
+    }
+    memset(base + cnt, -1, tot - cnt);
+}
+
+void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
+                CPURISCVState *env, uint32_t desc,
+                opivv2_fn *fn, uint32_t esz)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vma = vext_vma(desc);
+    uint32_t i;
+
+    for (i = env->vstart; i < vl; i++) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+        fn(vd, vs1, vs2, i);
+    }
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+}
+
+void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
+                CPURISCVState *env, uint32_t desc,
+                opivx2_fn fn, uint32_t esz)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vma = vext_vma(desc);
+    uint32_t i;
+
+    for (i = env->vstart; i < vl; i++) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+        fn(vd, s1, vs2, i);
+    }
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 7f56c5f88d..c3801ee5e0 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -16,6 +16,7 @@ riscv_ss.add(files(
   'gdbstub.c',
   'op_helper.c',
   'vector_helper.c',
+  'vector_internals.c',
   'bitmanip_helper.c',
   'translate.c',
   'm128_helper.c',
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CDD74F652
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGjP-0002BX-Jq; Tue, 11 Jul 2023 13:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGjL-0001z2-Sq
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:00:51 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGjK-0001EF-69
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:00:51 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-262d33fa37cso2979898a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689094848; x=1691686848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHS86pQjMlrcYUtbAnhHB80mR2E9qScpycHOknGfKfE=;
 b=FBLzQX1y58lvdeBF8KumBXc2vBcSC4DePewdCk6fj4o7Ccb9+4NKS1C3I2PLxqiizs
 5qEsLpLYlUn2Y7O3jrL2JPN5xhvQkPf1qsGFI12P8q03jCbuclAGHMBVGXIQX7OrHeez
 hUTUXXEo2MtS9C6f03HWYYO+KHtBPBZe69+bEgPfEtN58NeAppijMLD8vnQSJBYCgZWF
 GWIY6LmZuupOOuUbiLUhJH6FpQoFtQ+soDt8ZdVMSyeCqRjySRqU1VN5/us36O8R8pdq
 2Ud0BylmHUJcRqWfQJ/4EfAqF5l32/kxYxcIbzHPyAdqyErIH40N0IE5/lZcJaaXjJG1
 Rm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094848; x=1691686848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHS86pQjMlrcYUtbAnhHB80mR2E9qScpycHOknGfKfE=;
 b=WG7EFsQTYB1C1KubV9qcWTqyKfmYqE4P2Q1kYNp50VJAnPaodzkWniZJc/Hx4jpWoZ
 u39jj3Svk4B81yRL+De8+uXYRArutEmxVi9Dgb67HIK4wcSfYyeyZ9uSSgji4VcGlFLX
 UsP6GItgjwr2t4EmaahUDdX2oWZPXkhXg9Aw6LKqZoB2pFInUNDWDcY8+Rrg6LCplPDT
 su4elGFQi2fYe4LvgipBDqSZNGwMEGlvMqDVuXlLf7w07TDBiLpg8bSHQmDWwt8jlg5z
 gi3G/t9yGCzI/j7Bs2751f0A1eaBwwA269S1oYIDKEh+ni0R2U9OOs6tNwc2LyrwspfD
 8+xg==
X-Gm-Message-State: ABy/qLaNpPSlqyqv9+CeRLN77FSWpayjsd2Eq2HaEddDwYwVsFLzpHQu
 QEnSKhZ84vi2eJcw+Axcvh+WVrbL8qyL6gmN8vdveiJo1MLQJhLrkAue86o5dl9VwGqM7gnI5vp
 s6krsaPQaxplEiqwURWO/s1VtmovXylihKSAUm+9RXYCUnmG3E0n4AL17Et6LWEZMueDIKgTd3V
 ZehdU=
X-Google-Smtp-Source: APBJJlGSkNLVyMXuae14/zmfIkAC9WezwVZW8+NETk7sRx2+26qO1z1IcYHw0mCHUluyYO/f7RiDaw==
X-Received: by 2002:a17:90b:3109:b0:259:3e2a:b6d8 with SMTP id
 gc9-20020a17090b310900b002593e2ab6d8mr13419804pjb.17.1689094848247; 
 Tue, 11 Jul 2023 10:00:48 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 gw10-20020a17090b0a4a00b00262fc84b931sm8381793pjb.44.2023.07.11.10.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 10:00:47 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v8 07/15] target/riscv: Refactor some of the generic vector
 functionality
Date: Wed, 12 Jul 2023 00:59:06 +0800
Message-Id: <20230711165917.2629866-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711165917.2629866-1-max.chou@sifive.com>
References: <20230711165917.2629866-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102c.google.com
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

From: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>

Move some macros out of `vector_helper` and into `vector_internals`.
This ensures they can be used by both vector and vector-crypto helpers
(latter implemented in proceeding commits).

Signed-off-by: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c    | 42 ------------------------------
 target/riscv/vector_internals.h | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6434fd2f7e8..ae94576f3df 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -635,9 +635,6 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b)
 #define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
 #define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
 #define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
-#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
-#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
-#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
 #define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
 #define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
 #define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
@@ -3437,11 +3434,6 @@ GEN_VEXT_VF(vfwnmsac_vf_h, 4)
 GEN_VEXT_VF(vfwnmsac_vf_w, 8)
 
 /* Vector Floating-Point Square-Root Instruction */
-/* (TD, T2, TX2) */
-#define OP_UU_H uint16_t, uint16_t, uint16_t
-#define OP_UU_W uint32_t, uint32_t, uint32_t
-#define OP_UU_D uint64_t, uint64_t, uint64_t
-
 #define OPFVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
 static void do_##NAME(void *vd, void *vs2, int i,      \
                       CPURISCVState *env)              \
@@ -4138,40 +4130,6 @@ GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
 GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
 
 /* Vector Floating-Point Classify Instruction */
-#define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
-static void do_##NAME(void *vd, void *vs2, int i)      \
-{                                                      \
-    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
-    *((TD *)vd + HD(i)) = OP(s2);                      \
-}
-
-#define GEN_VEXT_V(NAME, ESZ)                          \
-void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
-                  CPURISCVState *env, uint32_t desc)   \
-{                                                      \
-    uint32_t vm = vext_vm(desc);                       \
-    uint32_t vl = env->vl;                             \
-    uint32_t total_elems =                             \
-        vext_get_total_elems(env, desc, ESZ);          \
-    uint32_t vta = vext_vta(desc);                     \
-    uint32_t vma = vext_vma(desc);                     \
-    uint32_t i;                                        \
-                                                       \
-    for (i = env->vstart; i < vl; i++) {               \
-        if (!vm && !vext_elem_mask(v0, i)) {           \
-            /* set masked-off elements to 1s */        \
-            vext_set_elems_1s(vd, vma, i * ESZ,        \
-                              (i + 1) * ESZ);          \
-            continue;                                  \
-        }                                              \
-        do_##NAME(vd, vs2, i);                         \
-    }                                                  \
-    env->vstart = 0;                                   \
-    /* set tail elements to 1s */                      \
-    vext_set_elems_1s(vd, vta, vl * ESZ,               \
-                      total_elems * ESZ);              \
-}
-
 target_ulong fclass_h(uint64_t frs1)
 {
     float16 f = frs1;
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 749d138bebe..8133111e5f6 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -121,12 +121,52 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
 /* expand macro args before macro */
 #define RVVCALL(macro, ...)  macro(__VA_ARGS__)
 
+/* (TD, T2, TX2) */
+#define OP_UU_B uint8_t, uint8_t, uint8_t
+#define OP_UU_H uint16_t, uint16_t, uint16_t
+#define OP_UU_W uint32_t, uint32_t, uint32_t
+#define OP_UU_D uint64_t, uint64_t, uint64_t
+
 /* (TD, T1, T2, TX1, TX2) */
 #define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
 #define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
 #define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
 #define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
 
+#define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
+static void do_##NAME(void *vd, void *vs2, int i)      \
+{                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
+    *((TD *)vd + HD(i)) = OP(s2);                      \
+}
+
+#define GEN_VEXT_V(NAME, ESZ)                          \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+                  CPURISCVState *env, uint32_t desc)   \
+{                                                      \
+    uint32_t vm = vext_vm(desc);                       \
+    uint32_t vl = env->vl;                             \
+    uint32_t total_elems =                             \
+        vext_get_total_elems(env, desc, ESZ);          \
+    uint32_t vta = vext_vta(desc);                     \
+    uint32_t vma = vext_vma(desc);                     \
+    uint32_t i;                                        \
+                                                       \
+    for (i = env->vstart; i < vl; i++) {               \
+        if (!vm && !vext_elem_mask(v0, i)) {           \
+            /* set masked-off elements to 1s */        \
+            vext_set_elems_1s(vd, vma, i * ESZ,        \
+                              (i + 1) * ESZ);          \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i);                         \
+    }                                                  \
+    env->vstart = 0;                                   \
+    /* set tail elements to 1s */                      \
+    vext_set_elems_1s(vd, vta, vl * ESZ,               \
+                      total_elems * ESZ);              \
+}
+
 /* operation of two vector elements */
 typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
 
@@ -179,4 +219,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
                do_##NAME, ESZ);                           \
 }
 
+/* Three of the widening shortening macros: */
+/* (TD, T1, T2, TX1, TX2) */
+#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
+#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
+#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
+
 #endif /* TARGET_RISCV_VECTOR_INTERNALS_H */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B4744E81
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzQ4-0002oZ-4v; Sun, 02 Jul 2023 11:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzPj-0002UL-T8
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:55:07 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzPg-0008O9-Q8
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:55:03 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-55adfa61199so2670874a12.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1688313299; x=1690905299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkO25Rg1Lt6NXKDYaL4gODfG/1cPbL2sMM5/ee4/pn4=;
 b=Mtmyp0lpM3CH0/kNd+tmGiG4dr5rMCo5yB8z7xw1XXKbVG3REmq3aSku0WjJN7enwB
 lT3bHG9Zcqh6cBUn6658V2HlOy7s70Q0QSzuyltFQgcVfNrPNBTVkvj2ZRRG9RX2ELwd
 BIO0x9Okrv7tFrYYKJrnGbqlU4a6xeeRY9O0Xg/vu3bMpw4/XP859hm1kT+B/XW7LbsK
 BXFGKKIXYzz1v7Z1jsFeMJrewDckEGXM/eaaJK25HiQ+Rd9A7tSruJTeWDu2oAWn4WV6
 GDxfCcRIe4xsJ9n0F3AXr7kv6+jAUhOtOOTsn//HIydlDNwl3q5t5kgVAgasFWDKA9XO
 wOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688313299; x=1690905299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkO25Rg1Lt6NXKDYaL4gODfG/1cPbL2sMM5/ee4/pn4=;
 b=NZHCYMnAhdMcxD6LcLI4E78bZ1tnXTvVNZQNW5yGtCOm++YfHPKVOHdo0rKoqT1pLz
 eQWlRs+GTLZK1cSA1eqd4f4VqWIKC24mKBmKq99T18q143TUCFt8LOE9Sb59rsLtsYaJ
 Ad7jaZ9thp4dRApXKZNZtA8lc5+6Ay/TvVSduQRKXdLaksm2Fg3Wn0XYoC/NKjI9/rle
 K/JSFBJxc7vzhVQE4NiX6yZAl6Hl9Bm4LdaGrEszuxN/gpNI7qcBO7DFn5z5HcbPHEcE
 zInu6jVVsGeyNSGd104eZraYfsaXsS5ty8QG/sgAiv55BOl5vlgbO2Nirl9pnkn3mUcC
 8oVg==
X-Gm-Message-State: AC+VfDz3H20yHhe7j/J/fA7Ymr5aS/hL7MtviBYokfE/62lsYpfmKWlF
 oc/WpWIcqZxwiLvNiVJJib8UlUsYJ4TVYTwxdrJISca5s9n0TexCJbjxnpKB9euZ8VDOxaPGhFg
 67N9AThJsRu2Id8PVY+XqM188W1nBHnlKpJwgYaZ7im694+tF4w6OKV0kdc5/JM1JseTrwTIh3X
 +2nnw=
X-Google-Smtp-Source: ACHHUZ4FqKOoCIjTHb90BD5bSm+XbK4xg4QOD1PUcejSp/GgcnLy9WenRC/GEFwjXFfvYpv+VF5n/g==
X-Received: by 2002:a05:6a20:1051:b0:12b:e7de:6382 with SMTP id
 gt17-20020a056a20105100b0012be7de6382mr8537676pzc.34.1688313299101; 
 Sun, 02 Jul 2023 08:54:59 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 y19-20020aa78553000000b0066f37665a63sm8231969pfn.73.2023.07.02.08.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 08:54:58 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 07/15] target/riscv: Refactor some of the generic vector
 functionality
Date: Sun,  2 Jul 2023 23:53:41 +0800
Message-Id: <20230702155354.2478495-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702155354.2478495-1-max.chou@sifive.com>
References: <20230702155354.2478495-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52e.google.com
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
index 57be83400d..124ed22f95 100644
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
@@ -3426,11 +3423,6 @@ GEN_VEXT_VF(vfwnmsac_vf_h, 4)
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
@@ -4127,40 +4119,6 @@ GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
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
index 749d138beb..8133111e5f 100644
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



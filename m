Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F2387B418
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Mar 2024 23:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWgI-0007Su-AB; Wed, 13 Mar 2024 18:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfq-0007O7-C5
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:02:10 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfj-0004J2-Ev
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:02:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6a9fafacdso312205b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710367321; x=1710972121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPly5yBBZQQVtgU/69v3f7o9ty+mZmpXig0D2/l9sek=;
 b=R7jiD+ii3wAWAnCHmWsf3PZM6SMheqfbml6VTZqDoGCzTrD0Fw3bHxqZLbFZLRv2cz
 j8hjFPX7y6tId6jgaPpFKfILfgsOv4rPfa+VLXC1eRIpd8BnNdgVjqg5Gk7RYlT6IDIU
 zh4VDi5pe5yQGTQcicSmlmpNfFNcLXQUqMPnsZvRzaAjOjgrySZrpplr0MYjfDwXZtMy
 n6f7tWNOahw9n/ZWNGSQhFiH2JQMMiE9T+KX9ingcq6VaYfoX/n0lSffGwAVwflN6Y8+
 qwiTPBMzH7x5Fo76Lq9txszPzxpiNxedWd//R7kA2WN3K2srbN8n+c1QxLuwERxXYrFA
 nWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710367321; x=1710972121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPly5yBBZQQVtgU/69v3f7o9ty+mZmpXig0D2/l9sek=;
 b=cFgSHk4QjHenHs/lOnI4GsLdmbv57fwF7/U53f2IuWTQ84GZ3uTKMJ83mHPsFoEWjA
 nSHlx2ri3cybAa14L99qIt7qchtUhFGauXBWiY5X8c9W1qnDisRn7b5QjPNu7hvL8CfH
 ujdEJajZ2qAnJsmYng6AyaKAm9EAUTxbx97FErUBU5ConNm81OdDsUooACBfgAGEKwRZ
 LqpanjTtZ1dJhCN+i49djV8/x0wn7li2XbQl7EpQKnZCk1fmsmOBH2INm7CG1w/Mo0Qy
 Z6V1jOQTB7+3QFtKyhd7tenwWSxJfIraFLaJQKsqxy+YLVApvx9WtdQ2H+fA6Eg6JhmK
 WSuQ==
X-Gm-Message-State: AOJu0Yw6TsPO0rea7wtDKflt8L0CyH89yruRBKePu6r3BbvzeQfWyrIc
 bKS34zXiODhf47+V+fgmswt1QDfImAWp4rD6QpIujhZhxnE9bJO80nf2UuXwru0tiIDF1ygb7Qd
 Z
X-Google-Smtp-Source: AGHT+IHjcswP445Lqak7DEYOnImeOOSlBNAYbNXPMNAJUpYy7J5de9HmjtobIBvKiPo9WyPdy6sDjw==
X-Received: by 2002:a05:6a00:22d1:b0:6e5:43b5:953b with SMTP id
 f17-20020a056a0022d100b006e543b5953bmr19401pfj.14.1710367321074; 
 Wed, 13 Mar 2024 15:02:01 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ln17-20020a056a003cd100b006e6bcbea9e0sm95812pfb.88.2024.03.13.15.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:02:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v14 4/8] target/riscv/vector_helpers: do early exit
 when vstart >= vl
Date: Wed, 13 Mar 2024 19:01:37 -0300
Message-ID: <20240313220141.427730-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313220141.427730-1-dbarboza@ventanamicro.com>
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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

We're going to make changes that will required each helper to be
responsible for the 'vstart' management, i.e. we will relieve the
'vstart < vl' assumption that helpers have today.

Helpers are usually able to deal with vstart >= vl, i.e. doing nothing
aside from setting vstart = 0 at the end, but the tail update functions
will update the tail regardless of vstart being valid or not.

Unifying the tail update process in a single function that would handle
the vstart >= vl case isn't trivial. We have 2 functions that are used
to update tail: vext_set_tail_elems_1s() and vext_set_elems_1s(). The
latter is a more generic function that is also used to mask elements.
There's no easy way of making all callers using vext_set_tail_elems_1s()
because we're not encoding NF properly in all cases [1].

This patch takes a blunt approach: do an early exit in every single
vector helper if vstart >= vl. We can worry about unifying the tail
update process later.

[1] https://lore.kernel.org/qemu-riscv/1590234b-0291-432a-a0fa-c5a6876097bc@linux.alibaba.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vcrypto_helper.c   | 32 ++++++++++++
 target/riscv/vector_helper.c    | 88 +++++++++++++++++++++++++++++++++
 target/riscv/vector_internals.c |  4 ++
 target/riscv/vector_internals.h |  9 ++++
 4 files changed, 133 insertions(+)

diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index e2d719b13b..f7423df226 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -222,6 +222,8 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
         uint32_t total_elems = vext_get_total_elems(env, desc, 4);        \
         uint32_t vta = vext_vta(desc);                                    \
                                                                           \
+        VSTART_CHECK_EARLY_EXIT(env);                                     \
+                                                                          \
         for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {        \
             AESState round_key;                                           \
             round_key.d[0] = *((uint64_t *)vs2 + H8(i * 2 + 0));          \
@@ -246,6 +248,8 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
         uint32_t total_elems = vext_get_total_elems(env, desc, 4);        \
         uint32_t vta = vext_vta(desc);                                    \
                                                                           \
+        VSTART_CHECK_EARLY_EXIT(env);                                     \
+                                                                          \
         for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {        \
             AESState round_key;                                           \
             round_key.d[0] = *((uint64_t *)vs2 + H8(0));                  \
@@ -305,6 +309,8 @@ void HELPER(vaeskf1_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     uimm &= 0b1111;
     if (uimm > 10 || uimm == 0) {
         uimm ^= 0b1000;
@@ -351,6 +357,8 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     uimm &= 0b1111;
     if (uimm > 14 || uimm < 2) {
         uimm ^= 0b1000;
@@ -457,6 +465,8 @@ void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         if (sew == MO_32) {
             vsha2ms_e32(((uint32_t *)vd) + i * 4, ((uint32_t *)vs1) + i * 4,
@@ -572,6 +582,8 @@ void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
                   ((uint32_t *)vs1) + 4 * i + 2);
@@ -590,6 +602,8 @@ void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
                   ((uint64_t *)vs1) + 4 * i + 2);
@@ -608,6 +622,8 @@ void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
                   (((uint32_t *)vs1) + 4 * i));
@@ -626,6 +642,8 @@ void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t total_elems;
     uint32_t vta = vext_vta(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
                   (((uint64_t *)vs1) + 4 * i));
@@ -658,6 +676,8 @@ void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
     uint32_t *vs1 = vs1_vptr;
     uint32_t *vs2 = vs2_vptr;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (int i = env->vstart / 8; i < env->vl / 8; i++) {
         uint32_t w[24];
         for (int j = 0; j < 8; j++) {
@@ -757,6 +777,8 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     uint32_t *vs2 = vs2_vptr;
     uint32_t v1[8], v2[8], v3[8];
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (int i = env->vstart / 8; i < env->vl / 8; i++) {
         for (int k = 0; k < 8; k++) {
             v2[k] = bswap32(vd[H4(i * 8 + k)]);
@@ -780,6 +802,8 @@ void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
     uint32_t vta = vext_vta(desc);
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         uint64_t Y[2] = {vd[i * 2 + 0], vd[i * 2 + 1]};
         uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
@@ -817,6 +841,8 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
     uint32_t vta = vext_vta(desc);
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         uint64_t Y[2] = {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
         uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
@@ -853,6 +879,8 @@ void HELPER(vsm4k_vi)(void *vd, void *vs2, uint32_t uimm5, CPURISCVState *env,
     uint32_t esz = sizeof(uint32_t);
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = group_start; i < group_end; ++i) {
         uint32_t vstart = i * egs;
         uint32_t vend = (i + 1) * egs;
@@ -909,6 +937,8 @@ void HELPER(vsm4r_vv)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t esz = sizeof(uint32_t);
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = group_start; i < group_end; ++i) {
         uint32_t vstart = i * egs;
         uint32_t vend = (i + 1) * egs;
@@ -943,6 +973,8 @@ void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t esz = sizeof(uint32_t);
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = group_start; i < group_end; ++i) {
         uint32_t vstart = i * egs;
         uint32_t vend = (i + 1) * egs;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cd8235ea98..48d041dd4e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -207,6 +207,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env->vstart; i < env->vl; i++, env->vstart++) {
         k = 0;
         while (k < nf) {
@@ -272,6 +274,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     /* load bytes from guest memory */
     for (i = env->vstart; i < evl; i++, env->vstart++) {
         k = 0;
@@ -386,6 +390,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     /* load bytes from guest memory */
     for (i = env->vstart; i < env->vl; i++, env->vstart++) {
         k = 0;
@@ -477,6 +483,8 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     target_ulong addr, offset, remain;
     int mmu_index = riscv_env_mmu_index(env, false);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     /* probe every access */
     for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -572,6 +580,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     k = env->vstart / max_elems;
     off = env->vstart % max_elems;
 
@@ -877,6 +887,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -909,6 +921,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                        \
+                                                                         \
     for (i = env->vstart; i < vl; i++) {                                 \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
         ETYPE carry = vext_elem_mask(v0, i);                             \
@@ -944,6 +958,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -982,6 +998,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
     uint32_t i;                                                 \
                                                                 \
+    VSTART_CHECK_EARLY_EXIT(env);                               \
+                                                                \
     for (i = env->vstart; i < vl; i++) {                        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
         ETYPE carry = !vm && vext_elem_mask(v0, i);             \
@@ -1078,6 +1096,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vma = vext_vma(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -1125,6 +1145,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     uint32_t vma = vext_vma(desc);                          \
     uint32_t i;                                             \
                                                             \
+    VSTART_CHECK_EARLY_EXIT(env);                           \
+                                                            \
     for (i = env->vstart; i < vl; i++) {                    \
         if (!vm && !vext_elem_mask(v0, i)) {                \
             /* set masked-off elements to 1s */             \
@@ -1187,6 +1209,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -1252,6 +1276,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                   \
+                                                                    \
     for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
         if (!vm && !vext_elem_mask(v0, i)) {                        \
@@ -1799,6 +1825,8 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
         *((ETYPE *)vd + H(i)) = s1;                                  \
@@ -1823,6 +1851,8 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env->vstart; i < vl; i++) {                             \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
     }                                                                \
@@ -1846,6 +1876,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
         *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
@@ -1870,6 +1902,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
         ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
@@ -1915,6 +1949,8 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2040,6 +2076,8 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2837,6 +2875,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             /* set masked-off elements to 1s */           \
@@ -2880,6 +2920,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             /* set masked-off elements to 1s */           \
@@ -3466,6 +3508,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
+    VSTART_CHECK_EARLY_EXIT(env);                      \
+                                                       \
     if (vl == 0) {                                     \
         return;                                        \
     }                                                  \
@@ -3987,6 +4031,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -4027,6 +4073,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                   \
+                                                                    \
     for (i = env->vstart; i < vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
         if (!vm && !vext_elem_mask(v0, i)) {                        \
@@ -4220,6 +4268,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env->vstart; i < vl; i++) {                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         *((ETYPE *)vd + H(i)) =                               \
@@ -4386,6 +4436,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -4472,6 +4524,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     uint32_t i;                                            \
     TD s1 =  *((TD *)vs1 + HD(0));                         \
                                                            \
+    VSTART_CHECK_EARLY_EXIT(env);                          \
+                                                           \
     for (i = env->vstart; i < vl; i++) {                   \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
         if (!vm && !vext_elem_mask(v0, i)) {               \
@@ -4544,6 +4598,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         a = vext_elem_mask(vs1, i);                       \
         b = vext_elem_mask(vs2, i);                       \
@@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env->vl;
     int i;
 
+    if (env->vstart >= env->vl) {
+        env->vstart = 0;
+        return 0;
+    }
+
     for (i = env->vstart; i < vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {
@@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env->vl;
     int i;
 
+    if (env->vstart >= env->vl) {
+        env->vstart = 0;
+        return 0;
+    }
+
     for (i = env->vstart; i < vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {
@@ -4632,6 +4698,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
     int i;
     bool first_mask_bit = false;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -4704,6 +4772,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -4737,6 +4807,8 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     uint32_t vma = vext_vma(desc);                                        \
     int i;                                                                \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -4772,6 +4844,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong offset = s1, i_min, i;                                   \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     i_min = MAX(env->vstart, offset);                                     \
     for (i = i_min; i < vl; i++) {                                        \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
@@ -4805,6 +4879,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong i_max, i_min, i;                                         \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
     i_max = MAX(i_min, env->vstart);                                      \
     for (i = env->vstart; i < i_max; ++i) {                               \
@@ -4847,6 +4923,8 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                          \
     uint32_t i;                                                             \
                                                                             \
+    VSTART_CHECK_EARLY_EXIT(env);                                           \
+                                                                            \
     for (i = env->vstart; i < vl; i++) {                                    \
         if (!vm && !vext_elem_mask(v0, i)) {                                \
             /* set masked-off elements to 1s */                             \
@@ -4896,6 +4974,8 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                            \
     uint32_t i;                                                               \
                                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                                             \
+                                                                              \
     for (i = env->vstart; i < vl; i++) {                                      \
         if (!vm && !vext_elem_mask(v0, i)) {                                  \
             /* set masked-off elements to 1s */                               \
@@ -4971,6 +5051,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint64_t index;                                                       \
     uint32_t i;                                                           \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -5014,6 +5096,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint64_t index = s1;                                                  \
     uint32_t i;                                                           \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -5048,6 +5132,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t num = 0, i;                                                  \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vext_elem_mask(vs1, i)) {                                    \
             continue;                                                     \
@@ -5100,6 +5186,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     uint32_t vma = vext_vma(desc);                               \
     uint32_t i;                                                  \
                                                                  \
+    VSTART_CHECK_EARLY_EXIT(env);                                \
+                                                                 \
     for (i = env->vstart; i < vl; i++) {                         \
         if (!vm && !vext_elem_mask(v0, i)) {                     \
             /* set masked-off elements to 1s */                  \
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 12f5964fbb..996c21eb31 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -44,6 +44,8 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vma = vext_vma(desc);
     uint32_t i;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -68,6 +70,8 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vma = vext_vma(desc);
     uint32_t i;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 842765f6c1..9e1e15b575 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -24,6 +24,13 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 
+#define VSTART_CHECK_EARLY_EXIT(env) do { \
+    if (env->vstart >= env->vl) {         \
+        env->vstart = 0;                  \
+        return;                           \
+    }                                     \
+} while (0)
+
 static inline uint32_t vext_nf(uint32_t desc)
 {
     return FIELD_EX32(simd_data(desc), VDATA, NF);
@@ -151,6 +158,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
+    VSTART_CHECK_EARLY_EXIT(env);                      \
+                                                       \
     for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
             /* set masked-off elements to 1s */        \
-- 
2.43.2



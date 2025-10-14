Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356F1BDB483
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 22:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8liP-00015L-5f; Tue, 14 Oct 2025 16:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liN-00013w-70
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liH-0000U1-H2
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=QTYfwcNR3uxc7BiUVi8y1FMFWAZApGFKjHeFHtMytzk=; b=cczrbE3KfnU1c/i
 LZqvV4eOAEvUrJHEgudDm/WDtX7DGqgmyZ4XxmJRwZwIQRJlhCKFxWoFHtENKl2Es6iL+LEee2mDy
 WqgLemctU8OS9+ZCUw5ZYE5aKn/6bjGOxNAo7yUDU583aWvn4Dm7R6tH0ix+TiEEUN1tWmwtiSepE
 bw=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 21/34] target/riscv: Fix size of priv
Date: Tue, 14 Oct 2025 22:34:58 +0200
Message-ID: <20251014203512.26282-22-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The priv field of CPUArchState only stores values in the range [0,3],
fix to 8 bits in size and update relevant function arguments.  Introduce
a new privilege_mode_t typedef for passing around the privilege mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h        | 15 +++++++++++----
 target/riscv/cpu_helper.c | 12 +++++++-----
 target/riscv/machine.c    |  2 +-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 37035a9541..1d5d74f11b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -109,6 +109,12 @@ typedef struct riscv_cpu_profile {
 
 extern RISCVCPUProfile *riscv_profiles[];
 
+/*
+ * Type large enough to hold all PRV_* fields, update CPUArchState::priv
+ * migration field if changing this type.
+ */
+typedef uint8_t privilege_mode_t;
+
 /* Privileged specification version */
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
@@ -264,7 +270,7 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-    target_ulong priv;
+    privilege_mode_t priv;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     uint64_t senvcfg;
@@ -650,10 +656,11 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
+void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
+                        bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, target_ulong prev_priv, bool prev_virt);
+    enum CTRType type, privilege_mode_t prev_priv, bool prev_virt);
 void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
@@ -724,7 +731,7 @@ static inline int cpu_address_mode(CPURISCVState *env)
     return mode;
 }
 
-static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
+static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 {
     RISCVMXL xl = env->misa_mxl;
     /*
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7790244d93..26c3c846a5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -799,7 +799,7 @@ void riscv_ctr_clear(CPURISCVState *env)
     memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
 }
 
-static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
+static uint64_t riscv_ctr_priv_to_mask(privilege_mode_t priv, bool virt)
 {
     switch (priv) {
     case PRV_M:
@@ -819,7 +819,8 @@ static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
     g_assert_not_reached();
 }
 
-static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long priv,
+static uint64_t riscv_ctr_get_control(CPURISCVState *env,
+                                      privilege_mode_t priv,
                                       bool virt)
 {
     switch (priv) {
@@ -841,7 +842,8 @@ static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long priv,
  * and src privilege is less than target privilege. This includes the virtual
  * state as well.
  */
-static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
+static bool riscv_ctr_check_xte(CPURISCVState *env,
+                                privilege_mode_t src_prv,
                                 bool src_virt)
 {
     target_long tgt_prv = env->priv;
@@ -930,7 +932,7 @@ static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
  *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
  */
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, target_ulong src_priv, bool src_virt)
+    enum CTRType type, privilege_mode_t src_priv, bool src_virt)
 {
     bool tgt_virt = env->virt_enabled;
     uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
@@ -1028,7 +1030,7 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     env->sctrstatus = set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
 }
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
+void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv, bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c55794c554..ce5e44325d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -445,7 +445,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
         VMSTATE_UNUSED(4),
         VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
-        VMSTATE_UINTTL(env.priv, RISCVCPU),
+        VMSTATE_UINT8(env.priv, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
         VMSTATE_UINT64(env.resetvec, RISCVCPU),
         VMSTATE_UINT64(env.mhartid, RISCVCPU),
-- 
2.51.0



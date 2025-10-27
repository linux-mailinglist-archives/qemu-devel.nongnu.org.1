Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCCC0FE15
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 19:18:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmO-0004nc-Bk; Mon, 27 Oct 2025 14:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRm6-0004ho-Ns
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRly-000409-6U
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=okOiofNy7st7WsZ2e3AUHi2e/nfBmPBAYNfiTpuL2hk=; b=YR1pdmwDq+QIt8H
 QQvxE2haJfqx5j1h2PksBzI8mcB0OWB2e9ciKwXOdFjur992ZB3GAQs9mLkcUwN2mxqy+085/RbjM
 TWtlj5uU00+dYgQ1SM1jlG7gYCXihpbJ3kGjMp3+r84V7dw7BmGzwQ3EYrBQ58uG1KCH57smgHTyo
 YU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 21/33] target/riscv: Fix size of gei fields
Date: Mon, 27 Oct 2025 19:18:18 +0100
Message-ID: <20251027181831.27016-22-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

geilen takes the values 31 or 63, fix it to 8 bits. hgeie and hgeip are
at most 64 bits in size, fix to 64.  Update relevant function arguments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 10 +++++-----
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/machine.c    |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c42971809..5f051796f4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -279,7 +279,7 @@ struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
-    target_ulong geilen;
+    uint8_t geilen;
     uint64_t resetvec;
 
     uint64_t mhartid;
@@ -356,8 +356,8 @@ struct CPUArchState {
     uint64_t htval;
     uint64_t htinst;
     uint64_t hgatp;
-    target_ulong hgeie;
-    target_ulong hgeip;
+    uint64_t hgeie;
+    uint64_t hgeip;
     uint64_t htimedelta;
     uint64_t hvien;
 
@@ -609,8 +609,8 @@ int riscv_cpu_mirq_pending(CPURISCVState *env);
 int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
+uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
+void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 38b57bc622..e0a324b401 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -661,7 +661,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
+uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
 {
     if (!riscv_has_ext(env, RVH)) {
         return 0;
@@ -670,7 +670,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
     return env->geilen;
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
+void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
         return;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ce5e44325d..8a8f5be8d6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -91,8 +91,8 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.htval, RISCVCPU),
         VMSTATE_UINT64(env.htinst, RISCVCPU),
         VMSTATE_UINT64(env.hgatp, RISCVCPU),
-        VMSTATE_UINTTL(env.hgeie, RISCVCPU),
-        VMSTATE_UINTTL(env.hgeip, RISCVCPU),
+        VMSTATE_UINT64(env.hgeie, RISCVCPU),
+        VMSTATE_UINT64(env.hgeip, RISCVCPU),
         VMSTATE_UINT64(env.hvien, RISCVCPU),
         VMSTATE_UINT64(env.hvip, RISCVCPU),
         VMSTATE_UINT64(env.htimedelta, RISCVCPU),
-- 
2.51.0



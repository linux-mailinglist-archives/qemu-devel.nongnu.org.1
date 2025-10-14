Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C72BDB474
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 22:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8liS-00016l-Rb; Tue, 14 Oct 2025 16:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liQ-00016A-Oq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:51 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liI-0000UI-Ti
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=TUmJvSUXb1z086TrrU3UN8wTaK6KpbzMPiFq/OCXpAw=; b=Xp2OtosMQ7YN1ow
 uH5kh2T8jAvMmqsIzQlqSGQ4OZykg8mVc1FmXoMNfS01Cqq4FRl/kcFczO4SQZ8/FvoJFz9ZeC8kB
 nijrQbKCPZeRMGpLBXkLIsO3k8Th6l3GsVWpNXjHJcmakxBOErqwn0lmOa4vP/QWzRGVePMf1hEOV
 DI=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 23/34] target/riscv: Fix size of [m|s|vs]iselect fields
Date: Tue, 14 Oct 2025 22:35:00 +0200
Message-ID: <20251014203512.26282-24-anjo@rev.ng>
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

[m|s|vs]iselect are defined in version 20250508 of the privileged
specification to be XLEN in size, however QEMU only ever uses at most
16 bits of these fields, so fix them to 16.  Update relevant function
arguments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/cpu.h     |  6 +++---
 target/riscv/csr.c     | 32 ++++++++++++++++----------------
 target/riscv/machine.c |  6 +++---
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f637ab476e..620411b894 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -342,8 +342,8 @@ struct CPUArchState {
     uint8_t siprio[64];
 
     /* AIA CSRs */
-    target_ulong miselect;
-    target_ulong siselect;
+    uint16_t miselect;
+    uint16_t siselect;
     uint64_t mvien;
     uint64_t mvip;
 
@@ -389,7 +389,7 @@ struct CPUArchState {
     uint64_t vsatp;
 
     /* AIA VS-mode CSRs */
-    target_ulong vsiselect;
+    uint16_t vsiselect;
 
     uint64_t mtval2;
     uint64_t mtinst;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5ba1fe4168..ebdb955869 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2405,7 +2405,7 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong *val, target_ulong new_val,
                                    target_ulong wr_mask)
 {
-    target_ulong *iselect;
+    uint16_t *iselect;
     int ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
@@ -2448,18 +2448,18 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static bool xiselect_aia_range(target_ulong isel)
+static bool xiselect_aia_range(uint16_t isel)
 {
     return (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) ||
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
-static bool xiselect_cd_range(target_ulong isel)
+static bool xiselect_cd_range(uint16_t isel)
 {
     return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
 }
 
-static bool xiselect_ctr_range(int csrno, target_ulong isel)
+static bool xiselect_ctr_range(int csrno, uint16_t isel)
 {
     /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
     return CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST &&
@@ -2467,7 +2467,7 @@ static bool xiselect_ctr_range(int csrno, target_ulong isel)
 }
 
 static int rmw_iprio(target_ulong xlen,
-                     target_ulong iselect, uint8_t *iprio,
+                     uint16_t iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
                      target_ulong wr_mask, int ext_irq_no)
 {
@@ -2511,7 +2511,7 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, target_ulong *val,
                           target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2550,7 +2550,7 @@ static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, target_ulong *val,
                           target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2589,7 +2589,7 @@ static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2630,7 +2630,7 @@ static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
 }
 
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
-                         target_ulong isel, target_ulong *val,
+                         uint16_t isel, target_ulong *val,
                          target_ulong new_val, target_ulong wr_mask)
 {
     bool virt = false, isel_reserved = false;
@@ -2710,12 +2710,12 @@ done:
 }
 
 static int rmw_xireg_cd(CPURISCVState *env, int csrno,
-                        target_ulong isel, target_ulong *val,
+                        uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    int ctr_index = isel - ISELECT_CD_FIRST;
-    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+    uint16_t ctr_index = isel - ISELECT_CD_FIRST;
+    uint16_t isel_hpm_start = ISELECT_CD_FIRST + 3;
 
     if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
         ret = RISCV_EXCP_ILLEGAL_INST;
@@ -2782,7 +2782,7 @@ done:
 }
 
 static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
-                        target_ulong isel, target_ulong *val,
+                        uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
@@ -2810,7 +2810,7 @@ static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
  * extension using csrind should be implemented here.
  */
 static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
-                              target_ulong isel, target_ulong *val,
+                              uint16_t isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
     bool virt = csrno == CSR_VSIREG ? true : false;
@@ -2840,7 +2840,7 @@ static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
                       target_ulong new_val, target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    target_ulong isel;
+    uint16_t isel;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
     if (ret != RISCV_EXCP_NONE) {
@@ -2871,7 +2871,7 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    target_ulong isel;
+    uint16_t isel;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
     if (ret != RISCV_EXCP_NONE) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 8a8f5be8d6..376075b2bd 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -108,7 +108,7 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.vscause, RISCVCPU),
         VMSTATE_UINT64(env.vstval, RISCVCPU),
         VMSTATE_UINT64(env.vsatp, RISCVCPU),
-        VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
+        VMSTATE_UINT16(env.vsiselect, RISCVCPU),
         VMSTATE_UINT64(env.vsie, RISCVCPU),
 
         VMSTATE_UINT64(env.mtval2, RISCVCPU),
@@ -467,8 +467,8 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.mepc, RISCVCPU),
         VMSTATE_UINT64(env.mcause, RISCVCPU),
         VMSTATE_UINT64(env.mtval, RISCVCPU),
-        VMSTATE_UINTTL(env.miselect, RISCVCPU),
-        VMSTATE_UINTTL(env.siselect, RISCVCPU),
+        VMSTATE_UINT16(env.miselect, RISCVCPU),
+        VMSTATE_UINT16(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
         VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
-- 
2.51.0



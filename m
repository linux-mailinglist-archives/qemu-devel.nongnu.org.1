Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E438CB987CE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 09:21:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JnN-0005b2-Ob; Wed, 24 Sep 2025 03:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnK-0005Zo-A2
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:06 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnB-0003Q5-Aw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=jS+5jUWqLf8DzdZREyGhxtYoH1mze7wS+V8aFfit5jY=; b=nYiH3bSWuOzhYQs
 a/p0bGupwL6BxQAOZyQCJEhxWp8nkMHQ/H7qZJswOjcTE7DZ9Oj6P45gR2ZXqdWrgVBj9hJyanY/Q
 bglAMc0mD72PqWgk1wxrbEMiaY5SrOCrWWtgXSeapwtJCq7DNtHLUeEM1HRvyu8M1rXDNUkxvV6ZE
 3E=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 13/34] target/riscv: Fix size of frm and fflags
Date: Wed, 24 Sep 2025 09:21:03 +0200
Message-ID: <20250924072124.6493-14-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

According to version 20250508 of the unprivileged specification the frm
field of fcsr is 3-bits in size, fix it to 8-bits.  Similarly fflags is
5 bits, fix to 8.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h        | 6 +++---
 target/riscv/csr.c        | 4 ++++
 target/riscv/fpu_helper.c | 6 +++---
 target/riscv/machine.c    | 2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 01ca3e781d..cf10662b3a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -230,7 +230,7 @@ struct CPUArchState {
 
     /* Floating-Point state */
     uint64_t fpr[32]; /* assume both F and D extensions */
-    target_ulong frm;
+    uint8_t frm;
     float_status fp_status;
 
     target_ulong badaddr;
@@ -663,8 +663,8 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
                                       uintptr_t pc);
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
+uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
+void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
 
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f29a3c9991..a471e59f2d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -895,6 +895,10 @@ static RISCVException write_frm(CPURISCVState *env, int csrno,
 static RISCVException read_fcsr(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
+    /*
+     * This is an 8-bit operation, fflags make up the lower 5 bits and
+     * frm the upper 3 bits of fcsr.
+     */
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index af40561b31..db64fca622 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -23,10 +23,10 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
+uint8_t riscv_cpu_get_fflags(CPURISCVState *env)
 {
     int soft = get_float_exception_flags(&env->fp_status);
-    target_ulong hard = 0;
+    uint8_t hard = 0;
 
     hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
     hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
@@ -37,7 +37,7 @@ target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
     return hard;
 }
 
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
+void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t hard)
 {
     int soft = 0;
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 405a960f28..d38243b278 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -411,7 +411,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.pc, RISCVCPU),
         VMSTATE_UINT64(env.load_res, RISCVCPU),
         VMSTATE_UINT64(env.load_val, RISCVCPU),
-        VMSTATE_UINTTL(env.frm, RISCVCPU),
+        VMSTATE_UINT8(env.frm, RISCVCPU),
         VMSTATE_UINTTL(env.badaddr, RISCVCPU),
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
-- 
2.51.0



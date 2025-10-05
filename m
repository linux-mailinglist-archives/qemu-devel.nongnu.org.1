Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22EBB99B5
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 18:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5RvW-0000UZ-3j; Sun, 05 Oct 2025 12:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5RvP-0000SY-Fr; Sun, 05 Oct 2025 12:49:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5RvN-00077K-Sa; Sun, 05 Oct 2025 12:49:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 618FC15AA3B;
 Sun, 05 Oct 2025 19:49:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F35432996F4;
 Sun,  5 Oct 2025 19:49:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 75/81] target/riscv: rvv: Replace checking V by
 checking Zve32x
Date: Sun,  5 Oct 2025 19:47:55 +0300
Message-ID: <20251005164822.442861-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

The Zve32x extension will be applied by the V and Zve* extensions.
Therefore we can replace the original V checking with Zve32x checking for both
the V and Zve* extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250923090729.1887406-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ae4a37f57818e47e212272821a5a86ad54620eb8)
(Mjt: drop the MonitorDef change due to missing v10.1.0-850-ge06d209aa6 "target/riscv: implement MonitorDef HMP API")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..a877018ab0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -604,7 +604,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             }
         }
     }
-    if (riscv_has_ext(env, RVV) && (flags & CPU_DUMP_VPU)) {
+    if (riscv_cpu_cfg(env)->ext_zve32x && (flags & CPU_DUMP_VPU)) {
         static const int dump_rvv_csrs[] = {
                     CSR_VSTART,
                     CSR_VXSAT,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8842e07a73..5824928d95 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2004,7 +2004,8 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     if (riscv_has_ext(env, RVF)) {
         mask |= MSTATUS_FS;
     }
-    if (riscv_has_ext(env, RVV)) {
+
+    if (riscv_cpu_cfg(env)->ext_zve32x) {
         mask |= MSTATUS_VS;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1600ec44f0..4d3b213617 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -131,7 +131,8 @@ static bool vector_needed(void *opaque)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    return riscv_has_ext(env, RVV);
+    return kvm_enabled() ? riscv_has_ext(env, RVV) :
+                           riscv_cpu_cfg(env)->ext_zve32x;
 }
 
 static const VMStateDescription vmstate_vector = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb279184..a6f60f55ce 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -660,7 +660,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (riscv_has_ext(env, RVV)) {
+    if (cpu->cfg.ext_zve32x) {
         riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.47.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD51A82889F
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 16:01:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDZw-0004Ul-56; Tue, 09 Jan 2024 09:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rNDZt-0004Ta-B5; Tue, 09 Jan 2024 09:59:41 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rNDZq-0007m1-RX; Tue, 09 Jan 2024 09:59:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 36F9BC000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1704812376;
 bh=/3BoQ65SwFzb/8NChuj73jsr2YIu/wN+xGTLSwDWZl8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fPucQQUPXXmp67sE2RlU5SvwghiEECdnWrT7dMWbkGJmycS6FMt234KqcZ+ZDqKN6
 qZYZP+PaaZHVssDFU8gefrvRogj8+0rMtHkbF6FOZgX6RXykiwo7jGf39DjZ9q0R4y
 q7CnepXu544q/qf3cIt2kyohPGqWCYeJurtpidrjQXzfzylwM1GWvDx5ES8Udt2bcU
 kPCktUe5fw99GUrsJdosthZQEboHrqzPCJtnZVhMJAPBcG8D5UHwvTVyPXL0NA6ubT
 N/+OHhLa+MDdTfvQdtD8g7Y6N1udt0NaSW1iax+LETImvprBdDdfXJrXXD/biJ64Ed
 TDLcVv42t5bBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1704812376;
 bh=/3BoQ65SwFzb/8NChuj73jsr2YIu/wN+xGTLSwDWZl8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QE6rCE9LioJRggk9mLbZEhH/e3KKmqPsQkoQnzOb8Jq0av9Z1NHG7QaqAZ2OePSWn
 h3j1VqYs0rl+wfcyRnZj5HgNG8niatnXfHF2obk/EuF5xvQIKSwfJUIOvdcj3Kub/3
 RqEDUwnnJC2m6FCovs1Si7Qr0P1+2lgZaFWTzWdAOzPcAuwem4Zul3Wh1coUK8ECJs
 BqQD40NowQVoKyjQOybZasXaDNBdPP5+pI2NPKDxdVxRfN/4HrugGuMRZt8ghJf+EB
 8lpnqaOV8BbughibIASko+Id1G9la4YiGPKTd8nai0G+dGq8QsuxFDBZ+S0tU8cE+E
 KA9/yR8J1ppSA==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH v3 2/2] target/riscv: UPDATE xATP write CSR
Date: Tue, 9 Jan 2024 17:59:22 +0300
Message-ID: <20240109145923.37893-2-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
References: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Added xATP_MODE validation for vsatp/hgatp CSRs.
The xATP register is an SXLEN-bit read/write WARL register, so
the legal value must be returned (See riscv-privileged-20211203, SATP/VSATP/HGATP CSRs).

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 735fb27be7..6d7a3dd9aa 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1282,6 +1282,32 @@ static bool validate_vm(CPURISCVState *env, target_ulong vm)
     return get_field(mode_supported, (1 << vm));
 }
 
+static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
+                                  target_ulong val)
+{
+    target_ulong mask;
+    bool vm;
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        vm = validate_vm(env, get_field(val, SATP32_MODE));
+        mask = (val ^ old_xatp) & (SATP32_MODE | SATP32_ASID | SATP32_PPN);
+    } else {
+        vm = validate_vm(env, get_field(val, SATP64_MODE));
+        mask = (val ^ old_xatp) & (SATP64_MODE | SATP64_ASID | SATP64_PPN);
+    }
+
+    if (vm && mask) {
+        /*
+         * The ISA defines SATP.MODE=Bare as "no translation", but we still
+         * pass these through QEMU's TLB emulation as it improves
+         * performance.  Flushing the TLB on SATP writes with paging
+         * enabled avoids leaking those invalid cached mappings.
+         */
+        tlb_flush(env_cpu(env));
+        return val;
+    }
+    return old_xatp;
+}
+
 static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
                                  target_ulong val)
 {
@@ -2997,31 +3023,11 @@ static RISCVException read_satp(CPURISCVState *env, int csrno,
 static RISCVException write_satp(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
-    target_ulong mask;
-    bool vm;
-
     if (!riscv_cpu_cfg(env)->mmu) {
         return RISCV_EXCP_NONE;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        vm = validate_vm(env, get_field(val, SATP32_MODE));
-        mask = (val ^ env->satp) & (SATP32_MODE | SATP32_ASID | SATP32_PPN);
-    } else {
-        vm = validate_vm(env, get_field(val, SATP64_MODE));
-        mask = (val ^ env->satp) & (SATP64_MODE | SATP64_ASID | SATP64_PPN);
-    }
-
-    if (vm && mask) {
-        /*
-         * The ISA defines SATP.MODE=Bare as "no translation", but we still
-         * pass these through QEMU's TLB emulation as it improves
-         * performance.  Flushing the TLB on SATP writes with paging
-         * enabled avoids leaking those invalid cached mappings.
-         */
-        tlb_flush(env_cpu(env));
-        env->satp = val;
-    }
+    env->satp = legalize_xatp(env, env->satp, val);
     return RISCV_EXCP_NONE;
 }
 
@@ -3506,7 +3512,7 @@ static RISCVException read_hgatp(CPURISCVState *env, int csrno,
 static RISCVException write_hgatp(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    env->hgatp = val;
+    env->hgatp = legalize_xatp(env, env->hgatp, val);
     return RISCV_EXCP_NONE;
 }
 
@@ -3772,7 +3778,7 @@ static RISCVException read_vsatp(CPURISCVState *env, int csrno,
 static RISCVException write_vsatp(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    env->vsatp = val;
+    env->vsatp = legalize_xatp(env, env->vsatp, val);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.25.1



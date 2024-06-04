Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D18FAE80
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 11:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQGG-0006bo-50; Tue, 04 Jun 2024 05:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yumin686@andestech.com>)
 id 1sEQFw-0006ag-Q4; Tue, 04 Jun 2024 05:15:01 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yumin686@andestech.com>)
 id 1sEQFt-0003QL-ED; Tue, 04 Jun 2024 05:15:00 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 45494wWf090663;
 Tue, 4 Jun 2024 17:04:58 +0800 (+08)
 (envelope-from yumin686@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 45494epg090481;
 Tue, 4 Jun 2024 17:04:40 +0800 (+08)
 (envelope-from yumin686@andestech.com)
Received: from lubuntu-vb.andestech.com (10.0.12.32) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Tue, 4 Jun 2024 17:04:40 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <yumin686@andestech.com>, Alvin Chang
 <alvinga@andestech.com>
Subject: [PATCH v4] target/riscv: raise an exception when CSRRS/CSRRC writes a
 read-only CSR
Date: Tue, 4 Jun 2024 17:04:34 +0800
Message-ID: <20240604090434.37136-1-yumin686@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.32]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 45494wWf090663
Received-SPF: pass client-ip=60.248.80.70; envelope-from=yumin686@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Yu-Ming Chang <yumin686@andestech.com>
From:  Yu-Ming Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Both CSRRS and CSRRC always read the addressed CSR and cause any read side
effects regardless of rs1 and rd fields. Note that if rs1 specifies a register
holding a zero value other than x0, the instruction will still attempt to write
the unmodified value back to the CSR and will cause any attendant side effects.

So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specifies
a register holding a zero value, an illegal instruction exception should be
raised.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
Hi Alistair,
    This fixed the issue of riscv_csrrw_debug().

Best regards,
Yuming

 target/riscv/cpu.h       |  4 +++
 target/riscv/csr.c       | 57 ++++++++++++++++++++++++++++++++++++----
 target/riscv/op_helper.c |  6 ++---
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d0c02c35b..72921bafc0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -708,6 +708,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                          target_ulong *ret_value);
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
@@ -740,6 +742,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
                                           target_ulong new_value,
                                           target_ulong write_mask);
 
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value);
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..aa765678b9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4312,7 +4312,7 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
 
 static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
                                                int csrno,
-                                               bool write_mask)
+                                               bool write)
 {
     /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
     bool read_only = get_field(csrno, 0xC00) == 3;
@@ -4334,7 +4334,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     }
 
     /* read / write check */
-    if (write_mask && read_only) {
+    if (write && read_only) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -4421,11 +4421,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                           target_ulong *ret_value)
+{
+    RISCVException ret = riscv_csrrw_check(env, csrno, false);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
+}
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask)
 {
-    RISCVException ret = riscv_csrrw_check(env, csrno, write_mask);
+    RISCVException ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
@@ -4473,13 +4484,45 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value)
+{
+    RISCVException ret;
+
+    ret = riscv_csrrw_check(env, csrno, false);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    if (csr_ops[csrno].read128) {
+        return riscv_csrrw_do128(env, csrno, ret_value,
+                                 int128_zero(), int128_zero());
+    }
+
+    /*
+     * Fall back to 64-bit version for now, if the 128-bit alternative isn't
+     * at all defined.
+     * Note, some CSRs don't need to extend to MXLEN (64 upper bits non
+     * significant), for those, this fallback is correctly handling the
+     * accesses
+     */
+    target_ulong old_value;
+    ret = riscv_csrrw_do64(env, csrno, &old_value,
+                           (target_ulong)0,
+                           (target_ulong)0);
+    if (ret == RISCV_EXCP_NONE && ret_value) {
+        *ret_value = int128_make64(old_value);
+    }
+    return ret;
+}
+
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask)
 {
     RISCVException ret;
 
-    ret = riscv_csrrw_check(env, csrno, int128_nz(write_mask));
+    ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
@@ -4518,7 +4561,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = true;
 #endif
-    ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+    if (!write_mask) {
+        ret = riscv_csrr(env, csrno, ret_value);
+    } else {
+        ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+    }
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = false;
 #endif
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f414aaebdb..b95d47e9ac 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
     }
 
     target_ulong val = 0;
-    RISCVException ret = riscv_csrrw(env, csr, &val, 0, 0);
+    RISCVException ret = riscv_csrr(env, csr, &val);
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
@@ -84,9 +84,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
 target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
 {
     Int128 rv = int128_zero();
-    RISCVException ret = riscv_csrrw_i128(env, csr, &rv,
-                                          int128_zero(),
-                                          int128_zero());
+    RISCVException ret = riscv_csrr_i128(env, csr, &rv);
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FF70625C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6u-0002uF-62; Wed, 17 May 2023 04:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6f-0002eZ-59; Wed, 17 May 2023 04:01:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6b-0000ks-U9; Wed, 17 May 2023 04:01:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B8B96763;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 091F35E1B;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: (nullmailer pid 3624157 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng@tinylab.org>,
 Fei Wu <fei2.wu@intel.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v8.0.1 26/36] target/riscv: Restore the predicate() NULL check
 behavior
Date: Wed, 17 May 2023 11:00:46 +0300
Message-Id: <20230517080056.3623993-26-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bin Meng <bmeng@tinylab.org>

When reading a non-existent CSR QEMU should raise illegal instruction
exception, but currently it just exits due to the g_assert() check.

This actually reverts commit 0ee342256af9205e7388efdf193a6d8f1ba1a617.
Some comments are also added to indicate that predicate() must be
provided for an implemented CSR.

Reported-by: Fei Wu <fei2.wu@intel.com>
Signed-off-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230417043054.3125614-1-bmeng@tinylab.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit eae04c4c131a8d95087c8568eb2cac1988262f25)
(mjt: context edit after ce3af0bbbcdfa "target/riscv: add support for Zcmt extension")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/riscv/csr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d522efc0b6..736ab64275 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3797,6 +3797,11 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    /* ensure CSR is implemented by checking predicate */
+    if (!csr_ops[csrno].predicate) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     /* privileged spec version check */
     if (env->priv_ver < csr_min_priv) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -3814,7 +3819,6 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
      * illegal instruction exception should be triggered instead of virtual
      * instruction exception. Hence this comes after the read / write check.
      */
-    g_assert(csr_ops[csrno].predicate != NULL);
     RISCVException ret = csr_ops[csrno].predicate(env, csrno);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
@@ -3991,7 +3995,10 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
     return ret;
 }
 
-/* Control and Status Register function table */
+/*
+ * Control and Status Register function table
+ * riscv_csr_operations::predicate() must be provided for an implemented CSR
+ */
 riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* User Floating-Point CSRs */
     [CSR_FFLAGS]   = { "fflags",   fs,     read_fflags,  write_fflags },
-- 
2.39.2



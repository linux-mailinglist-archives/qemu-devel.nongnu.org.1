Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB129C2CC8
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:15:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kKu-00023R-Qv; Sat, 09 Nov 2024 07:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKa-0001kF-Vd; Sat, 09 Nov 2024 07:12:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKZ-0004c8-BI; Sat, 09 Nov 2024 07:12:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2DAF3A1610;
 Sat,  9 Nov 2024 15:07:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E7D9B167F9E;
 Sat,  9 Nov 2024 15:08:03 +0300 (MSK)
Received: (nullmailer pid 3295376 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 40/57] target/riscv/csr.c: Fix an access to VXSAT
Date: Sat,  9 Nov 2024 15:07:42 +0300
Message-Id: <20241109120801.3295120-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>

The register VXSAT should be RW only to the first bit.
The remaining bits should be 0.

The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture

The vxsat CSR has a single read-write least-significant bit (vxsat[0])
that indicates if a fixed-point instruction has had to saturate an output
value to fit into a destination format. Bits vxsat[XLEN-1:1]
should be written as zeros.

Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 5a60026cad4e9dba929cab4f63229e4b9110cf0a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 829d8346ed..c31b3121f1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -708,7 +708,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 static RISCVException read_vxsat(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->vxsat;
+    *val = env->vxsat & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
@@ -718,7 +718,7 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxsat = val;
+    env->vxsat = val & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.39.5



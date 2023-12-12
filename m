Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 649C280EB59
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:20:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1ja-0005mS-Sq; Tue, 12 Dec 2023 07:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jX-0005fc-UD; Tue, 12 Dec 2023 07:19:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jW-0000Og-Au; Tue, 12 Dec 2023 07:19:31 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE34F3AF01;
 Tue, 12 Dec 2023 15:18:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 729E73B94F;
 Tue, 12 Dec 2023 15:18:32 +0300 (MSK)
Received: (nullmailer pid 1003438 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ivan Klokov <ivan.klokov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 13/31] target/riscv/cpu_helper.c: Fix mxr bit behavior
Date: Tue, 12 Dec 2023 15:18:01 +0300
Message-Id: <20231212121831.1003318-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

According to RISCV Specification sect 9.5 on two stage translation when
V=1 the vsstatus(mstatus in QEMU's terms) field MXR, which makes
execute-only pages readable, only overrides VS-stage page protection.
Setting MXR at HS-level(mstatus_hs), however, overrides both VS-stage
and G-stage execute-only permissions.

The hypervisor extension changes the behavior of MXR\MPV\MPRV bits.
Due to RISCV Specification sect. 9.4.1 when MPRV=1, explicit memory
accesses are translated and protected, and endianness is applied, as
though the current virtualization mode were set to MPV and the current
nominal privilege mode were set to MPP. vsstatus.MXR makes readable
those pages marked executable at the VS translation stage.

Fixes: 36a18664ba ("target/riscv: Implement second stage MMU")

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231121071757.7178-3-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 6bca4d7d1ff2b8857486c3ff31f5c6fc3e3984b4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3c482f9fd4..ce10d722f1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -989,13 +989,29 @@ restart:
         prot |= PAGE_WRITE;
     }
     if (pte & PTE_X) {
-        bool mxr;
+        bool mxr = false;
 
-        if (first_stage == true) {
+        /*
+         * Use mstatus for first stage or for the second stage without
+         * virt_enabled (MPRV+MPV)
+         */
+        if (first_stage || !env->virt_enabled) {
             mxr = get_field(env->mstatus, MSTATUS_MXR);
-        } else {
-            mxr = get_field(env->vsstatus, MSTATUS_MXR);
         }
+
+        /* MPRV+MPV case, check VSSTATUS */
+        if (first_stage && two_stage && !env->virt_enabled) {
+            mxr |= get_field(env->vsstatus, MSTATUS_MXR);
+        }
+
+        /*
+         * Setting MXR at HS-level overrides both VS-stage and G-stage
+         * execute-only permissions
+         */
+        if (env->virt_enabled) {
+            mxr |= get_field(env->mstatus_hs, MSTATUS_MXR);
+        }
+
         if (mxr) {
             prot |= PAGE_READ;
         }
-- 
2.39.2



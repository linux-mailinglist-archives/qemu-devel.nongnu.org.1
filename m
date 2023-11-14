Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81347EB53A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:01:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wl9-0006xO-DJ; Tue, 14 Nov 2023 11:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkt-0006kX-Im; Tue, 14 Nov 2023 11:59:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkr-0004x4-HB; Tue, 14 Nov 2023 11:59:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0040E3326E;
 Tue, 14 Nov 2023 19:59:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C26A6351F5;
 Tue, 14 Nov 2023 19:58:42 +0300 (MSK)
Received: (nullmailer pid 2949096 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH trivial 08/21] target/arm/tcg: spelling fixes: alse, addreses
Date: Tue, 14 Nov 2023 19:58:21 +0300
Message-Id: <20231114165834.2949011-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
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

Fixes: 179e9a3baccc "target/arm: Define new TB flag for ATA0"
Fixes: 5d7b37b5f675 "target/arm: Implement the CPY* instructions"
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/arm/tcg/helper-a64.c | 2 +-
 target/arm/tcg/hflags.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ce4800b8d1..8ad84623d3 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1414,7 +1414,7 @@ void HELPER(setge)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
 /*
  * Perform part of a memory copy from the guest memory at fromaddr
  * and extending for copysize bytes, to the guest memory at
- * toaddr. Both addreses are dirty.
+ * toaddr. Both addresses are dirty.
  *
  * Returns the number of bytes actually set, which might be less than
  * copysize; the caller should loop until the whole copy has been done.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 3d7fdce5c3..a6ebd7571a 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -327,7 +327,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
         }
         /*
-         * For unpriv tag-setting accesses we alse need ATA0. Again, in
+         * For unpriv tag-setting accesses we also need ATA0. Again, in
          * contexts where unpriv and normal insns are the same we
          * duplicate the ATA bit to save effort for translate-a64.c.
          */
-- 
2.39.2



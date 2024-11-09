Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CC9C2C98
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kHZ-0001Mg-LU; Sat, 09 Nov 2024 07:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kHF-000172-Vt; Sat, 09 Nov 2024 07:09:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kHE-0003vw-9W; Sat, 09 Nov 2024 07:09:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91161A15F8;
 Sat,  9 Nov 2024 15:07:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 58791167F86;
 Sat,  9 Nov 2024 15:08:02 +0300 (MSK)
Received: (nullmailer pid 3295298 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexandra Diupina <adiupina@astralinux.ru>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 16/57] hw/intc/arm_gicv3_cpuif: Add cast to match the
 documentation
Date: Sat,  9 Nov 2024 15:07:18 +0300
Message-Id: <20241109120801.3295120-16-mjt@tls.msk.ru>
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

From: Alexandra Diupina <adiupina@astralinux.ru>

The result of 1 << regbit with regbit==31 has a 1 in the 32nd bit.
When cast to uint64_t (for further bitwise OR), the 32 most
significant bits will be filled with 1s. However, the documentation
states that the upper 32 bits of ICH_AP[0/1]R<n>_EL2 are reserved.

Add an explicit cast to match the documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: c3f21b065a ("hw/intc/arm_gicv3_cpuif: Support vLPIs")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3db74afec3ca87f81fbdf5918ed1e21d837fbfab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 67d8fd07b7..ed0a080173 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -753,7 +753,7 @@ static void icv_activate_vlpi(GICv3CPUState *cs)
     int regno = aprbit / 32;
     int regbit = aprbit % 32;
 
-    cs->ich_apr[cs->hppvlpi.grp][regno] |= (1 << regbit);
+    cs->ich_apr[cs->hppvlpi.grp][regno] |= (1U << regbit);
     gicv3_redist_vlpi_pending(cs, cs->hppvlpi.irq, 0);
 }
 
-- 
2.39.5



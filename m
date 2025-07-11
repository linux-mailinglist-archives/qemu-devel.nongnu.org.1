Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9027B0164C
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 10:35:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua97r-0006nC-Gg; Fri, 11 Jul 2025 04:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8z4-0007bI-Uk; Fri, 11 Jul 2025 04:19:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8z2-0004Lq-Sq; Fri, 11 Jul 2025 04:19:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C31CA1356E3;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA82523FA58;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ethan Chen <ethan84@andestech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 24/39] qemu-options.hx: Fix reversed description of
 icount sleep behavior
Date: Fri, 11 Jul 2025 11:16:20 +0300
Message-ID: <20250711081745.1785806-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
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

From: Ethan Chen <ethan84@andestech.com>

The documentation for the -icount option incorrectly describes the behavior
of the sleep suboption. Based on the actual implementation and system
behavior, the effects of sleep=on and sleep=off were inadvertently reversed.
This commit updates the description to reflect their intended functionality.

Cc: qemu-stable@nongnu.org
Fixes: fa647905e6ba ("qemu-options.hx: Fix minor issues in icount documentation")
Signed-off-by: Ethan Chen <ethan84@andestech.com>
Message-id: 20250606095728.3672832-1-ethan84@andestech.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e372214e663a4370fe064f7867f402eade37357e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..396eea7ef2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4936,13 +4936,13 @@ SRST
     with actual performance.
 
     When the virtual cpu is sleeping, the virtual time will advance at
-    default speed unless ``sleep=on`` is specified. With
-    ``sleep=on``, the virtual time will jump to the next timer
+    default speed unless ``sleep=off`` is specified. With
+    ``sleep=off``, the virtual time will jump to the next timer
     deadline instantly whenever the virtual cpu goes to sleep mode and
     will not advance if no timer is enabled. This behavior gives
     deterministic execution times from the guest point of view.
-    The default if icount is enabled is ``sleep=off``.
-    ``sleep=on`` cannot be used together with either ``shift=auto``
+    The default if icount is enabled is ``sleep=on``.
+    ``sleep=off`` cannot be used together with either ``shift=auto``
     or ``align=on``.
 
     ``align=on`` will activate the delay algorithm which will try to
-- 
2.47.2



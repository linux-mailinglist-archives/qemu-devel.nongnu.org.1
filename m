Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CA7539FC
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:46:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9r-0001Uz-Tu; Fri, 14 Jul 2023 07:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9i-00012T-OX; Fri, 14 Jul 2023 07:40:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9g-0004ap-SV; Fri, 14 Jul 2023 07:40:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 260B913DA0;
 Fri, 14 Jul 2023 14:38:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 209F814BAF;
 Fri, 14 Jul 2023 14:38:42 +0300 (MSK)
Received: (nullmailer pid 1186255 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 20/29] tree-wide spelling fixes in comments and some
 messages: hw/display
Date: Fri, 14 Jul 2023 14:38:25 +0300
Message-Id: <20230714113834.1186117-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/bochs-display.c | 2 +-
 hw/display/qxl.c           | 2 +-
 hw/display/ssd0303.c       | 2 +-
 hw/display/ssd0323.c       | 2 +-
 hw/display/xlnx_dp.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index e7ec268184..9138e98c3b 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -166,3 +166,3 @@ static int bochs_display_get_mode(BochsDisplayState *s,
     case 16:
-        /* best effort: support native endianess only */
+        /* best effort: support native endianness only */
         mode->format = PIXMAN_r5g6b5;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f1c0eb7dfc..af941fb0c2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1546,3 +1546,3 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
 
-/* return 1 if surface destoy was initiated (in QXL_ASYNC case) or
+/* return 1 if surface destroy was initiated (in QXL_ASYNC case) or
  * done (in QXL_SYNC case), 0 otherwise. */
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index d67b0ad7b5..32b32a3044 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -10,3 +10,3 @@
 /* The controller can support a variety of different displays, but we only
-   implement one.  Most of the commends relating to brightness and geometry
+   implement one.  Most of the commands relating to brightness and geometry
    setup are ignored. */
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index ab229d32b7..09b1bbed0a 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -10,3 +10,3 @@
 /* The controller can support a variety of different displays, but we only
-   implement one.  Most of the commends relating to brightness and geometry
+   implement one.  Most of the commands relating to brightness and geometry
    setup are ignored. */
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index b0828d65aa..822355ecc6 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -382,3 +382,3 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
     /*
-     * Get some data from the DPDMA and compute these datas.
+     * Get some data from the DPDMA and compute these data.
      * Then wait for QEMU's audio subsystem to call this callback.
-- 
2.39.2



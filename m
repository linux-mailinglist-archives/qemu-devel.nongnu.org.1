Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE2B0305F
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Jul 2025 11:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uask2-0003RT-Io; Sun, 13 Jul 2025 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uasjt-0003Nc-DP; Sun, 13 Jul 2025 05:11:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uasjh-00070v-Eo; Sun, 13 Jul 2025 05:11:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9C4F1362E2;
 Sun, 13 Jul 2025 12:10:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 70C16245F4D;
 Sun, 13 Jul 2025 12:10:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Lambertz <patch@thomaslambertz.de>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/6] hw/usb/dev-hid: Support side and extra mouse buttons for
 usb-tablet
Date: Sun, 13 Jul 2025 12:10:43 +0300
Message-ID: <20250713091059.35165-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250713091059.35165-1-mjt@tls.msk.ru>
References: <20250713091059.35165-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Thomas Lambertz <patch@thomaslambertz.de>

The necessary plumbing for side- and extra mouse buttons to reach
usb-tablet is already done. But the descriptor advertises three buttons
max. Increase this to 5. Buttons are now identical to usb-mouse.

Signed-off-by: Thomas Lambertz <patch@thomaslambertz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/dev-hid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 54d064e54e..96623aa322 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -491,14 +491,14 @@ static const uint8_t qemu_tablet_hid_report_descriptor[] = {
     0xa1, 0x00,		/*   Collection (Physical) */
     0x05, 0x09,		/*     Usage Page (Button) */
     0x19, 0x01,		/*     Usage Minimum (1) */
-    0x29, 0x03,		/*     Usage Maximum (3) */
+    0x29, 0x05,		/*     Usage Maximum (5) */
     0x15, 0x00,		/*     Logical Minimum (0) */
     0x25, 0x01,		/*     Logical Maximum (1) */
-    0x95, 0x03,		/*     Report Count (3) */
+    0x95, 0x05,		/*     Report Count (5) */
     0x75, 0x01,		/*     Report Size (1) */
     0x81, 0x02,		/*     Input (Data, Variable, Absolute) */
     0x95, 0x01,		/*     Report Count (1) */
-    0x75, 0x05,		/*     Report Size (5) */
+    0x75, 0x03,		/*     Report Size (3) */
     0x81, 0x01,		/*     Input (Constant) */
     0x05, 0x01,		/*     Usage Page (Generic Desktop) */
     0x09, 0x30,		/*     Usage (X) */
-- 
2.47.2



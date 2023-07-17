Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C77559CB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 05:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLETW-00053g-FI; Sun, 16 Jul 2023 23:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLETN-00051u-Qw
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 23:00:29 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLETK-0007MR-Oz
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 23:00:29 -0400
From: Shiyuan Gao <gaoshiyuan@baidu.com>
To: <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>,
 Shiyuan Gao <gaoshiyuan@baidu.com>
Subject: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Date: Mon, 17 Jul 2023 10:59:36 +0800
Message-ID: <20230717025936.71456-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex29.internal.baidu.com (172.31.51.23) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 10.127.64.12
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

When only use PS/2 mouse without usb-tablet, the mouse pointer of the
guest on the VNC will work badly that the cursor of VNC is inconsistent
with the mouse pointer of guest.

The reason is the PS/2 mouse use relative coordinates and we can't know
the initial position of the guest mouse pointer.

So move the guest mouse pointer to (0, 0) of the screen when connect the
VNC, and then move the mouse pointer to the cursor of VNC(absolute
coordinates are also relative coordinates).

On windows VM, also need disable "Enhance Pointer Precision" Option in
"Pointer Options" (Control Panel -> Mouse).

Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
---
 hw/input/ps2.c | 2 +-
 ui/vnc.c       | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 45af76a837..e1f44bd298 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -77,7 +77,7 @@
 #define MOUSE_STATUS_ENABLED    0x20
 #define MOUSE_STATUS_SCALE21    0x10
 
-#define PS2_QUEUE_SIZE      16  /* Queue size required by PS/2 protocol */
+#define PS2_QUEUE_SIZE      32  /* Queue size required by PS/2 protocol */
 #define PS2_QUEUE_HEADROOM  8   /* Queue size for keyboard command replies */
 
 /* Bits for 'modifiers' field in PS2KbdState */
diff --git a/ui/vnc.c b/ui/vnc.c
index 92964dcc0c..a1a6048ee4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1816,6 +1816,11 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
         if (vs->last_x != -1) {
             qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x);
             qemu_input_queue_rel(con, INPUT_AXIS_Y, y - vs->last_y);
+        } else {
+            qemu_input_queue_rel(con, INPUT_AXIS_X, 0 - width);
+            qemu_input_queue_rel(con, INPUT_AXIS_Y, 0 - height);
+            x = 0;
+            y = 0;
         }
         vs->last_x = x;
         vs->last_y = y;
-- 
2.27.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335485EB62
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 22:52:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuTt-0004UO-KC; Wed, 21 Feb 2024 16:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuTf-0004EA-0L; Wed, 21 Feb 2024 16:50:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuTc-0007iH-NW; Wed, 21 Feb 2024 16:50:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 112D64F87A;
 Thu, 22 Feb 2024 00:47:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A2BF9869FB;
 Thu, 22 Feb 2024 00:47:25 +0300 (MSK)
Received: (nullmailer pid 2339914 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Markus Frank <m.frank@proxmox.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 30/33] ui/clipboard: mark type as not available when
 there is no data
Date: Thu, 22 Feb 2024 00:47:13 +0300
Message-Id: <20240221214723.2339742-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Fiona Ebner <f.ebner@proxmox.com>

With VNC, a client can send a non-extended VNC_MSG_CLIENT_CUT_TEXT
message with len=0. In qemu_clipboard_set_data(), the clipboard info
will be updated setting data to NULL (because g_memdup(data, size)
returns NULL when size is 0). If the client does not set the
VNC_ENCODING_CLIPBOARD_EXT feature when setting up the encodings, then
the 'request' callback for the clipboard peer is not initialized.
Later, because data is NULL, qemu_clipboard_request() can be reached
via vdagent_chr_write() and vdagent_clipboard_recv_request() and
there, the clipboard owner's 'request' callback will be attempted to
be called, but that is a NULL pointer.

In particular, this can happen when using the KRDC (22.12.3) VNC
client.

Another scenario leading to the same issue is with two clients (say
noVNC and KRDC):

The noVNC client sets the extension VNC_FEATURE_CLIPBOARD_EXT and
initializes its cbpeer.

The KRDC client does not, but triggers a vnc_client_cut_text() (note
it's not the _ext variant)). There, a new clipboard info with it as
the 'owner' is created and via qemu_clipboard_set_data() is called,
which in turn calls qemu_clipboard_update() with that info.

In qemu_clipboard_update(), the notifier for the noVNC client will be
called, i.e. vnc_clipboard_notify() and also set vs->cbinfo for the
noVNC client. The 'owner' in that clipboard info is the clipboard peer
for the KRDC client, which did not initialize the 'request' function.
That sounds correct to me, it is the owner of that clipboard info.

Then when noVNC sends a VNC_MSG_CLIENT_CUT_TEXT message (it did set
the VNC_FEATURE_CLIPBOARD_EXT feature correctly, so a check for it
passes), that clipboard info is passed to qemu_clipboard_request() and
the original segfault still happens.

Fix the issue by handling updates with size 0 differently. In
particular, mark in the clipboard info that the type is not available.

While at it, switch to g_memdup2(), because g_memdup() is deprecated.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2023-6683
Reported-by: Markus Frank <m.frank@proxmox.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Markus Frank <m.frank@proxmox.com>
Message-ID: <20240124105749.204610-1-f.ebner@proxmox.com>
(cherry picked from commit 405484b29f6548c7b86549b0f961b906337aa68a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d14bffaf8..b3f6fa3c9e 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -163,9 +163,15 @@ void qemu_clipboard_set_data(QemuClipboardPeer *peer,
     }
 
     g_free(info->types[type].data);
-    info->types[type].data = g_memdup(data, size);
-    info->types[type].size = size;
-    info->types[type].available = true;
+    if (size) {
+        info->types[type].data = g_memdup2(data, size);
+        info->types[type].size = size;
+        info->types[type].available = true;
+    } else {
+        info->types[type].data = NULL;
+        info->types[type].size = 0;
+        info->types[type].available = false;
+    }
 
     if (update) {
         qemu_clipboard_update(info);
-- 
2.39.2



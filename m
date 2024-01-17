Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A7830413
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:01:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3fa-0001ug-V0; Wed, 17 Jan 2024 06:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ3fZ-0001uK-4j; Wed, 17 Jan 2024 06:01:17 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQ3fX-0008KQ-BG; Wed, 17 Jan 2024 06:01:16 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 065C249194;
 Wed, 17 Jan 2024 12:01:13 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, m.frank@proxmox.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v2] ui/clipboard: ensure data is available or request callback
 is set upon update
Date: Wed, 17 Jan 2024 12:01:09 +0100
Message-Id: <20240117110109.287430-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With VNC, it can be that a client sends a VNC_MSG_CLIENT_CUT_TEXT
message before sending a VNC_MSG_CLIENT_SET_ENCODINGS message with
VNC_ENCODING_CLIPBOARD_EXT for configuring the clipboard extension.

This means that qemu_clipboard_request() can be reached (via
vnc_client_cut_text_ext()) before vnc_server_cut_text_caps() was
called and had the chance to initialize the clipboard peer. In that
case, info->owner->request is NULL instead of a function and so
attempting to call it in qemu_clipboard_request() results in a
segfault.

In particular, this can happen when using the KRDC (22.12.3) VNC
client on Wayland.

Another code path leading to the same issue in
qemu_clipboard_request() is via vdagent_chr_write() and
vdagent_clipboard_recv_request() after a non-extended
VNC_MSG_CLIENT_CUT_TEXT messages with len=0 was sent.

In particular, this can happen when using the KRDC (22.12.3) VNC
client on X11.

It is not enough to check in ui/vnc.c's protocol_client_msg() if the
VNC_FEATURE_CLIPBOARD_EXT feature is enabled before handling an
extended clipboard message with vnc_client_cut_text_ext(), because of
the following scenario with two clients (say noVNC and KRDC):

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

Fix the issue by disallowing clipboard update if both, data is missing
and the clipboard owner's 'request' callback is not set.

Add an assert that the clipboard owner's 'request' callback is set in
qemu_clipboard_request() to have a clean error/abort should a similar
issue appear in the future.

Fixes: CVE-2023-6683
Reported-by: Markus Frank <m.frank@proxmox.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
    * Different approach as suggested by Marc-André:
      Instead of quietly returning in qemu_clipboard_request() when no
      request callback is set, prevent clipboard update if there is
      both, no data and no request callback.

 ui/clipboard.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d14bffaf8..d1bb7c77f2 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -65,12 +65,28 @@ bool qemu_clipboard_check_serial(QemuClipboardInfo *info, bool client)
 
 void qemu_clipboard_update(QemuClipboardInfo *info)
 {
+    uint32_t type;
+    bool missing_data = false;
     QemuClipboardNotify notify = {
         .type = QEMU_CLIPBOARD_UPDATE_INFO,
         .info = info,
     };
     assert(info->selection < QEMU_CLIPBOARD_SELECTION__COUNT);
 
+    for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT && !missing_data; type++) {
+        if (!info->types[type].data) {
+            missing_data = true;
+        }
+    }
+    /*
+     * If data is missing, the clipboard owner's 'request' callback needs to be
+     * set. Otherwise, there is no way to get the clipboard data and
+     * qemu_clipboard_request() cannot be called.
+     */
+    if (missing_data && info->owner && !info->owner->request) {
+        return;
+    }
+
     notifier_list_notify(&clipboard_notifiers, &notify);
 
     if (cbinfo[info->selection] != info) {
@@ -132,6 +148,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
         !info->owner)
         return;
 
+    assert(info->owner->request);
+
     info->types[type].requested = true;
     info->owner->request(info, type);
 }
-- 
2.39.2




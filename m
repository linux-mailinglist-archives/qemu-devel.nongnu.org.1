Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E773382C134
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:56:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI1c-000053-O2; Fri, 12 Jan 2024 08:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rOI1a-0008OV-11; Fri, 12 Jan 2024 08:56:42 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rOI1V-0002XU-8l; Fri, 12 Jan 2024 08:56:41 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3ECAC4911C;
 Fri, 12 Jan 2024 14:56:31 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, m.frank@proxmox.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH] ui/clipboard: avoid crash upon request when clipboard peer is
 not initialized
Date: Fri, 12 Jan 2024 14:55:27 +0100
Message-Id: <20240112135527.57212-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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
the feature correctly, so the check added by your patch passes), that
clipboard info is passed to qemu_clipboard_request() and the original
segfault still happens.

Fixes: CVE-2023-6683
Reported-by: Markus Frank <m.frank@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Markus Frank <m.frank@proxmox.com>
---

This is just a minimal fix. Happy to add some warning/error to not
hide the issue with the missing initialization completely and/or go
for a different approach with a check somewhere in the VNC code.

 ui/clipboard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d14bffaf8..c13b54d2e9 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
     if (info->types[type].data ||
         info->types[type].requested ||
         !info->types[type].available ||
-        !info->owner)
+        !info->owner ||
+        !info->owner->request)
         return;
 
     info->types[type].requested = true;
-- 
2.39.2




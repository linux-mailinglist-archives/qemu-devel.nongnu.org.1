Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF985E0E0
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:21:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoOp-0003Er-Qx; Wed, 21 Feb 2024 10:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoKs-0000wk-Tn; Wed, 21 Feb 2024 10:16:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchvp-00036p-Ki; Wed, 21 Feb 2024 03:26:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BF3144F3F6;
 Wed, 21 Feb 2024 11:21:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B374860D5;
 Wed, 21 Feb 2024 11:21:02 +0300 (MSK)
Received: (nullmailer pid 2142159 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 56/60] ui/clipboard: add asserts for update and request
Date: Wed, 21 Feb 2024 11:20:44 +0300
Message-Id: <20240221082058.2141850-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
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

Should an issue like CVE-2023-6683 ever appear again in the future,
it will be more obvious which assumption was violated.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240124105749.204610-2-f.ebner@proxmox.com>
(cherry picked from commit 9c416582611b7495bdddb4c5456c7acb64b78938)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/clipboard.c b/ui/clipboard.c
index b3f6fa3c9e..4264884a6c 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -65,12 +65,24 @@ bool qemu_clipboard_check_serial(QemuClipboardInfo *info, bool client)
 
 void qemu_clipboard_update(QemuClipboardInfo *info)
 {
+    uint32_t type;
     QemuClipboardNotify notify = {
         .type = QEMU_CLIPBOARD_UPDATE_INFO,
         .info = info,
     };
     assert(info->selection < QEMU_CLIPBOARD_SELECTION__COUNT);
 
+    for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
+        /*
+         * If data is missing, the clipboard owner's 'request' callback needs to
+         * be set. Otherwise, there is no way to get the clipboard data and
+         * qemu_clipboard_request() cannot be called.
+         */
+        if (info->types[type].available && !info->types[type].data) {
+            assert(info->owner && info->owner->request);
+        }
+    }
+
     notifier_list_notify(&clipboard_notifiers, &notify);
 
     if (cbinfo[info->selection] != info) {
@@ -132,6 +144,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
         !info->owner)
         return;
 
+    assert(info->owner->request);
+
     info->types[type].requested = true;
     info->owner->request(info, type);
 }
-- 
2.39.2



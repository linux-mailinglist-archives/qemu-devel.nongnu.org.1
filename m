Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA2680724D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 15:24:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAsoC-0002Oe-Ql; Wed, 06 Dec 2023 09:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1rAsoA-0002Ny-CF
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:23:26 -0500
Received: from mail-4319.protonmail.ch ([185.70.43.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1rAso6-00031O-1n
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1701872598; x=1702131798;
 bh=A8Jk/BOxCJe6M9F5lvuwW/R1HrS3nQzEs9j8zKQcTww=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aDskFkC2CBM/SlgD+VFtuEIgTJFeHt3PG35g0SS/reXYMPF2tgVMYNQ4bzL51ter0
 goJypVM9y7A0N7hW2Dgxru9C++ydZYJPmtuHRfnOatew9PM+uqJPZmX2xSYknraDT7
 0Kbxpfcy2nNxDvSIEORrcjFKrXg7TYELMiaApR7dhPkxsEt13dIfo+3FP/oDhv1gTa
 dOYI5MI+CLlMo6WSUCbWPkzztwJkVbs0g+RLl6am61+paoWjKM+0dtVx2HHXR90I1W
 8g4DZxvPCRCTUF/NfbdwxqqvyehSSzCQ+Gtd3NV7wTZ15ESwenUhms5RHQwkkpjanW
 Q39iirLnkgBCg==
Date: Wed, 06 Dec 2023 14:22:57 +0000
To: qemu-devel@nongnu.org
From: Edmund Raile <edmund.raile@proton.me>
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com,
 Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH v4] ui/gtk-clipboard: async owner_change clipboard_request
Message-ID: <20231206142243.510068-1-edmund.raile@proton.me>
Feedback-ID: 45198251:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.19; envelope-from=edmund.raile@proton.me;
 helo=mail-4319.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Previous implementation of both functions was blocking and caused guest
freezes / crashes on host clipboard owner change.
 * use callbacks instead of waiting for GTK to deliver
   clipboard content type evaluation and contents
 * evaluate a serial in the info struct to discard old events

Fixes: d11ebe2ca257 ("ui/gtk: add clipboard support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1150
Signed-off-by: Edmund Raile <edmund.raile@proton.me>
---
Gitlab user kolAflash is to credit for determining that the main issue
of the QEMU-UI-GTK clipboard is the call to the blocking function
gtk_clipboard_wait_is_text_available in gd_owner_change, causing guests
to freeze / crash when GTK takes too long.
Marc-Andr=C3=A9 Lureau suggested:=20
 * gd_clipboard_request might express the same issue due to using
   gtk_clipboard_wait_for_text
 * the callbacks could use the QemuClipboardInfo struct's serial field
   to discard old events
 * storing the serial for the owner change callback inside the
   GtkDisplay struct

This patch implements asynchronous gd_clipboard_request and
gd_owner_change with serial checking.

What I haven't implemented is gd_clipboard_notify's
QEMU_CLIPBOARD_RESET_SERIAL handling, I don't know how to.

Please help me test this patch.
The issue mentions the conditions, so far it has been stable.
Note that you will need to build QEMU with `enable-gtk-clipboard`.
command line options for qemu-vdagent:
-device virtio-serial,packed=3Don,ioeventfd=3Don \
-device virtserialport,name=3Dcom.redhat.spice.0,chardev=3Dvdagent0 \
-chardev qemu-vdagent,id=3Dvdagent0,name=3Dvdagent,clipboard=3Don,mouse=3Do=
ff \
The guests spice-vdagent user service may have to be started manually.

If testing is sufficient and shows no way to break this, we could undo
or modify 29e0bfffab87d89c65c0890607e203b1579590a3
to have the GTK UI's clipboard built-in by default again.

Previous threads:
 * https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06027.html
 * https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04397.html
 * https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05755.html

 include/ui/gtk.h   |  1 +
 ui/gtk-clipboard.c | 79 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index aa3d637029..ac44609770 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -147,6 +147,7 @@ struct GtkDisplayState {
     uint32_t cbpending[QEMU_CLIPBOARD_SELECTION__COUNT];
     GtkClipboard *gtkcb[QEMU_CLIPBOARD_SELECTION__COUNT];
     bool cbowner[QEMU_CLIPBOARD_SELECTION__COUNT];
+    uint32_t cb_serial_owner_change;
=20
     DisplayOptions *opts;
 };
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 8d8a636fd1..6b2c32abee 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -133,26 +133,81 @@ static void gd_clipboard_notify(Notifier *notifier, v=
oid *data)
     }
 }
=20
+/*
+ * asynchronous clipboard text transfer callback
+ * called when host (gtk) is ready to deliver to guest
+ */
+static void gd_clipboard_request_text_callback
+    (GtkClipboard *clipboard, const gchar *text, gpointer data)
+{
+    QemuClipboardInfo *info =3D data;
+
+    if (!text || !qemu_clipboard_check_serial(info, true)) {
+        qemu_clipboard_info_unref(info);
+        return;
+    }
+
+    qemu_clipboard_set_data(info->owner, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                            strlen(text), text, true);
+    qemu_clipboard_info_unref(info);
+}
+
+/*
+ * asynchronous clipboard data transfer initiator
+ * guest requests, host delivers when ready
+ */
 static void gd_clipboard_request(QemuClipboardInfo *info,
                                  QemuClipboardType type)
 {
     GtkDisplayState *gd =3D container_of(info->owner, GtkDisplayState, cbp=
eer);
-    char *text;
=20
     switch (type) {
     case QEMU_CLIPBOARD_TYPE_TEXT:
-        text =3D gtk_clipboard_wait_for_text(gd->gtkcb[info->selection]);
-        if (text) {
-            qemu_clipboard_set_data(&gd->cbpeer, info, type,
-                                    strlen(text), text, true);
-            g_free(text);
-        }
+        gtk_clipboard_request_text
+            (gd->gtkcb[info->selection],
+             gd_clipboard_request_text_callback, info);
         break;
     default:
         break;
     }
 }
=20
+/*
+ * asynchronous clipboard text availability notification callback
+ * called when host (gtk) is ready to notify guest
+ */
+static void gd_owner_change_text_callback
+    (GtkClipboard *clipboard, const gchar *text, gpointer data)
+{
+    QemuClipboardInfo *info =3D data;
+    GtkDisplayState *gd =3D container_of(info->owner, GtkDisplayState, cbp=
eer);
+
+    /*
+     * performing the subtraction of uints as ints
+     * is a neat trick to guard against rollover issues
+     */
+    if (!text ||
+        (((int32_t)(info->serial - gd->cb_serial_owner_change)) < 0))
+    {
+        goto end;
+    }
+    gd->cb_serial_owner_change =3D info->serial;
+
+    info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
+    qemu_clipboard_update(info);
+
+end:
+    /*
+     * this notification info struct is temporary
+     * and can safely be freed after use
+     */
+    qemu_clipboard_info_unref(info);
+}
+
+/*
+ * asynchronous clipboard data availability notification initiator
+ * host notifies guest when ready
+ */
 static void gd_owner_change(GtkClipboard *clipboard,
                             GdkEvent *event,
                             gpointer data)
@@ -166,16 +221,12 @@ static void gd_owner_change(GtkClipboard *clipboard,
         return;
     }
=20
-
     switch (event->owner_change.reason) {
     case GDK_OWNER_CHANGE_NEW_OWNER:
         info =3D qemu_clipboard_info_new(&gd->cbpeer, s);
-        if (gtk_clipboard_wait_is_text_available(clipboard)) {
-            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
-        }
-
-        qemu_clipboard_update(info);
-        qemu_clipboard_info_unref(info);
+        info->serial =3D ++gd->cb_serial_owner_change;
+        gtk_clipboard_request_text
+            (clipboard, gd_owner_change_text_callback, info);
         break;
     default:
         qemu_clipboard_peer_release(&gd->cbpeer, s);
--=20
2.42.0




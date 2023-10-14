Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 397257C94AB
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 15:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qreHZ-0002qJ-Td; Sat, 14 Oct 2023 09:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1qraKh-0002xe-Jh
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 04:49:16 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1qraKe-0007s9-DE
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 04:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=cklm25jzzjcynolz4hnegnomuq.protonmail; t=1697273340; x=1697532540;
 bh=y+vwsWrldHhN+9Ne43ungHBeCx2pq9r5/WJsEMxkc60=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Jiu6LcW1pBiC7vz4Uwx/Sxb2XoX9Whtwx6kv57+p3towM/CmbH/bmrLCyoyJyTThZ
 RRgT6yFVTmVancS2PeznodTDli0IdclpVmQ0OaZ4+gvyXbouRKVBp7jnCdVE6fbdsa
 3gPRO/7SQPuk0ImuRyfrsk7STHJ7X3wtvviuXi5WR+HNTXd5Iuhbt7iezq3L4MARXK
 T9htFDlHkDnhAMDXMU9cRtHedzHWEBymTrouaMoDTqOYo3Al8eknOFHXAllf40BsSt
 KWVdGtspIKYF4FWb5INZ9rZdYXlu/OSjgneX1/vN+tEOfoWaPkqr0aliSbnAOsrLij
 oIb/dT4BnoT1Q==
Date: Sat, 14 Oct 2023 08:48:50 +0000
To: qemu-devel@nongnu.org
From: Edmund Raile <edmund.raile@proton.me>
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com,
 Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH] qemu-ui-gtk clipboard: fix for freeze-crashes v2
Message-ID: <20231014084641.42317-2-edmund.raile@proton.me>
Feedback-ID: 45198251:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.137;
 envelope-from=edmund.raile@proton.me; helo=mail-40137.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 14 Oct 2023 09:02:15 -0400
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

summary

adresses https://gitlab.com/qemu-project/qemu/-/issues/1150
replaces blocking gtk_clipboard_wait_is_text_available in gd_owner_change a=
nd gtk_clipboard_wait_for_text in gd_clipboard_request with asynchronous gt=
k_clipboard_request_text
uses serial_last and serial of QemuClipboardInfo to only process new clipbo=
ard data



In response to [gemu-gtk-clipboard freezing and crashing guests](https://gi=
tlab.com/qemu-project/qemu/-/issues/1150).

I think I might have a solution for the gtk clipboard sometimes crashing gu=
ests.

@kolAflash I couldn't have done it without you, figuring out `gtk_clipboard=
_wait_is_text_available(clipboard)` was the issue is half the work.

The real issue is that it's blocking and I'd wager that's a big no-no since=
 qemu & KVM have to run the VM + OS, preferably as real-time as possible.
Something times out and you get a core dump.

As a replacement, `gtk_clipboard_request_text`, which is async and non-bloc=
king is a better choice, hopefully.
It requires an additional function to handle receiving text.

In a previous (first) attempt of submitting a patch (https://lists.gnu.org/=
archive/html/qemu-devel/2023-09/msg06027.html), Mr. Lureau gave advice whic=
h I followed here:
 * now both gd_owner_change and gd_clipboard_request are asynchronous by me=
ans of the gd_clipboard_transfer_text_to_guest_callback
 * the QemuClipboardInfo struct now carries a serial_last field which is us=
ed by gd_clipboard_transfer_text_to_guest_callback to only process the clip=
board when new

I hope the comments are acceptable, they should be very useful to people no=
t particularly familiar with he workings of both qemu and gtk clipboards (l=
ike me).

To not risk breaking anything in the mailing list, I'm starting this new ma=
il thread instead of replying to my first one.
Hopefully I'll get it right this time.

Kind regards,
Edmund Raile

Signed-off-by: Edmund Raile <edmund.raile@proton.me>



---
 include/ui/clipboard.h |  2 ++
 ui/gtk-clipboard.c     | 34 ++++++++++++++++++++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index ab6acdbd8a..123c04fc07 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -106,6 +106,7 @@ struct QemuClipboardNotify {
  * @types: clipboard data array (one entry per type).
  * @has_serial: whether @serial is available.
  * @serial: the grab serial counter.
+ * @serial_last: used by GTK UI to discard outdated transaction results.
  *
  * Clipboard content data and metadata.
  */
@@ -115,6 +116,7 @@ struct QemuClipboardInfo {
     QemuClipboardSelection selection;
     bool has_serial;
     uint32_t serial;
+    uint32_t serial_last;
     struct {
         bool available;
         bool requested;
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 8d8a636fd1..9e96cc2fb5 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -133,26 +133,38 @@ static void gd_clipboard_notify(Notifier *notifier, v=
oid *data)
     }
 }
=20
+/* asynchronous clipboard text transfer (host -> guest): callback */
+static void gd_clipboard_transfer_text_to_guest_callback(GtkClipboard *cli=
pboard, const gchar *text, gpointer data)
+{
+    QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
+
+    // serial_last is intentionally not stored as a static in this functio=
n as callbacks implementing other data types (e.g. images) need access as w=
ell
+
+    if (text && (info->serial > info->serial_last)) {
+        info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
+        qemu_clipboard_update(info);
+        info->serial_last =3D info->serial;
+    }
+
+    qemu_clipboard_info_unref(info);
+}
+
+/* asynchronous clipboard transfer (host -> guest) initiator when guest re=
quests clipboard data */
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
+        gtk_clipboard_request_text(gd->gtkcb[info->selection], gd_clipboar=
d_transfer_text_to_guest_callback, info);
         break;
     default:
         break;
     }
 }
=20
+/* asynchronous clipboard transfer (host -> guest) initiator when host has=
 new clipboard data */
 static void gd_owner_change(GtkClipboard *clipboard,
                             GdkEvent *event,
                             gpointer data)
@@ -166,16 +178,10 @@ static void gd_owner_change(GtkClipboard *clipboard,
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
+        gtk_clipboard_request_text(clipboard, gd_clipboard_transfer_text_t=
o_guest_callback, info);
         break;
     default:
         qemu_clipboard_peer_release(&gd->cbpeer, s);
--=20
2.42.0




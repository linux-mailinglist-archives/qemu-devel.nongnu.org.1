Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C67916D9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8BV-0000gC-1O; Mon, 04 Sep 2023 07:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BI-0000Te-DE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BF-0000mP-Mu
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:47 -0400
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-UATYqAN3OpmGo9KOEBmkgg-1; Mon, 04 Sep 2023 07:55:44 -0400
X-MC-Unique: UATYqAN3OpmGo9KOEBmkgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B28FC3C0BE24
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB472026D4B;
 Mon,  4 Sep 2023 11:55:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 43/52] ui/vc: do not parse VC-specific options in Spice and GTK
Date: Mon,  4 Sep 2023 15:52:40 +0400
Message-ID: <20230904115251.4161397-44-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

In commit 6f974c843c ("gtk: overwrite the console.c char driver"), I
shared the VC console parse handler with GTK. And later on in commit
d8aec9d9 ("display: add -display spice-app launching a Spice client"),
I also used it to handle spice-app VC.

This is not necessary, the VC console options (width/height/cols/rows)
are specific, and unused by tty-level GTK/Spice VC.

This is not a breaking change, as those options are still being parsed
by QAPI ChardevVC. Adjust the documentation about it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-44-marcandre.lureau@redhat.com>
---
 qapi/char.json         | 4 ++++
 include/chardev/char.h | 3 ---
 ui/console.c           | 4 ++--
 ui/gtk.c               | 1 -
 ui/spice-app.c         | 7 ++++++-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 52aaff25eb..c1bab7b855 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -390,6 +390,10 @@
 #
 # @rows: console height, in chars
 #
+# Note: the options are only effective when the VNC or SDL graphical
+# display backend is active. They are ignored with the GTK, Spice, VNC
+# and D-Bus display backends.
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevVC',
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 44cd82e405..01df55f9e8 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -320,7 +320,4 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
 void suspend_mux_open(void);
 void resume_mux_open(void);
 
-/* console.c */
-void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
-
 #endif
diff --git a/ui/console.c b/ui/console.c
index ba9da8c1b3..e2b0b9ce06 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2708,7 +2708,7 @@ void qemu_display_help(void)
     }
 }
 
-void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
+static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     int val;
     ChardevVC *vc;
@@ -2746,7 +2746,7 @@ static void char_vc_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_vc;
+    cc->parse = vc_chr_parse;
     cc->open = vc_chr_open;
     cc->chr_write = vc_chr_write;
     cc->chr_accept_input = vc_chr_accept_input;
diff --git a/ui/gtk.c b/ui/gtk.c
index 8ba41c8f13..ef98bb0648 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1860,7 +1860,6 @@ static void char_gd_vc_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_vc;
     cc->open = gd_vc_open;
     cc->chr_write = gd_vc_chr_write;
     cc->chr_accept_input = gd_vc_chr_accept_input;
diff --git a/ui/spice-app.c b/ui/spice-app.c
index ad7f0551ad..405fb7f9f5 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -96,6 +96,11 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
     /* TODO: set echo for frontends QMP and qtest */
 }
 
+static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
+{
+    /* fqdn is dealt with in vc_chr_open() */
+}
+
 static void char_vc_class_init(ObjectClass *oc, void *data)
 {
     VCChardevClass *vc = CHARDEV_VC_CLASS(oc);
@@ -103,7 +108,7 @@ static void char_vc_class_init(ObjectClass *oc, void *data)
 
     vc->parent_open = cc->open;
 
-    cc->parse = qemu_chr_parse_vc;
+    cc->parse = vc_chr_parse;
     cc->open = vc_chr_open;
     cc->chr_set_echo = vc_chr_set_echo;
 }
-- 
2.41.0



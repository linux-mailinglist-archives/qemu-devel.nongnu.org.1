Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B478D4CA
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHi9-0002p9-FG; Wed, 30 Aug 2023 05:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhn-0002aP-JW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhl-0001XC-5m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/q4fKSOhyZCL2FrkGOjnzDqZRW/4aoqTcGzWnJ3CVU=;
 b=gnqoOm9wcHWlS3TA9Wq5FrwfCjy23WJKfhLFRWTHSc+Tnn7buRvnYBF8++uRxugM1MpX4g
 mPTwnuPX6G4wxa3rNa/g/CGYaUMFc0f8hd6s9q9joIGEWeDb+S9249dQTZo096vPki9L3J
 GrCG9bSviu5+bCNlrUE7vQUPLccmOPA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-X-Ec5l0FMOGD5fnpVoGWSg-1; Wed, 30 Aug 2023 05:41:38 -0400
X-MC-Unique: X-Ec5l0FMOGD5fnpVoGWSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53C2D8022E4
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C249140E96E;
 Wed, 30 Aug 2023 09:41:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 43/67] ui/vc: do not parse VC-specific options in Spice and GTK
Date: Wed, 30 Aug 2023 13:38:17 +0400
Message-ID: <20230830093843.3531473-44-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 qapi/char.json         | 4 ++++
 include/chardev/char.h | 3 ---
 ui/console.c           | 4 ++--
 ui/gtk.c               | 1 -
 ui/spice-app.c         | 7 ++++++-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 52aaff25eb..7e23fe3180 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -390,6 +390,10 @@
 #
 # @rows: console height, in chars
 #
+# Note: the options are only effective when using the built-in QEMU graphical VC
+# (with the SDL display). When the VC is handled by the display backend (with
+# GTK/VTE, Spice or D-Bus), they are simply ignored.
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
index 7be2d4eef3..9fccecafd7 100644
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



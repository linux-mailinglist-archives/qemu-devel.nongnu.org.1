Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF31B7EF4A4
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:36:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zwR-00052S-Jy; Fri, 17 Nov 2023 09:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zwM-00050a-DE
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zwJ-00030F-0z
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700231720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8B05378RFNqkW3h/mnChVllxYbuM/KVt02AhcVbP1I=;
 b=KLMOa6ggXTATyYRfPoHWPlSVi2msSpO1kBdoifv2yWMwnTnT4Hz3vfr76QDHf/2tGvGqjG
 0nkNBBpmB7SA+GJpjhABijbmaWkVDYNZY3a7dBLD8/7iqkOB/3v2TzSGznKkMhoLawZvJN
 PK05v/gPJkBsmxN/dbRmnoLEHQ/+S8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-0PSacX6lOHGS6ojd4VyaOw-1; Fri, 17 Nov 2023 09:35:17 -0500
X-MC-Unique: 0PSacX6lOHGS6ojd4VyaOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1348585A58A;
 Fri, 17 Nov 2023 14:35:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 531C02166B27;
 Fri, 17 Nov 2023 14:35:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dwmw@amazon.co.uk
Subject: [PATCH for-8.2 2/3] ui: use "vc" chardev for dbus, gtk & spice-app
Date: Fri, 17 Nov 2023 18:35:04 +0400
Message-ID: <20231117143506.1521718-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Those display have their own implementation of "vc" chardev, which
doesn't use pixman. They also don't implement the width/height/cols/rows
options, so qemu_display_get_vc() should return a compatible argument.

This patch was meant to be with the pixman series, when the "vc" field
was introduced. It fixes a regression where VC are created on the
tty (or null) instead of the display own "vc" implementation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus.c      | 1 +
 ui/gtk.c       | 1 +
 ui/spice-app.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/ui/dbus.c b/ui/dbus.c
index 866467ad2e..e08b5de064 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -518,6 +518,7 @@ static QemuDisplay qemu_display_dbus = {
     .type       = DISPLAY_TYPE_DBUS,
     .early_init = early_dbus_init,
     .init       = dbus_init,
+    .vc         = "vc",
 };
 
 static void register_dbus(void)
diff --git a/ui/gtk.c b/ui/gtk.c
index be047a41ad..810d7fc796 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2534,6 +2534,7 @@ static QemuDisplay qemu_display_gtk = {
     .type       = DISPLAY_TYPE_GTK,
     .early_init = early_gtk_display_init,
     .init       = gtk_display_init,
+    .vc         = "vc",
 };
 
 static void register_gtk(void)
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 405fb7f9f5..a10b4a58fe 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -220,6 +220,7 @@ static QemuDisplay qemu_display_spice_app = {
     .type       = DISPLAY_TYPE_SPICE_APP,
     .early_init = spice_app_display_early_init,
     .init       = spice_app_display_init,
+    .vc         = "vc",
 };
 
 static void register_spice_app(void)
-- 
2.41.0



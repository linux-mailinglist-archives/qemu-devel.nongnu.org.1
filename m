Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860F7D33B6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutAg-0001HS-EN; Mon, 23 Oct 2023 07:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qutA7-0008VK-W9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qutA6-0003gt-Ga
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjyX/hzVkoTNTRue4FPmHzJ+w3/YyERyvkVhX3gqTLo=;
 b=Ur5gEf5P8eQIILke4875IcZ9qkfb17/APPaOnGV8pkTE7ZH/hzapUlyOwfGG7mS1z5ioqH
 iM6M6gtuNG2hnO0OINNNEXqwlHmSiJAJghmUFZpPQv537NPvwZ/Nh8OEGF1IExZZxfiHuW
 FUcOmBALo6UY4ZErs5WscdWGAgt8EBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-3ZJ3kmeWNAGdeVWIcTu10w-1; Mon, 23 Oct 2023 07:31:49 -0400
X-MC-Unique: 3ZJ3kmeWNAGdeVWIcTu10w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 567E58021B1;
 Mon, 23 Oct 2023 11:31:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FE09111D784;
 Mon, 23 Oct 2023 11:31:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 13/19] ui/spice: SPICE/QXL requires PIXMAN
Date: Mon, 23 Oct 2023 15:30:40 +0400
Message-ID: <20231023113047.2572137-14-marcandre.lureau@redhat.com>
In-Reply-To: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build        |  6 +++++-
 hw/display/Kconfig |  2 +-
 ui/meson.build     | 10 +++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index c4dd9e01ea..3d6e41d1fb 100644
--- a/meson.build
+++ b/meson.build
@@ -1015,7 +1015,11 @@ if not get_option('spice_protocol').auto() or have_system
                               method: 'pkg-config')
 endif
 spice = not_found
-if not get_option('spice').auto() or have_system
+if get_option('spice') \
+             .disable_auto_if(not have_system) \
+             .require(pixman.found(),
+                      error_message: 'cannot enable SPICE if pixman is not available') \
+             .allowed()
   spice = dependency('spice-server', version: '>=0.14.0',
                      required: get_option('spice'),
                      method: 'pkg-config')
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 7b3da68d1c..4d8b0cec40 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -93,7 +93,7 @@ config VGA
 
 config QXL
     bool
-    depends on SPICE && PCI
+    depends on SPICE && PCI && PIXMAN
     select VGA
 
 config VIRTIO_GPU
diff --git a/ui/meson.build b/ui/meson.build
index b3525ef064..7f806a6d48 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -141,12 +141,12 @@ if spice.found()
     'spice-display.c'
   ))
   ui_modules += {'spice-core' : spice_core_ss}
-endif
 
-if spice.found() and gio.found()
-  spice_ss = ss.source_set()
-  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
-  ui_modules += {'spice-app': spice_ss}
+  if gio.found()
+    spice_ss = ss.source_set()
+    spice_ss.add(spice, gio, pixman, files('spice-app.c'))
+    ui_modules += {'spice-app': spice_ss}
+  endif
 endif
 
 keymaps = [
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A58D4AE3
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 13:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdwS-0006NY-DL; Thu, 30 May 2024 07:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwP-0006Lw-Tq
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwN-0003eU-HK
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717068446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwd70H1PbpqlY2vcizptzp18Ufdhj9422qrYmE21yDk=;
 b=RTuZIjzUspuzuIfcbUr+IJ7NPhmLxupc7HOnY9gC1SN+MmX32P1Ak1oYoB4ChXybch5dVq
 2VUDNQeU+UVujNmWbOpZM80o7pLKbHWQTfSQfE6IXJCfc4E7vbM0RAfU31N6yljzb24R4g
 oDlIlupdI6U0ddHV35gv8txQiN66nhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-dzqdLpF9MkuYwzoLNbKlBA-1; Thu, 30 May 2024 07:27:23 -0400
X-MC-Unique: dzqdLpF9MkuYwzoLNbKlBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4F6D185A780;
 Thu, 30 May 2024 11:27:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4C2F286E;
 Thu, 30 May 2024 11:27:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 60AD618007A5; Thu, 30 May 2024 13:27:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 2/4] usb: add config options for the hub and hid devices
Date: Thu, 30 May 2024 13:27:15 +0200
Message-ID: <20240530112718.1752905-3-kraxel@redhat.com>
In-Reply-To: <20240530112718.1752905-1-kraxel@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/Kconfig     | 10 ++++++++++
 hw/usb/meson.build |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index f569ed7eeaa1..84bc7fbe36cd 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -65,6 +65,16 @@ config TUSB6010
     bool
     select USB_MUSB
 
+config USB_HUB
+    bool
+    default y
+    depends on USB
+
+config USB_HID
+    bool
+    default y
+    depends on USB
+
 config USB_TABLET_WACOM
     bool
     default y
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 23f7f7acb50b..d7de1003e3db 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -35,8 +35,8 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-
 system_ss.add(when: 'CONFIG_XLNX_USB_SUBSYS', if_true: files('xlnx-usb-subsystem.c'))
 
 # emulated usb devices
-system_ss.add(when: 'CONFIG_USB', if_true: files('dev-hub.c'))
-system_ss.add(when: 'CONFIG_USB', if_true: files('dev-hid.c'))
+system_ss.add(when: 'CONFIG_USB_HUB', if_true: files('dev-hub.c'))
+system_ss.add(when: 'CONFIG_USB_HID', if_true: files('dev-hid.c'))
 system_ss.add(when: 'CONFIG_USB_TABLET_WACOM', if_true: files('dev-wacom.c'))
 system_ss.add(when: 'CONFIG_USB_STORAGE_CORE', if_true: files('dev-storage.c'))
 system_ss.add(when: 'CONFIG_USB_STORAGE_BOT', if_true: files('dev-storage-bot.c'))
-- 
2.45.1



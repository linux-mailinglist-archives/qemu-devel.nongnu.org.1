Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8C7D740D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjGW-00071S-PB; Wed, 25 Oct 2023 15:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjGU-0006xv-Ia
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjGS-0000hf-QX
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698261000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jm7z9T8PI3TaN5Ibcu8ZAR34M0vHVjaqargdypAD7v0=;
 b=D8YA2xnhOrUdSNDFuipYV6Pkr7cpfVoFoYbXSFmnI1+118dDOS/n6mRPCoG8WLlFpFmJ6q
 l1XtIedkzPk8s3/gIWt4VYa/LKU2OPYb9vlBv9/PIATlg0sh6Ts2Fg7UbskHHmzCt+DooV
 yJ4u39HXNLlcyOaDONLkHaluESH/7nA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-qcJNj_ZwO8WwqpHjmewZUQ-1; Wed,
 25 Oct 2023 15:09:56 -0400
X-MC-Unique: qcJNj_ZwO8WwqpHjmewZUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49BBC38062B1;
 Wed, 25 Oct 2023 19:09:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0D25027;
 Wed, 25 Oct 2023 19:09:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 22/23] hw/display: make ATI_VGA depend on PIXMAN
Date: Wed, 25 Oct 2023 23:08:16 +0400
Message-ID: <20231025190818.3278423-23-marcandre.lureau@redhat.com>
In-Reply-To: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 configs/devices/mips64el-softmmu/default.mak | 2 +-
 hw/display/Kconfig                           | 2 +-
 hw/display/meson.build                       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
index d5188f7ea5..8d85607571 100644
--- a/configs/devices/mips64el-softmmu/default.mak
+++ b/configs/devices/mips64el-softmmu/default.mak
@@ -3,7 +3,7 @@
 include ../mips-softmmu/common.mak
 CONFIG_FULOONG=y
 CONFIG_LOONGSON3V=y
-CONFIG_ATI_VGA=y
+# CONFIG_ATI_VGA=n
 CONFIG_RTL8139_PCI=y
 CONFIG_JAZZ=y
 CONFIG_VT82C686=y
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1aafe1923d..4d8a6c4af8 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -125,7 +125,7 @@ config DPCD
 config ATI_VGA
     bool
     default y if PCI_DEVICES
-    depends on PCI
+    depends on PCI && PIXMAN
     select VGA
     select BITBANG_I2C
     select DDC
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 9c06aaee20..344dfe3d8c 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
 
 system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
-system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
+system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
-- 
2.41.0



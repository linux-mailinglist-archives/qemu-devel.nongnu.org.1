Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33DE7E1B2B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:26:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztyr-0005U3-GH; Mon, 06 Nov 2023 02:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztyj-0004tG-QP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztyh-0006Uj-Fd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=keLfkghX2/N7TKnXbXJ/FeXnBd82lE6vU0DmoqeQtkw=;
 b=ifqp5gPGntnUzq2JCyeouEM1AVNEZtCsy0beL3KGYyzCfkmvXnjhLOMzY95ulzk07lvCgd
 79u5DmPU5WyQpzchcAnMM+/zlWDiOtNX7OpIjfyvXsa7jaxMK14X8NkgKTGaztAZIJzmiv
 BQE8vssfdYZ/n9fKGifjK9oAF/6hav4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-jB_vks_OMm2nVTC-a1j-Cw-1; Mon,
 06 Nov 2023 02:24:50 -0500
X-MC-Unique: jB_vks_OMm2nVTC-a1j-Cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4391A1C29EB2;
 Mon,  6 Nov 2023 07:24:50 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 389D15039;
 Mon,  6 Nov 2023 07:24:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/23] hw/display: make ATI_VGA depend on PIXMAN
Date: Mon,  6 Nov 2023 11:23:11 +0400
Message-ID: <20231106072313.1742543-23-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

To avoid a kconfig cycle, change "depends on PCI" to "select PCI".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 configs/devices/mips64el-softmmu/default.mak | 3 +--
 hw/display/Kconfig                           | 3 ++-
 hw/display/meson.build                       | 2 +-
 hw/mips/Kconfig                              | 2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
index d5188f7ea5..4d80d60511 100644
--- a/configs/devices/mips64el-softmmu/default.mak
+++ b/configs/devices/mips64el-softmmu/default.mak
@@ -1,9 +1,8 @@
 # Default configuration for mips64el-softmmu
 
 include ../mips-softmmu/common.mak
-CONFIG_FULOONG=y
+#CONFIG_FULOONG=y
 CONFIG_LOONGSON3V=y
-CONFIG_ATI_VGA=y
 CONFIG_RTL8139_PCI=y
 CONFIG_JAZZ=y
 CONFIG_VT82C686=y
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1aafe1923d..8219225a1c 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -125,7 +125,8 @@ config DPCD
 config ATI_VGA
     bool
     default y if PCI_DEVICES
-    depends on PCI
+    depends on PIXMAN
+    select PCI
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
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ac1eb06a51..5d40795c0b 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -32,7 +32,9 @@ config JAZZ
 
 config FULOONG
     bool
+    default y if MIPS64
     select PCI_BONITO
+    depends on ATI_VGA
 
 config LOONGSON3V
     bool
-- 
2.41.0



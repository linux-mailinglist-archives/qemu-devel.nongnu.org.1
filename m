Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7029A737C7A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBsTV-0007QV-8Y; Wed, 21 Jun 2023 03:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBsTK-0007Q7-97
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBsTI-0003PW-QP
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687333302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b6Bl+BJwmqNoHxFOHb8Nw1nDvrvlNDR4AOBpTSQVthY=;
 b=MVHOz3CNbP+rYwVrqjswvL/nS42imfhlrjBtMFlqk2kUp0QSDwJ4U38seP48aEODZ20Bjd
 0AIhjqbHkuOlCf49jkn7IcuvPD9C5niJ0om+EnlwzvEfqEfMTtE9/HIb0yKo8jKZrrCkvJ
 Qg0t1fZR5BV9vZ9mDLEziwWmBLgpo/E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-zEnUddtkN42GOWnY5rP52g-1; Wed, 21 Jun 2023 03:41:38 -0400
X-MC-Unique: zEnUddtkN42GOWnY5rP52g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B983813F20;
 Wed, 21 Jun 2023 07:41:38 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7823A40C2063;
 Wed, 21 Jun 2023 07:41:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Date: Wed, 21 Jun 2023 09:41:34 +0200
Message-Id: <20230621074134.82781-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It's possible to compile QEMU without the USB devices (e.g. when using
"--without-default-devices" as option for the "configure" script).
To be still able to run the loongson3-virt machine in default mode with
such a QEMU binary, we have to check here for the availability of the
USB devices first before instantiating them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use #ifdef instead of runtime check

 hw/mips/loongson3_virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 216812f660..3094413eea 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -51,6 +51,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "qemu/error-report.h"
+#include CONFIG_DEVICES
 
 #define PM_CNTL_MODE          0x10
 
@@ -447,11 +448,13 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     pci_vga_init(pci_bus);
 
+#ifdef CONFIG_USB_OHCI_PCI
     if (defaults_enabled()) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
         usb_create_simple(usb_bus_find(-1), "usb-kbd");
         usb_create_simple(usb_bus_find(-1), "usb-tablet");
     }
+#endif
 
     for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
-- 
2.39.3



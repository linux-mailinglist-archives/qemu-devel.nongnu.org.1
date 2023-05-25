Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D36C7105CE
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 08:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q24ld-00046x-Sk; Thu, 25 May 2023 02:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q24lP-00046M-K7
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q24l9-0000Rh-4Q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684997256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A95lLAIdtpkxMDTZ+DqWYiJxVnVg3gkOuxjWLDYKksw=;
 b=Ms/Yw9KXfXDpPMk4po+rgzJFfBZW5Ha0hf/im8ZcNsUL/BB/EVPr93hPUGDSg+eRG0dTtC
 GKcPehSPxSZ7PWV2BBthnLWEPs5ieRIaqwSN3YDKnbFbA2JdDXRTo/oor6Xg4PDt1V/XYm
 YWSXcaJyGqc3rWxVGBS7vq44ZNicaEE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-5aT-AgYKOrOEW2fv8FrBQw-1; Thu, 25 May 2023 02:47:34 -0400
X-MC-Unique: 5aT-AgYKOrOEW2fv8FrBQw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43EB21C068CC;
 Thu, 25 May 2023 06:47:34 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 632B6492B0A;
 Thu, 25 May 2023 06:47:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Date: Thu, 25 May 2023 08:47:31 +0200
Message-Id: <20230525064731.1854107-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

It's possible to compile QEMU without the USB devices (e.g. when using
"--without-default-devices" as option for the "configure" script).
To be still able to run the loongson3-virt machine in default mode with
such a QEMU binary, we have to check here for the availability of the
devices first before instantiating them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 The alternative would be to use a "#ifdef CONFIG_USB_OHCI_PCI" etc.
 ... not sure what is nicer ... what do you think?

 hw/mips/loongson3_virt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 216812f660..a0afb17030 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -447,10 +447,14 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     pci_vga_init(pci_bus);
 
-    if (defaults_enabled()) {
+    if (defaults_enabled() && module_object_class_by_name("pci-ohci")) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-tablet");
+        if (module_object_class_by_name("usb-kbd")) {
+            usb_create_simple(usb_bus_find(-1), "usb-kbd");
+        }
+        if (module_object_class_by_name("usb-tablet")) {
+            usb_create_simple(usb_bus_find(-1), "usb-tablet");
+        }
     }
 
     for (i = 0; i < nb_nics; i++) {
-- 
2.31.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF7C7538C3
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 12:50:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGML-0002uk-Gw; Fri, 14 Jul 2023 06:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qKGMJ-0002uD-Ky
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 06:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qKGMH-0005xN-Vl
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 06:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689331748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1EUpEPdGCMPna7btGH7N3m/vHp8//TkK2jHWAgDDhkw=;
 b=OESTLlcRrD2Drzo1+ie3aNfqpCCRetHvbl1PuSphodplt/OzVO5Ulp42m9dQCL3hG1KVVV
 +N4xWqv4le0jlCXrUqS1LrJ5xu5mWziKiy6U4eecFj1OxI1PO7f+LG7VlkjhDjBxsm9Op5
 JmhDb1eo0HUlj3fubtg4oeLaS8xtlEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-6-hPFmKjPh-owNGBxrsvJA-1; Fri, 14 Jul 2023 06:49:07 -0400
X-MC-Unique: 6-hPFmKjPh-owNGBxrsvJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1846185A792;
 Fri, 14 Jul 2023 10:49:06 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA26F40C6CCD;
 Fri, 14 Jul 2023 10:49:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH v3] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Date: Fri, 14 Jul 2023 12:49:03 +0200
Message-Id: <20230714104903.284845-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

It's possible to compile QEMU without the USB devices (e.g. when using
"--without-default-devices" as option for the "configure" script).
To be still able to run the loongson3-virt machine in default mode with
such a QEMU binary, we have to check here for the availability of the
OHCI controller first before instantiating the USB devices.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Back to runtime detection, but more simple this time compared to v1
     (checking for OHCI should be enough, since this implies CONFIG_USB
      which is the switch that usb-kbd and usb-tablet are depending on)

 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4018b8c1d3..3ad0a223df 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -447,7 +447,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     pci_vga_init(pci_bus);
 
-    if (defaults_enabled()) {
+    if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
         usb_create_simple(usb_bus_find(-1), "usb-kbd");
         usb_create_simple(usb_bus_find(-1), "usb-tablet");
-- 
2.39.3



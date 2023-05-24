Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8670F4E0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mSA-0006UA-QQ; Wed, 24 May 2023 07:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q1mS6-0006Pr-A0; Wed, 24 May 2023 07:14:46 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q1mS3-0003vo-1E; Wed, 24 May 2023 07:14:45 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 119952602AC;
 Wed, 24 May 2023 13:14:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohnQ23sV1NUL; Wed, 24 May 2023 13:14:39 +0200 (CEST)
Received: from applejack.lan (83.21.125.167.ipv4.supernova.orange.pl
 [83.21.125.167])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 3B2972609C0;
 Wed, 24 May 2023 13:14:37 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v4 2/3] Add Bochs to list of vga_interfaces
Date: Wed, 24 May 2023 13:14:12 +0200
Message-Id: <20230524111413.833912-3-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524111413.833912-1-marcin.juszkiewicz@linaro.org>
References: <20230524111413.833912-1-marcin.juszkiewicz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

arm/sbsa-ref uses Bochs-display graphics card and without it being
present in vga_interfaces "-vga none" argument handling cannot be added.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 hw/pci/pci.c            | 2 ++
 include/sysemu/sysemu.h | 2 +-
 softmmu/vl.c            | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1cc7c89036..edac76ea15 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1937,6 +1937,8 @@ PCIDevice *pci_vga_init(PCIBus *bus)
         return pci_create_simple(bus, -1, "vmware-svga");
     case VGA_VIRTIO:
         return pci_create_simple(bus, -1, "virtio-vga");
+    case VGA_BOCHS:
+        return pci_create_simple(bus, -1, "bochs-display");
     case VGA_NONE:
     default: /* Other non-PCI types. Checking for unsupported types is already
                 done in vl.c. */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 25be2a692e..9713a1b470 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -29,7 +29,7 @@ extern int autostart;
 
 typedef enum {
     VGA_NONE, VGA_STD, VGA_CIRRUS, VGA_VMWARE, VGA_XENFB, VGA_QXL,
-    VGA_TCX, VGA_CG3, VGA_DEVICE, VGA_VIRTIO,
+    VGA_TCX, VGA_CG3, VGA_DEVICE, VGA_VIRTIO, VGA_BOCHS,
     VGA_TYPE_MAX,
 } VGAInterfaceType;
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..07e6030875 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -216,6 +216,7 @@ static struct {
     { .driver = "ati-vga",              .flag = &default_vga       },
     { .driver = "vhost-user-vga",       .flag = &default_vga       },
     { .driver = "virtio-vga-gl",        .flag = &default_vga       },
+    { .driver = "bochs-display",        .flag = &default_vga       },
 };
 
 static QemuOptsList qemu_rtc_opts = {
@@ -935,6 +936,11 @@ static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
         .name = "CG3 framebuffer",
         .class_names = { "cgthree" },
     },
+    [VGA_BOCHS] = {
+        .opt_name = "bochs-display",
+        .name = "Bochs framebuffer",
+        .class_names = { "bochs-display" },
+    },
 #ifdef CONFIG_XEN_BACKEND
     [VGA_XENFB] = {
         .opt_name = "xenfb",
-- 
2.40.1



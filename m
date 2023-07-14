Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0175D7539DC
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9t-0001eM-TG; Fri, 14 Jul 2023 07:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9j-00012u-4q; Fri, 14 Jul 2023 07:40:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9g-0004ao-UA; Fri, 14 Jul 2023 07:40:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F260413D9F;
 Fri, 14 Jul 2023 14:38:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ED34A14BAE;
 Fri, 14 Jul 2023 14:38:41 +0300 (MSK)
Received: (nullmailer pid 1186252 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 19/29] tree-wide spelling fixes in comments and some
 messages: hw/usb hw/ide hw/i2c
Date: Fri, 14 Jul 2023 14:38:24 +0300
Message-Id: <20230714113834.1186117-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i2c/pm_smbus.c           | 2 +-
 hw/i2c/pmbus_device.c       | 2 +-
 hw/i2c/smbus_slave.c        | 2 +-
 hw/ide/ahci_internal.h      | 4 ++--
 hw/ide/cmd646.c             | 2 +-
 hw/ide/core.c               | 2 +-
 hw/usb/ccid-card-emulated.c | 2 +-
 hw/usb/hcd-ehci.c           | 6 +++---
 hw/usb/hcd-ohci.c           | 2 +-
 hw/usb/quirks.h             | 2 +-
 hw/usb/redirect.c           | 2 +-
 hw/usb/trace-events         | 2 +-
 hw/usb/xen-usb.c            | 2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index d7eae548cb..9ad6a47739 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -2,3 +2,3 @@
  * PC SMBus implementation
- * splitted from acpi.c
+ * split from acpi.c
  *
diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 44fe4eddbb..426f72ac60 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1625,3 +1625,3 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
 passthrough:
-    /* Unimplimented registers get passed to the device */
+    /* Unimplemented registers get passed to the device */
     default:
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index feb3ec6333..2ef2c7c5f6 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -4,3 +4,3 @@
  * This code is a helper for SMBus device emulation.  It implements an
- * I2C device inteface and runs the SMBus protocol from the device
+ * I2C device interface and runs the SMBus protocol from the device
  * point of view and maps those to simple calls to emulate.
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 2480455372..c244bbd8be 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -63,3 +63,3 @@ enum AHCIHostReg {
     AHCI_HOST_REG_PORTS_IMPL = 3,  /* PI: bitmap of implemented ports */
-    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliancy */
+    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliance */
     AHCI_HOST_REG_CCC_CTL    = 5,  /* CCC_CTL: CCC Control */
@@ -69,3 +69,3 @@ enum AHCIHostReg {
     AHCI_HOST_REG_CAP2       = 9,  /* CAP2: host capabilities, extended */
-    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmare/os handoff ctrl & status */
+    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmware/os handoff ctrl & status */
     AHCI_HOST_REG__COUNT     = 11
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index cabe9048b1..c0bcfa4414 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -259,3 +259,3 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     if (d->secondary) {
-        /* XXX: if not enabled, really disable the seconday IDE controller */
+        /* XXX: if not enabled, really disable the secondary IDE controller */
         pci_conf[CNTRL] |= CNTRL_EN_CH1; /* enable IDE1 */
diff --git a/hw/ide/core.c b/hw/ide/core.c
index de48ff9f86..ee116891ed 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1700,3 +1700,3 @@ static bool cmd_set_features(IDEState *s, uint8_t cmd)
                 break;
-            case 0x02: /* sigle word dma mode*/
+            case 0x02: /* single word dma mode */
                 put_le16(identify_data + 62, 0x07 | (1 << (val + 8)));
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index c328660075..3ee9c73b87 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -520,3 +520,3 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
 
-    /* TODO: a passthru backened that works on local machine. third card type?*/
+    /* TODO: a passthru backend that works on local machine. third card type?*/
     if (card->backend == BACKEND_CERTIFICATES) {
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index c930c60921..19b4534c20 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1466,3 +1466,3 @@ static int ehci_process_itd(EHCIState *ehci,
                 } else {
-                    DPRINTF("ISOCH: attempt to addess non-iso endpoint\n");
+                    DPRINTF("ISOCH: attempt to address non-iso endpoint\n");
                     ehci->ipacket.status = USB_RET_NAK;
@@ -1515,3 +1515,3 @@ static int ehci_process_itd(EHCIState *ehci,
 /*  This state is the entry point for asynchronous schedule
- *  processing.  Entry here consitutes a EHCI start event state (4.8.5)
+ *  processing.  Entry here constitutes a EHCI start event state (4.8.5)
  */
@@ -2460,3 +2460,3 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
      * to miss a QH unlink, and fail to cancel packets, since the unlinked QH
-     * will never have existed on the destination. Therefor we must flush the
+     * will never have existed on the destination. Therefore we must flush the
      * async schedule on savevm to catch any not yet noticed unlinks.
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index cc5cde6983..7ff1b65ced 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1357,3 +1357,3 @@ static uint32_t ohci_get_frame_remaining(OHCIState *ohci)
     }
-    /* Being in USB operational state guarnatees sof_time was set already. */
+    /* Being in USB operational state guarantees sof_time was set already. */
     tks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ohci->sof_time;
diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index c3e595f40b..94b2c95341 100644
--- a/hw/usb/quirks.h
+++ b/hw/usb/quirks.h
@@ -69,3 +69,3 @@ static const struct usb_device_id usbredir_raw_serial_ids[] = {
     { USB_DEVICE(0x10C4, 0x8044) }, /* Cygnal Debug Adapter */
-    { USB_DEVICE(0x10C4, 0x804E) }, /* Software Bisque Paramount ME build-in converter */
+    { USB_DEVICE(0x10C4, 0x804E) }, /* Software Bisque Paramount ME built-in converter */
     { USB_DEVICE(0x10C4, 0x8053) }, /* Enfora EDG1228 */
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 39fbaaab16..0e256c1eca 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -473,3 +473,3 @@ static int bufp_alloc(USBRedirDevice *dev, uint8_t *data, uint16_t len,
     }
-    /* Since we're interupting the stream anyways, drop enough packets to get
+    /* Since we're interrupting the stream anyways, drop enough packets to get
        back to our target buffer size */
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 6bb9655c8d..ed7dc210d3 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -250,3 +250,3 @@ usb_set_device_feature(int addr, int feature, int ret) "dev %d, feature %d, ret
 usb_hub_reset(int addr) "dev %d"
-usb_hub_control(int addr, int request, int value, int index, int length) "dev %d, req 0x%x, value %d, index %d, langth %d"
+usb_hub_control(int addr, int request, int value, int index, int length) "dev %d, req 0x%x, value %d, index %d, length %d"
 usb_hub_get_port_status(int addr, int nr, int status, int changed) "dev %d, port %d, status 0x%x, changed 0x%x"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 38ee660a30..09ec326aea 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -453,3 +453,3 @@ static int usbback_check_and_submit(struct usbback_req *usbback_req)
     /*
-     * When the device is first connected or resetted, USB device has no
+     * When the device is first connected or reset, USB device has no
      * address. In this initial state, following requests are sent to device
-- 
2.39.2



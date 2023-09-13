Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976579E90D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPlC-0007KP-7l; Wed, 13 Sep 2023 09:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPl8-0007Ew-NU; Wed, 13 Sep 2023 09:18:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPl5-0002uu-Vp; Wed, 13 Sep 2023 09:18:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 171DE21761;
 Wed, 13 Sep 2023 16:18:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1286027C84;
 Wed, 13 Sep 2023 16:18:02 +0300 (MSK)
Received: (nullmailer pid 4073286 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 07/66] lsi53c895a: disable reentrancy detection for
 MMIO region, too
Date: Wed, 13 Sep 2023 16:17:31 +0300
Message-Id: <20230913131757.4073200-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Thomas Huth <thuth@redhat.com>

While trying to use a SCSI disk on the LSI controller with an
older version of Fedora (25), I'm getting:

 qemu: warning: Blocked re-entrant IO on MemoryRegion: lsi-mmio at addr: 0x34

and the SCSI controller is not usable. Seems like we have to
disable the reentrancy checker for the MMIO region, too, to
get this working again.

The problem could be reproduced it like this:

./qemu-system-x86_64 -accel kvm -m 2G -machine q35 \
 -device lsi53c810,id=lsi1 -device scsi-hd,drive=d0 \
 -drive if=none,id=d0,file=.../somedisk.qcow2 \
 -cdrom Fedora-Everything-netinst-i386-25-1.3.iso

Where somedisk.qcow2 is an image that contains already some partitions
and file systems.

In the boot menu of Fedora, go to
"Troubleshooting" -> "Rescue a Fedora system" -> "3) Skip to shell"

Then check "dmesg | grep -i 53c" for failure messages, and try to mount
a partition from somedisk.qcow2.

Message-Id: <20230516090556.553813-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit d139fe9ad8a27bcc50b4ead77d2f97d191a0e95e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 17af67935f..f7d45b0b20 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2318,6 +2318,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
      * re-entrancy guard.
      */
     s->ram_io.disable_reentrancy_guard = true;
+    s->mmio_io.disable_reentrancy_guard = true;
 
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
     qdev_init_gpio_out(d, &s->ext_irq, 1);
-- 
2.39.2



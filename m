Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA77063AD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:12:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDBT-0000GE-0A; Wed, 17 May 2023 05:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBM-00008P-Dp; Wed, 17 May 2023 05:10:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBF-0006LV-Pl; Wed, 17 May 2023 05:10:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CEDC6829;
 Wed, 17 May 2023 12:10:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B8A775EF5;
 Wed, 17 May 2023 12:10:42 +0300 (MSK)
Received: (nullmailer pid 3626675 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com, anisinha@redhat.com,
 jusual@redhat.com
Subject: [PATCH v7.2.3 03/30] acpi: pcihp: allow repeating hot-unplug requests
Date: Wed, 17 May 2023 12:10:15 +0300
Message-Id: <20230517091042.3626593-3-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

with Q35 using ACPI PCI hotplug by default, user's request to unplug
device is ignored when it's issued before guest OS has been booted.
And any additional attempt to request device hot-unplug afterwards
results in following error:

  "Device XYZ is already in the process of unplug"

arguably it can be considered as a regression introduced by [2],
before which it was possible to issue unplug request multiple
times.

Accept new uplug requests after timeout (1ms). This brings ACPI PCI
hotplug on par with native PCIe unplug behavior [1] and allows user
to repeat unplug requests at propper times.
Set expire timeout to arbitrary 1msec so user won't be able to
flood guest with SCI interrupts by calling device_del in tight loop.

PS:
ACPI spec doesn't mandate what OSPM can do with GPEx.status
bits set before it's booted => it's impl. depended.
Status bits may be retained (I tested with one Windows version)
or cleared (Linux since 2.6 kernel times) during guest's ACPI
subsystem initialization.
Clearing status bits (though not wrong per se) hides the unplug
event from guest, and it's upto user to repeat device_del later
when guest is able to handle unplug requests.

1) 18416c62e3 ("pcie: expire pending delete")
2)
Fixes: cce8944cc9ef ("qdev-monitor: Forbid repeated device_del")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
CC: mst@redhat.com
CC: anisinha@redhat.com
CC: jusual@redhat.com
CC: kraxel@redhat.com
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
(cherry picked from commit 0f689cf5ada4d5df5ab95c7f7aa9fc221afa855d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 76326210e43991e9fb678ec05e06463c99794611)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/acpi/pcihp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 84d75e6b84..a2a3738b46 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -429,6 +429,16 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
      * acpi_pcihp_eject_slot() when the operation is completed.
      */
     pdev->qdev.pending_deleted_event = true;
+    /* if unplug was requested before OSPM is initialized,
+     * linux kernel will clear GPE0.sts[] bits during boot, which effectively
+     * hides unplug event. And than followup qmp_device_del() calls remain
+     * blocked by above flag permanently.
+     * Unblock qmp_device_del() by setting expire limit, so user can
+     * repeat unplug request later when OSPM has been booted.
+     */
+    pdev->qdev.pending_deleted_expires_ms =
+        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL); /* 1 msec */
+
     s->acpi_pcihp_pci_status[bsel].down |= (1U << slot);
     acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
-- 
2.39.2



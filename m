Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A437708EE
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0KD-0005OS-CT; Fri, 04 Aug 2023 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0KA-0005C4-6z; Fri, 04 Aug 2023 15:18:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0K8-0007AI-Hh; Fri, 04 Aug 2023 15:18:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 430CE1846B;
 Fri,  4 Aug 2023 22:17:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CC7E21B8AE;
 Fri,  4 Aug 2023 22:16:54 +0300 (MSK)
Received: (nullmailer pid 1875763 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 57/63] pci: do not respond config requests after PCI
 device eject
Date: Fri,  4 Aug 2023 22:16:40 +0300
Message-Id: <20230804191647.1875608-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
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

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2224964

In migration with VF failover, Windows guest and ACPI hot
unplug we do not need to satisfy config requests, otherwise
the guest immediately detects the device and brings up its
driver. Many network VF's are stuck on the guest PCI bus after
the migration.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20230728084049.191454-1-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 348e354417b64c484877354ee7cc66f29fa6c7df)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfd185bbb4..7b09847be0 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -62,6 +62,17 @@ static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
     }
 }
 
+static bool is_pci_dev_ejected(PCIDevice *pci_dev)
+{
+    /*
+     * device unplug was requested and the guest acked it,
+     * so we stop responding config accesses even if the
+     * device is not deleted (failover flow)
+     */
+    return pci_dev && pci_dev->partially_hotplugged &&
+           !pci_dev->qdev.pending_deleted_event;
+}
+
 void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
                                   uint32_t limit, uint32_t val, uint32_t len)
 {
@@ -75,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -100,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E603761C55
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJSG-0002V5-0u; Tue, 25 Jul 2023 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS4-0002PU-79; Tue, 25 Jul 2023 10:55:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS2-0000D5-J1; Tue, 25 Jul 2023 10:55:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 40B3E161C5;
 Tue, 25 Jul 2023 17:55:38 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D56A219540;
 Tue, 25 Jul 2023 17:55:35 +0300 (MSK)
Received: (nullmailer pid 3375818 invoked by uid 1000);
 Tue, 25 Jul 2023 14:55:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ani Sinha <anisinha@redhat.com>, mst@redhat.com,
 mjt@tls.msk.ru
Subject: [PULL 7/8] hw/pci: add comment to explain checking for available
 function 0 in pci hotplug
Date: Tue, 25 Jul 2023 17:55:31 +0300
Message-Id: <67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5.1690294956.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690294956.git.mjt@tls.msk.ru>
References: <cover.1690294956.git.mjt@tls.msk.ru>
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

From: Ani Sinha <anisinha@redhat.com>

This change is cosmetic. A comment is added explaining why we need to check for
the availability of function 0 when we hotplug a device.

CC: mst@redhat.com
CC: mjt@tls.msk.ru
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/pci/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 784c02a182..b8d22e2e74 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1183,9 +1183,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
-    } else if (dev->hotplugged &&
-               !pci_is_vf(pci_dev) &&
-               pci_get_function_0(pci_dev)) {
+    } /*
+       * Populating function 0 triggers a scan from the guest that
+       * exposes other non-zero functions. Hence we need to ensure that
+       * function 0 wasn't added yet.
+       */
+    else if (dev->hotplugged &&
+             !pci_is_vf(pci_dev) &&
+             pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
-- 
2.39.2



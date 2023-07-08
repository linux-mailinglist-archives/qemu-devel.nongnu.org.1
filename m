Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7F74BBF5
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:16:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0GE-0006O6-MT; Sat, 08 Jul 2023 01:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fy-0006Fy-Io; Sat, 08 Jul 2023 01:13:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fw-0001kc-P2; Sat, 08 Jul 2023 01:13:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C1DD12683;
 Sat,  8 Jul 2023 08:13:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C6A0E139D1;
 Sat,  8 Jul 2023 08:13:04 +0300 (MSK)
Received: (nullmailer pid 3229988 invoked by uid 1000);
 Sat, 08 Jul 2023 05:13:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 04/10] hw: Simplify calls to pci_nic_init_nofail()
Date: Sat,  8 Jul 2023 08:12:44 +0300
Message-Id: <b697a48924fc1b6ea3b6077f824a2753cfa1b210.1688793073.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1688793073.git.mjt@tls.msk.ru>
References: <cover.1688793073.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

pci_nic_init_nofail() calls qemu_find_nic_model(), and this function
sets nd->model = g_strdup(default_model) if it has not been initialized
yet. So we don't have to set nd->model to the default_nic in the
calling sites.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/arm/sbsa-ref.c        | 8 +-------
 hw/arm/virt.c            | 8 +-------
 hw/loongarch/virt.c      | 8 +-------
 hw/mips/loongson3_virt.c | 8 +-------
 hw/xtensa/virt.c         | 8 +-------
 5 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index c2e0a9fa1a..64e1cbce17 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -689,13 +689,7 @@ static void create_pcie(SBSAMachineState *sms)
     pci = PCI_HOST_BRIDGE(dev);
     if (pci->bus) {
         for (i = 0; i < nb_nics; i++) {
-            NICInfo *nd = &nd_table[i];
-
-            if (!nd->model) {
-                nd->model = g_strdup(mc->default_nic);
-            }
-
-            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+            pci_nic_init_nofail(&nd_table[i], pci->bus, mc->default_nic, NULL);
         }
     }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 796181e169..8a4c663735 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1479,13 +1479,7 @@ static void create_pcie(VirtMachineState *vms)
     vms->bus = pci->bus;
     if (vms->bus) {
         for (i = 0; i < nb_nics; i++) {
-            NICInfo *nd = &nd_table[i];
-
-            if (!nd->model) {
-                nd->model = g_strdup(mc->default_nic);
-            }
-
-            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+            pci_nic_init_nofail(&nd_table[i], pci->bus, mc->default_nic, NULL);
         }
     }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ca8824b6ef..51a453fa9a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -547,13 +547,7 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
 
     /* Network init */
     for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-
-        if (!nd->model) {
-            nd->model = g_strdup(mc->default_nic);
-        }
-
-        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
     }
 
     /*
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 216812f660..3dd91da7a6 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -454,13 +454,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     }
 
     for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-
-        if (!nd->model) {
-            nd->model = g_strdup(mc->default_nic);
-        }
-
-        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
     }
 }
 
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b87f842e74..a6cf646e99 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -103,13 +103,7 @@ static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
     pci = PCI_HOST_BRIDGE(dev);
     if (pci->bus) {
         for (i = 0; i < nb_nics; i++) {
-            NICInfo *nd = &nd_table[i];
-
-            if (!nd->model) {
-                nd->model = g_strdup(mc->default_nic);
-            }
-
-            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+            pci_nic_init_nofail(&nd_table[i], pci->bus, mc->default_nic, NULL);
         }
     }
 }
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07F7426CC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErB8-0001bB-7N; Thu, 29 Jun 2023 08:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qErAt-0001aC-4L
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qErAq-0007AF-Iw
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688043299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+k+EZiPsbqU979sALNTepkIWmx3NZEF8XVlueEy6VNo=;
 b=WhNlice14iVZj9kC0/14pkWnfrVxRLKbH8UPFTbbDD1GoPXF0rEsXvvpN5f26/+6c4cGcS
 kuAWeFEGfiI3ZgJgCvKt7J84+LfpuN6PGooRxryDHzbqmgQ5fhyhv/CGky5mjamfirHbMa
 NmqF4UIcwE7rm2v72isIU7GIeftfq0s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-otZ0DLfkNn6EC3MG7UDMBg-1; Thu, 29 Jun 2023 08:54:54 -0400
X-MC-Unique: otZ0DLfkNn6EC3MG7UDMBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5DE31C09048;
 Thu, 29 Jun 2023 12:54:53 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 956402166B27;
 Thu, 29 Jun 2023 12:54:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] hw: Simplify calls to pci_nic_init_nofail()
Date: Thu, 29 Jun 2023 14:54:49 +0200
Message-Id: <20230629125449.234945-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

pci_nic_init_nofail() calls qemu_find_nic_model(), and this function
sets nd->model = g_strdup(default_model) if it has not been initialized
yet. So we don't have to set nd->model to the default_nic in the
calling sites.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/sbsa-ref.c        | 8 +-------
 hw/arm/virt.c            | 8 +-------
 hw/loongarch/virt.c      | 8 +-------
 hw/mips/loongson3_virt.c | 8 +-------
 hw/xtensa/virt.c         | 8 +-------
 5 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index b774d80291..d8e13ddbfe 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -683,13 +683,7 @@ static void create_pcie(SBSAMachineState *sms)
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
index 3937e30477..b660119bce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1477,13 +1477,7 @@ static void create_pcie(VirtMachineState *vms)
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
2.39.3



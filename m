Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD89088B8
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jun 2024 11:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3dv-0006Gg-JB; Fri, 14 Jun 2024 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dq-0006FI-Eo
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dp-0003bV-2K
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HKnQiklWYaIghTeOtHpxL/kWpViS48zyv9S134mg24=;
 b=CD2JsMW/d7m8MkoZxuhWJZpgEFUdhRF9MAEb2t43H3e7UvhTO3xz8RSknl2tpFLR/38S3a
 LMnM3/yCMjWaOA4F4mDhxsl7fjZRNq7DxvBpctrroJgKXTzrU1t/CVxMQ3bREenfYmuM0o
 urEQ6oCGGGn8WWuf1wPxja9NyMSGK2s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-RrmSGGorNGWiGv8_7QMUsw-1; Fri,
 14 Jun 2024 05:54:35 -0400
X-MC-Unique: RrmSGGorNGWiGv8_7QMUsw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6128F195609E; Fri, 14 Jun 2024 09:54:34 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05446300021A; Fri, 14 Jun 2024 09:54:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v4 4/8] HostIOMMUDevice: Store the aliased bus and devfn
Date: Fri, 14 Jun 2024 11:52:54 +0200
Message-ID: <20240614095402.904691-5-eric.auger@redhat.com>
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
References: <20240614095402.904691-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Store the aliased bus and devfn in the HostIOMMUDevice.
This will be useful to handle info that are iommu group
specific and not device specific (such as reserved
iova ranges).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/sysemu/host_iommu_device.h | 2 ++
 hw/pci/pci.c                       | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 40e0fa13ef..ee6c813c8b 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -35,6 +35,8 @@ struct HostIOMMUDevice {
 
     char *name;
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
+    PCIBus *aliased_bus;
+    int aliased_devfn;
     HostIOMMUDeviceCaps caps;
 };
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c8a8aab306..50b86d5790 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2745,11 +2745,15 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
-    PCIBus *iommu_bus;
+    PCIBus *iommu_bus, *aliased_bus;
+    int aliased_devfn;
 
     /* set_iommu_device requires device's direct BDF instead of aliased BDF */
-    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus,
+                                   &aliased_bus, &aliased_devfn);
     if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
+        hiod->aliased_bus = aliased_bus;
+        hiod->aliased_devfn = aliased_devfn;
         return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
                                                       iommu_bus->iommu_opaque,
                                                       dev->devfn, hiod, errp);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0148300FF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0ul-0002EE-00; Wed, 17 Jan 2024 03:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ0ud-000295-Vi
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:04:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ0ua-00033B-4h
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705478670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3CdxFmDkghBhZU+EeJss4FDl+MilK9UCJU2qsqidD0=;
 b=GpMn11dGBCGUSSfyNwgozyLcno+gmbZkBNF82LdcLwB750dxfFt8Ud4Fjmi8z1CVrpLWCG
 Im0+bDfu/KhooDSKLG31gKP+zHs9160euMOfE7rejnwmLYCLwZRTKXuBSZIoSHanbI0NnE
 itiyb3My8ji8qxYSkPKQPhXn5OtrMTI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-kKPI23l6N-aYcSqG6ds7qQ-1; Wed,
 17 Jan 2024 03:04:27 -0500
X-MC-Unique: kKPI23l6N-aYcSqG6ds7qQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 379383815F8D;
 Wed, 17 Jan 2024 08:04:27 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C666BFFF3;
 Wed, 17 Jan 2024 08:04:24 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, zhenzhong.duan@intel.com, peterx@redhat.com,
 yanghliu@redhat.com, pbonzini@redhat.com
Cc: mst@redhat.com,
	clg@redhat.com
Subject: [RFC 1/7] hw/pci: Introduce PCIIOMMUOps::set_host_iova_regions
Date: Wed, 17 Jan 2024 09:02:05 +0100
Message-ID: <20240117080414.316890-2-eric.auger@redhat.com>
In-Reply-To: <20240117080414.316890-1-eric.auger@redhat.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

This new callback will be used to convey usable IOVA regions
from VFIO-PCI devices to vIOMMUS (esp. virtio-iommu). The advantage
is that this callback can be called very early, once the device has
is known to be protected by a vIOMMU, after the get_address_space()
has been called by the parent device. Current solution to convey
IOVA regions relies on IOMMU MR callbacks but this requires an
IOMMU MR to be connected with the VFIO-PCI device which generally
comes with the enablement of the IOMMU MR (vIOMMU protection activated).
The downside is that is comes pretty late and in case of virtio-iommu,
after the probe.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/pci/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fa6313aabc..63c018b35a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -385,6 +385,21 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number
      */
    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+
+    /**
+     * @set_host_iova_ranges: convey the usable iova ranges for a given device
+     *
+     * Optional callback which returns 0 on success or an error value if any
+     * should be called after @get_address_space()
+     *
+     * @bus: the #PCIBus being accessed.
+     * @opaque: the data passed to pci_setup_iommu().
+     * @devfn: device and function number
+     * @iova_ranges: list of IOVA ranges usable by the device
+     * @errp: error handle
+     */
+   int (*set_host_iova_ranges)(PCIBus *bus, void *opaque, int devfn,
+                               GList *iova_ranges, Error **errp);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
-- 
2.41.0



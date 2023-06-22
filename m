Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6273ABD0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:50:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSBO-0003Bs-Sk; Thu, 22 Jun 2023 17:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBL-0003Bf-Nm
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBK-0007RT-4E
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MGKEE3020601; Thu, 22 Jun 2023 21:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=rWzue+QbNU//80kWBcBr6ZZ15PdalMOP5DaZE9JScdg=;
 b=0HCeSWev/7mhRtQm8ZkcsTatYH/tIDUZT4tKgTZIbMYKiA6p50L0qeu8j7szXdKzEShT
 fjUF7whS+2FgO8RgXwxBuejAjwSRm0aB8yUosC1qTO0pxVjBRAcvizWjxwpfxtnAl4eV
 yLyeFYzTu4dljS5d2rqIMj4esa18+QQ2pswvBWyRtUPb8iG5+t92h3PFJydXrNDEv63D
 AHOSHv+i98AL0z0FbXFw02LBB+pvEm5DDJ7TwaLwXdTVHTzoi0sK6i9ELWOOWCQXh+Wn
 SSr7A98qC6EErWdivhIA2YOasiLu9Qhrb0WcGGWOShQFXSmpnI7fvNk/RNSEMFXuOIqi Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94ettxm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:30 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKIV2s008333; Thu, 22 Jun 2023 21:49:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398epd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn76s035791;
 Thu, 22 Jun 2023 21:49:28 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-5; Thu, 22 Jun 2023 21:49:28 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 04/15] intel-iommu: Switch to pci_setup_iommu_ops()
Date: Thu, 22 Jun 2023 22:48:34 +0100
Message-Id: <20230622214845.3980-5-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: 8NiyYnk7YI-CgUdrWTNPM6zF65L-PwD7
X-Proofpoint-ORIG-GUID: 8NiyYnk7YI-CgUdrWTNPM6zF65L-PwD7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Use the PCI IOMMU setup function that supply a PCIIOMMUOps
argument. This is in preparation to support fetching vIOMMU
information via pci_device_get_iommu_attr() which will require
switching the driver to pci_setup_iommu_ops().

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
[joao: Split from the original patch]
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Splitted from:
https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/#Z2e.:20210302203827.437645-5-yi.l.liu::40intel.com:1hw:i386:intel_iommu.c
---
 hw/i386/intel_iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94d52f4205d2..1606d1b952d0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4032,6 +4032,10 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static PCIIOMMUOps vtd_iommu_ops = {
+    .get_address_space = vtd_host_dma_iommu,
+};
+
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -4155,7 +4159,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                       g_free, g_free);
     vtd_init(s);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
-    pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
+    pci_setup_iommu_ops(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
-- 
2.17.2



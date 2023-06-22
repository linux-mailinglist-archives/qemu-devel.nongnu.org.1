Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E658273ABCE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSBc-0003Fl-8j; Thu, 22 Jun 2023 17:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBa-0003FW-FA
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBZ-0007Ua-0f
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:50 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MIIq8O005803; Thu, 22 Jun 2023 21:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Po/ra4dh07FrZr1NNp3KpZMu9aR7qsmzh97ErMcsxjQ=;
 b=oQ8UoLeq+7hFBmk6fgDh6YJpvQnoXvLY0aywHxv1BmfWuAi+KQcnhv/sRDn33gi22WNo
 R8G/cX4k+hcyw7YGnt7uH5zcAx3k0KzPfn9BlSoPRHQhL/5LhKCVDSD9W+J+IADW3Dl2
 pPvIMbz+TOPhrvR8l8KoHjO+b+5hLL9nRktmQhxHbl1tDGsKPTZD4rEFCyHIxma9EtV4
 viILI/hCPxPAEVonxdeEdWuvEXg1AooIR37NkIiTqtzjsrBP3RfTjOxRS9OY5kPYq9Ta
 f8TPuumi3jJixirW3STttzcwYsnN3tLFnpI53lDz1JB4t4TDGme7+aAExJo0hVMxEg8u Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcu0q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKol2V008185; Thu, 22 Jun 2023 21:49:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398epkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn772035791;
 Thu, 22 Jun 2023 21:49:45 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-9; Thu, 22 Jun 2023 21:49:44 +0000
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
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 08/15] vfio/common: Relax vIOMMU detection when DMA
 translation is off
Date: Thu, 22 Jun 2023 22:48:38 +0100
Message-Id: <20230622214845.3980-9-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=882
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: rqWZzmVIHrM4k1sBkTWEexyoA7cpoQBa
X-Proofpoint-ORIG-GUID: rqWZzmVIHrM4k1sBkTWEexyoA7cpoQBa
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

Relax the vIOMMU migration blocker when the underlying IOMMU reports DMA
translation disabled. When it is disabled there will be no DMA mappings
via the vIOMMU and the guest can only use it for Interrupt Remapping.

The latter is done via vfio_viommu_preset() return value where in
addition to validating that the address space is memory, we also check
whether the vIOMMU backing the PCI device has DMA translation on. It
is assumed to be enabled, if the IOMMU model does not support toggling
on/off the dma-translation property.

Intel IOMMU right now is the only case supporting, although AMD IOMMU
can in theory provide the same functionality.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fa8fd949b1cf..17c1d882e221 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -419,7 +419,8 @@ static bool vfio_viommu_preset(void)
     VFIOAddressSpace *space;
 
     QLIST_FOREACH(space, &vfio_address_spaces, list) {
-        if (space->as != &address_space_memory) {
+        if ((space->as != &address_space_memory) &&
+            !space->no_dma_translation) {
             return true;
         }
     }
-- 
2.17.2



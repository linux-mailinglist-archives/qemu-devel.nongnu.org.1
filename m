Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5A710B51
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29Nw-00044V-7r; Thu, 25 May 2023 07:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q29Nh-00043e-Sw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:43:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q29Ng-0004B5-20
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:43:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PBfYtV032063; Thu, 25 May 2023 11:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=s9wYIVY7XZMUjjFLaqUN3mf5mMn69t8r517bYVE4i+g=;
 b=0Lp1KdsjLejY5rlyGabn50bxJx1ndUGFFF5bpGavuqs/jJyMjMGSryvLCb0Ibulm1Whn
 Bn++T0AjeMRxynuqf5wzl67nAhQJFMzy/RFsRX4SEsLyzjpMc6tiwlS5nV0vsGQ25/a4
 8lfPo2f196CdH/ZxslcXesbHYx7Ti7tESIpwbyCa9bgHGu/448UiodzONQ3M2Oe7zxdm
 2ahp209+EG6oaSNe/3J13Q0fPr2B6g3zR2q3ubXRGKbX7R1MbXV+5tChxoSvdtPjl6ry
 gnBtpyEV8MCIXCV+IWH1qFXt2jysRbRneU3Ol/YSMojJjinqGKsXb2AwKjOceWxacE8m EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt712804d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 11:43:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34PBdrZO027217; Thu, 25 May 2023 11:43:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2g84j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 11:43:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBe13D020951;
 Thu, 25 May 2023 11:43:33 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-196-224.vpn.oracle.com
 [10.175.196.224])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qqk2g84e8-1; Thu, 25 May 2023 11:43:33 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Date: Thu, 25 May 2023 12:43:19 +0100
Message-Id: <20230525114321.71066-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=434 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250098
X-Proofpoint-ORIG-GUID: RIPkQexJfnbDeoBlVOxUPmplIEACPeV0
X-Proofpoint-GUID: RIPkQexJfnbDeoBlVOxUPmplIEACPeV0
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hey,

This tiny series changes the tracepoint to include the number of
dirty pages via the vfio_get_dirty_bitmap. I find it useful for
observability in general to understand the number of dirty pages in an
IOVA range. With dirty tracking supported by device or IOMMU it's specially
relevant data to include in the tracepoint.

First patch changes the return value to be the number of dirty pages in
the helper function setting dirty bits and the second patch expands the
VFIO tracepoint to include the dirty pages.

Thanks,
	Joao

Changes since v1[1]:
* Make the nr of dirty pages a retval similar to sync variant of helper in
  patch 1 (Cedric)
* Stash number of bits set in bitmap quad in a variable and reuse in
  GLOBAL_DIRTY_RATE in patch 1
* Drop init to 0 given that we always initialize the @dirty used in the
  tracepoint

[1] https://lore.kernel.org/qemu-devel/20230523151217.46427-1-joao.m.martins@oracle.com/

Joao Martins (2):
  exec/ram_addr: return nr of dirty pages in cpu_physical_memory_set_dirty_lebitmap()
  hw/vfio: Add nr of dirty pages to vfio_get_dirty_bitmap tracepoint

 hw/vfio/common.c        |  7 ++++---
 hw/vfio/trace-events    |  2 +-
 include/exec/ram_addr.h | 21 +++++++++++++++------
 3 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.31.1



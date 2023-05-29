Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DC6714924
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bj4-0006wZ-U1; Mon, 29 May 2023 08:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3bj2-0006wJ-Ow
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:11:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3bj1-0003NU-1O
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:11:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34T7TPYi001562; Mon, 29 May 2023 12:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=ME+ZCyHDyTd+F6ShA4KXAcDUSpPCFVBSbe7VJDoNrHo=;
 b=apEGOUM/T55A6zYbXSPurPUfaP2cuci4bZIrFjybgwGSnVr4FartSc1vfy+yaSQmBQK+
 cwXJG+fS5R8ZmkVgmUKsADUm1LGviWfdoqZZ7GuX4+kO8wKzQI+OWVBe5rhU05cQ9rld
 453KXJuqv+LmjkyZCO1hG259VT0f6NVrpiM0Py1hRp7oUo46w5KwDybo7TREEVNKk1qk
 Q/HlU33y9GWQN8T6aEHqqZuHeyVJ/xYmWYidFR6bmgYQvT0LZQiZt9YgwuS/+Ab83lOc
 3URc3IqLBBdWZB5V6a3OiiEL8umCdnXYMtMSkCe6bxRr2jkNDHHZmF17QmjOL5ujWaNg 5A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjgtuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 May 2023 12:11:33 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34TAUPdD026028; Mon, 29 May 2023 12:11:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a92m7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 May 2023 12:11:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34TCBVLO038099;
 Mon, 29 May 2023 12:11:31 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-183-111.vpn.oracle.com
 [10.175.183.111])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a92m66-1; Mon, 29 May 2023 12:11:31 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Date: Mon, 29 May 2023 13:11:12 +0100
Message-Id: <20230529121114.5038-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=477 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290105
X-Proofpoint-ORIG-GUID: 0ftVtcANiW7IibF2hUhO5zZLUuKS0vRM
X-Proofpoint-GUID: 0ftVtcANiW7IibF2hUhO5zZLUuKS0vRM
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

Changes since v2[2]:
* Add a comment explaining the difference of retval between
cpu_physical_memory_set_dirty_lebitmap() and
cpu_physical_memory_sync_dirty_bitmap() (Peter Xu)
* Add Peter's Reviewed-by;
* Rename dirty variable into dirty_pages (Philippe Mathieu-Daude)

Changes since v1[1]:
* Make the nr of dirty pages a retval similar to sync variant of helper in
  patch 1 (Cedric)
* Stash number of bits set in bitmap quad in a variable and reuse in
  GLOBAL_DIRTY_RATE in patch 1
* Drop init to 0 given that we always initialize the @dirty used in the
  tracepoint

[1] https://lore.kernel.org/qemu-devel/20230523151217.46427-1-joao.m.martins@oracle.com/
[2] https://lore.kernel.org/qemu-devel/20230525114321.71066-1-joao.m.martins@oracle.com/

Joao Martins (2):
  exec/ram_addr: return nr of dirty pages in
    cpu_physical_memory_set_dirty_lebitmap()
  hw/vfio: Add nr of dirty pages to vfio_get_dirty_bitmap tracepoint

 hw/vfio/common.c        |  7 ++++---
 hw/vfio/trace-events    |  2 +-
 include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.39.3



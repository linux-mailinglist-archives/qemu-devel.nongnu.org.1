Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC431716BE9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43jl-00073O-EN; Tue, 30 May 2023 14:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43jh-0006wo-Fd
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:06:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43jf-0004Bh-D1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:06:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4uMA016912; Tue, 30 May 2023 18:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=he+CfFVQfZAerK61sIfBxAT4ZtI/gXCLqR+RUb/52Ec=;
 b=nGTdc29+UuBObztNky2UNJFzrZMPixfrEDjXVQXgfc7V9IOK57zyGWm5Gcs/g30BqHoD
 DhGG6fdrd9BibuqEypml3Ks6qfefkVkUBD41tZ7V4i5YWEq/nZnktndO3Lv2KDHT99I8
 KsbRxvLO3WGDKSp1J3KC7ZwG9zwRTyaGSuNA8dsBFUQx/nfwcuLqRM0OoG3DdfDpKmQr
 7LwXghWQ4lziJkz0ytAZocgcmEOXphjmU3/4dWAXIoZP7EAxmnaTD1Mt4FcM4PfKV1U4
 tyeaKB5WyTSnAcGwJOu1OWFpv8M1Dyn7KUtCUFfh6GRCj/CTCuXE5+eAFGFDH0gEdMji qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkkfab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:06:13 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UGjEpk014654; Tue, 30 May 2023 18:06:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a494sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:06:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UI6CbC036891;
 Tue, 30 May 2023 18:06:12 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a494ny-1; Tue, 30 May 2023 18:06:12 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Date: Tue, 30 May 2023 19:05:54 +0100
Message-Id: <20230530180556.24441-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=481 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-ORIG-GUID: WZ-6020e_6P2PZpgdmIgLWpf3g9Kb9Z8
X-Proofpoint-GUID: WZ-6020e_6P2PZpgdmIgLWpf3g9Kb9Z8
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

Changes since v3[3]:
* s/nr/number in patches subject line (Avihai)
* s/cpu_physical_memory_set_lebitmap()/cpu_physical_memory_set_dirty_lebitmap() (Avihai)
* Add Reviewed-by's from Phillipe and Cedric

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
[3] https://lore.kernel.org/qemu-devel/20230529121114.5038-1-joao.m.martins@oracle.com/

Joao Martins (2):
  exec/ram_addr: return number of dirty pages in
    cpu_physical_memory_set_dirty_lebitmap()
  hw/vfio: Add number of dirty pages to vfio_get_dirty_bitmap tracepoint

 hw/vfio/common.c        |  7 ++++---
 hw/vfio/trace-events    |  2 +-
 include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F870E0EE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:49:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Th5-0007iB-Kc; Tue, 23 May 2023 11:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q1Tgv-0007ZI-8d
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:12:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q1Tgk-0005t8-4J
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:12:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NEn3Cx030152; Tue, 23 May 2023 15:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=S1lf9CUCeTZuo5PMvkXvh8UEC316T3mEmHir6R7b2Tw=;
 b=P/QcC2vQjhoKxoqNmCIVOo1QgwnQog2FpRyLqshFCKroeV4XHYY149HADNEDoz+FLJd+
 VDstC+9Uz538pWmLwMaNX/KjR4c7GY1lntNtU/0LGhio6XI+UZ0b7tHpgt11nKAkeeKl
 aG4MaGiqs1GF6XhNhvc3PJMv8W4od+ax9l7/iMlUjgFYnswWO23JuFxRoVlbUOcS2jSB
 dIQqqBYQB2WxmNQh5bTL9Zqw21tll/Goq2mvPX2f4SnjZyQgUfoOCG+UI+PhJKeZg20M
 /vCQPH7BDH5ZMjh5WZV3aFqU9dGgtwrEsZzLIjPpE2rQGbixvk6Gbubw2apcviIltvbx SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44nan0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 15:12:33 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34NEgLNi029086; Tue, 23 May 2023 15:12:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2aymmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 15:12:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NFA183023564;
 Tue, 23 May 2023 15:12:31 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-217-116.vpn.oracle.com
 [10.175.217.116])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qqk2aymhr-1; Tue, 23 May 2023 15:12:31 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v1 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Date: Tue, 23 May 2023 16:12:15 +0100
Message-Id: <20230523151217.46427-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=247 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230119
X-Proofpoint-GUID: E0TskdppfXuur2Hq5EFoWGKQpeKd-pg0
X-Proofpoint-ORIG-GUID: E0TskdppfXuur2Hq5EFoWGKQpeKd-pg0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

First patch includes the dirty argument in the helper function setting
dirty bits and the second patch just expands the tracepoint to include
the dirty pages.

Thanks,
	Joao

[1] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/#r

Joao Martins (2):
  exec/ram_addr: add dirty arg to cpu_physical_memory_set_dirty_lebitmap()
  hw/vfio: Add nr of dirty pages to vfio_get_dirty_bitmap tracepoint

 accel/kvm/kvm-all.c     |  2 +-
 hw/vfio/common.c        |  7 ++++---
 hw/vfio/trace-events    |  2 +-
 include/exec/ram_addr.h | 10 +++++++++-
 4 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.31.1



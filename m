Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C675C140
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMlL3-00049y-QF; Fri, 21 Jul 2023 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme-s1.oci.oracle.com>)
 id 1qMlKw-00049P-Ep; Fri, 21 Jul 2023 04:18:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme-s1.oci.oracle.com>)
 id 1qMlKr-0003DC-UZ; Fri, 21 Jul 2023 04:18:06 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36L2XOOP009409; Fri, 21 Jul 2023 07:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=7ldPS9mlB2G1ZziMdDq2qLjr0oRiAJC3Hkd/SR5u3ws=;
 b=uNm3gwmJ0uI9hmWACkX/91WyZyQg0Za8Eunv2L8Qb0O7PtylSm7+7t1RYHNDIANKoHPb
 hABSTi3yz9saCiV4sZHsdGiTyWlNgmgiULzus4pCZOp5kXNjfnsWolSttX8YXAkde2pz
 QCqyNJpKtugxIeQwBGlM+sLBsH/qmEHE4eAV0voJLvU7rDpRLk3bpZeQWmQmYYnPb3j3
 gF9wiwQnHW+Nu2ilspDqMddySw0WjBk8k3K7BCGd2HcSe1fbPgyq9LtKnlEbwkCnI+72
 7afHk8/yqnH/xCMlV64AtJEbjaijOlsCbGNllRsZQnd7S4J9n/FZZiqUHzPqVvHThzoH Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8abe4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 07:28:26 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36L5fvhF017370; Fri, 21 Jul 2023 07:28:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw9n4eb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Jul 2023 07:28:25 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36L7O58O013680;
 Fri, 21 Jul 2023 07:28:24 GMT
Received: from dme-s1.osdevelopm1lhr.oraclevcn.com
 (dme-s1.allregionallhrs.osdevelopm1lhr.oraclevcn.com [100.110.7.39])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw9n4dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Jul 2023 07:28:24 +0000
Received: by dme-s1.osdevelopm1lhr.oraclevcn.com (Postfix, from userid 30000)
 id 37295BF30C; Fri, 21 Jul 2023 07:28:20 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>
Subject: [PATCH] hw/virtio: qmp: add RING_RESET to 'info virtio-status'
Date: Fri, 21 Jul 2023 08:28:20 +0100
Message-Id: <20230721072820.75797-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210066
X-Proofpoint-GUID: ZOC0FvxNChhZNMo0ztw9nXkRAu6-lQoa
X-Proofpoint-ORIG-GUID: ZOC0FvxNChhZNMo0ztw9nXkRAu6-lQoa
Received-SPF: none client-ip=205.220.165.32;
 envelope-from=dme@dme-s1.oci.oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 hw/virtio/virtio-qmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3d32dbec8d..7515b0947b 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -79,6 +79,8 @@ static const qmp_virtio_feature_map_t virtio_transport_map[] = {
             "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
     FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
             "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
+    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
+            "VIRTIO_F_RING_RESET: Driver can reset a queue individually"),
     /* Virtio ring transport features */
     FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
             "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
-- 
2.34.1



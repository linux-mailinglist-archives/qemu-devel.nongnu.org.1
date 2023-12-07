Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB88090D2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:57:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSM-0003aE-BG; Thu, 07 Dec 2023 13:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSA-0003XC-JC
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS8-0006p2-RW
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:30 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7HFTxO007979; Thu, 7 Dec 2023 18:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=twV6mGc+nRkfELdaEpOqp368u6C8dpOt4AY5JIu7iLY=;
 b=lstrWVEIEgBeg9R9/CfuziQOw5skbokGBSRzp6tkt0MkomJH3hJent7GA78cNjrkFTC0
 +9M5YNkmdMT25HemCfRzozvFueeXwM2Ss4jLofSFY83IG4g0+c0Q31Z0BrEpuRYwQ6JR
 9/jdtFyIfW39tIxwJXH4LbZUjgcFl0qKjdGx0y1jqEpD9Rl2KA3MryUn+qV+gtzd24gx
 dGgT+ETovTckEKbaEoIFTBkr5wQMu58fzjQV+kOvsclRNSlUwiZlaWhOjJ8naahbok+z
 MucjJXsEK/Q94zkvb7+yHy3ahWLbG5FEkroGJS/jKmV5gaYrHKIyoH+ZZbRDndpVOFbK Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hmjt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:25 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HhN4P039752; Thu, 7 Dec 2023 18:50:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90A008067;
 Thu, 7 Dec 2023 18:50:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-10; Thu, 07 Dec 2023 18:50:24 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 09/40] vdpa: no repeat setting shadow_data
Date: Thu,  7 Dec 2023 09:39:22 -0800
Message-Id: <1701970793-6865-10-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=947
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-GUID: cHp_8aKC8Y4Ixecv0cnkyEkjc74aR3XW
X-Proofpoint-ORIG-GUID: cHp_8aKC8Y4Ixecv0cnkyEkjc74aR3XW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Since shadow_data is now shared in the parent data struct, it
just needs to be set only once by the first vq. This change
will make shadow_data independent of svq enabled state, which
can be optionally turned off when SVQ descritors and device
driver areas are all isolated to a separate address space.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c9bfc6f..2555897 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -387,13 +387,12 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     if (s->always_svq ||
         migration_is_setup_or_active(migrate_get_current()->state)) {
         v->shadow_vqs_enabled = true;
-        v->shared->shadow_data = true;
     } else {
         v->shadow_vqs_enabled = false;
-        v->shared->shadow_data = false;
     }
 
     if (v->index == 0) {
+        v->shared->shadow_data = v->shadow_vqs_enabled;
         vhost_vdpa_net_data_start_first(s);
         return 0;
     }
-- 
1.8.3.1



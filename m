Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500A2809091
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSC-0003X9-Io; Thu, 07 Dec 2023 13:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJRy-0003TS-Vb
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJRx-0006Lr-Cu
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:18 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7FDI5Y009711; Thu, 7 Dec 2023 18:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=TrIoq3vUpKqQshngqQYAQZZona36DrqAj6vqchuF/wo=;
 b=KL3i9z0Dolluz6H13ajkTJhmcAgaEmtrjZFMPQzJzaxyzaOtvFTZEF4oV30RBXq2bvMo
 I+wbYkbNaDj4KmWLxX5iu5eTf1AdwPyJ3q3FC31JJlCb0rm3+Y0YUg/96TgixKHo/0Hi
 6HMP4H4+TRBCR1j0CrnkVMcQkUxj7TEv4Jn9BZ8luT83B4VXTTMuugynaDYsuleSnaAg
 lCGGxmq4VfeA9oICx9hKUlyShQqtEDOiSxRNSQjlEQW0zJj6LleQN/3xOqCvgJbFfJ/X
 lenWTV2Sa0Anp3EQTBeRAb8fdlaQCITHo1LD/6f/EbXDB6SA2HdGABqknmVLMAg0+nJe 5Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvmpev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:14 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7IUvxb039487; Thu, 7 Dec 2023 18:50:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vh5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io9xu008067;
 Thu, 7 Dec 2023 18:50:12 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-3; Thu, 07 Dec 2023 18:50:12 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 02/40] vdpa: add vhost_vdpa_get_vring_desc_group
Date: Thu,  7 Dec 2023 09:39:15 -0800
Message-Id: <1701970793-6865-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-GUID: bmLNHMZTQo4Ac7POoz9aONmEpHuNHn7K
X-Proofpoint-ORIG-GUID: bmLNHMZTQo4Ac7POoz9aONmEpHuNHn7K
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Internal API to get the descriptor group index for a specific virtqueue
through the VHOST_VDPA_GET_VRING_DESC_GROUP ioctl.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 90f4128..887c329 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -471,6 +471,25 @@ static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
     return state.num;
 }
 
+static int64_t vhost_vdpa_get_vring_desc_group(int device_fd,
+                                               unsigned vq_index,
+                                               Error **errp)
+{
+    struct vhost_vring_state state = {
+        .index = vq_index,
+    };
+    int r = ioctl(device_fd, VHOST_VDPA_GET_VRING_DESC_GROUP, &state);
+
+    if (unlikely(r < 0)) {
+        r = -errno;
+        error_setg_errno(errp, errno, "Cannot get VQ %u descriptor group",
+                         vq_index);
+        return r;
+    }
+
+    return state.num;
+}
+
 static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
                                            unsigned vq_group,
                                            unsigned asid_num)
-- 
1.8.3.1



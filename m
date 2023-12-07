Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AD80909A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:52:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSJ-0003Ys-Gw; Thu, 07 Dec 2023 13:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS6-0003U7-JB
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS0-0006Xt-DC
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7InWTp000621; Thu, 7 Dec 2023 18:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=BqSj62+diHUsR87x+1wTb6AuDlUE/ZCVpHyqeDC2E4E=;
 b=Ii27jVM2QxmN8r8GV7zmQ12Y8VH6dWmxM+ZrDYAqjRRu+pqkSCmNwW/51VVUhd8AMY2O
 akMycakkvLA9FdZDlF7gxZuwPZQ5f/KjsWJWcRvcNK4nDtr8V6YLvVeU97dnR/UNLvJ/
 LEUpMP6Tm+utEAd9jhtKPCPZCs4PcE8q1N2meerF9IXkMkDJLoFhr92+z030uVv7GZ45
 noRG091o6W5YU91bVyvVO9yY4OqTXX7pZxP5nUAllDpZxMSCW6vaRpzt1gLbWgolc2aH
 NipgGh76FloBYs2164BOY8jIVkMmPIUzzgHCAVvInJItLfZ6FGt59Ey1DND9c7TqB8Lr 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mmh4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:16 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7IltKg039527; Thu, 7 Dec 2023 18:50:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vh7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io9xw008067;
 Thu, 7 Dec 2023 18:50:15 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-4; Thu, 07 Dec 2023 18:50:15 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 03/40] vdpa: probe descriptor group index for data vqs
Date: Thu,  7 Dec 2023 09:39:16 -0800
Message-Id: <1701970793-6865-4-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: sr7q8q4OSq04SprcZhsiDUxgdZbDOoRP
X-Proofpoint-ORIG-GUID: sr7q8q4OSq04SprcZhsiDUxgdZbDOoRP
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

Getting it ahead at initialization time instead of start time allows
decision making independent of device status, while reducing failure
possibility in starting device or during migration.

Adding function vhost_vdpa_probe_desc_group() for that end. This
function will be used to probe the descriptor group for data vqs.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 887c329..0cf3147 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1688,6 +1688,95 @@ out:
     return r;
 }
 
+static int vhost_vdpa_probe_desc_group(int device_fd, uint64_t features,
+                                       int vq_index, int64_t *desc_grpidx,
+                                       Error **errp)
+{
+    uint64_t backend_features;
+    int64_t vq_group, desc_group;
+    uint8_t saved_status = 0;
+    uint8_t status = 0;
+    int r;
+
+    ERRP_GUARD();
+
+    r = ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features);
+    if (unlikely(r < 0)) {
+        error_setg_errno(errp, errno, "Cannot get vdpa backend_features");
+        return r;
+    }
+
+    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
+        return 0;
+    }
+
+    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID))) {
+        return 0;
+    }
+
+    r = ioctl(device_fd, VHOST_VDPA_GET_STATUS, &saved_status);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot get device status");
+        goto out;
+    }
+
+    r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot reset device");
+        goto out;
+    }
+
+    r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
+    if (unlikely(r)) {
+        error_setg_errno(errp, errno, "Cannot set features");
+    }
+
+    status = VIRTIO_CONFIG_S_ACKNOWLEDGE |
+             VIRTIO_CONFIG_S_DRIVER |
+             VIRTIO_CONFIG_S_FEATURES_OK;
+
+    r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot set device status");
+        goto out;
+    }
+
+    vq_group = vhost_vdpa_get_vring_group(device_fd, vq_index, errp);
+    if (unlikely(vq_group < 0)) {
+        if (vq_group != -ENOTSUP) {
+            r = vq_group;
+            goto out;
+        }
+
+        /*
+         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa frontend
+         * support ASID even if the parent driver does not.
+         */
+        error_free(*errp);
+        *errp = NULL;
+        r = 0;
+        goto out;
+    }
+
+    desc_group = vhost_vdpa_get_vring_desc_group(device_fd, vq_index,
+                                                 errp);
+    if (unlikely(desc_group < 0)) {
+        r = desc_group;
+        goto out;
+    } else if (desc_group != vq_group) {
+        *desc_grpidx = desc_group;
+    }
+    r = 1;
+
+out:
+    status = 0;
+    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    if (saved_status) {
+        ioctl(device_fd, VHOST_VDPA_SET_STATUS, &saved_status);
+    }
+    return r;
+}
+
 static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        const char *device,
                                        const char *name,
-- 
1.8.3.1



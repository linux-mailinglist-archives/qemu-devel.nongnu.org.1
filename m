Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C0809094
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSJ-0003ZM-RV; Thu, 07 Dec 2023 13:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS6-0003U8-J2
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS1-0006bb-Jd
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7EtISZ017262; Thu, 7 Dec 2023 18:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=VXUEwdiXIGYALuEd5KfW5mDWOK4SrCBkiWVuRQsjMa4=;
 b=QgvsHVMwQspdOf1YmV914EB0wo3+2FbdlN4orY7UmijBuCCAyc6/vkAitd1pllzL1xRE
 dEXeM0dXqds0nD8vif6fPLhiKhnkUDQ5tfMxRtJx7Ypz8X+GRql8eiuE27Y4mFLf9T97
 NYl9RoRclTFIWdk1h9peOZUD0HOl3c5/uncZlFiwR/BDSzzcOCkea0NsFFMNte0pXWgN
 njc61K/SuDFuWWck+2Xl6UXR09YCtOyOAMCy/PfnxhGNCX97ACPBTnL2k/efLzEP7MJ8
 rn3xfQW6GWbmwY/SFFfycvP+g/DEvZioMz1y4tHnJBYUFmeFVu5dBiUHwhC8kggMtZSz Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvmpf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:20 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7Hb9ff039324; Thu, 7 Dec 2023 18:50:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io902008067;
 Thu, 7 Dec 2023 18:50:18 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-6; Thu, 07 Dec 2023 18:50:18 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 05/40] vdpa: populate desc_group from net_vhost_vdpa_init
Date: Thu,  7 Dec 2023 09:39:18 -0800
Message-Id: <1701970793-6865-6-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: xUPjONcvcF8ZQ082lNdJc9WCRsW0WXh5
X-Proofpoint-ORIG-GUID: xUPjONcvcF8ZQ082lNdJc9WCRsW0WXh5
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

Add the desc_group field to struct vhost_vdpa, and get it
populated when the corresponding vq is initialized at
net_vhost_vdpa_init. If the vq does not have descriptor
group capability, or it doesn't have a dedicated ASID
group to host descriptors other than the data buffers,
desc_group will be set to a negative value -1.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/hw/virtio/vhost-vdpa.h |  1 +
 net/vhost-vdpa.c               | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 6533ad2..63493ff 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -87,6 +87,7 @@ typedef struct vhost_vdpa {
     Error *migration_blocker;
     VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
     IOMMUNotifier n;
+    int64_t desc_group;
 } VhostVDPA;
 
 int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index cb5705d..1a738b2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1855,11 +1855,22 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
 
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
-        qemu_del_net_client(nc);
-        return NULL;
+        goto err;
     }
 
+    if (is_datapath) {
+        ret = vhost_vdpa_probe_desc_group(vdpa_device_fd, features,
+                                          0, &desc_group, errp);
+        if (unlikely(ret < 0)) {
+            goto err;
+        }
+    }
+    s->vhost_vdpa.desc_group = desc_group;
     return nc;
+
+err:
+    qemu_del_net_client(nc);
+    return NULL;
 }
 
 static int vhost_vdpa_get_features(int fd, uint64_t *features, Error **errp)
-- 
1.8.3.1



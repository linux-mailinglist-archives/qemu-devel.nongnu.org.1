Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D18090C9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:56:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJT5-00049C-HN; Thu, 07 Dec 2023 13:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJT2-00047b-NL
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSt-0007E1-Io
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:24 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7F2dui022096; Thu, 7 Dec 2023 18:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=BU8+O9Al6PiQ7o7HvWw6WPaWNTW+Fg1nkZ5IYUEQFOo=;
 b=CvlGWxjIDOIjN2ywMyRPU7+vQ8N1ExZVEWz1IM9IKMx3yNBPpxKVNQFSPpy4o19NMDH8
 pDz32v2tOEQkJw86TmzMGym6tiKLQE+fkbgJvI/BPrqAQ53W89as5DVooglwBavdpwQH
 wZfUO5qMl7ZMRG4X8LcQpsU+C7q1eXxyG9vLO4C35e423o9HLzHJcTH4K8FZyPpp6JVZ
 xTBjQ1cPSkE5TY8mt7+Gjb1uEBT1DCQQ1MLwZV4UI+TPJvpDmNmkY/Yi57YClq9D5R7w
 7PRwnH0SizCRZbyWA2QYxPlTHv0s2qQzt2A90sVjc87bfTtETbQeSHB/tfk0iTXnU49z 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1gcsjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:03 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7InXqE039476; Thu, 7 Dec 2023 18:51:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vjed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io912008067;
 Thu, 7 Dec 2023 18:51:02 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-36; Thu, 07 Dec 2023 18:51:01 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 35/40] vdpa: add vhost_vdpa_set_address_space_id trace
Date: Thu,  7 Dec 2023 09:39:48 -0800
Message-Id: <1701970793-6865-36-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: 3hQOZX71Ea9Xuw3Xdpmb4Z3JMnSrwyOC
X-Proofpoint-GUID: 3hQOZX71Ea9Xuw3Xdpmb4Z3JMnSrwyOC
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

For better debuggability and observability.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/trace-events | 3 +++
 net/vhost-vdpa.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/trace-events b/net/trace-events
index 823a071..aab666a 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -23,3 +23,6 @@ colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, in
 # filter-rewriter.c
 colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=0x%x"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
+
+# vhost-vdpa.c
+vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 41714d1..84876b0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -30,6 +30,7 @@
 #include "migration/misc.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-vdpa.h"
+#include "trace.h"
 
 /* Todo:need to add the multiqueue support here */
 typedef struct VhostVDPAState {
@@ -365,6 +366,8 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
     };
     int r;
 
+    trace_vhost_vdpa_set_address_space_id(v, vq_group, asid_num);
+
     r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
     if (unlikely(r < 0)) {
         error_report("Can't set vq group %u asid %u, errno=%d (%s)",
-- 
1.8.3.1



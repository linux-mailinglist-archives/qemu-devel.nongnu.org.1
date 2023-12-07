Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C328090C2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:56:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJTL-0004lC-5X; Thu, 07 Dec 2023 13:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJT7-0004NR-9C
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSz-0007Et-5a
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7EtISd017262; Thu, 7 Dec 2023 18:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=WPm5hA3Uu3KbbEN+UqK0pesOU6z6VRZ/RI9BjPTbiq4=;
 b=ZvacEikrNP3nqMuDWQTOwPIW6uSC69dshZ2cDM48Fyb232n5t3y35ZuvaSd0vmuwFjZQ
 RSrvuBwTjBHaTPlBVt31HKBQle4smP6JDCNW30eYypW3USljaW5TrTQSX/Nx9Dj5Dn/8
 X+pj//L+/onGBf+3jwToLLRsDQroiqhmAqCsNLoMq3J0y/tg9tcjKng88RfqfIUExKqx
 1qRntUZwhLgxugIaA6cZIbSwi5pdobWKTE6Wu/5OjsaiIzqsxI0KI6YazrBMLFYMiD5z
 mSX5lUFBmjoFbeEYPYGuNDsBO5Sf/gSo8AkmvvHEC8fJKPYTCQVZqDJD70vslVj8rKxz XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvmpgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:09 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7Hb9IL039550; Thu, 7 Dec 2023 18:51:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vjht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io91A008067;
 Thu, 7 Dec 2023 18:51:08 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-40; Thu, 07 Dec 2023 18:51:08 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 39/40] vdpa: add trace events for vhost_vdpa_net_load_cmd
Date: Thu,  7 Dec 2023 09:39:52 -0800
Message-Id: <1701970793-6865-40-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: SfR0iKqbb0YA5_4aNqhfmt3kn_yoD1WP
X-Proofpoint-ORIG-GUID: SfR0iKqbb0YA5_4aNqhfmt3kn_yoD1WP
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
 net/trace-events | 2 ++
 net/vhost-vdpa.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/trace-events b/net/trace-events
index d650c71..be087e6 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -28,3 +28,5 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
 vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
 vhost_vdpa_net_data_eval_flush(void *s, int qindex, int svq_switch, bool svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
 vhost_vdpa_net_cvq_eval_flush(void *s, int qindex, int svq_switch, bool svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
+vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
+vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a0bd8cd..61da8b4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -885,6 +885,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
     cmd_size = sizeof(ctrl) + data_size;
+    trace_vhost_vdpa_net_load_cmd(s, class, cmd, data_num, data_size);
     if (vhost_svq_available_slots(svq) < 2 ||
         iov_size(out_cursor, 1) < cmd_size) {
         /*
@@ -916,6 +917,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
 
     r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
     if (unlikely(r < 0)) {
+        trace_vhost_vdpa_net_load_cmd_retval(s, class, cmd, r);
         return r;
     }
 
-- 
1.8.3.1



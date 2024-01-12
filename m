Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693782C280
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6i-0001bd-7F; Fri, 12 Jan 2024 10:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ6C-00011E-04
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ63-0003Zq-CX
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:29 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEbQUm031070; Fri, 12 Jan 2024 15:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=X2IzaakZ/vHct/Fb0wTIrTI5L2v2n1dUrtaOz68TNxU=;
 b=OEY2JiRS9sGXjeEjZrmWXpuFiku8W1qTpYcU5kt/CAakAG8vZBlUzv8ayxY+Ia2ZwxTN
 cuwHhBSRLMkzJlo9EBs1cK/FD8KlvRhzvEtsEaxlw1ZFUZ6qryU39SgUVMCIXpEk+EzP
 LT51IPLXgWSqyuJiWDHcSxer8kZbkNf82iA0XzCWOfDjzt654yJo0T/VA6AXpIhKTvJr
 3MDWQ3oHbirNiaxngk5p7rZLO5LWjjo3qRi8JFyFpklfY61CEHhKqv/eO8PVS0pa0H6v
 qKnF84LLLTg0xqAMDvVemQxvWT3pOsFgQfcfM8MCjU8lMjBGwMmnXUK32TYci+zv9OQI /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk7bmg30e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:14 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CEVudL013735; Fri, 12 Jan 2024 15:05:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoA017833;
 Fri, 12 Jan 2024 15:05:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-3; Fri, 12 Jan 2024 15:05:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 02/11] migration: remove error from notifier data
Date: Fri, 12 Jan 2024 07:05:01 -0800
Message-Id: <1705071910-174321-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120117
X-Proofpoint-GUID: PpOWnxtxTOnTQFA-KoqV6QLt7Pnzyu7X
X-Proofpoint-ORIG-GUID: PpOWnxtxTOnTQFA-KoqV6QLt7Pnzyu7X
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove the error object from opaque data passed to notifiers.
Use the new error parameter passed to the notifier instead.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/virtio/vhost-user.c   | 8 ++++----
 include/migration/misc.h | 1 -
 migration/postcopy-ram.c | 1 -
 migration/postcopy-ram.h | 1 -
 migration/ram.c          | 1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f502345..a1eea85 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2096,20 +2096,20 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
         if (!virtio_has_feature(dev->protocol_features,
                                 VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
             /* TODO: Get the device name into this error somehow */
-            error_setg(pnd->errp,
+            error_setg(errp,
                        "vhost-user backend not capable of postcopy");
             return -ENOENT;
         }
         break;
 
     case POSTCOPY_NOTIFY_INBOUND_ADVISE:
-        return vhost_user_postcopy_advise(dev, pnd->errp);
+        return vhost_user_postcopy_advise(dev, errp);
 
     case POSTCOPY_NOTIFY_INBOUND_LISTEN:
-        return vhost_user_postcopy_listen(dev, pnd->errp);
+        return vhost_user_postcopy_listen(dev, errp);
 
     case POSTCOPY_NOTIFY_INBOUND_END:
-        return vhost_user_postcopy_end(dev, pnd->errp);
+        return vhost_user_postcopy_end(dev, errp);
 
     default:
         /* We ignore notifications we don't know */
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 1bc8902..5e65c18 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -31,7 +31,6 @@ typedef enum PrecopyNotifyReason {
 
 typedef struct PrecopyNotifyData {
     enum PrecopyNotifyReason reason;
-    Error **errp;
 } PrecopyNotifyData;
 
 void precopy_infrastructure_init(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4438ac7..59b80dc 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -77,7 +77,6 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
 {
     struct PostcopyNotifyData pnd;
     pnd.reason = reason;
-    pnd.errp = errp;
 
     return notifier_with_return_list_notify(&postcopy_notifier_list,
                                             &pnd, errp);
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 442ab89..ecae941 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -128,7 +128,6 @@ enum PostcopyNotifyReason {
 
 struct PostcopyNotifyData {
     enum PostcopyNotifyReason reason;
-    Error **errp;
 };
 
 void postcopy_add_notifier(NotifierWithReturn *nn);
diff --git a/migration/ram.c b/migration/ram.c
index 3fceba4..1923366 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -426,7 +426,6 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
 {
     PrecopyNotifyData pnd;
     pnd.reason = reason;
-    pnd.errp = errp;
 
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd, errp);
 }
-- 
1.8.3.1



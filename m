Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2927D749C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjo3-0002xV-1O; Wed, 25 Oct 2023 15:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qvjny-0002tE-1D
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:44:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qvjnv-00074W-TJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:44:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PEwkob004627; Wed, 25 Oct 2023 19:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=0Tm/GYd2BWb6llQIM5XRrWXbqf9w8dr19lzEtwsICBw=;
 b=d+GA5Kji+tjktr10LM8xBVZa3WQa17uj9PEb6lbO8opZD9ZNofhaMaUYb0ZpX9lT7U0H
 T8q48KU0lrujomMoNw/FWR6R5JZmwVOUjkCh2gwkvGmcRqa8xNbs5y4wqlUgSp0t2YQZ
 JvAWj98U6YiPRDlZ8dfwoT/eBv7ADVoTUKRMzl3pi4RhQOlCxj57t6d8+IUg73wVUj24
 SDUxDCp3sMGa1/rYhWvPyMPt8SQE1MnLXrk7X/8dN8eA1xGcm42NOsj11wJHCUQBFtew
 aCKE5/jN80vBBvoJ11ycFRlb/H7kSRa93Nl24BAZInrvFAMSejq2cQ2X/3B+TrV5kGgh 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e38mnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 19:44:34 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39PI4bB3034564; Wed, 25 Oct 2023 19:44:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv5374bte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 19:44:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PJiUNT037154;
 Wed, 25 Oct 2023 19:44:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tv5374bqp-5; Wed, 25 Oct 2023 19:44:32 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 4/6] cpr: relax vhost migration blockers
Date: Wed, 25 Oct 2023 12:44:27 -0700
Message-Id: <1698263069-406971-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_09,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250169
X-Proofpoint-GUID: 43rLyxjUaOq89Hr08VJ4JUnjA5_3rDs6
X-Proofpoint-ORIG-GUID: 43rLyxjUaOq89Hr08VJ4JUnjA5_3rDs6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vhost blocks migration if logging is not supported to track dirty
memory, and vhost-user blocks it if the log cannot be saved to a shm fd.

vhost-vdpa blocks migration if both hosts do not support all the device's
features using a shadow VQ, for tracking requests and dirty memory.

vhost-scsi blocks migration if storage cannot be shared across hosts,
or if state cannot be migrated.

None of these conditions apply if the old and new qemu processes do
not run concurrently, and if new qemu starts on the same host as old,
which is the case for cpr.

Narrow the scope of these blockers so they only apply to normal mode.
They will not block cpr modes when they are added in subsequent patches.

No functional change until a new mode is added.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/scsi/vhost-scsi.c | 2 +-
 hw/virtio/vhost.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 14e23cc..bf528d5 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -208,7 +208,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
                 "When external environment supports it (Orchestrator migrates "
                 "target SCSI device state or use shared storage over network), "
                 "set 'migratable' property to true to enable migration.");
-        if (migrate_add_blocker(&vsc->migration_blocker, errp) < 0) {
+        if (migrate_add_blocker_normal(&vsc->migration_blocker, errp) < 0) {
             goto free_virtio;
         }
     }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d737671..f5e9625 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1527,7 +1527,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     if (hdev->migration_blocker != NULL) {
-        r = migrate_add_blocker(&hdev->migration_blocker, errp);
+        r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
             goto fail_busyloop;
         }
-- 
1.8.3.1



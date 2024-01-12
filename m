Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28B82C27E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:06:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6G-00011V-Pr; Fri, 12 Jan 2024 10:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ63-0000yO-PQ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ61-0003ax-31
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:22 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXnU7024991; Fri, 12 Jan 2024 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=M8hxLzxuF6yFE9a3yTj/FwrS8J3GenFySau0lTU/x5M=;
 b=QxNPPyEU5ZtnSO8KQavX9vqGMtERS8yReVq5OAK8EuunhMj7lK7iyplajM5Nc6gDTnP1
 8KRFyLaOEwaa+SiLB3e1rQto6D5vRkAgdgiW3GaONGMYEsHrmKHg4EjrkspHDoLD37zq
 VBvCM/feY1+oSJxiEsnmIJ/j1AU9KDkpkB6nq1k8gXAEDn2RVjBBY70qqfCtX6wypcJJ
 CDFrepxl0xeD8cBfHc9HijXWntCE+EONmtlOprV3n1+mr1xMMlPf2iugPP+9RlUbKmxL
 v7R44sy1TN0copLR4WE2jLQtiriyQB7zr1FeA7FpnUCrpv6cC9yCDrgx36yd8eKHPGSw 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcbkkq4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CEVudN013735; Fri, 12 Jan 2024 15:05:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoM017833;
 Fri, 12 Jan 2024 15:05:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-9; Fri, 12 Jan 2024 15:05:17 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 08/11] migration: refactor migrate_fd_connect failures
Date: Fri, 12 Jan 2024 07:05:07 -0800
Message-Id: <1705071910-174321-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: tuBv5ZvTjhVBNfp3sXDDHo9m5yseVqW-
X-Proofpoint-GUID: tuBv5ZvTjhVBNfp3sXDDHo9m5yseVqW-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move common code for the error path in migrate_fd_connect to a shared
fail label.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e9914aa..c828ba7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3549,6 +3549,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    int expect_state = s->state;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -3603,11 +3604,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     if (migrate_postcopy_ram() || migrate_return_path()) {
         if (open_return_path_on_source(s)) {
             error_setg(&local_err, "Unable to open return-path for postcopy");
-            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
-            migrate_fd_cleanup(s);
-            return;
+            goto fail;
         }
     }
 
@@ -3629,12 +3626,8 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (multifd_save_setup(&local_err) != 0) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
-        migrate_fd_cleanup(s);
-        return;
+        expect_state = MIGRATION_STATUS_SETUP;
+        goto fail;
     }
 
     if (migrate_background_snapshot()) {
@@ -3645,6 +3638,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
                 migration_thread, s, QEMU_THREAD_JOINABLE);
     }
     s->migration_thread_running = true;
+    return;
+
+fail:
+    migrate_set_error(s, local_err);
+    migrate_set_state(&s->state, expect_state, MIGRATION_STATUS_FAILED);
+    error_report_err(local_err);
+    migrate_fd_cleanup(s);
 }
 
 static void migration_class_init(ObjectClass *klass, void *data)
-- 
1.8.3.1



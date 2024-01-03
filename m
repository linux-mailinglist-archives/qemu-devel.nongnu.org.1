Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8106C823619
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:07:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7VI-0004rJ-Ay; Wed, 03 Jan 2024 15:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7VG-0004mT-8w
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7VD-0002GB-SJ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:13 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JXMKa030829; Wed, 3 Jan 2024 20:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Tdz/0665DIlKQYsKJPHoEEW9YQgWa4jTt33Mn6oJUDU=;
 b=C4i3B+Al7zeK7mwoSVh3DZR5iw244G7srCHtkJqI8M9D+VNp5PH/W0C0HTZmQRutqjFV
 khs76DVDMd4tJXiRVBEXf3zhIsbfN1aYKM8a91cRtqglHAJjEzokBjzqakDNrR/wCW+f
 +Tbvuaj0hyONQffc+ekxjAgthK85JVaExcRyuEcsllGMmKQOE99DFODR1hpOndcDgGR9
 jjQV2MSEkdOABuYABwyLUSzN52Bxi2t6ko6Kw4Q/mt0aF02h1iBav41yn8z2Ni6Eqazj
 84dYJtIHU6R3afE+E2snavjzPSgBtbqaCqWPNt6AT1JhlxDxvdpGI9lliXn7jKXm7lWa 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9me5qq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:50 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K22g3013704; Wed, 3 Jan 2024 20:05:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2UZn020511;
 Wed, 3 Jan 2024 20:05:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-7; Wed, 03 Jan 2024 20:05:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V9 06/12] migration: preserve suspended runstate
Date: Wed,  3 Jan 2024 12:05:35 -0800
Message-Id: <1704312341-66640-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030162
X-Proofpoint-ORIG-GUID: j7j69EdrP-f_-mXLXGYyq3OdMxiD7bnG
X-Proofpoint-GUID: j7j69EdrP-f_-mXLXGYyq3OdMxiD7bnG
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

A guest that is migrated in the suspended state automaticaly wakes and
continues execution.  This is wrong; the guest should end migration in
the same state it started.  The root cause is that the outgoing migration
code automatically wakes the guest, then saves the RUNNING runstate in
global_state_store(), hence the incoming migration code thinks the guest is
running and continues the guest if autostart is true.

On the outgoing side, delete the call to qemu_system_wakeup_request().
Now that vm_stop completely stops a vm in the suspended state (from the
preceding patches), the existing call to vm_stop_force_state is sufficient
to correctly migrate all vmstate.

On the incoming side, call vm_start if the pre-migration state was running
or suspended.  For the latter, vm_start correctly restores the suspended
state, and a future system_wakeup monitor request will cause the vm to
resume running.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3ce04b2..8124811 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -604,7 +604,7 @@ static void process_incoming_migration_bh(void *opaque)
      */
     if (!migrate_late_block_activate() ||
          (autostart && (!global_state_received() ||
-            global_state_get_runstate() == RUN_STATE_RUNNING))) {
+            runstate_is_live(global_state_get_runstate())))) {
         /* Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet. */
         bdrv_activate_all(&local_err);
@@ -628,7 +628,7 @@ static void process_incoming_migration_bh(void *opaque)
     dirty_bitmap_mig_before_vm_start();
 
     if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
+        runstate_is_live(global_state_get_runstate())) {
         if (autostart) {
             vm_start();
         } else {
@@ -2416,7 +2416,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     migration_downtime_start(ms);
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2615,7 +2614,6 @@ static int migration_completion_precopy(MigrationState *s,
 
     qemu_mutex_lock_iothread();
     migration_downtime_start(s);
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
     s->vm_old_state = runstate_get();
     global_state_store();
@@ -3136,7 +3134,7 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-        if (s->vm_old_state == RUN_STATE_RUNNING) {
+        if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
             }
-- 
1.8.3.1



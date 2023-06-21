Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE9738237
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlR-0007KM-UY; Wed, 21 Jun 2023 07:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlQ-0007KE-A4
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:40 -0400
Received: from mail-bn8nam12on20615.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::615]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlN-0002W9-T1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHcw4pda9xpfTeoRqeevmeW79KHK0Fq9pgQ4DJiusFR9k1KU0Ngl5DWF8hrOAT2YakhEj5JJ+1dnmB6H2eJ+dFmroVMDlBMEvEvOG0YGXG/S3OLAOPinw6jS6WkYtiAlskCXb1OGglWphEkd/eWZQqMoehiCVtQHRxXICMpn1jTBv+8Yeq73YwdjUrhcX4yb+VMNmvt/kfQjPEr981ZBnMzNHs+BqUPX+hRgq4OgOuO/mEFScPI8PfYev73Ri/YaFCtfQ8eUC/jCibgtxTF3GNqIO+FL3zk0pOh5Jej3oU2WAfBDKAMjpAF09cZgvex+3amBqFCzPeiflQVwV83QyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNK+eS3m27SmtBDe3I7Lwe8yCPma8axVl+RCe4lHXiM=;
 b=UcNRl0ZQrXzuRjEVK3Ic8o+e2QXcauHQ0IkbJx2JRBylo3Mnkexnyj/kNK/Ep/qampR+ilu3sMmriFXxxS/b0iN6f9EWo4iC/nRVvgbyFEGblinOzY1JRRhsNWmDa31pqcI17larV42VT+RWOFHEc9JYAkas5SNpwRaIil+zl9zJfWuk86LH8LdbwtQaIQSB8lVsMSIUTqlXkTTCh/Q7D0H+FBRoZ79rn++FRjQGJNT0+zqwA/pNLo/mfjyZD8ciBJdVo7JfmhBuh/sZqcQc7wqmktjwuQ/HQdHOKk1NQyXFQxJx4TD8gNzjWGxk5LG84oeaJKmYo0vp+pbTPnZXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNK+eS3m27SmtBDe3I7Lwe8yCPma8axVl+RCe4lHXiM=;
 b=aktSgoM+I78CSJv/Em9/ETYVOxcWPQ/TDiNywYmzAbbq8b5En3cUSJ7Y/Bek3j6gNSxUY7wmu8ohv/qAHEqtEaiI65Gl/XT7Z115KBzenjbKnUEPlP91CSuijO29jrBdBwmJ6dhIAbcifuswPVYeRrTEh7kVonhaM/EQlRsmOSGZolk9Cz3aKHMLQP3JKLKH7zlK+e4Y9kJ+2RGLvwwqNtUISryqQGtdgoJxBnEJDf5GZ+HPaDYBonuyJBG0NlmtoDxFFgohJa6T8NgpO47UUyEF59kv0tcCWN9wjil2X5tD25UAjwJ1Cs4Oqws7uXbaOo0FQeniOEiFQcMkEQyNQw==
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.39; Wed, 21 Jun 2023 11:12:32 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::b) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.38 via Frontend Transport; Wed, 21 Jun 2023 11:12:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:16 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:11 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v6 2/8] migration: Implement switchover ack logic
Date: Wed, 21 Jun 2023 14:11:55 +0300
Message-ID: <20230621111201.29729-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 00614445-04b1-412e-084e-08db724868ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7OT+ithOK5tvde0kzLBOuOW3VYNJIvXvPd2X2Jkvcsb155Sd4XgUk8/66Uj2yE4HsD1aQvAjitI0AYqTe1yK8DbbPoyS29MCNmGV7pIf8urikedroECRkgmh8DgSP5u+yChi5fnCrS/GMBX4zTXAwgyhD8H35Z4Jq7aAExpiPOO+ZkhlWKU7RurBKuexjP2nGbMI2gxqD7ZzfQ4XVuYsbFUp/Lif3pG03x5YNHe8lwExrvj6tyDYD/J0c4zARq85SGy6BtUwF3JKItmc6LezkxUJGhBoYweoioxez4PC2wpVacarfKnjkclpm53Vk6GwD6+SY5XPVX6ed9aQ4RsAWaWdxjOjVZeb36DdMTQa6C96AMlQ9AUXgIz2HRpqBxucgm6rEdG4GBbZG8A2H0FyT6eArKREEQoouJAp/Gvp+YhOUSePCs4LpAjjEwXKtxEj01AZW4zvl8WhvGzXYobj407Wfs4+gq0Z582ljk4GgkVP0p/sNSMmDql8lDVScmJ3l8iDRk2wyeEqkDXFvgY7dZ6jbZK4TbHvI4vV8pyRi23Xy5qEjJ1AAVJllLEuj1F0ipk1QAmkNHrZS3oPoCpAY9yjk054w5dr9zkGfuJLecjRS3EAg1Y40KtqRVHxYF8/xHpFr6OrtaC8zmwaBImMlvpPrG2Zyum+iK3/JZ07e6xzZmk6Pmt6H6y9Qkses5BuEl1fq440EnFUpj6O0zNqhYcCt7c1hRDYgy5haWu8wE=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(8676002)(8936002)(7696005)(5660300002)(7416002)(186003)(30864003)(40460700003)(336012)(426003)(2616005)(2906002)(478600001)(36860700001)(47076005)(54906003)(86362001)(83380400001)(36756003)(6916009)(316002)(70586007)(70206006)(26005)(4326008)(1076003)(82310400005)(6666004)(356005)(7636003)(82740400003)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:32.5292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00614445-04b1-412e-084e-08db724868ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::615;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Implement switchover ack logic. This prevents the source from stopping
the VM and completing the migration until an ACK is received from the
destination that it's OK to do so.

To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.

The switchover_ack_needed() handler is called during migration setup in
the destination to check if switchover ack is used by the migrated
device.

When switchover is approved by all migrated devices in the destination
that support this capability, the MIG_RP_MSG_SWITCHOVER_ACK return path
message is sent to the source to notify it that it's OK to do
switchover.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
---
 include/migration/register.h |  2 ++
 migration/migration.h        | 14 ++++++++++
 migration/savevm.h           |  1 +
 migration/migration.c        | 32 +++++++++++++++++++--
 migration/savevm.c           | 54 ++++++++++++++++++++++++++++++++++++
 migration/trace-events       |  3 ++
 6 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a8dfd8fefd..90914f32f5 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -71,6 +71,8 @@ typedef struct SaveVMHandlers {
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
     int (*resume_prepare)(MigrationState *s, void *opaque);
+    /* Checks if switchover ack should be used. Called only in dest */
+    bool (*switchover_ack_needed)(void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(const char *idstr,
diff --git a/migration/migration.h b/migration/migration.h
index 30c3e97635..c859a0d35e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -210,6 +210,13 @@ struct MigrationIncomingState {
      * contains valid information.
      */
     QemuMutex page_request_mutex;
+
+    /*
+     * Number of devices that have yet to approve switchover. When this reaches
+     * zero an ACK that it's OK to do switchover is sent to the source. No lock
+     * is needed as this field is updated serially.
+     */
+    unsigned int switchover_ack_pending_num;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -440,6 +447,12 @@ struct MigrationState {
 
     /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
     JSONWriter *vmdesc;
+
+    /*
+     * Indicates whether an ACK from the destination that it's OK to do
+     * switchover has been received.
+     */
+    bool switchover_acked;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -480,6 +493,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
+int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
diff --git a/migration/savevm.h b/migration/savevm.h
index fb636735f0..e894bbc143 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -65,6 +65,7 @@ int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
+int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f6ea..7653787f74 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
+    MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
 
     MIG_RP_MSG_MAX
 };
@@ -760,6 +761,11 @@ bool migration_has_all_channels(void)
     return true;
 }
 
+int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
+{
+    return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
+}
+
 /*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
@@ -1405,6 +1411,7 @@ void migrate_init(MigrationState *s)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+    s->switchover_acked = false;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1721,6 +1728,7 @@ static struct rp_cmd_args {
     [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
     [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
+    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
     [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
 };
 
@@ -1959,6 +1967,11 @@ retry:
             }
             break;
 
+        case MIG_RP_MSG_SWITCHOVER_ACK:
+            ms->switchover_acked = true;
+            trace_source_return_path_thread_switchover_acked();
+            break;
+
         default:
             break;
         }
@@ -2693,6 +2706,20 @@ static void migration_update_counters(MigrationState *s,
                               bandwidth, s->threshold_size);
 }
 
+static bool migration_can_switchover(MigrationState *s)
+{
+    if (!migrate_switchover_ack()) {
+        return true;
+    }
+
+    /* No reason to wait for switchover ACK if VM is stopped */
+    if (!runstate_is_running()) {
+        return true;
+    }
+
+    return s->switchover_acked;
+}
+
 /* Migration thread iteration status */
 typedef enum {
     MIG_ITERATE_RESUME,         /* Resume current iteration */
@@ -2708,6 +2735,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool can_switchover = migration_can_switchover(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     uint64_t pending_size = must_precopy + can_postcopy;
@@ -2720,14 +2748,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
     }
 
-    if (!pending_size || pending_size < s->threshold_size) {
+    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
 
     /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size &&
+    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
         qatomic_read(&s->start_postcopy)) {
         if (postcopy_start(s)) {
             error_report("%s: postcopy failed to start", __func__);
diff --git a/migration/savevm.c b/migration/savevm.c
index bc284087f9..cdf4793924 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2360,6 +2360,21 @@ static int loadvm_process_command(QEMUFile *f)
             error_report("CMD_OPEN_RETURN_PATH failed");
             return -1;
         }
+
+        /*
+         * Switchover ack is enabled but no device uses it, so send an ACK to
+         * source that it's OK to switchover. Do it here, after return path has
+         * been created.
+         */
+        if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
+            int ret = migrate_send_rp_switchover_ack(mis);
+            if (ret) {
+                error_report(
+                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
+                    strerror(-ret));
+                return ret;
+            }
+        }
         break;
 
     case MIG_CMD_PING:
@@ -2586,6 +2601,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
     return 0;
 }
 
+static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->switchover_ack_needed) {
+            continue;
+        }
+
+        if (se->ops->switchover_ack_needed(se->opaque)) {
+            mis->switchover_ack_pending_num++;
+        }
+    }
+
+    trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
+}
+
 static int qemu_loadvm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
@@ -2789,6 +2821,10 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
+    if (migrate_switchover_ack()) {
+        qemu_loadvm_state_switchover_ack_needed(mis);
+    }
+
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
@@ -2862,6 +2898,24 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
+int qemu_loadvm_approve_switchover(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->switchover_ack_pending_num) {
+        return -EINVAL;
+    }
+
+    mis->switchover_ack_pending_num--;
+    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
+
+    if (mis->switchover_ack_pending_num) {
+        return 0;
+    }
+
+    return migrate_send_rp_switchover_ack(mis);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea..5259c1044b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
+loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -180,6 +182,7 @@ source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
+source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
-- 
2.26.3



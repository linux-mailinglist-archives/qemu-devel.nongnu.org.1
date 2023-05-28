Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4577139E3
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3U-00011v-Mq; Sun, 28 May 2023 10:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3T-00011n-Ga
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:31 -0400
Received: from mail-bn7nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::616]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3P-0002fx-Qk
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGKgx4oMOPtJe810MpV//m2VlWhh3LFtvyKJKlm/SprCXy1YjiUbHUNl1RRt+oxINL6ZbvIZGpuIumyLfZeShJt0DMf7ky34T1KHaFEFHGsOSlIgyWP22k5R1hkZirMrI7ht5/3H82HoEQnf+6/phuK4hmqyOy1HcYYzYAXHQ2hks6giwNkLYVUqkKOwTcZYhd5haLJm1ULUDdg13F74xLYxSmqGLsD+VwINWV9Ca/kFJOeFJ36bY513vcXAyFdHAzE1mvYy++FeiPdo9dzN9vpuUkSDCuBGa290OVK5wrNjh8l0+/+Hrq2RKsTxz4kcFNQV/5fG680zUF6mF2agfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvs2DsXgmjdi3KUK6MINM6KetlUsiJdkf48iAEG530U=;
 b=acg4TZKmGSTCnZcrBCuAGeAL83qtXU9QflrW/6NGtSsoj35rDYD8BFu4EFyIalOp0q4Ywm+pifx2bwcdEeYtvbacpcmEw1G7EaX5KyJxPM90yp7GEhK0QuzyjBn8xeUyp7sEGiJsE4UAgn7+TaefOsYFsB0PUf52JfhR41++f6coO00dlbmW4ogSHnOxeC98CooO5G/4ObdUk+lq1DElb8rFZjT/OwRmwFM4q66Z+jvpDwFJRgovPSCRgi6Z5q26Ms1G/6cNPnRLyai+Gj/yW3v42fmeTsC/m80BmiWNPr0zY6vOZyoqHU/N2tQNerYd0kpHkiIOWIwnQs/0ixJpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvs2DsXgmjdi3KUK6MINM6KetlUsiJdkf48iAEG530U=;
 b=dtM5Xyec5MLz6NTZx34r1LGtF2kI9HsZqUhVispTSxGogl0wgVE2iOyDS1bPtZmZT4lNCQeNsVq4rMWZlHQp8h+USIaFgpF5AO6hrOVuzRb0DlScwkeOGkIJ5i2B3wA/WpjgXTxZuLjnW7ugODcyZoHBVb4KxtsgOmYSow2zEvp8+r5GJ3ijLoXl8/n/Nm0mzHZohC+G6HUV0AfGAn1Aro6Pq/hIvjHcvXXSWkE3dQBScVLahPY9pFKPVLYjEhtis6piPbvacX+CxJjVrXA7/QcKUiMoH5bwRZUpycpm5mRAViwa/LKDoXrmZZYWh17WRqF+o8O0GBmZ2mrhNAXx/w==
Received: from BN0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:e7::14)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 14:07:21 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::f9) by BN0PR03CA0039.outlook.office365.com
 (2603:10b6:408:e7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sun, 28 May 2023 14:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.15 via Frontend Transport; Sun, 28 May 2023 14:07:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:10 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:07:05 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 2/9] migration: Implement switchover ack logic
Date: Sun, 28 May 2023 17:06:45 +0300
Message-ID: <20230528140652.8693-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|CO6PR12MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c532a6-5d3b-4380-825b-08db5f84daaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJnzg7ld1yDuaCD9xWG2IUTvmIhmtt4dvOMwIerugEarWeQBcLtqyuqerQKAVCs0pULJ+1uW6P24++4x6toU/hzwsJ40g1j6OTIGy4fa9IYbpsnUpGnZCxMl5qaVV5MTyZL85qzUaWsiBWdRXi4wjAwiZS2I+RnhntppdH3ik66yUK5wJ0UdInGCQGHCiv84eHg6nda+EKcP404Kag8pviZAcN/k0Ju43wkTXbMsXn6WW2cwy5NrNGCm2fkwQsVLfRNVM17FLLWPz9prd5ueyhM/IQcwX0KzDu53scSVhiUVX7kMbklzgYoRWPSwL4HyW585m/w4o+ySAcdljUmRg6iK5SxFvuOlVBxFPnxdDjLpObHaB4cv+Fz7y57zHVrcMqecclOgxpX6oigKsqaxKUe/aI7hY6k8VqbfsK0EyL4vPut0EVYPjup3uqEucXS5p3tLxhIKRey7REu5xsKw7mrWzMemB2j2qYD3+AWnB0zX76PE75EBw5WqmvsVy586UQzPwLalzaT5oJWYRaxeHEKqvoN3tJycykq59BC22b0QrrTX0AxNJstEL+wdjXuYVBoSpUgKLmlOuPqwT+BxswkciekBfGfaeKqCzgOQukiAh2bco1vsdmDKbUvkIn9laiEVZVJZqrpbPLRV0A2egrd5eLVPUBFSXkhjMseT3YLNDzggVK8O/aUj4QqMrcE1NhIuN+/MZfT5DCR54S6LAEf3nFFzKRjDzqWigvG9cZM=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(83380400001)(47076005)(5660300002)(316002)(6666004)(70206006)(70586007)(36756003)(7416002)(4326008)(6916009)(82310400005)(82740400003)(356005)(7636003)(8676002)(8936002)(41300700001)(7696005)(86362001)(40480700001)(54906003)(30864003)(2906002)(2616005)(186003)(336012)(426003)(478600001)(1076003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:20.9955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c532a6-5d3b-4380-825b-08db5f84daaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::616;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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
index 48a46123a0..1e92ba7b1d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -209,6 +209,13 @@ struct MigrationIncomingState {
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
@@ -437,6 +444,12 @@ struct MigrationState {
 
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
@@ -477,6 +490,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
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
index 5de7f734b9..c73261118c 100644
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
     s->vm_was_running = false;
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
@@ -2700,6 +2713,20 @@ static void migration_update_counters(MigrationState *s,
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
@@ -2715,6 +2742,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool can_switchover = migration_can_switchover(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     uint64_t pending_size = must_precopy + can_postcopy;
@@ -2727,14 +2755,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
index 03795ce8dc..285b814726 100644
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



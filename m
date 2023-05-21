Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6C70AE80
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:20:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kpe-00087g-Ee; Sun, 21 May 2023 11:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpc-00086z-1I
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:48 -0400
Received: from mail-bn7nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpZ-0000CO-LO
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1wc4uHys+TnH82tBv3aXlP2/ZOaL23BF6MQq52pFBMLgvJfRUUpAhoNJO9cXCwUjzUn3G/6br4Qj0C3UwKVlQSLX3hcFrkqGd3BDcDZUQ45AWfSQgmBXd6+io81WrqnWgz6aIqd5dKKl4XmpcKZ5JnwX3wI3GulnFkMvmazf4JwdScIEb7iMGojoKdaa4iuuhFWyxueIiypAT87+l6TmvnuUQ8CQDCSJ/Eu03Fx5v88eSPXwOnK3FHySuxFIYyUY9M2zrAv3miU9npOijrnrQB5SopoT9NkOfy1H2LVw86rxcdDxWSZACDBAnputE7s2dPguUX3+DuM17JGt6To+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NknjFa4r6OrI3cOniA8DR/52KoLI9LcOJMs+y8l/y0=;
 b=AURNiCiiOvjSF4+lzERhcnLlpjs0x1QZseu9yTaQMPuntyu0Ot4kRjEljwkVsDKx76AQ7jYgBLcyjjtJ+b338RNraK6JVqzeDQJKyIjTrK7MLry97G3MOUM3FfketQZYdETNZhiirN/Nm/My4Ua+T78mC2/eI872YKuBxtDYMQRZ5ynm/ZPS9E178G31rNxsgOnemeQuvXTLjCZHaV110MSgkFJzbBvFkF8Jszx4GigczJX2187jaaaZYLNAEfVhhko+fg/J0Wat/IM8aG6blrnW9UneIpE93VfZMbPJS7j8r1VPubZuYNLk3doe3ycnalUPzQTKfgjqqmD1CDeT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NknjFa4r6OrI3cOniA8DR/52KoLI9LcOJMs+y8l/y0=;
 b=He9AGlcmemVszcPFt6GZSBpPgrpvDYxxI6ywd8yeYpoAX/NrMa2zLnVjo4ouWbsQLstwYTFiEeDEU501YrzkV409YDYLct1obccwn16ybBNuWbDEua59Up07iG/pOXsJS6sogDygHlnarnulL6IWpIyf7CShqvTJ598FJHqIsSJJaBxdUwoT3y+vjJ5Rg0+SEHOpYw92tpLFsUxeyZbZHbra2eedT/cYRUWMNXSpXXSLOx2dwMMiL7WWYoyurc7o0qnxzs+ykojpKFikdImLAGzojrQd8Dy4aNRdPPDkOWVV4KKnMOOMyfNG9T65CxwBf3AY0Uwu/wtPRGNDAbsA7Q==
Received: from SJ0PR05CA0101.namprd05.prod.outlook.com (2603:10b6:a03:334::16)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 15:18:39 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:334:cafe::89) by SJ0PR05CA0101.outlook.office365.com
 (2603:10b6:a03:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.12 via Frontend
 Transport; Sun, 21 May 2023 15:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Sun, 21 May 2023 15:18:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:25 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:20 -0700
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
Subject: [PATCH v3 2/7] migration: Implement switchover ack logic
Date: Sun, 21 May 2023 18:18:03 +0300
Message-ID: <20230521151808.24804-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230521151808.24804-1-avihaih@nvidia.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 517ba4c1-cae6-4eac-9a9f-08db5a0ea7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMz9jsVZh07MI77a1E84SrOECSkGp+ktNcusqAXN3sHbLJWvF0XdfMSda864mjccPCfzRZwhZ5HftHtGhsycN0u+7i2Tz2xyMqzu4ndRVs3Mh+jiv5dtHrA5+ppphkWdh8k64zqa8jRc9piwkfW0qRjHEr3nLYaI0rsKj09GuUVI0EJ/Ox2D8MsYgzbgqKIm48teTLLOKtDQ1RaQVBHbldFBhZZEatSzWAGVG1qzPapxzopd4qhd3thF+a3rjuVDCuTS3kGu8Ijs2vdsj43tbYjRURiakDM33jU4sSB638qX5aMPqn7LYFat2S0oc8Jq9sm2HmbxvhSG0BHDiVCV6bM4tu7OKyA/wAf753cmU1xRaBO9/XsYOGZstGdfdiSO25HrL+BZ4TrOUUipw631/eZSsdmpUQlVEYOlA6pldDiZfLxN0XWFdXyBwXbTXIFD+c/1i5t/MN1yl/huTtp1K3iVTx65EQX34nvrwTxF1K670eQ48Yj0Licl120BBaYcguTehA8YjT97g1gKHUh7+yQ423NoHrtiLBEAJyTMUbuZ/6LkTQYmj21Zpwsk/CP3IAgXTrwn47bfZroKx7bwa0SV3qi3rQfiwbojXlVSNJ6oqVKUeXIgycozemuLYC9JniDArnG4E0hP172HajfzZjp9MB/I5BXcXMQLhELEwK26o1XjqAqHcvNcx7RlXSasERjBM93BiG6A+fTbIxE2zf+oF5PGgKnR5hAsMbMp7lE=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(30864003)(2906002)(54906003)(5660300002)(7416002)(36860700001)(47076005)(82310400005)(8676002)(8936002)(40460700003)(41300700001)(316002)(70586007)(70206006)(478600001)(6916009)(4326008)(36756003)(40480700001)(6666004)(7696005)(336012)(426003)(26005)(1076003)(2616005)(86362001)(186003)(83380400001)(7636003)(356005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:18:39.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ba4c1-cae6-4eac-9a9f-08db5a0ea7dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::62a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

The switchover_ack_needed() handler is called during migration setup
both in the source and the destination to check if switchover ack is
used by the migrated device.

When switchover is approved by all migrated devices in the destination
that support this capability, the MIG_RP_MSG_INITIAL_DATA_LOADED_ACK
return path message is sent to the source to notify it that it's OK to
do switchover.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/register.h |  3 ++
 migration/migration.h        | 16 +++++++++++
 migration/savevm.h           |  2 ++
 migration/migration.c        | 42 +++++++++++++++++++++++++--
 migration/savevm.c           | 56 ++++++++++++++++++++++++++++++++++++
 migration/trace-events       |  4 +++
 6 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a8dfd8fefd..cda36d377b 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -71,6 +71,9 @@ typedef struct SaveVMHandlers {
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
     int (*resume_prepare)(MigrationState *s, void *opaque);
+
+    /* Checks if switchover ack should be used. Called both in src and dest */
+    bool (*switchover_ack_needed)(void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(const char *idstr,
diff --git a/migration/migration.h b/migration/migration.h
index 48a46123a0..e209860cce 100644
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
@@ -437,6 +444,14 @@ struct MigrationState {
 
     /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
     JSONWriter *vmdesc;
+
+    /* Number of devices that use switchover ack capability */
+    unsigned int switchover_ack_user_num;
+    /*
+     * Indicates whether an ACK from the destination that it's OK to do
+     * switchover has been received.
+     */
+    bool switchover_acked;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -477,6 +492,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
+int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
diff --git a/migration/savevm.h b/migration/savevm.h
index fb636735f0..5c3e1a026b 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -32,6 +32,7 @@
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 void qemu_savevm_state_setup(QEMUFile *f);
+void qemu_savevm_state_switchover_ack_needed(MigrationState *ms);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
@@ -65,6 +66,7 @@ int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
+int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
diff --git a/migration/migration.c b/migration/migration.c
index 5de7f734b9..87423ec30c 100644
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
@@ -1405,6 +1411,8 @@ void migrate_init(MigrationState *s)
     s->vm_was_running = false;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+    s->switchover_ack_user_num = 0;
+    s->switchover_acked = false;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1721,6 +1729,7 @@ static struct rp_cmd_args {
     [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
     [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
+    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
     [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
 };
 
@@ -1959,6 +1968,11 @@ retry:
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
@@ -2700,6 +2714,25 @@ static void migration_update_counters(MigrationState *s,
                               bandwidth, s->threshold_size);
 }
 
+static bool migration_can_switchover(MigrationState *s)
+{
+    if (!migrate_switchover_ack()) {
+        return true;
+    }
+
+    /* Switchover ack was enabled but no device uses it */
+    if (!s->switchover_ack_user_num) {
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
@@ -2715,6 +2748,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool can_switchover = migration_can_switchover(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     uint64_t pending_size = must_precopy + can_postcopy;
@@ -2727,14 +2761,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
@@ -2959,6 +2993,10 @@ static void *migration_thread(void *opaque)
 
     qemu_savevm_state_setup(s->to_dst_file);
 
+    if (migrate_switchover_ack()) {
+        qemu_savevm_state_switchover_ack_needed(s);
+    }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 03795ce8dc..9482b1ff27 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1233,6 +1233,23 @@ bool qemu_savevm_state_guest_unplug_pending(void)
     return false;
 }
 
+void qemu_savevm_state_switchover_ack_needed(MigrationState *ms)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->switchover_ack_needed) {
+            continue;
+        }
+
+        if (se->ops->switchover_ack_needed(se->opaque)) {
+            ms->switchover_ack_user_num++;
+        }
+    }
+
+    trace_savevm_state_switchover_ack_needed(ms->switchover_ack_user_num);
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     MigrationState *ms = migrate_get_current();
@@ -2586,6 +2603,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
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
@@ -2789,6 +2823,10 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
+    if (migrate_switchover_ack()) {
+        qemu_loadvm_state_switchover_ack_needed(mis);
+    }
+
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
@@ -2862,6 +2900,24 @@ int qemu_load_device_state(QEMUFile *f)
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
index cdaef7a1ea..c52b429b28 100644
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
@@ -39,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
 savevm_send_colo_enable(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
+savevm_state_switchover_ack_needed(unsigned int switchover_ack_user_num) "Switchover ack user num=%u"
 savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
@@ -180,6 +183,7 @@ source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
+source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
-- 
2.26.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4159706D5C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJSU-0003MI-4u; Wed, 17 May 2023 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSQ-0003Kx-MG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:55 -0400
Received: from mail-mw2nam04on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::60b]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSN-0005v3-8m
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leLzj+4q142aFzt678Gw+QcTFsrnKPFmYpjRt18wy4LS400CwcMKgREn0D9TZd33yEXJGCyUN316M5H4Igk4ACmysndTbxsB27zDil/UKNSLp67833LCP6NCz4BBIayqnzDof+Uqb86BRUnEZptL9XPump6bKvYvJZ3s96WGf20XLhcgmc60VreLuDt9Q/cYsxdln+KuVMjdnqVu1qBvjuCGkehkx0njGUOOkEXSwxNFMAfrj8tGqwcYmCy0fuyvHF7UlC8gNNbuVNUZk0GQGDNQq9X16FS10z9ay3VwBiFV+9uRkJvCSbVc0z6qElQ6UPDVz73YrE0iT8dfSMGdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3eNmstU6+dZUNsKAOcuJIoMMbPJZdRDquef+y7SsbE=;
 b=iN3CNqpxpivtktgSzZvWQNL0Ey1PZUoVSDt8zrBY/c4er074iPcWXHpUBvaTJZ1E1NpFjEX50k+dhRgF6Hh0DxeRbQbDLPOlxUALGc4ihtpUkFDgYa+HhPFwIJKCbWS4JOrW8WWgdd0OyK/HaMG5l/Oiwhvsmq0LJY7c6orQF2E9T5h4om/YCU9MlAolT7FQuN+/zYtHMKEG0tKqZBPskNsmG9pgNTtTALPz/G4WBMQq7V1bn/yuU/Uf2wV1fBE6cDSmf4pzAQDgHpNpZBer2+WJDWBzoPF9lOr+JkmWvVOr3x9pRQojC/b9p8paZJhkI97TtYMG5P6jF7e+0gJ00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3eNmstU6+dZUNsKAOcuJIoMMbPJZdRDquef+y7SsbE=;
 b=pD0F1ZxHoTqyCb70HW0RVP5P6Tpe2+118RPb1RtRnv2XpdIS6hc7noWISsX4Z9Z4D8fkEe36/dJUcON7wdEhBcq34maP6gxy/gxoscl57tJDscfB5IGU6I0LdGotFNCepmqt5HbDjGVRY20vnCRAPVMqOmEtEdxSPanuQglBI7LimM7pwgxNs+dksBwwmLpw0TSnm5gmEtuF2VKFk/MlUPk321k6KKUHHgIKaiR5FLdiqcXPMz9V51R7FTykkZIpO4yMVprBYgO0mLi26YzpY7mtK1/CX0YtU0G1EtH1tZ+LQUQmiYQwfXjHbUYYi+6aX//9E4uv2+wkm28dBgOvRQ==
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:52:46 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::a7) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Wed, 17 May 2023 15:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:52:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:52:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:52:35 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:30 -0700
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
Subject: [PATCH v2 2/7] migration: Implement precopy initial data logic
Date: Wed, 17 May 2023 18:52:14 +0300
Message-ID: <20230517155219.10691-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230517155219.10691-1-avihaih@nvidia.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: be9ff45f-8954-4856-82e5-08db56eec239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1o4LOFR8ez0Jm+yvK/wUZ2sN73yEPX+717+6ywxnJFmMwAQBdKeZrklMw+uiKvVHQz5Jm6mwJhGBYg2Tq5GbzKhuX9h19GBO8aD48QkkzwAWBepsM+bTykXYBRvz93qpMf3Uw8TrQe/fpUBlwI/n3C3OGwGopEVna4jKgD0eUGIEFsiD1NuU8C44wz3kiWUvPN7z1rWE7XBh0hBXjzhrG1zcra0RGCk2jAmARwm/XWwcPAd9GunWuLd3Y4yd7kgz9u+lEQbXTimYP3eNPUFFlns2UsWKsvfvPokuf6QCw0eqICTPJaUf09Y2qlhMSmhZxHPObyDZEKg76V3glU0TjrxNJeaAFP06NVVuM/n/yMpnkQZf9tC1F4HkUOcfmT80IUeLR9wsZZBgWjtZsapgeg0hj3E+c5KmBd8KvuTQCnTLJDZ6UISvlsY6vJ+f/NC0JWqklUqkbCmGZFechpMphCN3yKwSdepr0aPvV1XPnDzOypJJH4j5e5UGbLndQq6H7h0RaRmRlZ4H5sIJra3QAz2G2dPD01+Tqzs4BXlJVSCM+hRQ5Xo3z38wHvOf6EJz2iP0Q9f7UO1hkXmR9B4ZmR5PzuF2Qofh0YgjlnjWnbFbXfsLh6AksNsmfw8Dx4/9c8/HdZsZHDx+SPyFegLt0cxbUnrRSr8M9N56Gz/HMVEDgrnu3h82pBIEW43KpKQc9FwcfT2YOo5wkIYf8FXUpGkGI5LOwQlqnDNm1Y8Ti0=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(316002)(70586007)(6916009)(54906003)(41300700001)(70206006)(4326008)(40480700001)(26005)(1076003)(478600001)(6666004)(7696005)(8936002)(5660300002)(8676002)(7416002)(82310400005)(40460700003)(86362001)(36860700001)(186003)(47076005)(83380400001)(7636003)(82740400003)(356005)(2616005)(30864003)(426003)(2906002)(36756003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:52:46.2405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ff45f-8954-4856-82e5-08db56eec239
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::60b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Implement precopy initial data logic. This allows migration users in the
source to send precopy initial data and the destination to ACK when this
data is loaded. Migration will not attempt to stop the source VM and
complete the migration until this ACK is received.

To achieve this, a new SaveVMHandlers handler initial_data_advise() and
a new return path mesage MIG_RP_MSG_INITIAL_DATA_LOADED_ACK are added.

The initial_data_advise() handler is called during migration setup both
in the source and the destination to advise the migration user that
precopy initial data is used, and its return value indicates whether
precopy initial data is supported by it.

When precopy initial data of all the migration users is loaded in
the destination, the MIG_RP_MSG_INITIAL_DATA_LOADED_ACK return path
message is sent to the source to notify it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/register.h |  6 ++++
 migration/migration.h        | 14 ++++++++
 migration/savevm.h           |  2 ++
 migration/migration.c        | 40 ++++++++++++++++++++--
 migration/savevm.c           | 65 ++++++++++++++++++++++++++++++++++++
 migration/trace-events       |  4 +++
 6 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a8dfd8fefd..3ac443a55f 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -71,6 +71,12 @@ typedef struct SaveVMHandlers {
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
     int (*resume_prepare)(MigrationState *s, void *opaque);
+
+    /*
+     * Advises that precopy initial data was requested. Returns true if it's
+     * supported or false otherwise. Called both in src and dest.
+     */
+    bool (*initial_data_advise)(void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(const char *idstr,
diff --git a/migration/migration.h b/migration/migration.h
index 7721c7658b..cc4e817939 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -202,6 +202,13 @@ struct MigrationIncomingState {
      * contains valid information.
      */
     QemuMutex page_request_mutex;
+
+    /*
+     * Number of migration users that are waiting for their initial data to be
+     * loaded. When this reaches zero an ACK is sent to source. No lock is
+     * needed as this field is updated serially.
+     */
+    unsigned int initial_data_pending_num;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -430,6 +437,12 @@ struct MigrationState {
 
     /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
     JSONWriter *vmdesc;
+
+    /*
+     * Indicates whether an ACK that precopy initial data was loaded in
+     * destination has been received.
+     */
+    bool initial_data_loaded_acked;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -470,6 +483,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
+int migrate_send_rp_initial_data_loaded_ack(MigrationIncomingState *mis);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
diff --git a/migration/savevm.h b/migration/savevm.h
index fb636735f0..e1d8a2b3b2 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -32,6 +32,7 @@
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 void qemu_savevm_state_setup(QEMUFile *f);
+void qemu_savevm_state_initial_data_advise(MigrationState *ms);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
@@ -65,6 +66,7 @@ int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
+int qemu_loadvm_notify_initial_data_loaded(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
diff --git a/migration/migration.c b/migration/migration.c
index 00d8ba8da0..fdb8592e64 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
+    MIG_RP_MSG_INITIAL_DATA_LOADED_ACK, /* Tell source initial data is loaded */
 
     MIG_RP_MSG_MAX
 };
@@ -780,6 +781,12 @@ bool migration_has_all_channels(void)
     return true;
 }
 
+int migrate_send_rp_initial_data_loaded_ack(MigrationIncomingState *mis)
+{
+    return migrate_send_rp_message(mis, MIG_RP_MSG_INITIAL_DATA_LOADED_ACK, 0,
+                                   NULL);
+}
+
 /*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
@@ -1425,6 +1432,7 @@ void migrate_init(MigrationState *s)
     s->vm_was_running = false;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+    s->initial_data_loaded_acked = false;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1741,6 +1749,9 @@ static struct rp_cmd_args {
     [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
     [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
+    [MIG_RP_MSG_INITIAL_DATA_LOADED_ACK] = { .len = 0,
+                                             .name =
+                                                 "INITIAL_DATA_LOADED_ACK" },
     [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
 };
 
@@ -1979,6 +1990,11 @@ retry:
             }
             break;
 
+        case MIG_RP_MSG_INITIAL_DATA_LOADED_ACK:
+            ms->initial_data_loaded_acked = true;
+            trace_source_return_path_thread_initial_data_loaded_ack();
+            break;
+
         default:
             break;
         }
@@ -2727,6 +2743,20 @@ static void migration_update_counters(MigrationState *s,
                               bandwidth, s->threshold_size);
 }
 
+static bool initial_data_loaded_acked(MigrationState *s)
+{
+    if (!migrate_precopy_initial_data()) {
+        return true;
+    }
+
+    /* No reason to wait for precopy initial data loaded ACK if VM is stopped */
+    if (!runstate_is_running()) {
+        return true;
+    }
+
+    return s->initial_data_loaded_acked;
+}
+
 /* Migration thread iteration status */
 typedef enum {
     MIG_ITERATE_RESUME,         /* Resume current iteration */
@@ -2742,6 +2772,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool initial_data_loaded = initial_data_loaded_acked(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     uint64_t pending_size = must_precopy + can_postcopy;
@@ -2754,7 +2785,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
     }
 
-    if (!pending_size || pending_size < s->threshold_size) {
+    if ((!pending_size || pending_size < s->threshold_size) &&
+        initial_data_loaded) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
@@ -2762,7 +2794,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
     /* Still a significant amount to transfer */
     if (!in_postcopy && must_precopy <= s->threshold_size &&
-        qatomic_read(&s->start_postcopy)) {
+        initial_data_loaded && qatomic_read(&s->start_postcopy)) {
         if (postcopy_start(s)) {
             error_report("%s: postcopy failed to start", __func__);
         }
@@ -2986,6 +3018,10 @@ static void *migration_thread(void *opaque)
 
     qemu_savevm_state_setup(s->to_dst_file);
 
+    if (migrate_precopy_initial_data()) {
+        qemu_savevm_state_initial_data_advise(s);
+    }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index e33788343a..c713ace891 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1233,6 +1233,32 @@ bool qemu_savevm_state_guest_unplug_pending(void)
     return false;
 }
 
+void qemu_savevm_state_initial_data_advise(MigrationState *ms)
+{
+    SaveStateEntry *se;
+    unsigned int supported_num = 0;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->initial_data_advise) {
+            continue;
+        }
+
+        if (se->ops->initial_data_advise(se->opaque)) {
+            supported_num++;
+        }
+    }
+
+    if (!supported_num) {
+        /*
+         * There are no migration users that support precopy initial data. Set
+         * initial data loaded acked to true so migration can be completed.
+         */
+        ms->initial_data_loaded_acked = true;
+    }
+
+    trace_savevm_state_initial_data_advise(supported_num);
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     MigrationState *ms = migrate_get_current();
@@ -2586,6 +2612,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
     return 0;
 }
 
+static void qemu_loadvm_state_initial_data_advise(MigrationIncomingState *mis)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->initial_data_advise) {
+            continue;
+        }
+
+        if (se->ops->initial_data_advise(se->opaque)) {
+            mis->initial_data_pending_num++;
+        }
+    }
+
+    trace_loadvm_state_initial_data_advise(mis->initial_data_pending_num);
+}
+
 static int qemu_loadvm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
@@ -2789,6 +2832,10 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
+    if (migrate_precopy_initial_data()) {
+        qemu_loadvm_state_initial_data_advise(mis);
+    }
+
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
@@ -2862,6 +2909,24 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
+int qemu_loadvm_notify_initial_data_loaded(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->initial_data_pending_num) {
+        return -EINVAL;
+    }
+
+    mis->initial_data_pending_num--;
+    trace_loadvm_notify_initial_data_loaded(mis->initial_data_pending_num);
+
+    if (mis->initial_data_pending_num) {
+        return 0;
+    }
+
+    return migrate_send_rp_initial_data_loaded_ack(mis);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/trace-events b/migration/trace-events
index f39818c329..807083c0a1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+loadvm_state_initial_data_advise(unsigned int initial_data_pending_num) "Initial data pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
+loadvm_notify_initial_data_loaded(unsigned int initial_data_pending_num) "Initial data pending num=%u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -39,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
 savevm_send_colo_enable(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
+savevm_state_initial_data_advise(unsigned int initial_data_supported_num) "Initial data supported num=%u"
 savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
@@ -180,6 +183,7 @@ source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
+source_return_path_thread_initial_data_loaded_ack(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
-- 
2.26.3



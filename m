Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A477A402C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6DI-0003QL-Hk; Mon, 18 Sep 2023 00:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6DD-0003Pb-HE
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:20 -0400
Received: from mail-mw2nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::609]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6D7-0003cE-Nh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BriSvDKjNc4l48uwtThk3RRdcEj/Lx9In4MdKS96tdlpuwV+ahZTXwqJp5PmidoqCYwRxM5A6Nxij+oS+U6AzhtYpAoKZwkL1McbBuut11++vQ6BLihe4JZTkEMjBUfz90qQECgGK/Vy38RiManOdWFjL2IKetOhuGVCo9iiTaMLi7dI+QNzhnbWiSbi74zMZ2lXvqc93ac9X3M/9RKTPcxVywro2CicmYxlq7tevMP7o/uOwkIYur88t3/IeszOTeln2hT1fvyj3tKozxlp0ZTq4v46s9FNTMDyzs6JV6QcTKKnnBgiE8A1yJb5CBPjX8NkTNZ+MAiVW43tlhyfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyvTH2zfw9Z+hRNhzFi1cneA5xIzTM4jiJfgb8FyEgo=;
 b=S4qYABX+Mfts2OnDgq0hetqCv7LpYIqMtETtaNMnahlF3u8L1rkzO7zb1EeOAUDo1GU7AQCMEcejRMjutMgk6jY+KQBI88+28HJKtP+kDe4r41VU0jluVvS0FJBG+TAueawXV5H7KP5n46S9WES/nSF2XDqqX/e/kSo8Z8UaWf+53ION15e8vrPo00Pb4wWeE5DoYVFpMcE8nWhQglSArXoMsTJzriGk7ujWFemxQNz0rhkOO6TcJ/kZ1lsA0MDWn/aqhziAVHvcMviEpiJNoZxCLX22s6PtHhsQuxdDUD/WWwlJyfYVcic/mrcwAOKJ/qbA08R3b78BCuZ78lEEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyvTH2zfw9Z+hRNhzFi1cneA5xIzTM4jiJfgb8FyEgo=;
 b=bZbmUxYYYu8ob7kAV2WmyuIALYukjz5VRijiYgtlLxWY4cEZwpWh4NiyACURfavpRUe9cfVFfUZZD5FDEDncGXQyEcT2dXa+m1r6vx3DYyz4Z3vCSTclmOFBX+oM51etyH7q2TmMFkW5LeWSFmvkx5jgBPcxHR35ZhAVLAEKiBZ3shv2w3Ql4WfSB3j4zsLbhFRwfuPxzdDjxuM7KHn8yESR108+Z/Ic9EXoleuv9ZOu7VgnVGHbjRtoYdhnXD/mb2lHIgp28JJQcUR/fSZwcOfU2v3Hb1EUoiReglrKCxMrf1KVhgdJm6aqB8PPAvt3RAwCDcg6wdoFeJFbNKYchQ==
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 04:50:06 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::5e) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 04:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 04:50:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:54 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:52 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <yajunw@nvidia.com>
CC: Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [RFC PATCH 1/5] vhost-user: Add presetup protocol feature and op
Date: Mon, 18 Sep 2023 12:49:28 +0800
Message-ID: <20230918044932.1433744-2-yajunw@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918044932.1433744-1-yajunw@nvidia.com>
References: <20230918044932.1433744-1-yajunw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a22ad2-69e8-4d5c-373d-08dbb802ba2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06hPi2sebr9IWqsnKw4IiE7/LGIalVDlPFQOsBO2+2Rh1vyO7Pwd5gksQa420hP2EpXGbbg6lplPodN6guIVwc+3af1XeNbam7BK0MMHC1Tnyl93W/5aKEl+u92N1XLzd4EDxA+KL5qAfB2PbGR8a2/4HeDWvPYQCyh7HvObd3ZzhjfK6xDtZY63rxwtAEYAkizE/uL9qI4SCTUvxyLXp5SlstcaZWG3oPreRnzXUe4ayR6QhM8NABHLy3h3qsee19ojNUqwaQcEg/fSs/CO/V+X5faeFA2jlY08aNo0j14UbOJ6mUDHNwN+q2UKZedJ+gKLieIoO+gaGvBjlRQjMXPAfykow8wtWa72Omr3UpLprwbkGmldzcC2IU4rY4Lgogn4mTvheKDSX+XB+zpdYxv6Nh2ogq/CGVWyxTLH9RErWVViYvIkIfFQ3HBBuM0/Eq3q+ZrvZ9GvZO5QgRl11kclwV3hPQnd+BVKR8zLdBsTeyIxeME7TOXhN0uLWATAb88FLZHTOKSmJ4XJhWfrFPfGITTqqyyvrYyZzmqxfIl9pc1XQ1UrU9lvhzLZj/OiqSbvX3sfqCkY6zUasGs+RLM+tIXlSAPRw5cqELcdmCz4g+hH3kKYHX0gz6mWNtK0cLQRc6S3MiaOniy9IE3UWCaQvsZIAkD7T3nnFZezPw3q+Heek2kNFQygWzEP7r7a6CAPzVbtKpqWkcVIVo91vQdR3J3lG5KbWqwcIvfphGGQKm8kmh8Tv4hwUXMw5gzb
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(7636003)(356005)(26005)(16526019)(6286002)(82740400003)(2616005)(8936002)(1076003)(40460700003)(4326008)(8676002)(107886003)(83380400001)(36860700001)(2906002)(36756003)(47076005)(426003)(336012)(40480700001)(55016003)(5660300002)(86362001)(7696005)(478600001)(6666004)(316002)(54906003)(70586007)(70206006)(110136005)(7049001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:50:05.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a22ad2-69e8-4d5c-373d-08dbb802ba2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
Received-SPF: softfail client-ip=2a01:111:f400:7e89::609;
 envelope-from=yajunw@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch implements VHOST_USER_PROTOCOL_F_PRESETUP protocol feature
and VHOST_USER_PRESETUP, so that the backend can know the beginning
and completion of the early setup phase for the virtio device.

Unlike the regular device state load, which occurs in the VM stop
phase, this pre-setup takes place in the live migration setup stage.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 docs/interop/vhost-user.rst       | 10 ++++++++++
 hw/virtio/vhost-user.c            | 30 ++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  3 +++
 3 files changed, 43 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..70b8e2694c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -885,6 +885,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_PRESETUP             18
 
 Front-end message types
 -----------------------
@@ -1440,6 +1441,15 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_PRESETUP``
+  :id: 41
+  :equivalent ioctl: N/A
+  :request payload: ``u64``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_PRESETUP`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  indicate start or end early setup. Value 1 means start, 2 means end.
 
 Back-end message types
 ----------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..71018d06c1 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -74,6 +74,8 @@ enum VhostUserProtocolFeature {
     /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_PRESETUP = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -121,6 +123,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_SET_STATUS = 39,
     VHOST_USER_GET_STATUS = 40,
+    VHOST_USER_PRESETUP = 41,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -132,6 +135,11 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
+typedef enum VhostUserPresetupState {
+    VHOST_USER_PRESETUP_START = 1,
+    VHOST_USER_PRESETUP_END = 2,
+} VhostUserPresetupState;
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -2741,6 +2749,27 @@ static void vhost_user_reset_status(struct vhost_dev *dev)
     }
 }
 
+static int vhost_user_set_presetup_state(struct vhost_dev *dev, bool start)
+{
+    if (start) {
+        return vhost_user_set_u64(dev, VHOST_USER_PRESETUP,
+                                  VHOST_USER_PRESETUP_START, false);
+    } else {
+        return vhost_user_set_u64(dev, VHOST_USER_PRESETUP,
+                                  VHOST_USER_PRESETUP_END, false);
+    }
+}
+
+static int vhost_user_presetup(struct vhost_dev *dev, bool start)
+{
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_PRESETUP)) {
+        return -ENOTSUP;
+    }
+
+    return vhost_user_set_presetup_state(dev, start);
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -2777,4 +2806,5 @@ const VhostOps user_ops = {
         .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
         .vhost_dev_start = vhost_user_dev_start,
         .vhost_reset_status = vhost_user_reset_status,
+        .vhost_presetup = vhost_user_presetup,
 };
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 31a251a9f5..00dd532df9 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -133,6 +133,8 @@ typedef int (*vhost_set_config_call_op)(struct vhost_dev *dev,
 
 typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
 
+typedef int (*vhost_presetup_op)(struct vhost_dev *dev, bool start);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -181,6 +183,7 @@ typedef struct VhostOps {
     vhost_force_iommu_op vhost_force_iommu;
     vhost_set_config_call_op vhost_set_config_call;
     vhost_reset_status_op vhost_reset_status;
+    vhost_presetup_op vhost_presetup;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
-- 
2.27.0



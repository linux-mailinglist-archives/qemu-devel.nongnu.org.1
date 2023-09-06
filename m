Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C57794001
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdu9l-0004O0-GV; Wed, 06 Sep 2023 11:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9j-0004N3-Eu
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:23 -0400
Received: from mail-mw2nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::619]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9g-0003jf-U4
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTcXdFmfLDF3DapRS/Jbz+eURwsNxaSnt0CJfD4A+duBkgTvn/L7H3bsZrnKWELTgGavK4oUiBCq1rs+MTkbbeTcuQhIxEZ7FGUE02RWJhBIoZSrjo3YPOusXCLIB/l8jY9TYKKn6idWzEe8+EshkUkbtiy61cAixq6vsYrO5V87ygsNyk1tJFujySsph6LB+1jClwJOMKSEvZqdiSbXDiF47aICopH7lfNq7GYkhV1u6yTqEszcqWaPMnETX1eXQb1ryC/xIpIjRCMjExQtAf5aYPGV3AHxdLm5OwNGifVRA37BAtDyK1DqTqJkgDcXcYV4l4IEm/uQhn3KlrqFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FotuBtmavqR9dkaD1yotgN9OXacIbAe0HgjsL8Lx8Hk=;
 b=ivl8kn2pYII3hyWeh3bSKmKLM0xJe2dm6LQn7K9NAUQ7rr2m82ibaXfg1F4H4hAirjD7t+U4h6+LSAuPqLKt8qQk9ER4RZMPpyChiBUJ/dNic/yJtycSzWheJXQPd0TTZj4/9DgGlUdkq1j3LFk0oxDx4qa4Ot7LtWb/ollhcabKwQNyNW9R7ygV2+VdkT7pYKA1MJoMPj3h5rm04QhKMeyPOow3V5ZnPDl9JZlj2yDC1cYEKO0iPUjmJK3h4VPgBrENi0KnLOSQt9hYWSzL3mUV4sx7D81EU1/bzL+i/3WGPQNNHzdLIhZ9L2NsgQZ/CnA54rw/12EuxXQBeSqjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FotuBtmavqR9dkaD1yotgN9OXacIbAe0HgjsL8Lx8Hk=;
 b=Ft0isJy3bTR18G6arpe+p8jvZ4FvGhr/+pGnGv2h8WIYGkVsiUt1dFms5CMIik8p0Y1dbUcISGAM3u4Suo8+cdzzuXN9f8dWpOfthlqBi3DQzrXzYFvh+meKXRB4uF+iyZyIe69GknE/dK6uADTI9RL0RbVuZnlDgaWkUiRFWc+dv4RwJkN8xZUOKC+Frdk/44fFgM2JycnLXC/1x6LN0GlmMDhd4jq29p8HA0rNRebUnB12oiNhu3ef/4hkXnyX0zAhN6ixuB+h3Ki7pHTp2qtWhl8LWBxvV2YIkQLb/R81fJjmju7GZTFUT5kmZ52Ok6DB7Saxd+XZtE0aVjfPZA==
Received: from BL0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:207:3c::19)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:09:17 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::bb) by BL0PR02CA0006.outlook.office365.com
 (2603:10b6:207:3c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 15:09:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:09:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:09:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:08:59 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 2/6] vfio/migration: Fail adding device with
 enable-migration=on and existing blocker
Date: Wed, 6 Sep 2023 18:08:49 +0300
Message-ID: <20230906150853.22176-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: be8c7b9b-d251-4f02-c053-08dbaeeb3cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7dqMCsd9fw9JNAyfacqYuleCCMi7rV3shuvfn/PjSqQWZf1zVUX5PAYkLCXrDcI4Bta0+nv38DmTvyr7qgZXbY2kgY+7XsND3xQuzb9ofLgwtBGiw81SubdPfnkhlGcHnHMM08zMcaSpUQ+UjHTJ4yLPUVADiqQcjDSxLfmbJFhNdCMwvuGUlN9CsQQUqxvsr97q7q+Xyw2QWem+BwBgPI6n9xiik1ArINA1aP3Ho34RLlGUTQmV8zPoXZYnRWuw0e+nrsLD3Y6Z7n7qudyxZzCE2P3g3UkNew1K8Ls9koqqYNh8CMhqctZTTZp9dQsWypNfkXQMjHHNuy3V6C/FEpktszBqEgQ464/VR0PKBPb29mN/pqtdkJJZyQm959b1jxZsdOSm54hJvoQiOhifxXMFnCPjENvEHfL5XvwC40n+WUmmU9lL+5BNkDEHJwO590CO36s/I2l9u/3Ij79z/fN5xKc2jWl+UCbZ99rKbWO2aEA+QaCObi2WOxHvmAX2onUgxONeKp6vIRmgBKfsD5iME/bLtxduNVQ6J+U6ify1tx9XQKpn0OlGpsaun7FZKDC7o8HIb2rvapi12yPPb67QdDL0DxVWU2qmCOGb5Ckc3vlkusmdjp7ewf6keeYWmhk6LXLruMzSyq+jYT9NAcWsokdCRSD2GF3Lv1Vms3XlKQxT5dewBJ8xi9zwS5ND3xeVmrui7wtS4eT8soc57knOKJ7O3qFNAU+j0KXOrbJ3H1jYsyJIWfGiy1zCsld
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(26005)(5660300002)(4326008)(2616005)(107886003)(1076003)(40460700003)(8676002)(66574015)(2906002)(83380400001)(86362001)(47076005)(82740400003)(356005)(7636003)(36860700001)(36756003)(426003)(336012)(8936002)(40480700001)(7696005)(70586007)(6666004)(6916009)(70206006)(54906003)(478600001)(316002)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:16.2567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8c7b9b-d251-4f02-c053-08dbaeeb3cd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::619;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

If a device with enable-migration=on is added and it causes a migration
blocker, adding the device should fail with a proper error.

This is not the case with multiple device migration blocker when the
blocker already exists. If the blocker already exists and a device with
enable-migration=on is added which causes a migration blocker, adding
the device will succeed.

Fix it by failing adding the device in such case.

Fixes: 8bbcb64a71d8 ("vfio/migration: Make VFIO migration non-experimental")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8a8d074e18..237101d038 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -394,8 +394,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
-    if (multiple_devices_migration_blocker ||
-        vfio_multiple_devices_migration_is_supported()) {
+    if (vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
 
@@ -405,6 +404,10 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
         return -EINVAL;
     }
 
+    if (multiple_devices_migration_blocker) {
+        return 0;
+    }
+
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-- 
2.26.3



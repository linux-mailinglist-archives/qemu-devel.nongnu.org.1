Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD548754DD5
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKwvO-0007mB-4D; Sun, 16 Jul 2023 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvK-0007lo-JJ
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:11 -0400
Received: from mail-sn1nam02on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::608]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvH-0000pn-AY
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU4N7CzLhr2ymdUON9gOVII2QW9bgYGVZoN8WYV5DHInxEvfXztflSBQgcjqNzwXLgNT0frI89XYvD3jIc2B3fMn/cxtWdIRrO2VZV80W+JujhcbPeX9LzIdrg8EUptT/0mwJ/S+lwjM+kP3Eg9NSu0Y12KWhqZzYqyPMY181w55rv2XVabR/hxub8fzkpr6wLTLQjdkfIvpTqOiXQX7PfrN94QFuFfgQ1nPZkUFF4GnsPRIVJ8UM817h3a+Up5/PAdhjTh1BaHPF07T5UuxoSNhWSpz3uOr2/aBtDVxgtjFJO+40x3ByRZHee/PHGYHAtxbWyeb71JFaxTD0ouxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JJJi1BljvRnqc53fMAMnBZ/7qU6EKYrUo6YPtPQy70=;
 b=hkGkE+h1zeM6IY4XLNSDfosrHewab9lqEmJvBrjBybqOKjhXaY5trvUfmnJ5Pe/z2ky3C/9RJ+Grg1G61TE2Jy3wMrVn0k+Oo287KBrUFHfQlTNF8L+qHKJ3HoDQeTafJ0sFXXURvWDs6r6AgH6+O/wJM6s+jZp3GakwqCyLWfwf96FJsEq1PbA9qDG5yFIOqCxvpmKEht6d7s9321dJaTKtrtqQT5Rjd0dvc2CFdNHpn+PDKlV24BMu9xmfu9nySrhKZHHZqJeoWdP2HkNNlMm5vsznGcjK75mchRyQwG274p4/H53sas+E3lJvqk0Jy7gZq++1eoiuBz06cvtEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JJJi1BljvRnqc53fMAMnBZ/7qU6EKYrUo6YPtPQy70=;
 b=e0dVpmB8ZrPp1Y4SY/d0mfy3Cs+daX2KUCo+8f6SOAJh6+6em2qInZzX549lEwZfvdgmi6mtIWnBr+kP/pSk7rHz3tbR5SlE8JiXHFhKd04ZnzLm/eEwK56AVOWvNhQxo2i0uSsXaK2JXibhkcNN3z8vWpWWpecUaZWWJcoSwE8l04ozl6GvSF9GlaNkyKJ0A3NtYw8M9/vD1LzPYCpeEPypt9VdG1Kh/NKsU76GC83RCKFpYFgA8xAMBukTDHvSqnidb/EC4yIWO3daABIkatZvwwNukoeXxEWYDMUj19TdbLOsWguWj4WD99JfpIvIr0ignJKMSm4cL9VrUvvp4Q==
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 08:16:03 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31 via Frontend
 Transport; Sun, 16 Jul 2023 08:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 08:16:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:15:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:15:48 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:15:45 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 1/6] vfio/migration: Move from STOP_COPY to STOP in
 vfio_save_cleanup()
Date: Sun, 16 Jul 2023 11:15:36 +0300
Message-ID: <20230716081541.27900-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|BL1PR12MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f87a5b-e1ef-46aa-6e9e-08db85d4e471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OLoX4zNU4sItlCjvQg3Umgi8Weq/Vq6qVjBDDK4u+mvtDn6XXBsGW3zdXvegl2jWMr6CMWTq7QUlrrg2Z9YSUtDKyhaPgiBv/ToMWqzSQSeFgSSNCq3r/7QeeYkfdaBVXdenmyHp+f5IHt6AXgvXb1UvUrCtygl848dUYn1bjuQVrmubWN8PZHWyWwsseyGlxZdWEAWvEyMwkZopDjclyyRJJESyMxQ3f/eSFl+Z5AOmlWDo4qktuNKF3XdO4aS5PjgtfjsrtdfxVo4091P0bJi6qsjcHcNPTI5VMWyNEjrqrjv4J5IsoUqww3k2opnDLSO0Zzy81rnSs1eldHaHenyZWTLAC3TOzBn9t3XM/iciwTWXXppe8O5/b1x9wppkzwcWFnqRQILGl7Atl1UfvuBap/nUw/zEBRnjmzyY0Y+4/hhXT17TvRbekHgAt9mZvCpGhEvqN5tyR/PMgfh9rflpo2jJFC9SJMOp5j12XrHFlrhlsOlpto5RIBtM/L0T7phKZFTncLeYXAs9tqZmL6LWnHL39MhoaxtOspbswASJyNkNTklWK9R7vgxeoLLtfVMAr+V6TjFP7OoSbcyUNcB/DIRZYUr7DL81SHYdv4n89pvRN4hagoSQwCntMl+WUCvy3bqoEM92geVIlACD/DR5rWQDCXStzOInQa9KgAApdCLcST7pbpzxSMMqtqq0Y8K+okR3GSS6Z+upk3/a8rKZc+GupdndbchcD90UpALpEF7RTXg4DSg3/d6ZF53
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(54906003)(40460700003)(478600001)(26005)(186003)(1076003)(336012)(107886003)(36860700001)(7696005)(6666004)(40480700001)(83380400001)(47076005)(426003)(2616005)(86362001)(5660300002)(8676002)(82740400003)(8936002)(41300700001)(316002)(4326008)(6916009)(2906002)(36756003)(356005)(7636003)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:16:01.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f87a5b-e1ef-46aa-6e9e-08db85d4e471
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::608;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

Changing the device state from STOP_COPY to STOP can take time as the
device may need to free resources and do other operations as part of the
transition. Currently, this is done in vfio_save_complete_precopy() and
therefore it is counted in the migration downtime.

To avoid this, change the device state from STOP_COPY to STOP in
vfio_save_cleanup(), which is called after migration has completed and
thus is not part of migration downtime.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2674f4bc47..8acd182a8b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -383,6 +383,19 @@ static void vfio_save_cleanup(void *opaque)
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
+    /*
+     * Changing device state from STOP_COPY to STOP can take time. Do it here,
+     * after migration has completed, so it won't increase downtime.
+     */
+    if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
+        /*
+         * If setting the device in STOP state fails, the device should be
+         * reset. To do so, use ERROR state as a recover state.
+         */
+        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
+                                 VFIO_DEVICE_STATE_ERROR);
+    }
+
     g_free(migration->data_buffer);
     migration->data_buffer = NULL;
     migration->precopy_init_size = 0;
@@ -508,12 +521,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    /*
-     * If setting the device in STOP state fails, the device should be reset.
-     * To do so, use ERROR state as a recover state.
-     */
-    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
-                                   VFIO_DEVICE_STATE_ERROR);
     trace_vfio_save_complete_precopy(vbasedev->name, ret);
 
     return ret;
-- 
2.26.3



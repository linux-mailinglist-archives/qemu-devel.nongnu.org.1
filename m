Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F3793FFD
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdu9u-0004QV-TT; Wed, 06 Sep 2023 11:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9r-0004PL-6j
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:31 -0400
Received: from mail-bn8nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::613]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9o-0003l8-L0
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+59MG6Na/zHjaVr8Bsc7KioWjFz+HXE3IOjz2NheQ13kosA3oYEiyb8U7r8seQ1fxZeNC46o8ZiprHiItAOGQG3aQphnzd8krwmk6ZCotYvollmAf4YdhrSnneFsIgxt78CRTN74rioXkzMEBoScR45LgsNf8tgTcHffyfjEdhFTRn2CX4ToXtiAo46Z0b6pm30R5VAx0c0OJRFhDVaoVMSbM8xPerWF+7pGUOkKFsHXGyHYkoaIbkCuxeofX8V4LXtS+cDgOiVy2KiB0nfwS46Zn23gyE4905lKi7+sgVeqrNyP0NnNxnXmwC54UM7dNcglIcuKZO9e6BejbvXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMqBWuBZ0C2IzYo80qdMyTdLCiOUB4xzzlj//eKXoXg=;
 b=RFWggbbDZMLRQCRxhoEkYYNkQqqFKG2YAHGOuz0hbWcvcNP+ICBVGCDpsuQioY+AifVIlrzUza8JuBSVsxw2XPuMn8sifCz1SWZ2mgJGjFlU0PfCq3qIhvqbTwKtDDY5uF2uC7MCYKP0hXXIOdt8KeE8dEeJqIqC4A/AA6mWrClcyfY7Lo0ae/ihNip1ZxS2odjADiI+AEuQqnCbyJWaNbHjA8WIQx4Ilhedt+KaL+vGaUcUv1gGvxRNJXzTszOUwMEUO/LpiEUojBMDP4QPyIrBZpRfRyUkdxuLyuRg4IvIQMNx57AX3GJUZZPSwvDvjLdBIFq7VF0FfMolhjzxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMqBWuBZ0C2IzYo80qdMyTdLCiOUB4xzzlj//eKXoXg=;
 b=hcngtd2eiul6iONQWsWqBRR9MdMOQbt3fXo2pG6ttYVKWI+h8bR32hoHHRNaGzwGUo1Aqk/YoxDuUQasLXF0cRi7fqYK8u6QeqmTBfABWuFlmllQuegePyh3SZGXpS2WL5l6JCuOi7/EUCUlu7DwuY3ZYgeTw/tnjlW90URURwUEFW7qdu5ZC011DrfaKkKcOTjmw/a6AWIgEwa1/ZekHvrm2B+ICRZqW+NnBbGkzYfph9F5+SLpHpd9ejYJEalxdQjpiCU2BBJzVmYI4mgGHSBZaCV2u61pYiqImRYLBQ/2s5M1+2FLC0fw+cZ+IMNyDVNX9RCF52jJFtdHmtVnvw==
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Wed, 6 Sep 2023 15:09:24 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::51) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.26 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:09:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:09:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:09:12 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:09:10 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 6/6] vfio/migration: Block VFIO migration with background
 snapshot
Date: Wed, 6 Sep 2023 18:08:53 +0300
Message-ID: <20230906150853.22176-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c491fe5-6c19-41fe-8b02-08dbaeeb417f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35Vi8CAwXfVj/BR7q2Rp0I/E7UrYv0iBCc5gutyrgX8QCPGKaUThL6+0grHuuLc1gkurEDmK3pfOvZPlPYDIyquYCIp/qOSr+gTG7H3Ucb3+WP0RjGTqb7I5yqLXR4TS0biuN5a5IR599mI7kmYpc5ihdoQo2JzhzfvblqctnUPryOiQcrfDT5QopSSwPnTyGoJk3jXL67Vh5I/iqCeE9WKkH8jFB/NdzO9Avej+yi1RrZe+S7XlGJyJiS7GFms//vFOY9YhKAKf6bf79Au0EZczO4OKveiBdlWf9rSd080m/VhxeEIk+xhy0nGIOeayrTxHz52MOcBeWRiwhS9QdMlU3an6+XC2GZbshjipV16s1NVj1TKV2RWcUfa9Wv9QAto2ug3N2uuyr7k3uu/QlyZh6IE7qURWa71E+3DS5Wo1Mbq3ebUgSeR2pIV0rYJR2syIyAI71XfEm35vrspf4G5FkiTH0P/kfp64uWX/anMdS8sBLKJCpZlQo3uxyyoTtL/oCsiUAQJzEc+cRBk2f82KO8Hhd2S2x5saGqh4LdUFxZP/UWX85YyA5uuxtokNnTZa/oiF4SB52NVjqp5Bj4hrPO0zRMA4yDsdvQ9QcSUpL2lqh5mkICpl1Um7GckYVfDV1KARzE6ERzitNQjfOMY4XBmDg/pCvK5DVzMOnmoatdJWaxEzg2hx9bdwJaNGFoQF1BZpzWWOyxwRwVqazgCk2u5iCGxEjXqZNKjT/QyejLtITzlSnMhOkT3pt4Y3
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(1076003)(107886003)(6666004)(7696005)(356005)(7636003)(478600001)(82740400003)(426003)(26005)(47076005)(2616005)(36860700001)(336012)(83380400001)(70586007)(2906002)(40480700001)(54906003)(6916009)(316002)(86362001)(70206006)(36756003)(8936002)(5660300002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:24.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c491fe5-6c19-41fe-8b02-08dbaeeb417f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::613;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Background snapshot allows creating a snapshot of the VM while it's
running and keeping it small by not including dirty RAM pages.

The way it works is by first stopping the VM, saving the non-iterable
devices' state and then starting the VM and saving the RAM while write
protecting it with UFFD. The resulting snapshot represents the VM state
at snapshot start.

VFIO migration is not compatible with background snapshot.
First of all, VFIO device state is not even saved in background snapshot
because only non-iterable device state is saved. But even if it was
saved, after starting the VM, a VFIO device could dirty pages without it
being detected by UFFD write protection. This would corrupt the
snapshot, as the RAM in it would not represent the RAM at snapshot
start.

To prevent this, block VFIO migration with background snapshot.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 20994dc1d6..da43dcd2fe 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -340,7 +340,8 @@ static int vfio_save_prepare(void *opaque, Error **errp)
     VFIODevice *vbasedev = opaque;
 
     /*
-     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy is on.
+     * Snapshot doesn't use postcopy nor background snapshot, so allow snapshot
+     * even if they are on.
      */
     if (runstate_check(RUN_STATE_SAVE_VM)) {
         return 0;
@@ -353,6 +354,14 @@ static int vfio_save_prepare(void *opaque, Error **errp)
         return -EOPNOTSUPP;
     }
 
+    if (migrate_background_snapshot()) {
+        error_setg(
+            errp,
+            "%s: VFIO migration is not supported with background snapshot",
+            vbasedev->name);
+        return -EOPNOTSUPP;
+    }
+
     return 0;
 }
 
-- 
2.26.3



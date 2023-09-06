Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D350794002
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qduA6-0004RA-Sh; Wed, 06 Sep 2023 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9y-0004Qt-N6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:39 -0400
Received: from mail-dm6nam11on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::61d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9p-0003lF-BD
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdbt5zLT2WTpokhdKe3G/vD/n3zArbTSeYMk7K8FaEJrQzpMAlR1SF+vn1sqkPPThcSjuV0nG3Yt74oWWVJVYF58iCF0SvWgk3BwK70mDd1lGqG6Z7HK11f52cCrVoSykNZocJtNBDAWWZ8jf9aLu4Ijlrj8yuHceA8STRfHNHl17wA0cy+bTCWrOE9UOar0I3ZfXkHic1A7NQn5JyftN0xBI00WycVtI6qk963PO6hkFaWCdeQe0CpC3kw4Q9nfHcQ8cLzeL59xPlnP54WlQLDgMUK+744xQYAx+eQ3f2sOWoUXzKF2APLLZrmofTmyZGTEiF1rYDtFC6uUcEXWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8r6cdkGjtfem0dSjq48tNITR5i3m7NvHpysIUHIz2o=;
 b=O+Wtx8hPqj+KF3l9lDOlEBslFBSYimRCDFkavtmDzlik7Biv9W8KjMu09fKx/Cd3GeqALuAhyraRpArNpOLWLSpToXn3aOaSuKxTc8N19INLMED0Q0hgpBWATMIYAB278RVTWxnn0PqIFbC6gHIAGBfsTd3s6BBfPfAc3O7U9xJWO1WcGD9uZ/bB4Bbpl1Mg7ug4DDYPH9JLw3bf2cWJcZVe5A5kQmsrrO4O3U0iraIWINOX7V1f36A8D8d+EM3l0I54XjvqW1tK2X8Rrz40gDWGRu+ldjL3BxFrbMbr5eR0yBH3croKmsBreznvXQdXAVirCdTIgvr13+9MTOCeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8r6cdkGjtfem0dSjq48tNITR5i3m7NvHpysIUHIz2o=;
 b=RWMzfgdvXunr/wEigAj2nv6RtJO72Kx12Z450hnYt2LvbMtS6TP79ZrIjC1rEIT7+uTOz+9gsPbznI6jf8BYua4vy6MhH9Ds5CEJy8VQ+jwawWp0iH6C9mGlJBFTbAqVkijHb9hvhd5dLTAOUB2pFjzOd8G6VoY190BeYCPHJ65yeSrWT/lOgbyJM83E4fbOBkPaRJJeybzWzDQi+U7JdtxVbeqkgP5uY3eWKnuC4Nf9GcYNhuDDts0sGlkWK5/KnEC3I6oLZ/6ho01dLW1Be9KFgzFXzTaALBjEJhQcHNdy/eujJCUdIBn7E2pgA0jmiLkMT3ikm3eZRgVo/3uenQ==
Received: from BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:09:26 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::48) by BL1PR13CA0092.outlook.office365.com
 (2603:10b6:208:2b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.26 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 15:09:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:09:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:09:10 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:09:07 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Date: Wed, 6 Sep 2023 18:08:52 +0300
Message-ID: <20230906150853.22176-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c1aca4-16ea-43a4-4dbe-08dbaeeb4262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SooIVNIFVDM0mKqUuJlm1gmma7hgMfRYel3XMp2qxb35XemutGJz7ROX5UlUaQYPWerT4EInLH4mRBNivVM92UupYRzpGBWMv8aEz9xSp6tufJ9LFd/7ZlTcI/R5WUiYDac31hOdfhl3SLyN682xq8mmRWR4MMZ0MvOQWykZEWKHycHiIO7ftJb8ONyuSmyCMKNETZMVNTr4/73N5+Ccj+sk+LnRm+0WrJZzolAcMPb4t/cXhrutPX7a9paSzvCcmf0xsV/XKVkYUOLyphsRA1wZBesQFfh5XhIY/V3d+X07YzDfNlnyYV9TmWHxmWrhlVXacYqz100MAz4THT5Hgj/epIK4W6aZh+znQrXkWwr++dg4u/96jYWEFrDNhiOT1MgImbwCdUGMTz/bm4g6ZFRbDG8jeixvSHdFEbCMcwosTUdmm9BDrVvaYZuCdKqNqt6WuMz1FNw+A/zcsKzAH2gXzj+tKQlaV8jZhODr/z6V7Iiq9FrvAaduMZ0Ik3h/0fjx9CKXZWXbFC+jpCFIw9EDCYFPnMv1VegPm/sQJDno0CxUQn9TTRmeph1l71i+X2C9+D5+KyIA7LB10MPL64euKN5GaYnhHUFxfTJyRe9hUNWYBJVv7pc6uAW/q82+i4/7aMmsaVKL2rnqK6VXVtfwKZqZRN0dFLieM7pCymWP1jUAqd6yVNmefOQfSQaLxi4gQVFCOOwvxNd9IaXMWy0lH34ye6kl9Iss4DeDXHgpGQ92OHZvB7mt4PlKlUn+
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(83380400001)(1076003)(107886003)(2616005)(426003)(336012)(2906002)(26005)(316002)(6916009)(54906003)(70206006)(70586007)(41300700001)(5660300002)(4326008)(8936002)(8676002)(40460700003)(82740400003)(40480700001)(47076005)(36860700001)(36756003)(86362001)(356005)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:25.4843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c1aca4-16ea-43a4-4dbe-08dbaeeb4262
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::61d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

VFIO migration is not compatible with postcopy migration. A VFIO device
in the destination can't handle page faults for pages that have not been
sent yet.

Doing such migration will cause the VM to crash in the destination:

qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
qemu: hardware error: vfio: DMA mapping failed, unable to continue

To prevent this, block VFIO migration with postcopy migration.

Reported-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
---
 hw/vfio/migration.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 71855468fe..20994dc1d6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -335,6 +335,27 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
 
 /* ---------------------------------------------------------------------- */
 
+static int vfio_save_prepare(void *opaque, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+
+    /*
+     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy is on.
+     */
+    if (runstate_check(RUN_STATE_SAVE_VM)) {
+        return 0;
+    }
+
+    if (migrate_postcopy_ram()) {
+        error_setg(
+            errp, "%s: VFIO migration is not supported with postcopy migration",
+            vbasedev->name);
+        return -EOPNOTSUPP;
+    }
+
+    return 0;
+}
+
 static int vfio_save_setup(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -640,6 +661,7 @@ static bool vfio_switchover_ack_needed(void *opaque)
 }
 
 static const SaveVMHandlers savevm_vfio_handlers = {
+    .save_prepare = vfio_save_prepare,
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
     .state_pending_estimate = vfio_state_pending_estimate,
-- 
2.26.3



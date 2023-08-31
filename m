Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0ED78EDF6
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHu-0006sb-HU; Thu, 31 Aug 2023 09:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhF2-0002u2-Bt
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:46 -0400
Received: from mail-bn8nam12on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::60a]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEx-0005J0-9C
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6tUxO62L4Guf3xLlgH4fPU5Xj+7hC9zZatKrmhprNdO3gJybuf122s/HXL/zSjHKT8oPbXy/oetfWFoA/CjOswyVyfR6GDNRFf3KJuRnUOgBIsSeZaVHcouz3zzM918Sk/BJC4Q14eZfwpIRQ1clUejM7GI31TYyrQ4ADOSyMiUi1kQLMEBDnRSKwyAhKaartJJ4m+3ZUOmUPl8QmJkU4IugUeigreptYnEIql6urYHmW5SvEGHNMqmoSzsgQ6lpJ1QtmD9bMK8AKOTf35PHPGNISIAjW8nunxGyvPKgOZO2rjXFYRzkr67jCZdix9Lnut84CdcZtwIVT/v1r6wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVsz7qyjfGTciYL0GienL0XaxUN0EYgW/kSLjyWZIg0=;
 b=nEvcWYvquGutJ+bqIn3fZn4EPWDWxGg1deEC7g39I3hS1iK78kJlNbhR4hUG3OeUBFlsMZlpQHEuQP/2AREZgpVqM7sgTXQuwLn1Kqdiby4hQxt1vIIsr/FdaDY+N1a4Nq0W8os7iOYk4Hk8rMEUGEznRCntk4m8xl8mXQ9l3BjLLvnyvBTH2iCQ7dyS5ZeQWpH83XlcEUSD25kM/EO8mQ6PhR4oS60RYyZioDojAaSUBxueOn1BOZcl7+AGy18p95mltokN6CHWKCK1tNEmD24gYqs9cKriGq1ozApKFmPC9+IDgGQ0w2QT6Hpu/Fas8a66qWullocVYO78H1QQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVsz7qyjfGTciYL0GienL0XaxUN0EYgW/kSLjyWZIg0=;
 b=tfV8AP/7RDhCqscEH9lha3q4aT6KXFZFkmVZ/dEiVWURqoM5yRALFWnfBwLH8XfCwKFvKW7kNCWaP05q5OM/Uc1pUp76gvQbJXiVH5ZfCAmZ1tNqwfX7W3jgMwuX7a6wz639yMYIMAZlmQHy8fR0w51ai8Y+hNaCJB2FYgyZXEVSFAt5Kl3NCp8uK4zObFxni2WXx3Ywi+6fwpM18iEYrV8tvrbXLIIAZSYqMFlXXr82gbI46DiYBBvZFGidqszETuoftwfyjerz7rmZFLkvUbdZpHpXTBGjdpY4Y5wGdWB6YDBF920Sfp+LOPU4I/+Rc2Q8F64EP7sD2hk+te07lA==
Received: from DM6PR04CA0009.namprd04.prod.outlook.com (2603:10b6:5:334::14)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 12:57:33 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::dc) by DM6PR04CA0009.outlook.office365.com
 (2603:10b6:5:334::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 12:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 12:57:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 05:57:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 05:57:17 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 05:57:15 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 5/5] vfio/migration: Block VFIO migration with background
 snapshot
Date: Thu, 31 Aug 2023 15:57:02 +0300
Message-ID: <20230831125702.11263-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230831125702.11263-1-avihaih@nvidia.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df120a8-994d-4381-f5cc-08dbaa21d764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLSBN8gtc4kIK24MBEvVE2UDWCTQUMdL92fMIc4127undcd/vBoIm6vvRt0qrBIRmjpRhAyFeQh7CN1iV7FOAc/YuMtD9RRo/2F5X12HAQUwF0UEkjLfSTp7+wS/+JEiGv/JiO/2crJfB2QsdvnumULY2TDQJk5KwOjQTzbgrNsnDQE8SkKxeK2E0guKJi60fBp/OuqztzAdhgdTnFQdfdixtAlcQ6GBpcvgC5PnJtv1F36EnCL4j7C2TKPyarsbiQunNwV+EDPdH01+BePPleF+h0b98kieiSV/JqpYVc0AA2WLkEd6tbHM7N7c8uU0AlUoM0G5tvveTAl/KS1BPYCpAG3dmiLPqCR7Zoz7DY8VGAU8jrV6kRNo0fsWW0WiUwIxQhDD1q7Aj2pu748cCJEbr8FoeQ/ifw0Q9MMAgmznaYw4NlfufgsKsZE75fLwZv56vf/MWt8rcjS+gSWvocOTiy2ynOfk786wrOSwvbBBBeXfTHwt1sDMju3/xt/QE836iQfNY4SP65wJK+v7NOAZoj7JJkarBBN642WeCw4HMMzwcU3IxGpfevw6jHlK9BZNG7JsjzaCpmiH6S4G2kwNSF+a//6AOt6IwDAJnPGs/gI2Cn1EEf1naelTfCc4V3aUwGEVNB9KGPGmBEoWoVXvU/KxHmAiMTEBf7t5vb9HRmPXwRm9KOK1w4ihrMPWWtPEfcLTsSyZy5vHHzr2xqQ5DnOEX3Xg8pN0jSushJPRhIEo5mmgVkL6axvu3dwG
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(41300700001)(26005)(356005)(82740400003)(7636003)(6666004)(86362001)(83380400001)(478600001)(47076005)(336012)(426003)(1076003)(107886003)(7696005)(2616005)(40480700001)(70206006)(70586007)(6916009)(2906002)(54906003)(36756003)(316002)(5660300002)(8936002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:57:32.6011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df120a8-994d-4381-f5cc-08dbaa21d764
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::60a;
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



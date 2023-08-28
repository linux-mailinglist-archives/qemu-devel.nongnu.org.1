Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623E78B441
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae1N-0002By-Tj; Mon, 28 Aug 2023 11:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1A-00025e-Q3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:06 -0400
Received: from mail-dm6nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae18-0006v6-8N
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/KwiBxRWxGiKDADlUHG0Aymq+JKws8qv3GBZuZBH9HI2JlnKpLz35tOG+ykOeeu6dnSR9hlEWeSea5DvYqTZl//zp8KaVnXwSKVsLe5y8JAr7VqubfO3xQGgmXZcsMT9K/nyRWNyI9yUHTUcKP4v4MLKfMBXOud6sp+yzKtYuEskRAJbHPIdbAsNOcNwxarlgMC6glrPa0/2XRVATlSfwkiq0bf7+yhjy6XmTvYucjTlqmmIqHtYQGsQF6fNMAr3WNbd2pBzlPPnqF/AbEnTjXC9fNX+vMjfs7F1h9N4sEDbh7VcvXdjshS9URzDSZLikZm5LgqkmG1jn6w/m/dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZfdw4/Q5yuFIGY0xGxMOXoPWdrRx8tuok7uG7FFrnY=;
 b=gOps7YGbVVdgaZFP3BE5YtCApFfWQfi/0ft9ikmvs8UuWbPsoj+3LyWbGWJurV3JEbLM70Bq4yHJjDGKpu43I71SK/Qveev2eYjZWCVHymOzgFDk8G6TTikQAXwuqO46YHQWQ8yQug/iD3XIDTXoguB58qVVRuq67VjMSqq1L6M8XDdSmsbk+5/Us+n09DPE1S+5yXbnjJ6II+U/lIUc1IhpsDa6K5TmDmVUx1wGXI+eAfvky0+PAwNUP5CNSHNLGax+AmTtEZL/roSf/xNADw2NZRnJlG18F35/NfQurC2X0kVcPp4eRhKzR+AOvM/hSO0nSHSjFSR//sZzJxR7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZfdw4/Q5yuFIGY0xGxMOXoPWdrRx8tuok7uG7FFrnY=;
 b=OEOaWHcvY4tDVWWdCyVilVHORX8uMZ+6CNH6yliaKCxvZk8MHC7OEB6El3+DJrlrAQuWx13dFprQYyrsifIxn1reR2+/uw2C/f1NyPyS5bK3f7G5LwHo9y5t5my9P37fQZex336mXUdLV6JQIga198Vkgnf/H9hsBLosU6QPXswckg21oPIvvWvEXJMlhXEYzG53th8yBcB3OZxj1GHz7TsQphHzzn7rLK3dVhcHyIRqJNgwxm1+YX8h4mdi6z4wlXgmDf4u7NDeEzka7bq/OA/l/KKO431suzss9a4IMhF/5FN3Q3S5+Unh1OFPdXWXlb7lYXVRLxV6eFfFf5wFbg==
Received: from CY8PR10CA0047.namprd10.prod.outlook.com (2603:10b6:930:4b::25)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:18:59 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::7b) by CY8PR10CA0047.outlook.office365.com
 (2603:10b6:930:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 15:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 15:18:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:18:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:18:50 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:48 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 2/6] vfio/migration: Fail adding device with
 enable-migration=on and existing blocker
Date: Mon, 28 Aug 2023 18:18:38 +0300
Message-ID: <20230828151842.11303-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230828151842.11303-1-avihaih@nvidia.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4fe5ac-b258-4c78-dbf2-08dba7da1a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbduWWFaoHPfhYJE0Dla1VM6YXd1Kh4PNnS3ZRnu7YDXB0XCyrvMPnUQmYd4SZSVWPUgCkIehthsieirIKEAiZOtaT+2aGQ6PLb6JM8yGaGBHqqJo64FEQxyejbwZrydivkxJqb4Cm9c9O1vrr5PKLTfMTa3ByF4g8cSShL9HhzaZDRcO3ABpy0GSXyy2Kuz2sWW2Zo7VQgJeeh+5F3azQu3TbFRc2s2GCNcFcDJ3In9ksojvz2IOhU7o0BqwXK+kmypLZf1AUwCwaY8FSN1s3BSnCLc3whjD3fZnWuCTFpG8VYhnsdY6zi5zQuz8TnvjFapoetaqwOpleOxKZ0+ZO3B5KLbpWYLSokq+boFyJvogZs3vAWrGcsBIZfsQQA9nxD05ukFavZI0Q1ItMa/1syJkdawSsbi+pqKOpHWefN/IqQp7DPmXflxnSIc5qic9F4W00HrN+iOClxAb2OmIbQsEHMxVl34dUBjIZQhXxWReNsPBJK3SEpYTMLs9J9MqLkOIBUXL+Nd7Suz/ij3QZOyHo8+FHMj1mCb/n+ctmMYN2v7y/WXh0pe8FncAQABj1cstyR/IKnu5uV13EmcXYGltALS/za6BN73N+pJRAVDbpQE2bFodTaWzcdo3HVKcb1nP25VEltJKcd07PY3hGNeeRSL+NSw9B9lU739AiosTP5rsIx83dY2Ukta+WOWXaFwW8fYSxzdOW60Kr3nPyv2AkrB42anhUQrFnOsJUk=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(7636003)(356005)(82740400003)(26005)(426003)(336012)(47076005)(36860700001)(107886003)(1076003)(2616005)(40480700001)(7696005)(6666004)(86362001)(2906002)(316002)(4326008)(6916009)(70206006)(8676002)(70586007)(41300700001)(8936002)(54906003)(36756003)(5660300002)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:18:58.9318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4fe5ac-b258-4c78-dbf2-08dba7da1a5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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



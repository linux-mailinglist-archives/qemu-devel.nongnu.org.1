Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDA769312
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6w-0000hY-Bc; Mon, 31 Jul 2023 06:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ63-0000aq-UC
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:25:51 -0400
Received: from mail-co1nam11on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::618]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ61-0006tC-Gm
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqstIj8ok82b0LKEtgl3j+UTUcsKVseHELCXywkv2+ogNBMPua+AZgUE8472XVD2JHKxY/IvAO79ER+WmukmDGNovg54sa2DikTIS3Fo8ZhrunT670Lz0svK03txli0eUWqMBkvX3LZKIx2vuUNRl7JBwuTMOwAnfQhYZgQTGOhjqYeByB/l4CnTy9yFzZxBbhUJSEjY7nIGdQ+4HiYDuwveDrAe/eJRLdsDQjSx84DWVbgre0+kIZLtM1piYdxvceJLmG1QeieQqzzRmhZHBEXVNyNddWDlrA68/57qRreT3sYBVv+gglUhR39PAXGYNDTypCN8930agTS6yPk6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JJJi1BljvRnqc53fMAMnBZ/7qU6EKYrUo6YPtPQy70=;
 b=lCBk7wxN9QtBWhcmskUDv2SwkZBNuweeovFhykgaUJ5F1n9Jnd7SecTnHpeBtfOuclXAi62DL/xt56NW9vhAQVF8tL9FV0j+8mIdq7bOj8fwv2RC3d+20oOVnah7FlzgJ27daqXVr7Mws3xOMAizdCVVU4xngRHpJcJD1wZK9IaxbvI3y/Sn0Zk8SkauWRx5b1YfgHx5M95NE4jPXwOTMydH1R+bk33Ea8xGB15nHH+6jDBAXWLnsQA661re8wYcEaKLDu5o0k5ei57P5TSf+iTfTv2b3GwkzhG2gmjQOFFpNiwTF4hkeQ1GsOjrJ1LAilEZO78+6cVh/M83omwhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JJJi1BljvRnqc53fMAMnBZ/7qU6EKYrUo6YPtPQy70=;
 b=pCckrrsZwMLp3CZYmXjATLPl8eAoijXBGPvJ9NSrLUj5TvSg1b+Z+VG/N14giVng8AAk39KL6FZM+vQkgaFz4OU39s7aK7SEeT5XDX3PuoCwHLhMquFX4mIcCElkHL9cm6Bi4D5atiqg/1mn89UIGlyPhBbPj2sQ2FKMLmdT+gjxrKRwAVFIIHjWJ5qXgrmyTBtpBqWgvHIKuJnsJpci/37wzGZ6reVpyKvX6CJHdBX1fLNNvR32sFMBwONLbls4nLErl7j85yCk/JbCguypPKxmhpetXCNus4rfpkPSfbC2nT9ZXyIbrwSQH+5kpZ1S6JJONLJwB55ae0Gxj9jkOg==
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 10:25:45 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::34) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 10:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 10:25:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:28 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:25 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 1/6] vfio/migration: Move from STOP_COPY to STOP in
 vfio_save_cleanup()
Date: Mon, 31 Jul 2023 13:25:16 +0300
Message-ID: <20230731102521.15335-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230731102521.15335-1-avihaih@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6bb181-484a-4dcd-9cac-08db91b07fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjCT+R5NcSlHE6Gg4HaLg/3QHyFqkPNYlXNgnTxMdpOgrWf+kwMOJhNWMvFCXGAu8jgEpy3xP5v8trJQpFQeHfer5CE/7tdzEpuwlZgKfImVrsJIfNrwZjjkCNlsd2soAQ2P9CLTqTHItAluUwrbMJ9qCCsYtu51FB7wKkhtuRKXUL/R3FECEkHAjREgf64TrpmKJbpPZeUQeZTsaLCT8ZGzoW7Qixw88hF+sYPbJsTVA+P9yH7HNuTTqfyLQhvywG5jf5gwv3zPBFnGscybGdXJlTYCCq8dP1a5zQvwYmOLeIe938Gau7lupjh67kuwr8OoSkt6imM/h8hEQoeH3S0Fr+fgKXCxNqdnW88ECfMYlryDpv10XjY8GkcKzVnULR9h00OMLGgzrvOJ95KR/bolV3aEvF+qjbDdly+/T/sE7F0QT+F2O1ULYE3wVRwNQiSdKe61zU2tgc4u9YUy6YsGex4OE/S0AhNUSVLBryBX7NCD8E3WLpwQ4kdk17p5dRlLVW6ZaNVpfSTFQ9pNT8c1xyO1H/6mU3ib23Ks9SAGw6GDc41slu8RnW/smnLykUvU29sFbyG3ULMTQ5znXcEXXdXPviH7Y+2LbYfEpya0ah4wQIRQOPGfsvtkWJtldUfgj55rBgEBQYBtzKC+2iXTFWuzmDRws0W83LCVhnIMCbks3ZM7uX0KLQIBjZSbQ5KT8qGnN5s5SAV7ZjHlhoCf4QiYsDQaJRvGDQu31qM4LK2a+e1GjJfUbaTxTzh+
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(5660300002)(2616005)(426003)(1076003)(8936002)(8676002)(186003)(336012)(36860700001)(316002)(26005)(47076005)(83380400001)(478600001)(70586007)(70206006)(4326008)(6916009)(54906003)(107886003)(6666004)(7696005)(41300700001)(86362001)(40480700001)(40460700003)(36756003)(2906002)(356005)(7636003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:25:44.6038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6bb181-484a-4dcd-9cac-08db91b07fcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
Received-SPF: softfail client-ip=2a01:111:f400:7eab::618;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BE706D62
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJTB-0003j9-UX; Wed, 17 May 2023 11:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSc-0003Ro-DZ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:53:11 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSa-0005z9-Hz
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMlWqNhnmfUQ53BthkmHmGeLFFxYtBRsqFgt83GGkRL6aH0YfR41xMNMnElw+P3jUKQa00I8axu1UWOrmtlSSZpc4wl7RyHpmKoT70Ct+wTmOEbZW/hIksTu+fSPdhHt4HGbw776B753irHsGGerBOcjzRL4fnIWxoYeYj47NNiofg6I9d1DuwMyXIziLyl9OxIoiJvZ+cLYVBcrRu01PRv/UFBQULkPnsJVoAzANZs8HsBSGy4h6vTCrZmyh/F4FAAoGqkvN/K7z1f8WoCOPnPJfK590iNIsUB4KTzFFwjRWhhdwLqMxpBiEgkymvb6lL3AxVSV3AC9051NTSES2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=L0e4rIkydafEhV7NI9eZy4XolITJfgV9bfbyS6x4l+FX1WPbEpYS0zNgOMdBadtVpFvFBaJQ8F8jPbJmfjqRfD029bJ3qEo+zPHF4psiiDpiGE9fcz8XS7A0qfesv0POs6WJ6njaTwzp7LlCS4qb+gL1jbO8Zl2trTREZZU5dqktnvP5ZmXlPU3GrcrWffUhKMSfoKERWi/ZV77vIdExH7j5mMXpv096vXSXwigbypBt2KnBQLpw/78IiVn/CYL5iOGuN3C6UfThzw9j/geWxklS9rElgZbOWv2t5o2zmPtnA3AyfXqK472lKOyPbUn1knK35InUylLM1m9WhCyC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=L7x3TtdJN6v7yRvMnSTRS4Yg6jM+3t3nzF8W0WVXBll8JJ20+TzHsJ2pA6o913smDXLU1MYKcCW3dTb/cjkAsYoZ7eNcvgqxDhOtGvqJotMKayiQg0CBbjMmxqIliyfEQXXw9f6tvSiSbopoof2j5HtHgZhG8FXxLaRJBDbUe6BwO4dsG100B4aWRdaTUGeVdfsm18qQRUX8xkspF8XdslF1qVzthXPkZ8dECOnIXGvR6KiRRzlbMpWDYZaw/efcDZgms0oDDWbUmFF7GBjypKlnMH9u06HI7V0Kw75Br6HPSruDt9N5TjU/3ufJ9j4pqGLkXAdL6Si1xQRBw00BBA==
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:53:01 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::3a) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 15:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 15:53:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:52:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:52:51 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:46 -0700
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
Subject: [PATCH v2 5/7] vfio/migration: Refactor vfio_save_block() to return
 saved data size
Date: Wed, 17 May 2023 18:52:17 +0300
Message-ID: <20230517155219.10691-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230517155219.10691-1-avihaih@nvidia.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CH2PR12MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: c9043374-d4fc-4bc0-c6c6-08db56eecacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCeJPF+23reuPStsyMwkyTdvnuPDIYAajc8WXU4zrZhYqO/aqBJYnoxcQNFPmEe9b4YyOsaZMGQocMS+1EZXNkCi3sc7w79DIvANolHoO/83urVK9eYnQVrmQAZx9unj2XZ3lZ1xp963hNDv1+v7lglyxvxwc2dH4T06GA3rSWE/OkRcsGy4xXxHc+76G6QztELEIo+Bqv19XciDy51UJ575DPdRKGlGocV6Bh7UeonwH016mvE96hKs5MbqosO3kdvF+ps6S6Y1cNJnbzod/kDFkXu1e8iYj6k2Ti5X/AA7WN/qgP8YowfJsPiho9/1bU8OdPMn+qFjIFEHiv8XB0db+dR2rGXHcAQTKXRW3QM94aM3lWoEanN3sWaItMxkG6izI20Kw8AvVEWTKV9TRffAOu/xOrgvCgJqqYB7i80n+yewBZ86KErEshJYYaHpNve/QrsUUw0hl7d47pAdHvkl/F8xYlbTIHUIr9+MaJycQXCD8qp2UtUeAd+rfqSGTKI1hpO+DOQ+0q77lc0it9lh9ljrGrPdC9Sb+SfHi7xocPftlSrW7fIoXvCoR18aueZ4wfrLJ8QVaJBMpV1q/rw9F0AR6iZwuoi18r74bmvQxCki/nu98EHQSV2beAA2OqBon8whlrv+XOQWPzbP3TUtgpYiZ5rRg1zTJTl6DSyDDuLPEvL+2Y5gV+ofU6B5S4wfqi94g35bhdipQmD8Ti9XGUufvE7PCiTk20Bl1MclarOkps1fNOX38JQwAFfC
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(36756003)(2906002)(7416002)(426003)(336012)(8676002)(5660300002)(8936002)(40460700003)(41300700001)(40480700001)(86362001)(70206006)(54906003)(70586007)(478600001)(7696005)(316002)(6666004)(83380400001)(186003)(82740400003)(7636003)(1076003)(36860700001)(356005)(82310400005)(66574015)(2616005)(47076005)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:53:00.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9043374-d4fc-4bc0-c6c6-08db56eecacf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Refactor vfio_save_block() to return the size of saved data on success
and -errno on error.

This will be used in next patch to implement VFIO migration pre-copy
support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/vfio/migration.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b58dddb88..235978fd68 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -241,8 +241,8 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
     return 0;
 }
 
-/* Returns 1 if end-of-stream is reached, 0 if more data and -errno if error */
-static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
+/* Returns the size of saved data on success and -errno on error */
+static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 {
     ssize_t data_size;
 
@@ -252,7 +252,7 @@ static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
         return -errno;
     }
     if (data_size == 0) {
-        return 1;
+        return 0;
     }
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
@@ -262,7 +262,7 @@ static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 
     trace_vfio_save_block(migration->vbasedev->name, data_size);
 
-    return qemu_file_get_error(f);
+    return qemu_file_get_error(f) ?: data_size;
 }
 
 /* ---------------------------------------------------------------------- */
@@ -335,6 +335,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    ssize_t data_size;
     int ret;
 
     /* We reach here with device state STOP only */
@@ -345,11 +346,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     }
 
     do {
-        ret = vfio_save_block(f, vbasedev->migration);
-        if (ret < 0) {
-            return ret;
+        data_size = vfio_save_block(f, vbasedev->migration);
+        if (data_size < 0) {
+            return data_size;
         }
-    } while (!ret);
+    } while (data_size);
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     ret = qemu_file_get_error(f);
-- 
2.26.3



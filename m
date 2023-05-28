Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC227139E4
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3l-00019h-4O; Sun, 28 May 2023 10:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3i-00018J-Tu
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:47 -0400
Received: from mail-dm6nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::62c]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3d-0002pE-OH
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2AZdAenA8oTwe//bG0OSCjx7nq8Ta41ik/TAY12q2deW3nGsgnlpQvZU2vJuGow7FiUGBzW6D6qs4tmBjNgCZhKp/BlLOh5WF58OzoOQ9mdPlr1Ruv6A0xAzvP8Xrf1TDgJs0Txx4LFIToIOssTB7e+qMEcqOc5In9hGaH851u6wPAD/slfis6sGWWPLNMfdgHV2sukhtvVSCOM3SN8cc2FynbPoPUyaXswbEkcixdsf9R2pNCfjUVaJAqpqVRy8s2UJPAijSnbTZVTa+7WFloORzcDGc8HmYLL84ZcAfZmrpDPgwoYYKWDecs44b9Yx3RAAOL34TKtUdjjoK1Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=P8vvMQwAxli+DGWFZnhDHmw7FNYF4lG22j/ru4TBdFr0QuAURGTCdk8O5a5mvjv9XaxWiQ6Y7R+yg6zGsOp8cH/BHY4t0YNyaQwgTlsgfK8GZ3rwx6LLDvoSAiDunLD9CSGi4nkyrUIz98OWILkcBbbx397Q+cYqLKoRtyHq9uHcmI9yh6QGRdrlXkBw1jFtTO8X75e7tCPLaPJzyPZAxfJEEKvG3fE40VDu5xPIox14BBhZwnFYcCZUSuEM/2OCEdJ3LdmrBpJytPVtlaPOctbzsmfe4ckrI/3knRug/rs2Bp6Jkk0FYBySB0AdzCzRm2RaAGdaTHujV33UcfFLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=JXrgB5yQQ6TC+xNY7K+9E8OMpHkbrfw3H/o0V4LWSOIfnBFeHNy/hwA5+D7DLHNrfXUPcLhLoUmK60pqAVarzMjPcZ8qY9dPQxFq41ur/SFJvPE415irc64xv2FHOqw7ER7NsLj7DFS3nsqwhXybvbQaTbt3FWLUpIBaeI6xpTlNzHSOwZn4YbmNMei350c3DB2n6Haoh892Hx2XtIj2rFtGCI8nj80RhJOLSinRWbwvs69btvpGx/+YdZWxK8F1/LgJF+7SNNKhOor5/kGNHY3++bMqvguOpKFzU2EcZzMtbrE3V+59BEttmlPM9jgKdjP1MlSqjbnSFqkkR/WrpA==
Received: from DM6PR06CA0048.namprd06.prod.outlook.com (2603:10b6:5:54::25) by
 BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 14:07:35 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::be) by DM6PR06CA0048.outlook.office365.com
 (2603:10b6:5:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Sun, 28 May 2023 14:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 14:07:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:28 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:07:22 -0700
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
Subject: [PATCH v4 5/9] vfio/migration: Refactor vfio_save_block() to return
 saved data size
Date: Sun, 28 May 2023 17:06:48 +0300
Message-ID: <20230528140652.8693-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdbef92-44f1-4688-8ecf-08db5f84e30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4jKLxRjf1EJmaNZag2uwq3Df6rF8L//s/sAxpVNdnJYWoh5bv4O/aYzKNCNH6NWQl1062DWX/qoMmmz3N2fJu+tsLh/Si6Lyu5K72EEXg5illl3te72mqpm8TFoZVbAhW7+9bDXCKjQ+mkfKYzmgi8vqKoshidMYDmeddtJC3VwHNkaBT4o56nkkoieafN8vCRqHmvxp9Ll9F0sS+Qn63j0GNa5Rm2wgQAKMPz99O4OVy5Zedbn+p0o2Vqua8yu8WA9Tk9Dg4CESa7iG3re+ujTfoPGcuYMMFQ/oGVC9cZEA0InPJABpivaVKQY1+Vu1h9vzYeJszFvzSa9kVs1Mzpu/qRz0pjqqDVKNuAMCARQCb77OmDoM1q2FxZsPTHzaB/xXZwTryrxRLC11uuM6A/3hnuEz2qyI916LhJcLuNtAmYLGmmrz8GudGerTeNAQE+k60uqBVXqvl+UhltJ/UmZzLiOUYQCik5L4dgBb6Wj+oJZV6iLqnJurOi79YNHybsvBt4VKnVha8JONRc6vF1EpoD43nCEOmOfhbnEn8M09ag0eNTbqDcrs+74gR8xK3dTDW8s6kS5jXsoUa/9PLt8Bpu9a6mZxNTv5oWoevdarVkD62xFb4viJv7FVeV24bE5/inB4s+QwT90vJWOZUskoPVLR3CEfTj0bGF1Wr5UPWFXYvMY8R8ofFCmR0xrvGbHb/7B89M/EB1dnXg+E3MWJbPmv+RYYwPtxbSxVq5gIwwHRbu9K3wqiI/jfPtI
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(54906003)(478600001)(40460700003)(5660300002)(8676002)(8936002)(7416002)(36756003)(2906002)(86362001)(82310400005)(70206006)(70586007)(4326008)(6916009)(82740400003)(7636003)(356005)(316002)(40480700001)(41300700001)(2616005)(336012)(426003)(186003)(26005)(1076003)(66574015)(47076005)(7696005)(36860700001)(6666004)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:35.1223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdbef92-44f1-4688-8ecf-08db5f84e30c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
Received-SPF: softfail client-ip=2a01:111:f400:fe59::62c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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



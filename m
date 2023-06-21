Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413773823B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlr-00080K-Qn; Wed, 21 Jun 2023 07:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlm-0007wQ-3c
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:13:02 -0400
Received: from mail-co1nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::61c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlj-0002aj-Q3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaD47/Hj4evgcmzl3u+QQXI6nVK2mgCygf431w/rCNgBjn1GIFPsv+D5RAG6AydWrLWkdVNpm5qumuAcINPHyV6o8tocGsCoOJ2T7zHE7WLf76ZzaLJbANBSEMVLDPrvmqRUuj15Fgp8390yu3LvQf++S2UFdtcu35iv2Pw8J8u6izk2Gwa1IubEoS6bLdiSGtI2mbyRg779HwjI5swdIyxdnX5C/pEYq7nQIwk+odHyR+kYPe4FgBD1eaVQr4Ga3sjcUahczwGd9x0PsGVy5UCKFt2dmMGNKdImtY1Rqu/kr10xy+6BCGIdWKsnwzjV+hT7paMT/ar30qHjm5C8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FhmB2+Xyuy1oef2WkwLBFJTvUzrCEpjFJAaiUT1s3Q=;
 b=bhoSAsvdKqrgur2q/ebP9481A/a8DlKZh1S0Mx4+2ZeEmWrSjor/Z83VZOE8Ue70/q2xVjIAgislla3/SP4DU2ezFMtlu0ZVxmpqiWipQJMquRJ6BJacFMq1OmL1jPWYsMpt32tRrber/zn30Hn30K7fsSVjyFfyh3CrlC/hphjrniAmlHddDzfIfaUPE467O61O9UOk25hycyk+yGGIsndUdEq1q/6YF4tLK7m4dxveGy0HVlwR6rPOx4YFNTqU7o0Fpmy3OR+KiMj5KavToPSTBwODYUTK0AWeG9lKPTXb5LeF31Y7o7N0wbX7nZhj5Qm5hheaiDadouwx9prLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FhmB2+Xyuy1oef2WkwLBFJTvUzrCEpjFJAaiUT1s3Q=;
 b=S0XvcrHxl6w9jyBqcwAvLHVhH9/e64KAafco+c2/e7iPX44cjzGGASgGoJjaTu9983+x7ws1PFTHOkib8awd7QOhoGXfAiZuWwvSuAmu9sGiFLo02/+IXLslDZ6dtX8YcP2OTxa9OfBTXVudInyr+L7acR3YfDvE6fEa1fGl+JDithoDDnjmd3J34n4uX3vR1mTEjGQXYbGGToSPXumpcEsOpzOylAbp8r5KpG6b99tmFCcbjzCJnEQSLCg7HXYwkRqiuQS0lYCfp0cLBm0acfHS7FQ76fS+bU8gjghm4SePw+BB71woR0U6MVMfY5M7ew7Dgs75amL5mPE2Eih+dw==
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 11:12:54 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::29) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.41 via Frontend Transport; Wed, 21 Jun 2023 11:12:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:35 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:30 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v6 6/8] vfio/migration: Store VFIO migration flags in
 VFIOMigration
Date: Wed, 21 Jun 2023 14:11:59 +0300
Message-ID: <20230621111201.29729-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: d443d339-0909-43f1-8055-08db72487611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WpxAyBcTTSFRy3ZRumO2sq2gliV9W+bAVW9N+L8rzuhst3fvs5E9urAhD2ZG0wRFAKUmsuRVfy8hX36pL1rp3Q2/cZPX4/wK4JoAh82xBQFRx3XPftLbnn0yEiYVaEoVSXHVllJLEVp38qyxgMLqZoQg19/BJYRysRHrCK+gH/mw2xBtE9Hj4v3zb9VwT+tTzL5MFdZSm3t6eCF2Q6y+ANv04RB4T+pZk6HzOQY+3okZ8O0xiFHo7hDJtX5yLiUXcGQa4Ho6LXsNXb2mM+VzUg4sezAfH7OePTimT5HMroGvQ3VKg1ftm2jrto7jTK+5Rcb7cRyE13tc3bMjoxM3OALsgVIJzKN+YqtWlcbHUbqDw41VuyS6Vi0zD41W+TehI1uznro3Ey47/A2UMQMSNzKjycKbOrsh+FKtDaBtQi2lMNOCwg2NE1RayNgQPzp50W2S4GdGkjq8dGwmhFVPrFDmJS2ViBP4QY+38MiRfyk+eH46diXRdDZKiMP3pHFqgL/S8SlBVLkFdHorH/XTneSawh7GLeIMDwXYY3EiUSI9Ej1RrxgvQsfxJQqIfrZCY5PkinYE/A0JALKKBaSh/2h5CUzV7qzKMeyN4jMNgFDgvzNxYPPL8KC6SSPKPzSxfA1FrpSth0gl9UanJKfjXr/lNO5d2cPhTQuUGBOerbbtunAPq+d0dcQR0HRhuHAVMGFqvxt2gbC0c3364T8H40/qexORFNGP+7BsLABfDYnpy6Aav0f7iKsZZ2XB57e
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(478600001)(6666004)(70206006)(6916009)(70586007)(82310400005)(26005)(186003)(2616005)(1076003)(336012)(7696005)(40460700003)(4326008)(41300700001)(5660300002)(316002)(8936002)(8676002)(7416002)(40480700001)(2906002)(356005)(7636003)(82740400003)(36756003)(86362001)(36860700001)(426003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:54.5721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d443d339-0909-43f1-8055-08db72487611
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
Received-SPF: softfail client-ip=2a01:111:f400:7eab::61c;
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

VFIO migration flags are queried once in vfio_migration_init(). Store
them in VFIOMigration so they can be used later to check the device's
migration capabilities without re-querying them.

This will be used in the next patch to check if the device supports
precopy migration.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/migration.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f..5f29dab839 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -66,6 +66,7 @@ typedef struct VFIOMigration {
     int data_fd;
     void *data_buffer;
     size_t data_buffer_size;
+    uint64_t mig_flags;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 235978fd68..8d33414379 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -603,6 +603,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     migration->vbasedev = vbasedev;
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
     migration->data_fd = -1;
+    migration->mig_flags = mig_flags;
 
     vbasedev->dirty_pages_supported = vfio_dma_logging_supported(vbasedev);
 
-- 
2.26.3



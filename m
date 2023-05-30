Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE87164FE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40fG-0004iB-Dk; Tue, 30 May 2023 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40f0-0003BW-5M
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:18 -0400
Received: from mail-bn8nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40ex-0007sd-24
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdwYDJU2s1g67/B9YFUj/MiFznDX7r+XqcapE4J9h/Ftxz2GGNnJ4uP62Q4sQFl9DjTairPgQ0k4uAMDgeSWgYK5+u0/4QdCfSvawLLPhbHbr+49LmkODDl0oZdWYkHhI+0l6TSNkQY/SCzGOPaog6kl7tCtva3C+JhJIT7oawWHNC7gh8uOOo73I5Cajnpq7Onhc6Mcj+BM7K/zlv8An4ujRF8/s9MzqrmeTiRA+oAzfVc0vcKVL1ZFxFFkWnCd6L3V7/lwOZJpKtn7y5RzaPXna7m8i5TbA7KPTP4JVe7Q+qEClBwpS4pWuIMLoIwp5lHV/rgNUPufeLHcLB2U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhA/YmiyC04Ww+XJicjCWGfho1lz+NY/70626nKviN8=;
 b=ecMU4XHv+WRkn/dpfX5eO7/9FE/UzyrjYXrMjfQwlMKlFY7sSUEabFtAORj/106YyKQemxXSMtQYT94vhHQCxd/Tk5wOx8Z5JL68FWmxYrelU/zfWGF9vlj6R8HH36I2dsjO2PjamGJbiZkeeVa89moLbj24pb+Rlol/Ifa83/BKApsORVcQ6Z45bz20vvKbebAbMsr77GR99lfskyGLypOwCYbiEHyDhXykCUuVXsnkWK4FN4UxEJe8kwOuB/4jc+TUDoo7U6kOujU65kP5K9yVwSRMJGeqB1VAMnV62QGGR1OpsFszMUEdHhe96pPI8AfC3ywmeeRPvxP2tzjBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhA/YmiyC04Ww+XJicjCWGfho1lz+NY/70626nKviN8=;
 b=ZoAoHk/lUjEo0WwzyxdEX56l5ZL8RTqgi+jLjZkUkVF4IIM/Fn1qQ2wQRfitxHtcqMbbor0LHAO68LSbPvcFvn0m2h5tFBDtAhYitAWI6mudoUMnHzuM6qGDmiBX/n1qTZKoBOhjhijwla5xRBCOwXmidPwsY7kljp6RJusfcyK6rObH2mrMQYT6hARQTRjOlfe71cZdLP02y7BPxtqMPK2Tu5ztVoUNgKxGEstESoD9Yyf3R4R4l/cNiFf5bOFBKGpOBMxXw8wC1A0mLIaouKNjnqNoninZiJf11rAZSZYD7iKIHs0YjMMWhyGFTaNhykO32iqkqHjWxq9+fGInzQ==
Received: from DM6PR02CA0155.namprd02.prod.outlook.com (2603:10b6:5:332::22)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:49:10 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::33) by DM6PR02CA0155.outlook.office365.com
 (2603:10b6:5:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:49:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:49:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:49:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:48:56 -0700
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
Subject: [PATCH v5 6/9] vfio/migration: Store VFIO migration flags in
 VFIOMigration
Date: Tue, 30 May 2023 17:48:18 +0300
Message-ID: <20230530144821.1557-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ea0f01-8469-4325-b76e-08db611d070e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eduXI9+gfFq5XwrCc3O8hxRwl6Bo3MXkrBSmEixJs7h5LjSbLRZBk5YvKT0sdjgyRJY1/4vG3y1RCoV4EOY7MNeIC27fTAtLAQB+8IWVTVEEryC42bESSJoPETFpXR+qxGIASuV/vBd5Y0F/5an6DGyb4mFtesttkMLTmxaldBI0Tgvg/21IiSju40O/yEjZWMdowF+lonP5Y5zQlvZkg4qzKUk3pM/9Hf/9Rt25DDfZp0dPZnsR66xEaXz3Nlgr4H73qaXdlWH7IX89y1Ol/hfip/OhwYTMumEwAVHZBghTZajUUUCRachMpd/Pb8h4C7r7AYOP0PtdcSEwI51PRSmgU28C42+UlqDPefBKSI9B69MOZJjFBqf6P53q1RCoqIbKLNzrGRUtftHk1RA90UHq2UbU2foqvX0mHMVg3PEAumb9Y/x5OdlZe8AN9MX+0inWhFt07AJX+8j3lVBnSOjJD6ZZvnVJYNlQc+hswtlQxEHYO4kJ7hI7uyWgWU80+P/M0lBPsInQgxu/7ryy8/XyOeukdzSHRpld/rM47W8ahauE/eKCivQ2zy/WtE44vNXk+3RqDFr2D9jXg/GoaBEbtHc6AAIBam+49fbfx8ziIRmpoDNSLWA+IrOCk0f9twt/IffpzXjOmZirF0D385Vh4RCiG2u/wumesYjQNE9oTgSBuHYZyKu0KD+LQlLvdLEvT1M7zYmfzt9p0VrX4cGIscYv3fz+flShrfAIGJsmgSm8grLJNhVbL/T1i9Mw
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(478600001)(40460700003)(8936002)(7416002)(5660300002)(8676002)(2906002)(86362001)(82310400005)(6916009)(70206006)(70586007)(82740400003)(4326008)(7636003)(356005)(316002)(40480700001)(36756003)(41300700001)(2616005)(336012)(426003)(186003)(1076003)(26005)(47076005)(7696005)(36860700001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:49:10.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ea0f01-8469-4325-b76e-08db611d070e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::62b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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



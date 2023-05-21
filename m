Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC170AE7F
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kpj-00088O-O9; Sun, 21 May 2023 11:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kph-00088A-Ge
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:53 -0400
Received: from mail-bn7nam10on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::613]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpf-0000DC-NX
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU6YAhZULMlelE0EK0rynOA1O1woYt+XYHAktaYv0ebzyqtZBn5e6zfV4kYfuIvp2PF170qtAWHr9ISZYl/8C3HWpBdmpwIFRurNOnXxxftqCYxpe5A/GPGvMLG2zT7q0ikz3O7vBGcJXpKU7/c22vcZBrnKciqmtaBTMw1wMi5WhsGA0vtHJTPpk/iK2yeExxB1kLJzECLejJUsq4sd/IX5C8wBq6nFrdMxSrf10G9VIDR4W91jZoVjrO0L3UtYaFrz6lgT+QIHRgAsJKMpdHLMg3ZVNob+R5KS0yjUSEnRXYUFiZH3CsL6qwK7FYmrD48KNL+voni0yLkKnBEz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=fUNId7bwvNMlDzC/KLy+DYuEwy3IRQVQdvBfVaSZI7z+u84t6ojsafmxcNsN9MaQP7GPcgYj4RuvCsi/wiSTlwM393mKlydJFHUxFDT/VPQuqmmjcwkJBAUXe1RvTHYrfCYbgRCU46CR1INAb2GSvwVraOJo6EvUwhljsw2eFoIN2sFYSI70/HjOVNvKv7JblJbJqzs5gKQrcAf7zSksF5JS5GGKUdiONf1y6Tnsc6zlop/3JOJPOHk+j1eBKzR1Tl+uD7pIg/rlw8BpBaWNixhyCXEtluZ+pEgt/gm4IStgjTN76IczTjVRDbXR5w+TvEdE6CDFifvGdIZIbs60HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h68j4Dm1Q/+H4wT8g4CxjcyAuM4Dnwee3te5mdFcdNY=;
 b=gFdd15yXEOtP9aVrdoYpVA1Vg8/6SVXPD/H//Fm9AwydqlwsCNh3YXrmHfZ+/RRhyRy7v2uPv9cTR+EAyVp6E8E3cCoAtdzDkT77aWhADOqSMozLLURL1TsusHXDiWhwUrWUIGnXRd2UGzD51hZDJFbPqFx9LB+WlFwf3bY7ZImjobWcPkjmx3BdOynmfkzxaxIfIZmT6DPDxPRu5OM0hwcRVyNGY5wernZGTw/uDLn03MOg50kWrdyZt8hUw/1+/lclx8rtkOGD7qUvEKeO3ATILmwEVh6Tfdqf/4IzIsgZtMAa/+DPJQj7+7DaoJojTD93Rsfu4KU3qFaWllHoVw==
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 15:18:47 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::94) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Sun, 21 May 2023 15:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27 via Frontend Transport; Sun, 21 May 2023 15:18:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:42 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:37 -0700
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
Subject: [PATCH v3 5/7] vfio/migration: Refactor vfio_save_block() to return
 saved data size
Date: Sun, 21 May 2023 18:18:06 +0300
Message-ID: <20230521151808.24804-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230521151808.24804-1-avihaih@nvidia.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: edfd5de1-41b3-4182-16da-08db5a0eac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJRd7qHs/wd0f2yiqTH+y6xLVdwCzmsgAZFYf2ePmbzQaAOrsobZPeyFTd5pl0ARooAs+dBzkhLt5I44wu0wxIXdPDOvzmt+tnkybxtkOzdWdfOqW1x6bggTVmU9+cPYAPn4CC0lV1vMxYNkMmYrrXnc9FBGWYEWQEG9KkN+Uzi7zq1g+HyYbhKOF/9CPLB7WWv+NFqsKq7a9qdKPCNDQoQzbwq0BVjfK/ZcxAw4dCpCgEaNyIoQbWD31c4QUOa1guy4n/C/Gt3O22/FjoGkg9edQDQNfzyRm7t/zg4IWIMjovLPrlG0dr1KXesu1ATOV94LpAgduwZFqIBlowArmco3EZUahoRrHtj/96pcHqM/8DoJ/fCWESIyWus5KkjHmA8+OOcX7Cf9KyWT0awdCsgOGnPdkMv65zegDXKK6X66+zwb8HKFJqREP5NAk+GNTEwmJRusydGLOUGED9CtqZ1eWnPQbYtH2zKQAVRfRZwv6mGis56o0m7WFrXwB26erHJGCPMYatDX3ZPh34glbscjRBhiBmR2DXbRU+T9YaZRLq9SLGjaxo9P7RusTC7WjKjhgRy8zwvG5kc/F502G7mhPP6DjceytxJBqEWAo2qmJmr+3pABzxXdNsQCWiP8eAHILGPwARYhC84HYQ/0BzmnxK5DLQyi39kEXjkQiPLweZoVo2mu8A9eHT3YYYKCbn8oFH7Bce7mD2ef6NcxeoZR/XslKzIHbMMY+WmaX1uwZBBsIl0ZffrG/i2xrHwJ
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(316002)(54906003)(4326008)(6916009)(7636003)(70206006)(70586007)(82740400003)(356005)(41300700001)(7696005)(82310400005)(6666004)(478600001)(86362001)(8676002)(40460700003)(5660300002)(8936002)(186003)(40480700001)(7416002)(1076003)(26005)(36756003)(336012)(426003)(36860700001)(83380400001)(2616005)(2906002)(47076005)(66574015);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:18:46.6863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfd5de1-41b3-4182-16da-08db5a0eac2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::613;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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



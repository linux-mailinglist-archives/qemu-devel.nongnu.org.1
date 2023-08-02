Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7259076C832
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR70r-0006oJ-TX; Wed, 02 Aug 2023 04:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70q-0006im-3s
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:20 -0400
Received: from mail-co1nam11on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::60c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70o-0006Oa-8U
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Rng97+cjvCYvTnnJYHJa5IA3nT8x/pHK+tnyBqUUsAe7kQKtD1ttLtf3eQw8HKxgR5w/VTKE7Jxvn0sLJIl9VccNmDRqpU+orjLbbb2sAfIigDdY6EfyUiDAQE4U12GX8JKvisIP2z9mEoqhWgaDIpSu8OxVL6wwz1zV2KlXaJilk5LPpHWHPmCFCPmhvJ7PnvnzgUja+jtaiAnnBz+LO56otBOvMdYfmuiYnIZVn1gg4KJWb5M552MWTZvO+i5B4YIBGKS2przLXMlvqxPjPLt9er92BP0cQvBZxvauzSYe23bMqs5Uc3eAg7OLiXBvUKtWc2F9jBBOF/MhQbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JJJi1BljvRnqc53fMAMnBZ/7qU6EKYrUo6YPtPQy70=;
 b=RLGrdeqeXLim677zX/houHqOwVrD3iDGlBDVFban2vRk+ofdyJnExMGHQbWRKmgjNdBnK7jDcqMaelPE7H61KSOKeASwSfJAKMelkv4r64DQfcx6p/laEYdOTjMi8pfnFiPgoMio0yUwUHsyJl2Sb/8moVC4yERglIC1oCdL3rEV1FmSVMszwupiLBES9YKvvKi2Vp7o5W6UouQNzMMOpm3jEy7fBaGN+rjX9iV1ZLERw/DUBT782O0jRJC9FUytvAN2ANIvrZxq0O+dySg7goip2KQEbH6k9ikzdn+XhwLoXkm4iu9qvu0BL3YPAoG4xzbw8VwklJfOUQM/zf/B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JJJi1BljvRnqc53fMAMnBZ/7qU6EKYrUo6YPtPQy70=;
 b=AV+ZAcWfa/yH0f/j+47N2tKRHI7PX4h7ToMLQXtxC3IBw2RKHJNaSN09Z43nMOdklEN9TbUNoa1cGJw4nesFktTuqqXZojgheyCGydVWnF3XriZa30K3zvcsrM/xYZIR9i2LxwPhCvSeUBSbCvOc6/bDkzPShSMyJhb7dR2XlS6oabpcz2UTehDQEjxFrurxw+PNspZhH+sksxniAASynn4sEf8uviMHx1qTMw8YKJIq69kOwM+2uEM5hd7FVWTV1UwG+bgeFo3bou3JOrQly1+3bYGk/iikFQ5qAF9QucCwJ5TzHWrTfq8jfgUyVcO47C9xCRxhtHzGu8MtT7NpPg==
Received: from BYAPR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:c0::43)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:12 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::6c) by BYAPR05CA0030.outlook.office365.com
 (2603:10b6:a03:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:14:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:14:57 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:14:54 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 1/6] vfio/migration: Move from STOP_COPY to STOP in
 vfio_save_cleanup()
Date: Wed, 2 Aug 2023 11:14:44 +0300
Message-ID: <20230802081449.2528-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbe9e71-7a6e-455e-6093-08db93309827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdzTIg1md3hf8LBbhkamzqlh3Q+MxBMs0/K9gc9+4dD5zv7+8RRbWjI/ZE7iKKGWOSUA3hyyN4GGrrjQ2V7XFIuwlpKPgaR/v3U6ZLxet4HfDxyiSmTgHXudsTrLcDzIBNziMbklC2UvvIk/DbtS1l40vTE2MzsOv0mfg9dYe/bmgYsqkqtt5dXfFw+fkSzbcvwNxEMl5L7PvCIHDhyG5vByD0FpjgNm7/qGUrOw7UFJyU9JMztCdKMIw1qRFok+Fw1z8NdHvuiPgV+l56+JLiXp4o4TenBS9LFDruz3FAi4H4CjG4ckweb3M+HzJhrdwBjcZelfoFC3+Ih/jg5RNSvCyHc9+stmDeGN3ezVX5ZxCK38GmiJVZZzn9I2NVZdkEz4pIb6xnWj1h5sqzNQYoBrf6wURY5jFKKPPnGt5A+oWywlGtlbOLMYxtTn+r74VG9p2xINBmehWe8Dyogscnt9zHLs6Zr0df7AgEE7Dqsx7QR+h7h2uVStqcxB8bkGRR0bTW8RFpS/1oUxIIVYWbjQZ+J1VRSZA3taqXGYTwmkI8HJfAZgKJR/PsDVg+mNRXZ8TYl87F8i31t9UYlJjlpk59cUcJ1MUDT407KPqoNzNCWuBrGa5s9pA6OTDk0ElMZwsvdAR60WdWftuJYi6xnfIULxka7csGymd9SwLyBqTxdMeQC3xzFNRAeFjPXKWMGj9/7ekldVFlXdalxubWUGD5zVPpAXGqy0uN/qZ0faddAGxAuFXr0OatYizxgQ
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(5660300002)(426003)(26005)(41300700001)(107886003)(36860700001)(2906002)(83380400001)(1076003)(47076005)(36756003)(40460700003)(336012)(2616005)(40480700001)(478600001)(54906003)(7636003)(316002)(86362001)(82740400003)(7696005)(356005)(70586007)(70206006)(6666004)(4326008)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:12.1925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbe9e71-7a6e-455e-6093-08db93309827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
Received-SPF: softfail client-ip=2a01:111:f400:7eab::60c;
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



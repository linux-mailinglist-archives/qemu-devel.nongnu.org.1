Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FC73D9B7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhbF-00018U-Ja; Mon, 26 Jun 2023 04:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhbB-00015X-Nz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:29:25 -0400
Received: from mail-sn1nam02on2050.outbound.protection.outlook.com
 ([40.107.96.50] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDhb3-0004Dq-F8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqMGIfZczlAElzYCfYzeTzJewaHQNXV5J5zNhyy7fkrkomIlLT2gEtISKXtEY/7BFPdlsqWZLF+d91vYCSrUWTZla+aGExtgiL8qPkgB49M4CAZt0rrPZul/C6xSvKs+XLhmRY2zsH0zDc1cRRqi4dySCn1YE8fN0ITxajHKvFabUNpp/v5w3o99gQmFS89IM9av7LnmBaTRYkYcRzAyKBC/6bSMd8u8d21PXaD5w4oOYWbI3vtIfTQdr5vlHSBVKRrG7ocPKF/65tnCxrT4LoIG4RCHs1iXbL0KcJ0HYCtFA/eu3BPH7i0/ZqdFLk1pBwE9wKI/xwxiy+ARann1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Myto345SPZplQL2pF3pF3n8IQnpGEGItr0GimxqrUfE=;
 b=mVMLjtxBhw+jb0wmd3wcwa34wmuXW9gK9AJLeae8yhWbGTpKVFThugY2znXOz8ZEAuZb56xJ87KNImUO/IefQ6UiDwhUzEuTC5oUmnBZpeujKhlbR2geEcX0AqmC98qqMiqQGYsHoeR7V39UdzwzJNO5sYU+XEIVDqLFP5BskzsQ1Drm8VlhpcBNaSJxwcMO3tBh09xgBJXBIG8/rN/x3l9Z5XsTLqYfjGvIrnTIELGF13MC6fQVSlK2QTcmzAICyQilfxPIQSYGgYUR7aM5IdmbZeKhwdSJkBKFmeZZgHB8E2OYqD635iuXlL+CEPI/py2yH3Iz5oYuV7mPUtFm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myto345SPZplQL2pF3pF3n8IQnpGEGItr0GimxqrUfE=;
 b=fUAleG1Xc28bGMvMv3af5BUJkACpnEa2D586VDRa7yvAs/nLIN+uDXKfVMnrWStZIfLPJH76UXVzzoXwbmr+1JcTALVsSm4kwRxntZWG9hMRwsJxo+MLs8oAb+U7cnckQyDHd66+IKQuSYFvmEhKaHJTzHNqYoLrwCFygA8n8j8N8ZXz+D2ATOF9mjLjPNkzA4gmp1r1ZRok0LLyj+eNDtpv1wtOunKOf+YaqYuxDksCRWfTWkwpBDPOKj6CE4gPgFmzaKi9YDXW2s5Th8aR70lb7MCLM8hGml5ExiWknI3Iq0PukaZgmPH7FA43woO/py2ZSqp9Qy6R6QXd+7qY9g==
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 08:24:12 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::db) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Mon, 26 Jun 2023 08:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 08:24:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 01:24:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 01:24:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 26 Jun
 2023 01:23:58 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH 1/3] vfio/migration: Move from STOP_COPY to STOP in
 vfio_save_cleanup()
Date: Mon, 26 Jun 2023 11:23:51 +0300
Message-ID: <20230626082353.18535-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230626082353.18535-1-avihaih@nvidia.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f4e4c1-bd4d-4a31-65a1-08db761eb8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxumrOASINa41Y9FUXGYvrrTdInAjGDEadEyP9yGkR91yDBrqDtyuM3CviE7Ljfw4cp2Y1jQ3DhjfFn4YRn5Mzpb+Bq3ZxTVLdGR4VNNsaPjok2ee94nktSCvY3mm151Q9yU5JVlhKdxTnidkO40hlTWrSv40Ex3dGQI2sUiKBY0oXdmlXXsEtuwaFbPcBiAH5QatFoHqIvrdJe/qsiZbfEFKzJDPiomL7rMiOsPFFVETVhfOpcapo8UPIVj2h1JufO5v4F8hLWcdOUu43aExv6CscqMBnyPEB59TLXlRt/v9UFWZQxpKhqZkzKqGp5havW76CCD2rhbNgdpnPdMSj0JTDV1OctGTCOKPhSkelgYAo7EWJMPYvc4ATywKMD0qwG27J2QwaAyQtKuxcpdxOF1raN0EXJZfS/3gvnLN88gF97v398fhDP8Ig/WY06uFFrMfWZlq2hiI6I9Y2pIZQpCm7zqbp2LJqYYRLocirWczyesjNNyo4j8UAmZH2ctX5WIhuo3i4hTlDfxZNSk5xShi99CJtwGVhE+HnidINxqtFrs81KmA0CZE8ijLGeLAzXYeNL5JuiEJ1xZMoXEJ9dOGGWxxBZMp95kURtF223/jhkwYWNK2Uwka6ZKjJjdy/F2v5fWmIUJoQGCvqNWE7AsseK7BHFhbWrggZJoMhhYIr12kx6DKQTT/ZdPNr0ZrctM6mbsGbRzlp7fNkdTESNflj6BdAx745qM7T+JLgi6ODMtELllxcro9M9G7Uod
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(82310400005)(83380400001)(2616005)(186003)(7636003)(356005)(40480700001)(1076003)(426003)(47076005)(336012)(40460700003)(36860700001)(36756003)(316002)(6916009)(70586007)(4326008)(70206006)(8936002)(8676002)(26005)(86362001)(2906002)(41300700001)(5660300002)(54906003)(82740400003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:24:12.2470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f4e4c1-bd4d-4a31-65a1-08db761eb8c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
Received-SPF: softfail client-ip=40.107.96.50; envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index acbf0bb7ab..a8bfbe4b89 100644
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



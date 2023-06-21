Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0117738239
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlc-0007PR-7D; Wed, 21 Jun 2023 07:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlX-0007ME-VL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:48 -0400
Received: from mail-bn7nam10on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlV-0002Xq-8S
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhDbLVvGSn7WjrIj+ho/EICdapmyn7zntY+6anhJsxjKIULjvHa729DEz/0bV8zZD7IGB3sTPlkJ3fGcKq292RdIEISDWcqycNFhnrxivVDBjE+fFZPwq4j8st+lw7thrfYveg3QXLcOfEdylO5VLe1e9z9sHSh7wZwGf5zpUnl7WJV4Kk12XxtsuEMf01Y2qeFeyj2oT0ucbhNJBnWmHYUfMqrpGNAttr1N36vR/88DSjbw0qccw4+dode36wEsp26tVURWX6Mr8oQfIZwhxhAmF5N/+FQLDFoTwdT6+TxOuB6PayjJcBMM94fSAC8L/rwMBp5mj4vfqtETOpgQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x4zCSxKb7rP9YzA5xOn59RCxNucU5BY6IkAtnQ2zDs=;
 b=JPZKpn36d/J9IrOEKV+uqFdCIRDoZj2ZsD0RkT1vHOT6jwKMMvBk1ASXfWaKUi78/fuGZERoydZrzFJCAKiXaRqbmnXMr+FuXIgVQ8gLP/7l/wfMIF73htmYlWkOsc1qsFuq8n/NWSkOuhzRf3oTkg9ANANE2eHoVNkcNcTPxVjxOFj2xBD9uUVK+KixMNMLpJtpmERS0ln8u2Vct4u5ovaE98xvT+F47tL3ERMNn/GpdlpcAU+/nXdrCoCIx+wU3Hm+ql+lOo8pAXFSUGiAXur9W04C4ix8ppohdnVWzC4lo3XkMSQJg7YsrUhVLv7pPMjuOVJ9NOKAe70uxJri2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x4zCSxKb7rP9YzA5xOn59RCxNucU5BY6IkAtnQ2zDs=;
 b=C7iAN4NkUVDAhhpY2iEqkZvdH5rv6v7+B/ry1QQhWY/RvSGO78lHzVbYdMcGU1/PNUqcyFKgLARd2cWsGaCAEVmI8URgy7Yzlo7+LMUmpHk8xbriqVFPgJgHh7W+kQ+ii6R+iZPTl515DCLyjv5toEzyePyKd/+/9+t7fYgMtTyhRNl6/kKNIqzc8v/zmlKMnvTTVQI6QEKGRKhvIfU7M4nvxDaAVj6I7F1xx/SpN2TTVjXOGpNK+vSN3qrC/9fZIQl/fL+ySevG7VjXy5GPwh1rpDKfoasL8vNcX/OHhroJ7Ppk5unyjNzWK9xjK7Bm+cNn9YGYY7ulD3tn/JV4bQ==
Received: from CY8PR11CA0018.namprd11.prod.outlook.com (2603:10b6:930:48::7)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 11:12:41 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::b6) by CY8PR11CA0018.outlook.office365.com
 (2603:10b6:930:48::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.20 via Frontend Transport; Wed, 21 Jun 2023 11:12:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:30 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:26 -0700
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
Subject: [PATCH v6 5/8] vfio/migration: Refactor vfio_save_block() to return
 saved data size
Date: Wed, 21 Jun 2023 14:11:58 +0300
Message-ID: <20230621111201.29729-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 5214141c-9e72-476d-dee5-08db72486dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWAu8NBjRjMgPzuaBScYck6fEx55iLdi14OWrINY1uzhOAnZZjh6c7WMhxgN8h7Uavryt0ikaB645q78bmd48YMZbqcrob0ejKx2Wa3rJG7f5Fs5mw4G+UViYyFmBvkHomaQxJ42Np1mZ41o8n/+G705oJ0G2avl+EZtpv8DyiVLV83ctSdh1xaA6ur2dpHr2XDkHi14Ejb480bnvI1MzuPkocsajSy2V/34kw8FGalnVZyh9ESJN8BPBA9Am9qvW4feMcUxkatIDjPrHHSSMioVLpOq/uqeQ0xOX04z6rcb159wJX/OvuQjt3myWyOtXMRM/B0X6+K0NWN4Q6/Jh9YVI2Qy43By2CpAb7hRYZ7vWxpn68uh9UlVnRSm3DaU7z5R/gA5xvlmxq7G+DpH/AWhHth3+yYlgGnHmltZykkyv6b/So0mjJRnAXsW/P7sltDB+Y1G2dNekG1L+Yq1DLWJnHYwdkL7xmlrlga9ztNLybG7+HeKy2yEBACwetJicMqgSbNE9UQs62wqgbYgzR3Shic0E6g1EGYdGv0U6cvCEP27QKq5cCnB6tkmMjRPblymu11iT6qFryL2QRfMoYhgi4WmXpNJJivX0pjD8T7ZMk93GK3wcEwP22JV87FiGu1qu35dvIbSqXbCNZvOgs7Szi27te9hoIdKEZKlzu9hUQaEGXujn9htKQ0qpm0gW2ygXrsalT9OrwmHsM2m9YHGhszkugZ9ayfJq90TMApW38J7UC/Y9AjCktBvKIBF
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(70586007)(41300700001)(70206006)(40460700003)(4326008)(6916009)(2616005)(7636003)(186003)(356005)(82310400005)(86362001)(26005)(36860700001)(1076003)(66574015)(83380400001)(47076005)(426003)(336012)(82740400003)(478600001)(36756003)(7696005)(6666004)(54906003)(40480700001)(2906002)(5660300002)(7416002)(8936002)(8676002)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:40.6284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5214141c-9e72-476d-dee5-08db72486dc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::62c;
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
Tested-by: YangHang Liu <yanghliu@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A506F723456
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:07:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LAP-0004Uc-N6; Mon, 05 Jun 2023 21:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6Jy2-0002zJ-8A
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:50:31 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6Jy0-0008Nv-1k
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO/MSH9sAK9Gag62BJR3qcM5FOUzUyj9RVM04nHb6fnwG3Qf2vwUfg72jxRNe6U/a/xaANParHVKZHqdrOZvdhFQfYOKOQZ7kTYbElwQXh5stpjZxCHTFbr1yaC5w7AHBsk0DdzySt13G0/r7RQUfcNb/i/v6HQG+RwjJr719ojI6ML5T4RNfYYo1A+f9hwDrUHFbQcGaxg6qXLOTUK4TXeoLbHzckAaJvWP7aOYSQllngvepIkpON9cHXuk6AgbFXFVgOhwurMjBT5G4STXw2OicBC7ivsUj/AlSsp2SQX/OqjdPxNueWgOUwhFPPmaK4y3SYoce7X56vbfCl/Ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh0DJHpkPzzT0Au2dX5TwTQG/hy2oVHD1eWmLWBtq/Q=;
 b=kzPlKf1r5FnjH+Vc26qIGNAZOvl/tJHHDLDLgv1gt5hQ9XeT3V65KAK+Pqe84NKR9ni5qRvELXh1JUom7DT2BVgmE5bfJKCfedF5T8GRXk9UMPDHe3+t7RILZlvE7t1XaqXDnDBcM2quXrh0AtjFTdUpN3KWsSEgXNjL9Hf+x4eSGcCQMWxcHMrQxV2/llAFKFqjPCspxnb2iGW4TPjxA3z/ip1+Wh3XxT1vn8P3hvVGhsHTeRX3hlTmzrhhlqEsC2YwSGjiRhNqS5BiElFEQ3/S9bM0qhPikz+Xj0XYbSEP+ZHxRcWUX6yXUgMkexBoKUAutrjAaB4nT/buiBI4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh0DJHpkPzzT0Au2dX5TwTQG/hy2oVHD1eWmLWBtq/Q=;
 b=KmZmK5MKlJ85yzRX+tPQuSshYW4Nvahf7l9DSOc8WC9CH4XoYfXMBPypyB++bXTjKiv5OBIBzuAZeOn0WeRSWHJTf5aCiQqL9nGW39AEAB0bXq5qJm3jaEB7iXiaSorSfIX8iKZ8nJDOdEEYc0prJFwBWjYYIGideKPCa9m1thY/ht9OA0f7G5rJCUhK7/quNa+kqq6fNObVQGisvMWgmtVkj5S+x3IMB2/FhgWONXWKqattZcWzjuMwiF+IYs3r4BHORAMDOukgKGPoANmOCzywbJYbXRBdnJ3jg9Sgh1qh1FlYmc9vd1SpmTXlnh7WQojFO6DqbjCMJb2Q3UUVRQ==
Received: from BY5PR20CA0035.namprd20.prod.outlook.com (2603:10b6:a03:1f4::48)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 23:50:23 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::27) by BY5PR20CA0035.outlook.office365.com
 (2603:10b6:a03:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 23:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 23:50:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 16:50:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 5 Jun 2023 16:50:06 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 5 Jun 2023 16:50:06 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>
CC: <qemu-devel@nongnu.org>
Subject: [RFC v1 4/4] qemu: adjust queried bar size to power-of-2
Date: Mon, 5 Jun 2023 16:50:05 -0700
Message-ID: <20230605235005.20649-5-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605235005.20649-1-ankita@nvidia.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: ff330727-5456-4920-c6f1-08db661fa086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJR74sqVwPJCSjMNCl8GV7V4bYqVkvs0tUGNppv2h9uGeb3oTxyALG3B5NktgSQ0Ph1UHK7fsEddeA1XZzQrsFIbS9mPv6fyhxi+RkkD1iVeNC83r5uAlOtTOriE0c9WrRY+m4R2oSF873WEKsAkGaEqyyzM+/JBMbAs5IF94V84T0Y14SEWuIFvXI/k7KzRWy4G2CvP0OP7ANN6hds37KL2qYhqGuYOzvLVWVT6fzeLGq0DlF4wLV6DjN1hlFzNxrvwAXd86lWYc3xwxHScI6qynLx6kFrzxHCAlArm/mklYbD2zqRtdqux4LsvpniGJFgH4Jqrcq857lMGjGCimWVgU5KpQXHMMtXGMFhwzSbyZO9ISM5WTxnEHADbW/8NiMNlg9M4tqkH9qctOz6njig3dQIyQjTJVY1mTDmHM4SyHZjfrh9GbIwWOLWSBxNqcA+W4r1BbcnvZQeSxnVKPyCLdLZnuY++VPPoeKYXK44QcYMQ8GPpGEBrgtHslaKod22PlvOfd8WJ2wQhuSMNlx3k0rwizr1p344RXlDEgeBPvmrmq0NR93nCkQu3x4oh5pV/c19QkE/mNNZFvAz2Kue5/jsGC+0ZiE5jBpCM1gsxS+EuDo0NRSvxlkLpidf5tYu31FkqJsZhp597j0d8LCC9KA40sqKtwA6AGPbCmbqYWn4LhYLjP1Ng/orcyPXuHR97sQ3DcFrMcabfc1ED8VzPUbm90pw7/MJqe9nmxZAu+honn1BFgSVUN8N9wPDj
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(1076003)(26005)(36860700001)(36756003)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(82740400003)(186003)(356005)(7636003)(2616005)(41300700001)(110136005)(4744005)(478600001)(2906002)(70206006)(70586007)(8936002)(4326008)(8676002)(316002)(5660300002)(7696005)(2876002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 23:50:22.5326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff330727-5456-4920-c6f1-08db661fa086
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
Received-SPF: softfail client-ip=2a01:111:f400:fe59::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Jun 2023 21:07:19 -0400
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

From: Ankit Agrawal <ankita@nvidia.com>

The GPU device memory is reported to the VM as a BAR. The device memory
may not be aligned to the power-of-2, but the QEMU expects the PCI BAR to
be. Align the reported device memory size to the next power-of-2 before
QEMU does an mmap.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4d01ea3515..bb49200458 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -2061,7 +2061,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
     region->vbasedev = vbasedev;
     region->flags = info->flags;
-    region->size = info->size;
+    region->size = info->size ? pow2ceil(info->size) : info->size;
     region->fd_offset = info->offset;
     region->nr = index;
 
-- 
2.17.1



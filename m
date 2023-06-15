Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF838730BF6
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 02:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9aUM-0005pE-4X; Wed, 14 Jun 2023 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUI-0005m2-Dt
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:19 -0400
Received: from mail-dm6nam10on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUF-0006r8-FY
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWqJWv4CJuvpySqo0+6Ebe1H6T3d+C6DMRre9jFtCXSto7Hd3SI+u0wb+MLwUVoRzgc7v4bNoDWTHM4QYOCNs9prXzDsVFXb32fYfVx3k9F3R3r5RMihQxYj8J6tY1lEN4pzkUm/x8nFgxWqYDez8qgub7LRm9WAVbZhjTbylMPYkr/TnXKJ+7aclpEVzf+EdssF2trkmIY7FA9m9C+zw6yBikq7hVK6h14RF1akeG/52ODnbcTqX6ezfL2wXq/2UM+mB1SqV9rK21/e4PtfvtTqLNBDYJfDAt4h9ppR84c+G5h0Vfe3jFco1VYQzr6c9DCB9Zl8p+SjYflhLCPJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhReVhB10vpU72bAY3AMOPyk1Ul54IekP2dQt2HzTMI=;
 b=Nz4kkFSwwsLVCRW3zDlqm4Cnidp8n8V8MuFQEiYZ/zOk1ARL/ELyNrxqD4LuqbaHZNrGWdghS1dVjWKFmNnam+l3eIgoNch/l+sJBC++mR4V5/ezjM6mRmXrUPWM7paYosym6jykMyGvBDn9KNYmddKl9KRXYDMSZ2PCVmWkfpAB8b8x+RUwXjqu9UtyDaQdrC0nh1ID1M6CDdHNbv5U+nQdTib57xtSlFURLKeV1ZOTlaJ6HiGTKX/hoFzv7CBZU7bS07DV4QxWbtPldA/ojM8aUd/hDP+/epxgplnERMEPH5N3vEyxjFRJkjddu3YUG/0TeLi53evvcnlWY1fwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhReVhB10vpU72bAY3AMOPyk1Ul54IekP2dQt2HzTMI=;
 b=VYdUPU3selH8INXbaj8Mm0878UfiuSvzh1bvT6ztD8aum/MmC2Po+mtPqEfozENbLE3UF5KuZFU0TI6C8DQNftvZrsoh/D1GR2pcz5ENgkraDWqD/busZ1yZH+drSVAD5tMax3mSgBFqfaVMCI5afHM8VfNiFKTN657iVvu4aRo=
Received: from MW4PR03CA0038.namprd03.prod.outlook.com (2603:10b6:303:8e::13)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 00:05:12 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::49) by MW4PR03CA0038.outlook.office365.com
 (2603:10b6:303:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38 via Frontend
 Transport; Thu, 15 Jun 2023 00:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 00:05:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:05:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 17:04:40 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 14 Jun 2023 19:04:40 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Stefano Stabellini <stefano.stabellini@amd.com>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, "open list:X86 Xen
 CPUs" <xen-devel@lists.xenproject.org>
Subject: [QEMU][PATCH v8 05/11] include/hw/xen/xen_common: return error from
 xen_create_ioreq_server
Date: Wed, 14 Jun 2023 17:03:33 -0700
Message-ID: <20230615000340.1135-6-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615000340.1135-1-vikram.garhwal@amd.com>
References: <20230615000340.1135-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: e3521574-0481-4543-9174-08db6d342fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wi+CBZe7JJw8ZmKTtcBgPGte0fnVfCFVBoBMzibtTeM5v4zrD+U7AvUUXHmjwAg1nBIRKDPwBXr+PKzRyvowauS17v8BkN/IsxDYME+wjG4VL7tg36DH10cjTa1jC/rLGI4P/P/u6+kLHhsdxUnOESygvnzQndWaEaJTdVoFSuRylZEPRWaXUQG+bHOinkZxEYdbtXET+Nn1BpqhW6XwnRYTFSO8LRp9GWaaFnCXMppO9JBKh9oxF/2jbOUPY2Y7l9YcIDBRhIzVCwXnwdIvwS0WQIe/833dP0K7WtIs9d7CN1r+9zBMNq5+FTYT5AjrmQWkNpWSyBzztwUo7isEtLU8EMhnVz+5KRVA1AOjHO3dZcwkL91mjFob/IIuQvIt5RCjb5FJc0wfBfovPpb9bgkKtZPo0dSCSCr7dBb4Xk3bHq76+27idyGCdMPIk1whsK4ZdXT7Y5yq6LEvImDRSIPcwarXsHQZGjZ1+gG/DWDubzhwphSZ24YWLl/CuSH39X1teCZMKSt5QMrfaiVwr5h79AA2ZQYGLyVJnZZMb7Y2nOP/7wtHejn6HUS6e79kRxDiG9a+2sFMu6RbghJj8yh5vuzsUuakRNMawRqCZQPYSEiARyremTfzEqT0ROUBERx/h9nTUqxEYTqLBLlqmXWe5vKnj0pahx78JwoxSB5FM98OsoXqT/K5ixjOg7N7f+HLrfSJxPfzAZilKWFloAeylEkjL92wYZevA3Tsw60uqW5VdhFH5TJO/l6pRN2KJrCQ9fi06XPcEAlqTndmyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(2906002)(8676002)(70586007)(70206006)(44832011)(54906003)(6666004)(4326008)(26005)(1076003)(41300700001)(316002)(6916009)(186003)(36860700001)(82740400003)(356005)(426003)(336012)(47076005)(83380400001)(2616005)(40460700003)(478600001)(40480700001)(82310400005)(36756003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:05:11.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3521574-0481-4543-9174-08db6d342fec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62d;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

This is done to prepare for enabling xenpv support for ARM architecture.
On ARM it is possible to have a functioning xenpv machine with only the
PV backends and no IOREQ server. If the IOREQ server creation fails,
continue to the PV backends initialization.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 include/hw/xen/xen_native.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index f11eb423e3..4dce905fde 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -463,8 +463,8 @@ static inline void xen_unmap_pcidev(domid_t dom,
                                                   PCI_FUNC(pci_dev->devfn));
 }
 
-static inline void xen_create_ioreq_server(domid_t dom,
-                                           ioservid_t *ioservid)
+static inline int xen_create_ioreq_server(domid_t dom,
+                                          ioservid_t *ioservid)
 {
     int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
                                                 HVM_IOREQSRV_BUFIOREQ_ATOMIC,
@@ -472,12 +472,14 @@ static inline void xen_create_ioreq_server(domid_t dom,
 
     if (rc == 0) {
         trace_xen_ioreq_server_create(*ioservid);
-        return;
+        return rc;
     }
 
     *ioservid = 0;
     use_default_ioreq_server = true;
     trace_xen_default_ioreq_server();
+
+    return rc;
 }
 
 static inline void xen_destroy_ioreq_server(domid_t dom,
-- 
2.17.1



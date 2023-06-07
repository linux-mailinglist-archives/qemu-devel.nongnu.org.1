Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A367266F2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkR-0008Pd-NW; Wed, 07 Jun 2023 13:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkO-0008OP-Bm
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:01 -0400
Received: from mail-mw2nam12on20604.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::604]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkM-0005tZ-HF
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjSOqNAIySM4JAPBaHPXfAw1sF8Rtjvb0jC0l/B6VLszaIpWk9cz5Uv8iWxagnVHqMlvuAboIlcuJ3oegfSxAopnXwBNi75gSj6/m2FebdfYjPSn/gtIt+C0NzNN5+PxDWILiJLVdw/Dbdu/gLMAX/DBgnhbqUPPR2/5Ov3Mv4KprZZdqkSOr+SFIvPo8LYS4eyVA2N3909/ziTAe5SUIxymxSjKBF2czB+lFRwTDxmdaq0KPwSuB1zXpF7CgZ1ohFJ0C4ojxPGr+K2fVsXnuHqMxg/8oCb/M4upllXs3kaTnEoPNW/jg01GP6dn2oi3vt9EPiSsu9Zk19ewepUgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+MsXx2C2vfZr2Qm3zKi15wdouNswZ682yQUmM+5jY4=;
 b=ZLktXNNJuKnQnTg501Xl1sQVFBMnUZoIMYQUKZsXeMu11zMv1sqwouWIDKrssOxudRBTpSh24B6P//SmPAMzaxacfpK62lHGwBTlRq9mCJ+zVJY7qlE1I4dwMJ6KnUAD1OtCrSx9zhjyez83QgrQDgLdIqDTgtvWu8ey3klf7oL/tPahLhXzUv+HHgftVtwfWaUaO8jZmTt+PbddxA7Gp6RdHlPRJ99pFPSVOS29hytjmZO2RzkWZx27S74gry2hJRKdZbwisVUV92TunffzJeivBwiBgt/XssXfFSyVBIX+HhmPqiOTj8hw9yT73dA/kmMyg/gjbBKXFfCe6cwAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+MsXx2C2vfZr2Qm3zKi15wdouNswZ682yQUmM+5jY4=;
 b=b7AM66erG4YHmncKXvyDPoo0AAncQdt+CmBqjD0+ptzm3qbzrM5wligXWJO0v6ue77rnr4UaSFwAEBP1p9/4teSds+LFZU3RsKhsNiN7/6LDAw8RYVLOEeyD3oFQoD1EVeUMUJqlpwphiDJ78qHaecknSjAvZCrjGaanTQcFjhE=
Received: from CY5PR19CA0082.namprd19.prod.outlook.com (2603:10b6:930:69::28)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:14:54 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::ae) by CY5PR19CA0082.outlook.office365.com
 (2603:10b6:930:69::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:14:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 10:14:52 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:52 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: [QEMU][PATCH v7 05/10] include/hw/xen/xen_common: return error from
 xen_create_ioreq_server
Date: Wed, 7 Jun 2023 10:04:54 -0700
Message-ID: <20230607170459.14722-6-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ba29e7-3b52-4ac6-5902-08db677ab5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQLeP520E1Szze00HTcT7aDdrCR/LoumiPfQkzZ5O2pNaIVbq/sHa16RJx1bw9Zu3ujkB6xnju+BZ3caVistO+9+WrTTJxuuOOSS9NRbxUgWmZZcPlywx4e1rFaHeXgz71IrdwTWt0/vWTIxpiS4c//JCnrRd6XnGWNrhqIJNc5i7pFJj3XGHhK1NmHV3pH54TuQBg7BTdCaxUpf9Y8UpokuH0/EQQ89ufmePt3tY73Pqx2MCsvB592h+mNXDXmQ9b5kX2FgemSe0hSCYuV8tMw/42yVwvIrRlfPTQSJVcAP5iW2GlU0pHNFfHMGk2/Jp8ENEU2yWrf22HOTGoYUZLeJNVaPkH0u8qObp1TT/gdQuG0rDR1AMlWS7vBKDpDwvcUN4VD173BvywnKudTECXcTOY0XyHJJedESIJ3TKtgTi0IfvDFGw62omX32kyNn6NzefG4JjzwPfAqfI+8WHcOMwKmxQcN/zILGetoRMl6JraZ5ld9zQ/wbkddBmBDJ72nwDBH4knJAsutYtVfB17sqaVawnW/fP1b7V9BRY6HfmErmQJvkAzjZZlnzXjq/V8qMP1uucyMETkwYRkCFjpFVqRerNmoSTuD8qYtbABCwlkG0oV3L4wx+nBXtLuVKadQD/oXy1yDeRt7iLUxVnbuJ9EREytSoHDzZw2hIitvDOXT1zdqJtEIHAxxlE+/yIbKhjMbhHHvFsunnpKTUc1U8IxtfNYqU/Kzn47ePM/vH+OuC9O+wN9WIhRs6yfifGPQMk8FfxUm1yZRw4+U83w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(426003)(336012)(82740400003)(478600001)(44832011)(40480700001)(40460700003)(8676002)(8936002)(41300700001)(70206006)(70586007)(81166007)(356005)(316002)(6916009)(5660300002)(4326008)(86362001)(36756003)(2906002)(82310400005)(54906003)(36860700001)(26005)(186003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:53.8717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ba29e7-3b52-4ac6-5902-08db677ab5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::604;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
 include/hw/xen/xen_native.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 6bcc83baf9..8b01b071e5 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -433,9 +433,10 @@ static inline void xen_unmap_pcidev(domid_t dom,
 {
 }
 
-static inline void xen_create_ioreq_server(domid_t dom,
-                                           ioservid_t *ioservid)
+static inline int xen_create_ioreq_server(domid_t dom,
+                                          ioservid_t *ioservid)
 {
+    return 0;
 }
 
 static inline void xen_destroy_ioreq_server(domid_t dom,
@@ -566,8 +567,8 @@ static inline void xen_unmap_pcidev(domid_t dom,
                                                   PCI_FUNC(pci_dev->devfn));
 }
 
-static inline void xen_create_ioreq_server(domid_t dom,
-                                           ioservid_t *ioservid)
+static inline int xen_create_ioreq_server(domid_t dom,
+                                          ioservid_t *ioservid)
 {
     int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
                                                 HVM_IOREQSRV_BUFIOREQ_ATOMIC,
@@ -575,12 +576,14 @@ static inline void xen_create_ioreq_server(domid_t dom,
 
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



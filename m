Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20912726704
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkQ-0008OY-E6; Wed, 07 Jun 2023 13:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkO-0008ON-4n
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:00 -0400
Received: from mail-dm6nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::627]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkM-0005tb-8k
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:14:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq9WMLmcRK00LIJFwl12ZivOOiZ3orsgXd+kILEdApkSaV07O2DRkLvHGe+Z6Ay4Iz8CN2RQqTkbKtVo8V8ZCN4S+cDZcfl0gk89oL2qEIyxYEjjS/jgwLRy8ibxAVAM9T5pM7RXRd3CJG3ihDafF5GEwAJsskqquTHtwQFZnFZCrenmT/vd4YIIkRTejJFP12Xl4yiZs0zGC2dZviRQ5342xJq4T3GDEhto43uiXln1hF/kC+jeMjPet530icvhGbNqellqiTg3ee9H6NLRXT6Hu0FlzPUcZWhB8yc2121tUbu9eVpKOl5NjhQWltLwDWnjRXoL17pNwuv/HZkgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOsqWHq5VHxUgGsBfaYThNjh0r5g1aFE14BtltHtrOE=;
 b=dHXgS6Fxh8wWe5vzaKcyOWMkw2tOEq/NAt2WLnOj9qyhXLCsl5OvGGtKMecsPDKPZS/fK3Zr1/fII3U5SIIDC2Nb04S/nga43DcLwJts5X6hIEuZvttaXFoilllhy1naaA02rQ0P015Lv+SgylK5CvAPtMnLqyYBLD5DREV8GDQspaiAhVIAXQSX4atkC5wLVT8GLDsExduCUGoNlTTSc+XcjyGMLHNe2KW1SEZUViVgOssgpvF2ij1CwCTmRr7TV8qe4FpwkdgljwNrke1TTcoJ70l5ry7jY7HgHh82aA2x2HcUcYfXqFhNGAtLqq6deWXbktgSu0ftA8cHkI1v/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOsqWHq5VHxUgGsBfaYThNjh0r5g1aFE14BtltHtrOE=;
 b=swfgr2rET17B2I26ocJL2sTnUJAn00UTe4KHuChz5s5QNfccOe7Rbq/Z8aZ+euF/kA3aDgPHqI0XlTvFyG89o2owBowASGyj/MQIFoi+DXmhbEn0AKxQ3i8KMlt/LnmRA21YHFTrdx54rgpySMS7IoPt4Fwd4V2B9P7j9ZRM+HM=
Received: from CY5PR19CA0061.namprd19.prod.outlook.com (2603:10b6:930:69::7)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:14:55 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::28) by CY5PR19CA0061.outlook.office365.com
 (2603:10b6:930:69::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:14:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:53 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:53 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v7 07/10] hw/xen/xen-hvm-common: Use g_new and
 error_report
Date: Wed, 7 Jun 2023 10:04:56 -0700
Message-ID: <20230607170459.14722-8-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: f09cbfd8-b7cd-41a5-cb61-08db677ab64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+hViedXyJhjp8IDO7GLNAbC05RfppP0fIiLGZMHV/iCFL2PiYmfrKryiRKpRbElsz7tvYp3p5BzqOceTpFhw5INLl0wJ+X06PuITr+XAwAWT//g0DilOH6tW94lpA5U3chLlkLK1ZNCycIc5t01WRgYPXiDj8G3K8iOJfv0eyOjfyMoXdzV9Gp3riZ08MnRg4mrUxhoyB30yHLF1XUvvCimVOX4C+S8wYqe9DAtjFJU6uhHnSdoGDVX1a2igsFejQYY/+p7XxxlwT4Yj8ARMEaIcCMqUxfUUJzKoZbBFSEVg0VeYnyef2A0QPOYKeWJIW74jVd65QXq8QuzWceMyZGf9eQlz/VTiC5CDCWILlwVE3F81xnXdYOSrLCBn/XrfVjIotM/bZPB+SGrWCsA3ikRNlxrh94IbZV8GQQALb4hFCgdogONzE4ME7/7qhg6Zs93kKr2Wf5LL9Obc1iTdcsyroyqPLqWh/XNBAzaF9i+d0kbVZqVwt6eK4lYN8S44FU2R2jlr0Qsp9HyPCAqSiYugkQzuJ2AJhjP0fx0t7FJCFGbNdKCfuZl6Tf1OqX13teolrUbUmTKYlL+s6L3/HZGyWdOOJg1ACU+HbF688my1Qnfk68T5GhEUjLcb49bVwxGssHh5KEFhkEWWmQp7QY5hMKB8I0X2Ykv9a3Rfd0Oq4mGE3I0HrAXWw0F3TaPeDw0CnAmc55htsQ8DFH1BM9a74CNRxb4ZPJOquPfu38tmy28LZPrBHLwoGQTMcz3MIQyi+oNG1y7qyAK1hBOtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(8676002)(4326008)(478600001)(54906003)(41300700001)(316002)(5660300002)(1076003)(186003)(44832011)(70206006)(70586007)(26005)(6916009)(2616005)(47076005)(336012)(426003)(83380400001)(2906002)(40460700003)(81166007)(356005)(82740400003)(40480700001)(36860700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:54.4186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09cbfd8-b7cd-41a5-cb61-08db677ab64d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
Received-SPF: softfail client-ip=2a01:111:f400:7e88::627;
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

Replace g_malloc with g_new and perror with error_report.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/xen/xen-hvm-common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index cb82f4b83d..42339c96bd 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -33,7 +33,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
     trace_xen_ram_alloc(ram_addr, size);
 
     nr_pfn = size >> TARGET_PAGE_BITS;
-    pfn_list = g_malloc(sizeof (*pfn_list) * nr_pfn);
+    pfn_list = g_new(xen_pfn_t, nr_pfn);
 
     for (i = 0; i < nr_pfn; i++) {
         pfn_list[i] = (ram_addr >> TARGET_PAGE_BITS) + i;
@@ -730,7 +730,7 @@ void destroy_hvm_domain(bool reboot)
             return;
         }
         if (errno != ENOTTY /* old Xen */) {
-            perror("xendevicemodel_shutdown failed");
+            error_report("xendevicemodel_shutdown failed with error %d", errno);
         }
         /* well, try the old thing then */
     }
@@ -784,7 +784,7 @@ static void xen_do_ioreq_register(XenIOState *state,
     }
 
     /* Note: cpus is empty at this point in init */
-    state->cpu_by_vcpu_id = g_malloc0(max_cpus * sizeof(CPUState *));
+    state->cpu_by_vcpu_id = g_new0(CPUState *, max_cpus);
 
     rc = xen_set_ioreq_server_state(xen_domid, state->ioservid, true);
     if (rc < 0) {
@@ -793,7 +793,7 @@ static void xen_do_ioreq_register(XenIOState *state,
         goto err;
     }
 
-    state->ioreq_local_port = g_malloc0(max_cpus * sizeof (evtchn_port_t));
+    state->ioreq_local_port = g_new0(evtchn_port_t, max_cpus);
 
     /* FIXME: how about if we overflow the page here? */
     for (i = 0; i < max_cpus; i++) {
@@ -850,13 +850,13 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
 
     state->xce_handle = qemu_xen_evtchn_open();
     if (state->xce_handle == NULL) {
-        perror("xen: event channel open");
+        error_report("xen: event channel open failed with error %d", errno);
         goto err;
     }
 
     state->xenstore = xs_daemon_open();
     if (state->xenstore == NULL) {
-        perror("xen: xenstore open");
+        error_report("xen: xenstore open failed with error %d", errno);
         goto err;
     }
 
-- 
2.17.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 975897BA8EE
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSuT-0000Jj-N8; Thu, 05 Oct 2023 14:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSuR-0000Ie-M3
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:17:15 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSuP-0006AS-L0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab1OYBWdEoBFUmAgxCPaGsx90ekdARYa9PmsLO8/SyYogxrnipxkLJiX1jkFK/vU15+TYOAkYtwGoUK6Qib9YKvlt2VdCUptuM3D4TqmFTuAQ4LkjnOi298dnFZDxjgvQ+2bPSUkHMUMpgvZCiThmwmvyrkmoMqvauUU9RMNGe8lHBJr8+DJb4lNdV0EGJv3lHLnWwIeYVSzsxUdj2SnbYc7TycxcUfFfoGwNn/7Ex7k2iBLIZa/SK7ZFBwf5fPlQYS5g4mLsND9giaxF3JD8CQ/+nDYLSjbCVcAp2m/5OQ+Tz5tc/TSXGOjkYAX2WrO5pmWVpAcOpdQPr03RGg3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBm1/HvgRkcHzEvfw0xyO6CeVYuFR3EGjqLKTtIEjyQ=;
 b=FtDCCATxqVklkwGHuQ/2AKUKlSk6C2M3EDZQtOMHqYeEOuDS3f5QuZNdfIv4PegGaAie+JHBXJhewF7Fs4o0udNJd6IgX4q05GWakb3gvNan7vwZcJWmEUzNBtxDide5g0fn47bqWrDKdTMaD+8Ni5FqF8Tc1IO5SOZt02RhL29A1y88XeEe6RPIRfnilCLkuvJcbrCHyAXTwcyQtSIfbv6t4LXrGQFxH695EH+c/Sovr1ohtS1Bb+AOaBb58vuEQF9YmktyonGwpPbrW0SidupZKnw2X5AX8Ccqo9fuBijlaAu95OwAuqrkhePVnJwUftICXgOVEIdhv4Asm469GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBm1/HvgRkcHzEvfw0xyO6CeVYuFR3EGjqLKTtIEjyQ=;
 b=Fs1+40Km3P9YDtbVgdj8lG6PKd6CDD/FuiviSKEQPhmdK4Op+cGPwEJ/GbweZKgobRzPwOydjyWU6xvh7+f/qy1ORp/V8VOXdc90peWUxD591+vmiRKfVk3lpBn5z9Q9T6nkjIhYNgfQ9GK0HA7Q1fevsHO2ncNN344Wgf3VkkU=
Received: from MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 18:17:10 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::9b) by MN2PR10CA0019.outlook.office365.com
 (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 18:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 18:17:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:17:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:17:08 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 13:17:08 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>, Vikram Garhwal
 <vikram.garhwal@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [QEMU][PATCH v1 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Date: Thu, 5 Oct 2023 11:16:25 -0700
Message-ID: <20231005181629.4046-4-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231005181629.4046-1-vikram.garhwal@amd.com>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 80457754-d615-48f3-13fd-08dbc5cf4a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qImDFwnb16hQntWZZHPMiPDMBEmYWpJQWja+AlzuHKXhcpYShZeo+TKnp1IY+CRTObWRbYyNVBtHJ/6dqgCPy2cevG1hnC8w3+XAsjDE5oYua2IGvqz19racmvHuCGjisJ4k5L5Z+3ftBg/ar3RUWGJ5lHXFyIWeEsttjA8x9/HshqDYuc0ABcacM/r44PwqdV36usJbshUB0+z0hKHeV3Nr00ZjOyuVo2Tm8ZfTqGbizLQMRkvIKv81vZESP10SPnOXJxB0mdiGvDhfsiQkGwesnuMFmkty9eHcixM1XH8aKGY9FekT/W6JyByHF7LymR5IDuyyC5Xuz3N5zCYQAtVid1Jx2+ktWuE8pjrSNdpFB2W2mpf15JIl6QgcWlK7YuovUbCU5cQ8HWbBFZwNd1JY6qJTVLhxAib8kwhp5z5G9sR6MnNX3Hwq2YA1b/qatj0Nv1tbtLmRMKjABo3MjNCyExk99zhowkUC7yx+Gi2hxXD3xN2CGHRPbLBdlFfvX5G3MHkQtYnvTSaBSgjBS9XU/dRMCpheEx80eaJmd6euKzGfa7CV3WS/F8A4673PGlXO7aZd6Svy817DbiDprbS0yQ5ZAUz97infZAvIk/zyb2r/JPtdRd9XoGYWJrV0rJDuW5Ge0uU5NXVnd8Z/qP4x3yyLczz0CLuYV0ORKZdyH4hENZDjztdLfUxnG0F8Gx9ribbgLaeo/b6KZCFBp8t2PCPJDrf0Fs4aISm0SzPXc49ogY8F51PHnSdoN9y1Kcb6CiMDnrolLBgnYriVCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(5660300002)(2616005)(1076003)(356005)(44832011)(426003)(336012)(36860700001)(26005)(47076005)(83380400001)(478600001)(6666004)(70586007)(40480700001)(316002)(54906003)(70206006)(6916009)(41300700001)(86362001)(2906002)(36756003)(4326008)(8676002)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:17:09.4345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80457754-d615-48f3-13fd-08dbc5cf4a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juergen Gross <jgross@suse.com>

qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
modify qemu_ram_ptr_length() a little bit and use it for
qemu_map_ram_ptr(), too.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 softmmu/physmem.c | 58 +++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index e182a2fa07..6e5e379dd0 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2163,38 +2163,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
 }
 #endif /* !_WIN32 */
 
-/* Return a host pointer to ram allocated with qemu_ram_alloc.
- * This should not be used for general purpose DMA.  Use address_space_map
- * or address_space_rw instead. For local memory (e.g. video ram) that the
- * device owns, use memory_region_get_ram_ptr.
- *
- * Called within RCU critical section.
- */
-void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
-{
-    RAMBlock *block = ram_block;
-
-    if (block == NULL) {
-        block = qemu_get_ram_block(addr);
-        addr -= block->offset;
-    }
-
-    if (xen_enabled() && block->host == NULL) {
-        /* We need to check if the requested address is in the RAM
-         * because we don't want to map the entire memory in QEMU.
-         * In that case just map until the end of the page.
-         */
-        if (block->offset == 0) {
-            return xen_map_cache(addr, 0, 0, false);
-        }
-
-        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
-    }
-    return ramblock_ptr(block, addr);
-}
-
-/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
- * but takes a size argument.
+/*
+ * Return a host pointer to guest's ram.
  *
  * Called within RCU critical section.
  */
@@ -2202,7 +2172,9 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
                                  hwaddr *size, bool lock)
 {
     RAMBlock *block = ram_block;
-    if (*size == 0) {
+    hwaddr len = 0;
+
+    if (size && *size == 0) {
         return NULL;
     }
 
@@ -2210,7 +2182,10 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
         block = qemu_get_ram_block(addr);
         addr -= block->offset;
     }
-    *size = MIN(*size, block->max_length - addr);
+    if (size) {
+        *size = MIN(*size, block->max_length - addr);
+        len = *size;
+    }
 
     if (xen_enabled() && block->host == NULL) {
         /* We need to check if the requested address is in the RAM
@@ -2218,7 +2193,7 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, *size, lock, lock);
+            return xen_map_cache(addr, len, lock, lock);
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
@@ -2227,6 +2202,19 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/*
+ * Return a host pointer to ram allocated with qemu_ram_alloc.
+ * This should not be used for general purpose DMA.  Use address_space_map
+ * or address_space_rw instead. For local memory (e.g. video ram) that the
+ * device owns, use memory_region_get_ram_ptr.
+ *
+ * Called within RCU critical section.
+ */
+void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
+{
+    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
+}
+
 /* Return the offset of a hostpointer within a ramblock */
 ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
 {
-- 
2.17.1



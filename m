Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E894A7D76AB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvlNV-00075T-8E; Wed, 25 Oct 2023 17:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMw-000736-6F
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:50 -0400
Received: from mail-co1nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::630]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMt-0006Tc-H2
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEZATQRSOcF5kPP8Ph6nD78U3zGIo1hmqn7ftWqfofeAG/y+he2yc+3CXPkIITVcKzIpwxhOPQbYOdAl8PX3jEgEy8J3D5MwbtLcD8Tr4MzrR3FWuwrOPrCzwFZY++TBsffMzUWjuscL7j+IZdOA01P9mHiOea3CrY2EteBwo4C6HyXoxsjjoZEsed2x0Cgdy98PN8y3LVLqUZebawZgMhEOYxU4uUChmX0FsosKufOv9mXuuEETdA/v7MOdkKHXDze3PLIMg5+nqdVHmVv0kbYo8iqmRdZM2uuKF+HiClHiuN9j5WGkc+Vqrp1lt651HA55kBHnpRo0wJL8cDYYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cqfNUm4hsSUdVDsdLLwALon2+gIu1xBwgNlKjxMGTc=;
 b=DNQoLHUAXG7nrJNvHOIH1zTMnWi+bckUBRiHfh+K31ZO699YdQMnmfBw6bxoZVQefzkEQJcOwp9Sc/XNU5SPSbq+attvtefE0gF1PZse//JTD7o3TyhlBFvxUiKMCEHb7hxKk7r6vkb68BbOAvFI+pnMXSpDonxEoaE/7LNSx/mFhO0hckk1DEXC4BITnvMmVGCrbrtusQeJlAsjeSzomC4UWeQgIBEIeIDkd4aTYZthy+IpWsKtuUxcNUcPHDjmlBi3AluEO57ioh0FLE8eG/TTlzRDxJjyhfahpEm1sDr2MkODosHRyoirI6aO03KJk9VpEJNF4PZ2polKC3cOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cqfNUm4hsSUdVDsdLLwALon2+gIu1xBwgNlKjxMGTc=;
 b=pRPavyaALFfTDlrP5pusP7Uk7PwQCh8p/wjUwFRhfOrd6ukyPuOsg3/PMOt2yDHZgG1fjt7V9MkZERE7yV5e+uhWypCOb2iqtrrLrnc138fXarEKX9D4BzU5wp63xBpyiZvqwwuiGi1A/ED3DBqFclsYBPgJ4iWGf/bXQAlAfcc=
Received: from DM6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:100::43)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:24:43 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::80) by DM6PR03CA0066.outlook.office365.com
 (2603:10b6:5:100::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 21:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 21:24:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:37 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 16:24:36 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [QEMU][PATCHv2 4/8] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Date: Wed, 25 Oct 2023 14:24:17 -0700
Message-ID: <20231025212422.30371-5-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025212422.30371-1-vikram.garhwal@amd.com>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c66cc2b-634a-4ff1-8364-08dbd5a0ce52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwMvYrf2NEGWJHiP59SeX4Do9gSqau5yJCF34BMl22mKc29HHCuvXywCjRqlFr4W704iWX9hY3Tq3kQcBcoVRG43qprtzTRYlq4yOjW3m57N2ibUlmCJ2I7kOFZntX363TLtx1nnXH7tlqXWidVZjnhDrj4apytufhKVwVJ62KKuxVed4DYRlYCzUpa/c3BwssrKbRCINpBvC/fzlWldr5+4RUH8AbBgSQgd5yHiB95AsOf4x2uMf4+g8AMKduZg4WCs4A1XkbUGxN0Igcdb6nQTdj3RGl0xqKEvGB8geR3eV7znmyTu6H9PrnRltab62JRD0RLjP8Lyi+sLS43wNHjDT/6DbmAx/r/tA4oO1h1gzOOsvIMRO6pUmjqZp1jF8YxzhXP6Wgd+nU16VEayUJTU4TFpEnyXWLwSbdr1Ij7v2Mh1kkpBkEzEL053Ucfr+iSt/cd0f1s0lpvq6bZ4Yp5nKYGtIUJGBkuzlJRjECAAM2zpn6K7UGmm8L2/FxjISGaVUbup3ePciDHQjW74AQuR7zC0SJFOEcak3vztO/d3meCDrZN23wi0Z7x1boRQbn4FAwx4kUfNO0uXtV5EVlTDrMgy+DjPYVYIlpffW1FqmfIdswCaThmVLoCZPn4UMyshjbmFzgFXAD88VhCh2gmSsXXJX7Q/jYo8XnNiAn4PIiAjYGDugG2kfYceplAxTPo+kP7du1CDKPST6H85T2yODF3MY/ojHWmi9BaRUdn5c/GtEuWRFz7GlNw99rgNpjKyAc26ZTm01ZWeFPhiaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(2906002)(36860700001)(316002)(81166007)(478600001)(82740400003)(1076003)(356005)(70206006)(6916009)(6666004)(40480700001)(47076005)(336012)(426003)(83380400001)(41300700001)(5660300002)(44832011)(86362001)(40460700003)(2616005)(54906003)(8676002)(4326008)(8936002)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:24:43.4336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66cc2b-634a-4ff1-8364-08dbd5a0ce52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
Received-SPF: softfail client-ip=2a01:111:f400:7eab::630;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
 system/physmem.c | 58 +++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 7a7f95b8b9..667a695078 100644
--- a/system/physmem.c
+++ b/system/physmem.c
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



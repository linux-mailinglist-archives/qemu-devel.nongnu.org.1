Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3F7D76A9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvlNB-00073u-1P; Wed, 25 Oct 2023 17:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMu-00072e-Cg
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:48 -0400
Received: from mail-mw2nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::61c]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMr-0006TK-LK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/4j6Q1DDqM35+ymFmR1qgPauGtyMQhgSV/OcUVS1427HDOX/KKW7cGSq1LSQYqbKWPJCjoxGZbeODEcdosaWd+UtrzfJ6CIsZL3VRkqdi2bZqLFnWWjo9c7L0HKT33tLMc1OfEhvgYvuqqeWgcHOSe6KBZv8IiN1eizUuL2dO5y9EbEj4CMh7rpL4uV7rwm0cevvdkwk+19X9XNw3p7lJ8wqrYDDNPBrB9XUX9abPYyuqFWJnzMA2kODLtFQo0p43gLloupm+uCzvCE6evqYRPnMP6zhmpBU+jHbmaJd1w9Ke3YCxoU3S04iaRSNnqicT4INUth7XTutjcrahkkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+gsth6ujSqi5zNqKUIuI4TCVNwpCpWM/3+ygZ8wI/o=;
 b=PbHYEBv8+n+dEPxBn/9+Og+EWV2+U2Lw2KsxUckR7WukxfZDWmKPCa1zJpFRRNXjvfwxxpGqfGeXolI2gFzbA018CA8tj4EWFTHzCmXOhFMXNVaDgX2lWWSCiQ6MLSjKCQCcCs8OSDfWuylPZPZRtB4vc/jEfgo514EUOh4y7XYySJHRbE0kNz+1T6n/vnxgHTbSrLYn2RVZVRC4xjsO4ynHmhgH6fC1qpHCvkKPcTf9NO0tQosoTVhAtaRjItIFfP91U2ulZqAmSkdNCdGfEaHeusTqh/YcZqecH7FMfhxXp+gDD5PRN68HBtQckky/IHok2j1eGZriw0rDEkbMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+gsth6ujSqi5zNqKUIuI4TCVNwpCpWM/3+ygZ8wI/o=;
 b=He+V76Px+YazaiQXUscdAEE3IHFG0XKzMkmmlOrox1tRRK5Ineg8DextlFPYoerJSjL6dqvnwnmqeSHU8c6mgTpaIRSt1zfNq17stY9lsI7H2wZPBYYTXEn8jP9fkzovJvXXNK38XzXDCj8CbcqKxoz0C7h2a770Y2zkPgCq7pk=
Received: from SN6PR04CA0073.namprd04.prod.outlook.com (2603:10b6:805:f2::14)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 21:24:42 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::60) by SN6PR04CA0073.outlook.office365.com
 (2603:10b6:805:f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 21:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 21:24:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 14:24:38 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 16:24:38 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [QEMU][PATCHv2 6/8] memory: add MemoryRegion map and unmap callbacks
Date: Wed, 25 Oct 2023 14:24:19 -0700
Message-ID: <20231025212422.30371-7-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025212422.30371-1-vikram.garhwal@amd.com>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cfa505-d7d5-496d-b571-08dbd5a0cd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEgTHykEMENFg8KL5LY4B2CNLU1iByuYdXBvC43DbzFbuHkU/+fR5TTJxvoDaOIw6Ysu0fPKva1gv9BTnAJKHXntLl+C4TWij0Hou/SIerz9o9RMDgoWdKdbt0DJ6xlCol/Ob+7Um1h32RbaIWHezegTsLkDLFCRBZ9Ax55ZPd4S97G+BUQUpXHYgj3E9Qar9QH8UX9VRJcPNENoyJ1irRPGYqRv0pEL9hgIoFxKm8d8JQYwYE0Cjw/ZfTJJQZV6EazYdIjaGT8wlmDBjGTTKsSkuJTxKCfZC5Z3MrdQY2M0HGYQsBAOdzxPE0+q6qZkqUut5PVsT08CZHVUNtTvAha38SfqP+sWpuN8KITBCRdDj6t2T/Bb9qaFAXUvEADoXEzlKurQX119/Rb6cHEmcDpO4kEd11aizEK1d156ly8+KBq1t8t6qOk+PdKg4fHtD+m14x4UYZ/nnxuBrjmvRtMT8J+F3yh4rx2hUWgs5n6AKjSEZFnmJdBDdqRRImPjspE130U/HZGfWmUOwaN2h3lHzV2/Ijj+QRRAyFx1/lrNS4CZmrQT9xcIrStpAy3pd74Qm9mdYGbLDb55gJgGZEYaV48mCdNMXzScf3ewEkZbEFhiAu1kUbg4pv0+c/EGHCtFQCenJDMm3O9o3/9PxrE2Th8BZyqULrIp5QPNsz1vpWOYelg616hmGGqeT4CYQHOll6cqiYnld0vyF35dWBoHYGh9rLua/8Am/f5VTpb0kJo04Ldy1sbJCw6bR7UNmA7AnrezQuayD7U39ejWOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(86362001)(70586007)(6666004)(70206006)(6916009)(316002)(478600001)(8936002)(54906003)(44832011)(41300700001)(2906002)(8676002)(82740400003)(4326008)(356005)(47076005)(83380400001)(2616005)(36756003)(426003)(336012)(36860700001)(1076003)(26005)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:24:41.4007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cfa505-d7d5-496d-b571-08dbd5a0cd1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
Received-SPF: softfail client-ip=2a01:111:f400:7e89::61c;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

In order to support mapping and unmapping guest memory dynamically to
and from qemu during address_space_[un]map() operations add the map()
and unmap() callbacks to MemoryRegionOps.

Those will be used e.g. for Xen grant mappings when performing guest
I/Os.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 include/exec/memory.h | 21 ++++++++++++++++++
 system/physmem.c      | 50 +++++++++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9087d02769..7c5444d46f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -282,6 +282,27 @@ struct MemoryRegionOps {
                                     unsigned size,
                                     MemTxAttrs attrs);
 
+    /*
+     * Dynamically create mapping. @addr is the guest address to map; @plen
+     * is the pointer to the usable length of the buffer.
+     * @mr contents can be changed in case a new memory region is created for
+     * the mapping.
+     * Returns the buffer address for accessing the data.
+     */
+    void *(*map)(MemoryRegion **mr,
+                 hwaddr addr,
+                 hwaddr *plen,
+                 bool is_write,
+                 MemTxAttrs attrs);
+
+    /* Unmap an area obtained via map() before. */
+    void (*unmap)(MemoryRegion *mr,
+                  void *buffer,
+                  ram_addr_t addr,
+                  hwaddr len,
+                  bool is_write,
+                  hwaddr access_len);
+
     enum device_endian endianness;
     /* Guest-visible constraints: */
     struct {
diff --git a/system/physmem.c b/system/physmem.c
index 667a695078..5db1b32823 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3120,6 +3120,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr len = *plen;
     hwaddr l, xlat;
     MemoryRegion *mr;
+    void *ptr = NULL;
     FlatView *fv;
 
     if (len == 0) {
@@ -3153,12 +3154,20 @@ void *address_space_map(AddressSpace *as,
         return bounce.buffer;
     }
 
-
     memory_region_ref(mr);
+
+    if (mr->ops && mr->ops->map) {
+        ptr = mr->ops->map(&mr, addr, plen, is_write, attrs);
+    }
+
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     fuzz_dma_read_cb(addr, *plen, mr);
-    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
+    if (ptr == NULL) {
+        ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
+    }
+
+    return ptr;
 }
 
 /* Unmaps a memory region previously mapped by address_space_map().
@@ -3174,11 +3183,16 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
         mr = memory_region_from_host(buffer, &addr1);
         assert(mr != NULL);
-        if (is_write) {
-            invalidate_and_set_dirty(mr, addr1, access_len);
-        }
-        if (xen_enabled()) {
-            xen_invalidate_map_cache_entry(buffer);
+
+        if (mr->ops && mr->ops->unmap) {
+            mr->ops->unmap(mr, buffer, addr1, len, is_write, access_len);
+        } else {
+            if (is_write) {
+                invalidate_and_set_dirty(mr, addr1, access_len);
+            }
+            if (xen_enabled()) {
+                xen_invalidate_map_cache_entry(buffer);
+            }
         }
         memory_region_unref(mr);
         return;
@@ -3251,10 +3265,18 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
          * doing this if we found actual RAM, which behaves the same
          * regardless of attributes; so UNSPECIFIED is fine.
          */
+        if (mr->ops && mr->ops->map) {
+            cache->ptr = mr->ops->map(&mr, addr, &l, is_write,
+                                      MEMTXATTRS_UNSPECIFIED);
+        }
+
         l = flatview_extend_translation(cache->fv, addr, len, mr,
                                         cache->xlat, l, is_write,
                                         MEMTXATTRS_UNSPECIFIED);
-        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
+        if (!cache->ptr) {
+            cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l,
+                                             true);
+        }
     } else {
         cache->ptr = NULL;
     }
@@ -3276,14 +3298,20 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
 
 void address_space_cache_destroy(MemoryRegionCache *cache)
 {
-    if (!cache->mrs.mr) {
+    MemoryRegion *mr = cache->mrs.mr;
+
+    if (!mr) {
         return;
     }
 
-    if (xen_enabled()) {
+    if (mr->ops && mr->ops->unmap) {
+            mr->ops->unmap(mr, cache->ptr, cache->xlat, cache->len,
+                           cache->is_write, cache->len);
+    } else if (xen_enabled()) {
         xen_invalidate_map_cache_entry(cache->ptr);
     }
-    memory_region_unref(cache->mrs.mr);
+
+    memory_region_unref(mr);
     flatview_unref(cache->fv);
     cache->mrs.mr = NULL;
     cache->fv = NULL;
-- 
2.17.1



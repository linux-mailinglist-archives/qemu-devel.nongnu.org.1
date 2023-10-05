Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CB7BA8EC
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSua-0000Lq-IP; Thu, 05 Oct 2023 14:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSuW-0000KS-R4
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:17:20 -0400
Received: from mail-mw2nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSuU-0006E5-Ro
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SubmVfbzc/nPFhlr9hJByd8wNSLtdpk9+SNwAXl6BpVYkBUHS1nj1sgz9kTbFZGVjlVMdEON8TAp5E1pM2dzXeNrPr7zYdlddHFnraEEQAHUpScpwnVAnE6SDOQ0BFn2JYBDe/tQ7QkKLYg3BssWhnh7INVkR1pbG6NmNgfLuRK3RAsKlMYgekqbsoLIl00/i0VjSSnMKKv8/A7SG71O10urY+Pxl1XaJMrvuAhkBYZAcDeypphup0gSOMuuZ/P9CQ+UgnYjQDqc2lO6hc7w9/vLf44TZ00ClJqIeix6Wnb/JiINjydyNmb0qb3oy5FhDd4TPdv1igpTmQH5fkDotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI+N7d93jXJV1OR8YxQztq6LYTWmVI7kFZ/WxOVQQ2c=;
 b=b3a0Y0cpdOX7YQn0GLGJT/0FioV3ip/HVas/Ka6nxJvTqXhfEFCi0OsMiglbJdQrr5KtG6aytlnOt2AAD2SW6VdLsXwRZMr9iq3qgahtENGT1VwFyqt7rfGYfHIEPVcSQ1eExS7w4UK216Bd3OezF9A+VCusa7v5uEe2NWOrblifLSALfi7SY2+vF5V8CjazEKg5X4v7GFj98JozZqLgKfZKouffYrdNpf3ZSMb+g/Ki4oBp9SAJKlSUn0CvKGTfnsI63QUtq+6Isj5yrms8i+jUEjXwQSFYZV2OcYlgf8D6oDt9Su3INIvKqsEoW1lnAG++dhPYekGc1c6Yt8YhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI+N7d93jXJV1OR8YxQztq6LYTWmVI7kFZ/WxOVQQ2c=;
 b=LH4sEYSdQrq2F37sfnJ4s0d0tJHjK3OBHIDL3fWAIpYXA3hxd6SelYwc2gPfN3GsRi1eG1lcUfe4p9y4aeJAP4EUU5eEy6aNazUj3oSxCEE3BbslCmxbjJaOxAs4kiOc5eVKbHVzNy9aNMce82Qbvf266ym8QhiyDQ5lGl99054=
Received: from DM6PR11CA0023.namprd11.prod.outlook.com (2603:10b6:5:190::36)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 18:17:15 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::27) by DM6PR11CA0023.outlook.office365.com
 (2603:10b6:5:190::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Thu, 5 Oct 2023 18:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 18:17:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:17:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:17:12 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 13:17:12 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>, Vikram Garhwal
 <vikram.garhwal@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [QEMU][PATCH v1 5/7] memory: add MemoryRegion map and unmap callbacks
Date: Thu, 5 Oct 2023 11:16:27 -0700
Message-ID: <20231005181629.4046-6-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231005181629.4046-1-vikram.garhwal@amd.com>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: d58fbabc-5b84-4467-639a-08dbc5cf4d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rqatqywZbmoTDH2fKBFxAvlLAJ/YsgNP5pflRHnjl2BM5HdULHcfw3t5XoKlXoPo3yA3MgEqKx7D0XQU9gVrmNERlfLbaxQPd6tcXf84CKttCCeDTa5G0MUDQQs04CUlCi6UC3aKCXml9hOsPkq3z5N0vU2FO7JojtYqmiB+gsQgUEecKpNZh2Z8yW6zfTpLivnwuQ3LVwNfGUAe+4DJHFiGggNYkj3XoaUoPNQ6ZSTHlQLYVErO2NbQbnnzQLLmLLamhD2OdoWHUeN5EME7+PuUVb22mfqjRVeOJJ4Y3tDjHRfg3WjCPA+fqJpXOnv+PGGtB49iT/9juZpn6Xc6GqJbH8GG6dj6DeFCwV4+77D/xbhPZKAtbFsS9BJbH0xGJ5CmwCe6H/jZf/6rsWos1r8aaFj0YGDz2cekqLtioi1NMNOkTaRMS2uuXymi3jt4wSqgXAyiCx11najPJrrEQxDZR3hI/BGsQWL3En5r20riL5xb5fjvLliUWUYBf7L6/33oRg9OTfiMDseP3V3F/Mpam2eCZCyISMNSAiI33vDQf92LaXHEdWtkDjdMA1lkZb+jRnmgoA7RXJT/LnQTKQsxiI8iAfxwyFyvu/MI1w+inN0bBCq4gvyTZ3bj/3ajgrwEeMqkNA/VmgQY1AeVJP9zU8vSFK1ZB91KF9zBYt4rMF+Dyo4zw7iSMy7i0BYDR7iQN6rgwGzc/5FccYB1KYNvvhDJH5jArTuF8+hwi9pYo4VhwJ+E4U/qYP/QiY9sC6E3/sxBDeTuYAunDy/ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(2616005)(70586007)(54906003)(6916009)(40460700003)(316002)(41300700001)(70206006)(1076003)(26005)(336012)(426003)(6666004)(36756003)(478600001)(36860700001)(82740400003)(81166007)(356005)(86362001)(47076005)(83380400001)(40480700001)(44832011)(2906002)(8936002)(5660300002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:17:15.2486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58fbabc-5b84-4467-639a-08dbc5cf4d90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
Received-SPF: softfail client-ip=2a01:111:f400:7e89::60d;
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
 softmmu/physmem.c     | 50 +++++++++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c99842d2fc..f3c62d2883 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -280,6 +280,27 @@ struct MemoryRegionOps {
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
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 6e5e379dd0..5f425bea1c 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3135,6 +3135,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr len = *plen;
     hwaddr l, xlat;
     MemoryRegion *mr;
+    void *ptr = NULL;
     FlatView *fv;
 
     if (len == 0) {
@@ -3168,12 +3169,20 @@ void *address_space_map(AddressSpace *as,
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
@@ -3189,11 +3198,16 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
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
@@ -3266,10 +3280,18 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
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
@@ -3291,14 +3313,20 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
 
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



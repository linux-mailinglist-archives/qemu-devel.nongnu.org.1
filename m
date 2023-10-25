Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABC7D76A5
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvlNE-00073v-Hh; Wed, 25 Oct 2023 17:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMv-00072t-VP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:49 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qvlMs-0006TP-AP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 17:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBSAij50Q0XM+m3VRN8g0AA4lY1U1odbJAFevWSwNf6xfaiElnm89iuI4jqd4+OZIV0EfcXe9beaxQbUcRcZ3V0AI4ELlOd4uHBDjGobHvJXPelygcvQL8CMSVnEOqIxP4wnbc9QAbIVOyqInOG7IEe1hM4S+SzO6DlHTt/cig3BrUrt82phsK4msSgZ+lA4/z80iRj8C9tRIo9fMjpFbs0Usr63PpWgosaqjVISNdjGSwOlGBX6lkt+oczB5cd5FMWzbpYKb+LiovFUHHxBRQcZW5MgpgQG4zbdIheHPLBJp6ljG5sxz6qxHcbXnLizXqPXG1wqCBb22geGdiUvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwEQqo3ga6htNQpKW4efEVRt35ya5qOkvGV8p5I0w9E=;
 b=KWk8Cbqw4G/w9QogcCXNBLNAhxRjHWnHLQt0zjDZnC2wojNlSeMPcPlDn58sucF59JClE26UgxEjWevb40/9X0/E7Qc5rIXuBVRf5lYTCm7LQBkcauIBa/LYDjB4DTGh61pb4wjsPoZJJipb1xvxwsGXRIKNJXUMxzdvlOh6x1YTEnDTSj2d7dNgEsc4KuDZN9imynOnjeALx52CDI5asZHhnbvJn5EUvfqZ80xUoQkLo6FYappPztA+z8CwVCUHNe3rPJKRcyMCy+3Wiw3RrvINCnrgMoLFGIGd6m/VsUXrb/rS7BU1HSx3c+AuRE8YVfEegRADiikWqjCrt9OXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwEQqo3ga6htNQpKW4efEVRt35ya5qOkvGV8p5I0w9E=;
 b=HEq1CQzEiMXRwQbxVR5bu7d2lkFbUQ+aimezM9d84cQC/Ip0RPVsfHypLUE39cMeWtJDWpdR0+RdQKurSxL5K6nvmg8XoJVzFYYSlqgK3TjPk9tJb97kEYslyieBlXqq1mwxhELLeUXNNqf/8zeDYMf6Z8aaLSVtg+CFgbV7XIk=
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 21:24:43 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::34) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.39 via Frontend
 Transport; Wed, 25 Oct 2023 21:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 21:24:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 16:24:35 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 16:24:34 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [QEMU][PATCHv2 2/8] softmmu: physmem: Split ram_block_add()
Date: Wed, 25 Oct 2023 14:24:15 -0700
Message-ID: <20231025212422.30371-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025212422.30371-1-vikram.garhwal@amd.com>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1a41ff-db50-4b6f-6999-08dbd5a0cdfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q10mZYJ7yPTYB9hx2uXeVLMTEH2ph9f3aCI6tXnU3umwH5ibbYLfDeNQvLQl6UtBRr7XnajghWsbEp3uAabbK/sxwdQqOKO7ACGgXauaILTHcXs041UzeI0zhYOW5bT5Kf9J5gjLXhj/jBHDVzUPMz9+NGS3gLVF+vRQNL7ReYZfxgSHQTaHzkeEjWtEUbD8jRrQ0glnnNmgTKDLvVz+8qKY0I4MNpKQ3AxYVLqt3wGhGX7C99uGI5+JVJx5N4MVpvSoL+jlD8n2GCIVe4gDdw+UQShupj3Cjm0C1LwbtxQkXBLO85R98px1aQPics82xJ4rJljgH82jtC5JDqF/SNFtch+xuxs3v4TuNZrSfoegsc9QS+3CVPuOn1rwpj7ctIvtibb1+LJFgS6jOrEnHt2TzsZtC/7oUPLBDm8swNHXH7rpWBBdX+Jv2/e5n55bUxcjSP5kmNhn3Pod7/5opyGE0XnM42kSD/fPC3c760GZPcuAoO2wc2rzNa1IvcYSeKcJ3vT7p//1I1y4cK4A7IpgdtmKJIkGPw7TPyLQ2S3i2fuHRfvejbXaaLs83EFAXSxW2/9Cw4BDA0UZxSgcOpZ/Yh1a+MNctJd9XJE+oYHHeftpknROknjLUT+DsbdJZAcryha+JuRXZk1BhEtIJfdAHcLKrsulcdTrxTbWZNUKYeN/KoCXk2/g6JX7aP+gtU/k/C8IjeII71UJgHuWzjZR07QiE390468fX/CHCOz1ykxr5byS74D+PGSrtyIpTYk7+ZP4OuT/yqAvrZgNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(26005)(2906002)(41300700001)(44832011)(5660300002)(86362001)(40460700003)(4326008)(81166007)(316002)(8936002)(36860700001)(8676002)(70206006)(478600001)(1076003)(36756003)(2616005)(6916009)(356005)(70586007)(82740400003)(54906003)(83380400001)(336012)(426003)(40480700001)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:24:42.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1a41ff-db50-4b6f-6999-08dbd5a0cdfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::60b;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Extract ram block list update to a new function ram_block_add_list(). This is
done to support grant mappings which adds a memory region for granted memory and
updates the ram_block list.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 include/exec/ram_addr.h |  1 +
 system/physmem.c        | 62 ++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90676093f5..c0b5f9a7d0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -139,6 +139,7 @@ void qemu_ram_free(RAMBlock *block);
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
 void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+void ram_block_add_list(RAMBlock *new_block);
 
 /* Clear whole block of mem */
 static inline void qemu_ram_block_writeback(RAMBlock *block)
diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee01..7a7f95b8b9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1803,12 +1803,47 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
     }
 }
 
+static void ram_block_add_list_locked(RAMBlock *new_block)
+ {
+     RAMBlock *block;
+     RAMBlock *last_block = NULL;
+
+    /*
+     * Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
+     * QLIST (which has an RCU-friendly variant) does not have insertion at
+     * tail, so save the last element in last_block.
+     */
+    RAMBLOCK_FOREACH(block) {
+        last_block = block;
+        if (block->max_length < new_block->max_length) {
+            break;
+        }
+    }
+    if (block) {
+        QLIST_INSERT_BEFORE_RCU(block, new_block, next);
+    } else if (last_block) {
+        QLIST_INSERT_AFTER_RCU(last_block, new_block, next);
+    } else { /* list is empty */
+        QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
+    }
+    ram_list.mru_block = NULL;
+
+    /* Write list before version */
+    smp_wmb();
+    ram_list.version++;
+}
+
+void ram_block_add_list(RAMBlock *new_block)
+{
+    qemu_mutex_lock_ramlist();
+    ram_block_add_list_locked(new_block);
+    qemu_mutex_unlock_ramlist();
+}
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     const bool noreserve = qemu_ram_is_noreserve(new_block);
     const bool shared = qemu_ram_is_shared(new_block);
-    RAMBlock *block;
-    RAMBlock *last_block = NULL;
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
 
@@ -1846,28 +1881,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_ram_size > old_ram_size) {
         dirty_memory_extend(old_ram_size, new_ram_size);
     }
-    /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
-     * QLIST (which has an RCU-friendly variant) does not have insertion at
-     * tail, so save the last element in last_block.
-     */
-    RAMBLOCK_FOREACH(block) {
-        last_block = block;
-        if (block->max_length < new_block->max_length) {
-            break;
-        }
-    }
-    if (block) {
-        QLIST_INSERT_BEFORE_RCU(block, new_block, next);
-    } else if (last_block) {
-        QLIST_INSERT_AFTER_RCU(last_block, new_block, next);
-    } else { /* list is empty */
-        QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
-    }
-    ram_list.mru_block = NULL;
 
-    /* Write list before version */
-    smp_wmb();
-    ram_list.version++;
+    ram_block_add_list_locked(new_block);
+
     qemu_mutex_unlock_ramlist();
 
     cpu_physical_memory_set_dirty_range(new_block->offset,
-- 
2.17.1



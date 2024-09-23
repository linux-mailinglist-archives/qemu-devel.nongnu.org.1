Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E62B97D80F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Sep 2024 18:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srgDP-0007TY-3Y; Fri, 20 Sep 2024 12:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9860b8bee=graf@amazon.de>)
 id 1srgDG-0006rz-1e
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:10:31 -0400
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9860b8bee=graf@amazon.de>)
 id 1srgDB-0003xj-2e
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1726848625; x=1758384625;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YtORPU41FayDr8FxGw99bFQQH3dMnH0zok4tIyh1tkQ=;
 b=pFY4GJkww5kLT20RA2ej62KJzeREahBXyZQjkXcJqB4h0vHtTAkqK9Yn
 UPbRWXI89/PuNeW+ktjm2/KIMEBT6+2YuN3sA19xgAnX5dgPHgWiSR4tW
 ri8H/ayKtqtEl1VfTJt/YibfoEnCl2TE+INvdNJv3iH5chqdl7A2h12uP A=;
X-IronPort-AV: E=Sophos;i="6.10,244,1719878400"; d="scan'208";a="681739359"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 16:10:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:29227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.6:2525] with
 esmtp (Farcaster)
 id 64d82c24-49ac-423c-b85d-dc2d1c7bb5eb; Fri, 20 Sep 2024 16:10:14 +0000 (UTC)
X-Farcaster-Flow-ID: 64d82c24-49ac-423c-b85d-dc2d1c7bb5eb
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 20 Sep 2024 16:10:12 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 20 Sep 2024 16:10:11 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Eduard Vlad <evlad@amazon.de>
Subject: [PATCH v2] target-i386: Walk NPT in guest real mode
Date: Fri, 20 Sep 2024 16:10:09 +0000
Message-ID: <20240920161009.35834-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=52.119.213.156;
 envelope-from=prvs=9860b8bee=graf@amazon.de; helo=smtp-fw-52005.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

When translating virtual to physical address with a guest CPU that
supports nested paging (NPT), we need to perform every page table walk
access indirectly through the NPT, which we correctly do.

However, we treat real mode (no page table walk) special: In that case,
we currently just skip any walks and translate VA -> PA. With NPT
enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
which we fail to do so far.

The net result of that is that TCG VMs with NPT enabled that execute
real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
the guest accesses host code and data. This typically shows as failure
to boot guests.

This patch changes the page walk logic for NPT enabled guests so that we
always perform a GVA -> GPA translation and then skip any logic that
requires an actual PTE.

That way, all remaining logic to walk the NPT stays and we successfully
walk the NPT in real mode.

Fixes: fe441054bb3f0 ("target-i386: Add NPT support")

Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Eduard Vlad <evlad@amazon.de>

---

v1 -> v2:

  - Remove hack where we fake a PTE and instead just set the
    corresponding resolved variables and jump straight to the
    stage2 code.
---
 target/i386/tcg/sysemu/excp_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..4622d45643 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else {
+    } else if (pg_mode) {
         /*
          * Page table level 2
          */
@@ -343,6 +343,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         ptep &= pte | PG_NX_MASK;
         page_size = 4096;
         rsvd_mask = 0;
+    } else {
+        /* No paging (real mode), let's assemble a fake 1:1 1GiB PTE */
+        page_size = 0x40000000;
+        paddr = in->addr;
+        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        goto stage2;
     }
 
 do_check_protect:
@@ -420,6 +426,7 @@ do_check_protect_pse36:
 
     /* merge offset within page */
     paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
+stage2:
 
     /*
      * Note that NPT is walked (for both paging structures and final guest
@@ -562,7 +569,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             addr = (uint32_t)addr;
         }
 
-        if (likely(env->cr[0] & CR0_PG_MASK)) {
+        if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
             in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



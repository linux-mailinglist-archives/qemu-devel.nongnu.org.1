Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 219007C707C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwot-0003zR-Sx; Thu, 12 Oct 2023 10:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwol-0003fc-WD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwok-0005jU-Bv
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVyBcWiYW6qOY8uaAFii2zbj7On3Js9cYxSsh/zSpTM=;
 b=OjN8rqEqaxSUukBh6K1vAIzSpmV+29oVi6Rj9ox1HXyYi0wlrbL/AJOPRCPsar/vTEUsPD
 ahXXnPFEaAP1fydVpRwvorc0c552EafV7QrexFp9PHtMagx5+ohLf8qrtBOQnMl6hYpaEI
 c2sVbUdASRRFww2++JdPfCrsyTt+aeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-36-A2N67MF-crKKSc4MREQ-1; Thu, 12 Oct 2023 10:37:12 -0400
X-MC-Unique: 36-A2N67MF-crKKSc4MREQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD842862F58;
 Thu, 12 Oct 2023 14:37:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E31701C060DF;
 Thu, 12 Oct 2023 14:37:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 13/18] memory: Clarify mapping requirements for
 RamDiscardManager
Date: Thu, 12 Oct 2023 16:36:50 +0200
Message-ID: <20231012143655.114631-14-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We really only care about the RAM memory region not being mapped into
an address space yet as long as we're still setting up the
RamDiscardManager. Once mapped into an address space, memory notifiers
would get notified about such a region and any attempts to modify the
RamDiscardManager would be wrong.

While "mapped into an address space" is easy to check for RAM regions that
are mapped directly (following the ->container links), it's harder to
check when such regions are mapped indirectly via aliases. For now, we can
only detect that a region is mapped through an alias (->mapped_via_alias),
but we don't have a handle on these aliases to follow all their ->container
links to test if they are eventually mapped into an address space.

So relax the assertion in memory_region_set_ram_discard_manager(),
remove the check in memory_region_get_ram_discard_manager() and clarify
the doc.

Message-ID: <20230926185738.277351-14-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 5 +++--
 system/memory.c       | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c99842d2fc..cf7c7dde91 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -599,8 +599,9 @@ typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
  * populated (consuming memory), to be used/accessed by the VM.
  *
  * A #RamDiscardManager can only be set for a RAM #MemoryRegion while the
- * #MemoryRegion isn't mapped yet; it cannot change while the #MemoryRegion is
- * mapped.
+ * #MemoryRegion isn't mapped into an address space yet (either directly
+ * or via an alias); it cannot change while the #MemoryRegion is
+ * mapped into an address space.
  *
  * The #RamDiscardManager is intended to be used by technologies that are
  * incompatible with discarding of RAM (e.g., VFIO, which may pin all
diff --git a/system/memory.c b/system/memory.c
index fa1c99f9ba..e11bce5991 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2085,7 +2085,7 @@ int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr)
 
 RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
 {
-    if (!memory_region_is_mapped(mr) || !memory_region_is_ram(mr)) {
+    if (!memory_region_is_ram(mr)) {
         return NULL;
     }
     return mr->rdm;
@@ -2094,7 +2094,7 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
 void memory_region_set_ram_discard_manager(MemoryRegion *mr,
                                            RamDiscardManager *rdm)
 {
-    g_assert(memory_region_is_ram(mr) && !memory_region_is_mapped(mr));
+    g_assert(memory_region_is_ram(mr));
     g_assert(!rdm || !mr->rdm);
     mr->rdm = rdm;
 }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC6788880
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWm7-0001vZ-An; Fri, 25 Aug 2023 09:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZWm5-0001uU-He
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZWm2-0001pq-Bo
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692969769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHE7mkrehWHgWXyRLmrgc4bzKfsgE2qS/kJ9qG1wK7I=;
 b=WD3dITh7ShoVlUK8dpBN02hgfoWE5W1EMNPoJDXH9EcMqmiNjbaCHdd7LEBYG7f0J3lBK2
 H1ktubcFrJafI/6AqfLMm/2+jKBJ38ZzNTgrapAnpbjUd7fO++XwAWHxgyuC2q3MljtfW0
 PqRyRvJ5TYGEUvK/9F1R0FADnZjEOo8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-oh9zPMW6NrygoW5CgxBVOw-1; Fri, 25 Aug 2023 09:22:43 -0400
X-MC-Unique: oh9zPMW6NrygoW5CgxBVOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB9FA101A52E;
 Fri, 25 Aug 2023 13:22:42 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76E9F140E950;
 Fri, 25 Aug 2023 13:22:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
Subject: [PATCH v2 13/16] memory: Clarify mapping requirements for
 RamDiscardManager
Date: Fri, 25 Aug 2023 15:21:46 +0200
Message-ID: <20230825132149.366064-14-david@redhat.com>
In-Reply-To: <20230825132149.366064-1-david@redhat.com>
References: <20230825132149.366064-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 5 +++--
 softmmu/memory.c      | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f8..5feb704585 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -593,8 +593,9 @@ typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
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
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..c1e8aa133f 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -2081,7 +2081,7 @@ int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr)
 
 RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
 {
-    if (!memory_region_is_mapped(mr) || !memory_region_is_ram(mr)) {
+    if (!memory_region_is_ram(mr)) {
         return NULL;
     }
     return mr->rdm;
@@ -2090,7 +2090,7 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
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



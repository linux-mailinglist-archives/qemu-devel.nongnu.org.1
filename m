Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E798AEA45
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 17:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnZ-0006jI-Oc; Tue, 23 Apr 2024 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnG-000509-5M
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnE-0000KV-Fb
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cjy7Ijt3qnLWCz8+8hriRM5HGAkmtAHB92I6+4Xy2m4=;
 b=RVpJsDBuOL9+VvovDucbWvJtOqdvu8Y3qP4/ZqtBJ+tvXn6om/WwWDWpK9qIfElF8HiYXf
 DkjqpUsCBqZ3aOBScfl9OC6Miht8k1/WBXvYD8VU1c0JL5XcTz4oHzyDzhKcCINuA0C15D
 r3Pb0UIszaDGVDZpB6aqS8A6mhpN6Mw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-pSHFOqK0MJqLt85Iq1qdrw-1; Tue, 23 Apr 2024 11:10:45 -0400
X-MC-Unique: pSHFOqK0MJqLt85Iq1qdrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 746FD812C50
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:45 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE212033979
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/63] RAMBlock: make guest_memfd require uncoordinated discard
Date: Tue, 23 Apr 2024 17:09:41 +0200
Message-ID: <20240423150951.41600-54-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Some subsystems like VFIO might disable ram block discard, but guest_memfd
uses discard operations to implement conversions between private and
shared memory.  Because of this, sequences like the following can result
in stale IOMMU mappings:

1. allocate shared page
2. convert page shared->private
3. discard shared page
4. convert page private->shared
5. allocate shared page
6. issue DMA operations against that shared page

This is not a use-after-free, because after step 3 VFIO is still pinning
the page.  However, DMA operations in step 6 will hit the old mapping
that was allocated in step 1.

Address this by taking ram_block_discard_is_enabled() into account when
deciding whether or not to discard pages.

Since kvm_convert_memory()/guest_memfd doesn't implement a
RamDiscardManager handler to convey and replay discard operations,
this is a case of uncoordinated discard, which is blocked/released
by ram_block_discard_require().  Interestingly, this function had
no use so far.

Alternative approaches would be to block discard of shared pages, but
this would cause guests to consume twice the memory if they use VFIO;
or to implement a RamDiscardManager and only block uncoordinated
discard, i.e. use ram_block_coordinated_discard_require().

[Commit message mostly by Michael Roth <michael.roth@amd.com>]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index f5dfa20e57e..5ebcf5be116 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1846,6 +1846,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
+        if (ram_block_discard_require(true) < 0) {
+            error_setg_errno(errp, errno,
+                             "cannot set up private guest memory: discard currently blocked");
+            error_append_hint(errp, "Are you using assigned devices?\n");
+            goto out_free;
+        }
+
         new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
                                                         0, errp);
         if (new_block->guest_memfd < 0) {
@@ -2109,6 +2116,7 @@ static void reclaim_ramblock(RAMBlock *block)
 
     if (block->guest_memfd >= 0) {
         close(block->guest_memfd);
+        ram_block_discard_require(false);
     }
 
     g_free(block);
-- 
2.44.0




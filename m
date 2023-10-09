Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB877BD8E5
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnjB-00019B-Bf; Mon, 09 Oct 2023 06:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qpniw-00018u-It
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:42:55 -0400
Received: from relay5-d.mail.gandi.net ([2001:4b98:dc4:8::225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qpnim-0007ol-BI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:42:54 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EDAE1C0005;
 Mon,  9 Oct 2023 10:42:35 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH] memory: initialize 'fv' in MemoryRegionCache to make Coverity
 happy
Date: Mon,  9 Oct 2023 12:43:21 +0200
Message-ID: <20231009104322.3085887-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: neutral client-ip=2001:4b98:dc4:8::225;
 envelope-from=i.maximets@ovn.org; helo=relay5-d.mail.gandi.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Coverity scan reports multiple false-positive "defects" for the
following series of actions in virtio.c:

  MemoryRegionCache indirect_desc_cache;
  address_space_cache_init_empty(&indirect_desc_cache);
  address_space_cache_destroy(&indirect_desc_cache);

For some reason it's unable to recognize the dependency between 'mrs.mr'
and 'fv' and insists that '!mrs.mr' check in address_space_cache_destroy
may take a 'false' branch, even though it is explicitly initialized to
NULL in the address_space_cache_init_empty():

  *** CID 1522371:  Memory - illegal accesses  (UNINIT)
  /qemu/hw/virtio/virtio.c: 1627 in virtqueue_split_pop()
  1621         }
  1622
  1623         vq->inuse++;
  1624
  1625         trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
  1626     done:
  >>>     CID 1522371:  Memory - illegal accesses  (UNINIT)
  >>>     Using uninitialized value "indirect_desc_cache.fv" when
  >>>     calling "address_space_cache_destroy".
  1627         address_space_cache_destroy(&indirect_desc_cache);
  1628
  1629         return elem;
  1630
  1631     err_undo_map:
  1632         virtqueue_undo_map_desc(out_num, in_num, iov);

  ** CID 1522370:  Memory - illegal accesses  (UNINIT)

Instead of trying to silence these false positive reports in 4
different places, initializing 'fv' as well, as this doesn't result
in any noticeable performance impact.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/exec/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c99842d2fc..1ce80c4e82 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2770,6 +2770,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
 {
     cache->mrs.mr = NULL;
+    /* There is no real need to initialize fv, but it makes Coverity happy. */
+    cache->fv = NULL;
 }
 
 /**
-- 
2.41.0



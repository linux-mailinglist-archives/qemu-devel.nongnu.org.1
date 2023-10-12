Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B87C706D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoS-0002pg-Lo; Thu, 12 Oct 2023 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoQ-0002nh-84
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoO-0005gz-KP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ScThcU6EQo33ppZiwGwCd9UPtsaQwoUGXTwqOmM9gNk=;
 b=HmSq2XEo8zVhATlJW7YlE5mK1yJSdUiEbKnuiopVw18j+fN3IwlfBKd1AJepo7kO0+gup0
 PPCO8CtzkdN9uAJXeFQXS5BN93i5nJ9IS5UE+NLJZKkqOltKzeksNE82rKlR04lRvx6oCd
 GCh5IwyC3+mcFdlXkcCZNGhoJY6PfcM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-3DXaPg8RMPGSZqjNqnW5bw-1; Thu, 12 Oct 2023 10:37:14 -0400
X-MC-Unique: 3DXaPg8RMPGSZqjNqnW5bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF14B1C113E1;
 Thu, 12 Oct 2023 14:37:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF29C1C060DF;
 Thu, 12 Oct 2023 14:37:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 15/18] virtio-mem: Update state to match bitmap as soon as
 it's been migrated
Date: Thu, 12 Oct 2023 16:36:52 +0200
Message-ID: <20231012143655.114631-16-david@redhat.com>
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

It's cleaner and future-proof to just have other state that depends on the
bitmap state to be updated as soon as possible when restoring the bitmap.

So factor out informing RamDiscardListener into a functon and call it in
case of early migration right after we restored the bitmap.

Message-ID: <20230926185738.277351-16-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 0b0e6c5090..0cf47df9cf 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -984,9 +984,8 @@ static int virtio_mem_restore_unplugged(VirtIOMEM *vmem)
                                                virtio_mem_discard_range_cb);
 }
 
-static int virtio_mem_post_load(void *opaque, int version_id)
+static int virtio_mem_post_load_bitmap(VirtIOMEM *vmem)
 {
-    VirtIOMEM *vmem = VIRTIO_MEM(opaque);
     RamDiscardListener *rdl;
     int ret;
 
@@ -1001,6 +1000,20 @@ static int virtio_mem_post_load(void *opaque, int version_id)
             return ret;
         }
     }
+    return 0;
+}
+
+static int virtio_mem_post_load(void *opaque, int version_id)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(opaque);
+    int ret;
+
+    if (!vmem->early_migration) {
+        ret = virtio_mem_post_load_bitmap(vmem);
+        if (ret) {
+            return ret;
+        }
+    }
 
     /*
      * If shared RAM is migrated using the file content and not using QEMU,
@@ -1043,7 +1056,7 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
     int ret;
 
     if (!vmem->prealloc) {
-        return 0;
+        goto post_load_bitmap;
     }
 
     /*
@@ -1051,7 +1064,7 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
      * don't mess with preallocation and postcopy.
      */
     if (migrate_ram_is_ignored(rb)) {
-        return 0;
+        goto post_load_bitmap;
     }
 
     /*
@@ -1084,7 +1097,10 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
             return -EBUSY;
         }
     }
-    return 0;
+
+post_load_bitmap:
+    /* Finally, update any other state to be consistent with the new bitmap. */
+    return virtio_mem_post_load_bitmap(vmem);
 }
 
 typedef struct VirtIOMEMMigSanityChecks {
-- 
2.41.0



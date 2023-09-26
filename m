Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB347AF3A9
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDIC-0001yy-3L; Tue, 26 Sep 2023 15:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlDHt-0001la-Uj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlDHq-0003Fo-UW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695754798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntTc+iP8L3yWrsrYKBBm9BSj/8eg/GV85E1SzdVW1Ig=;
 b=SGR2B77oj0OHifHwCHGehZuV+PCjjYnjmGcVOjFL0cK6fN6cH6nZS8E28e61nTj8bqHj74
 gbjzDVbcgn7VooFoL8jw3d6EQ+95NhULT8InzYDu8UEiY0gOKmHkZTMBO2sp/bCQJNbq1J
 0TxrZMbu6Yg48ITHvDVJMUZpDtWZQ70=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-yclTkQ33N6O_cZeOs2BOmA-1; Tue, 26 Sep 2023 14:59:52 -0400
X-MC-Unique: yclTkQ33N6O_cZeOs2BOmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46C3A3814581;
 Tue, 26 Sep 2023 18:59:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CBD2026D4B;
 Tue, 26 Sep 2023 18:59:47 +0000 (UTC)
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
Subject: [PATCH v4 15/18] virtio-mem: Update state to match bitmap as soon as
 it's been migrated
Date: Tue, 26 Sep 2023 20:57:35 +0200
Message-ID: <20230926185738.277351-16-david@redhat.com>
In-Reply-To: <20230926185738.277351-1-david@redhat.com>
References: <20230926185738.277351-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



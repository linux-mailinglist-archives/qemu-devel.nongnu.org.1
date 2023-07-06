Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1E7496E4
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJrD-0002IR-Vs; Thu, 06 Jul 2023 03:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJr4-0002Fr-E4
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJr1-0007M5-RZ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688630201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcRjU/QKBHx5s8/4mzZ7k2PVwAnKyXc14KgCruFUohw=;
 b=g/SwJ+mDiiKEUQtMMGPhgH0snkpaLWDkDkqWHFmYoiuiU8D7FnYLAy+w7T6PCGnTpi8ga6
 4gXCKTrFsDgds7kI/uGIZnEff5bDcdqVcLWGhLXThuXh9nBJmLq6bR12Rm6K6VGnqtADr7
 cIcqlwgr/Zhr60a8Qr/L96YDU2O/uTg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-67ihg6skPzaLOZ3Cj5MCEQ-1; Thu, 06 Jul 2023 03:56:37 -0400
X-MC-Unique: 67ihg6skPzaLOZ3Cj5MCEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B40A3C0F673;
 Thu,  6 Jul 2023 07:56:37 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.193.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7F6818EB4;
 Thu,  6 Jul 2023 07:56:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 2/4] virtio-mem: Skip most of virtio_mem_unplug_all()
 without plugged memory
Date: Thu,  6 Jul 2023 09:56:07 +0200
Message-ID: <20230706075612.67404-3-david@redhat.com>
In-Reply-To: <20230706075612.67404-1-david@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Already when starting QEMU we perform one system reset that ends up
triggering virtio_mem_unplug_all() with no actual memory plugged yet.
That, in turn will trigger ram_block_discard_range() and perform some
other actions that are not required in that case.

Let's optimize virtio_mem_unplug_all() for the case that no memory is
plugged. This will be beneficial for x-ignore-shared support as well.

Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ec0ae32589..a922c21380 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -621,20 +621,20 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
 {
     RAMBlock *rb = vmem->memdev->mr.ram_block;
 
-    if (virtio_mem_is_busy()) {
-        return -EBUSY;
-    }
-
-    if (ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb))) {
-        return -EBUSY;
-    }
-    virtio_mem_notify_unplug_all(vmem);
-
-    bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
     if (vmem->size) {
+        if (virtio_mem_is_busy()) {
+            return -EBUSY;
+        }
+        if (ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb))) {
+            return -EBUSY;
+        }
+        virtio_mem_notify_unplug_all(vmem);
+
+        bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
         vmem->size = 0;
         notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
     }
+
     trace_virtio_mem_unplugged_all();
     virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
     return 0;
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388F73DF3E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlLv-0003Dc-Nd; Mon, 26 Jun 2023 08:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLM-0002hy-9K
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLG-00035P-JJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqGaDSnZccD0ikwcRDWj815DiMnuX6iQ2kN0X0ER5Dk=;
 b=V5Qkiwh2sM6Z0WOaz+iZZgJXUsqRukH+xqj/gvrSzbE2rQE5Gke7VduXP5ftqpMxzWcbE0
 uvoMUupt3J4hx01emu4ExHW8ZlelfPigzG5NUiqrC129IH3be4kCXLsSIZVy5lX3USljXA
 CBo+06ExUa6YvW0YdDqwiNhadEz+3Hg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-T962emIsNgSvGqmy2vY1MQ-1; Mon, 26 Jun 2023 08:29:12 -0400
X-MC-Unique: T962emIsNgSvGqmy2vY1MQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa8f8fb7b3so27938555e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782551; x=1690374551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqGaDSnZccD0ikwcRDWj815DiMnuX6iQ2kN0X0ER5Dk=;
 b=NX1ILUR0joXURB15cEW2mUV8ts7TeHR3jVz/24EODqlHOE9whZdZyIKBwq/79CzoHA
 vqenIpds7JeF5mrofAEbqL/VB5YA1M5xpfNfJNnrQWOKIwgciHIMOjwn3TR2o0lXl1kl
 bdrNnuY9b6/dE6vCh3RsbQsITmSLMNqJSkNdH5lDMoOsjtM7OGu4798zrciZK9AklvMM
 9Bh6AFbrsKIu9cUOeuO2Tq4dZbzNlGZzhZGuCQ+oT1qSKaLlUneYknHTcUPoJfteAcyT
 pY9jmiH9FgslURrasyMaTgmRWe+hdEaQoUYXxN7gaC0rsHhFq+x3IPTQ59rpZv639klR
 4vqg==
X-Gm-Message-State: AC+VfDwV9d8WJwtqyj3LFUOOPzAkV9DsNBon1Epd/BrTM7XQqmlWbS4H
 eXu6klWuAfrt3KPqYLTQTK0oH4QDhauonjWE8X9CnDKR/UQCXCtVz7NRiVRs2kJNVc+i01p33dX
 8F0BHaHk1pXQEU8ay1IlVeCkrPTJB18bNucTEoUVVDUgejpOkw1PGRTdjX34bDO6ZcLTs
X-Received: by 2002:a7b:c051:0:b0:3f6:1474:905 with SMTP id
 u17-20020a7bc051000000b003f614740905mr31768613wmc.29.1687782551154; 
 Mon, 26 Jun 2023 05:29:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AuUBfg9tNLl6cA+demAJ79ns6JqjNYh6xNDrcd8C1GUxRIrRSLeU9HTalOY5cH91vVYxRjA==
X-Received: by 2002:a7b:c051:0:b0:3f6:1474:905 with SMTP id
 u17-20020a7bc051000000b003f614740905mr31768597wmc.29.1687782550883; 
 Mon, 26 Jun 2023 05:29:10 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6782000000b00313f5babb18sm1326446wru.9.2023.06.26.05.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:10 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>
Subject: [PULL 26/53] virtio-mem: Simplify bitmap handling and
 virtio_mem_set_block_state()
Message-ID: <25c893037b89ddd4e42927a2a9b524dbbc0c34a3.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's separate plug and unplug handling to prepare for future changes
and make the code a bit easier to read -- working on block states
(plugged/unplugged) instead of on a bitmap.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230523183036.517957-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 112 +++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 12ea58d5ad..ec0ae32589 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -398,33 +398,46 @@ static void virtio_mem_notify_unplug_all(VirtIOMEM *vmem)
     }
 }
 
-static bool virtio_mem_test_bitmap(const VirtIOMEM *vmem, uint64_t start_gpa,
-                                   uint64_t size, bool plugged)
+static bool virtio_mem_is_range_plugged(const VirtIOMEM *vmem,
+                                        uint64_t start_gpa, uint64_t size)
 {
     const unsigned long first_bit = (start_gpa - vmem->addr) / vmem->block_size;
     const unsigned long last_bit = first_bit + (size / vmem->block_size) - 1;
     unsigned long found_bit;
 
     /* We fake a shorter bitmap to avoid searching too far. */
-    if (plugged) {
-        found_bit = find_next_zero_bit(vmem->bitmap, last_bit + 1, first_bit);
-    } else {
-        found_bit = find_next_bit(vmem->bitmap, last_bit + 1, first_bit);
-    }
+    found_bit = find_next_zero_bit(vmem->bitmap, last_bit + 1, first_bit);
     return found_bit > last_bit;
 }
 
-static void virtio_mem_set_bitmap(VirtIOMEM *vmem, uint64_t start_gpa,
-                                  uint64_t size, bool plugged)
+static bool virtio_mem_is_range_unplugged(const VirtIOMEM *vmem,
+                                          uint64_t start_gpa, uint64_t size)
+{
+    const unsigned long first_bit = (start_gpa - vmem->addr) / vmem->block_size;
+    const unsigned long last_bit = first_bit + (size / vmem->block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_bit(vmem->bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static void virtio_mem_set_range_plugged(VirtIOMEM *vmem, uint64_t start_gpa,
+                                         uint64_t size)
 {
     const unsigned long bit = (start_gpa - vmem->addr) / vmem->block_size;
     const unsigned long nbits = size / vmem->block_size;
 
-    if (plugged) {
-        bitmap_set(vmem->bitmap, bit, nbits);
-    } else {
-        bitmap_clear(vmem->bitmap, bit, nbits);
-    }
+    bitmap_set(vmem->bitmap, bit, nbits);
+}
+
+static void virtio_mem_set_range_unplugged(VirtIOMEM *vmem, uint64_t start_gpa,
+                                           uint64_t size)
+{
+    const unsigned long bit = (start_gpa - vmem->addr) / vmem->block_size;
+    const unsigned long nbits = size / vmem->block_size;
+
+    bitmap_clear(vmem->bitmap, bit, nbits);
 }
 
 static void virtio_mem_send_response(VirtIOMEM *vmem, VirtQueueElement *elem,
@@ -474,6 +487,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
 {
     const uint64_t offset = start_gpa - vmem->addr;
     RAMBlock *rb = vmem->memdev->mr.ram_block;
+    int ret = 0;
 
     if (virtio_mem_is_busy()) {
         return -EBUSY;
@@ -484,42 +498,43 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
             return -EBUSY;
         }
         virtio_mem_notify_unplug(vmem, offset, size);
-    } else {
-        int ret = 0;
+        virtio_mem_set_range_unplugged(vmem, start_gpa, size);
+        return 0;
+    }
 
-        if (vmem->prealloc) {
-            void *area = memory_region_get_ram_ptr(&vmem->memdev->mr) + offset;
-            int fd = memory_region_get_fd(&vmem->memdev->mr);
-            Error *local_err = NULL;
+    if (vmem->prealloc) {
+        void *area = memory_region_get_ram_ptr(&vmem->memdev->mr) + offset;
+        int fd = memory_region_get_fd(&vmem->memdev->mr);
+        Error *local_err = NULL;
 
-            qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err);
-            if (local_err) {
-                static bool warned;
+        qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err);
+        if (local_err) {
+            static bool warned;
 
-                /*
-                 * Warn only once, we don't want to fill the log with these
-                 * warnings.
-                 */
-                if (!warned) {
-                    warn_report_err(local_err);
-                    warned = true;
-                } else {
-                    error_free(local_err);
-                }
-                ret = -EBUSY;
+            /*
+             * Warn only once, we don't want to fill the log with these
+             * warnings.
+             */
+            if (!warned) {
+                warn_report_err(local_err);
+                warned = true;
+            } else {
+                error_free(local_err);
             }
-        }
-        if (!ret) {
-            ret = virtio_mem_notify_plug(vmem, offset, size);
-        }
-
-        if (ret) {
-            /* Could be preallocation or a notifier populated memory. */
-            ram_block_discard_range(vmem->memdev->mr.ram_block, offset, size);
-            return -EBUSY;
+            ret = -EBUSY;
         }
     }
-    virtio_mem_set_bitmap(vmem, start_gpa, size, plug);
+
+    if (!ret) {
+        ret = virtio_mem_notify_plug(vmem, offset, size);
+    }
+    if (ret) {
+        /* Could be preallocation or a notifier populated memory. */
+        ram_block_discard_range(vmem->memdev->mr.ram_block, offset, size);
+        return -EBUSY;
+    }
+
+    virtio_mem_set_range_plugged(vmem, start_gpa, size);
     return 0;
 }
 
@@ -538,7 +553,8 @@ static int virtio_mem_state_change_request(VirtIOMEM *vmem, uint64_t gpa,
     }
 
     /* test if really all blocks are in the opposite state */
-    if (!virtio_mem_test_bitmap(vmem, gpa, size, !plug)) {
+    if ((plug && !virtio_mem_is_range_unplugged(vmem, gpa, size)) ||
+        (!plug && !virtio_mem_is_range_plugged(vmem, gpa, size))) {
         return VIRTIO_MEM_RESP_ERROR;
     }
 
@@ -651,9 +667,9 @@ static void virtio_mem_state_request(VirtIOMEM *vmem, VirtQueueElement *elem,
         return;
     }
 
-    if (virtio_mem_test_bitmap(vmem, gpa, size, true)) {
+    if (virtio_mem_is_range_plugged(vmem, gpa, size)) {
         resp.u.state.state = cpu_to_le16(VIRTIO_MEM_STATE_PLUGGED);
-    } else if (virtio_mem_test_bitmap(vmem, gpa, size, false)) {
+    } else if (virtio_mem_is_range_unplugged(vmem, gpa, size)) {
         resp.u.state.state = cpu_to_le16(VIRTIO_MEM_STATE_UNPLUGGED);
     } else {
         resp.u.state.state = cpu_to_le16(VIRTIO_MEM_STATE_MIXED);
@@ -1372,7 +1388,7 @@ static bool virtio_mem_rdm_is_populated(const RamDiscardManager *rdm,
         return false;
     }
 
-    return virtio_mem_test_bitmap(vmem, start_gpa, end_gpa - start_gpa, true);
+    return virtio_mem_is_range_plugged(vmem, start_gpa, end_gpa - start_gpa);
 }
 
 struct VirtIOMEMReplayData {
-- 
MST



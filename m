Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CA775013C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV3I-0004AL-Qg; Wed, 12 Jul 2023 04:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3G-0004A1-CM
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3E-0000XP-RU
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ho+YQuzbAnpNE14EKD9WsG/foP+RxWa8sBQg8OFt5I=;
 b=Nv11Fo/trqXuVX6VRVYYdFt9udcx/+5Oa3AMBHrpFO6UgrO3z272W8qYvcrxuT0o+XvIug
 lLDyIBDftLTSFa0xXVKs+AGUj9hmieyU76280MNvXysILEG9m6z93SQ5kAxQv5pR4fFT5n
 euSEt8vLzUtHxYTDINDNObD8MIOnsEY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-ZVJheO2BMBivGQgypZki5Q-1; Wed, 12 Jul 2023 04:18:16 -0400
X-MC-Unique: ZVJheO2BMBivGQgypZki5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E14E38008B4;
 Wed, 12 Jul 2023 08:18:16 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2A90492C13;
 Wed, 12 Jul 2023 08:18:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [GIT PULL 10/21] memory-device: Track used region size in
 DeviceMemoryState
Date: Wed, 12 Jul 2023 10:17:39 +0200
Message-ID: <20230712081750.80852-11-david@redhat.com>
In-Reply-To: <20230712081750.80852-1-david@redhat.com>
References: <20230712081750.80852-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Let's avoid iterating over all devices and simply track it in the
DeviceMemoryState.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230623124553.400585-11-david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 22 +++-------------------
 include/hw/boards.h    |  2 ++
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 00c7755557..667d56bd29 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -52,28 +52,11 @@ static int memory_device_build_list(Object *obj, void *opaque)
     return 0;
 }
 
-static int memory_device_used_region_size(Object *obj, void *opaque)
-{
-    uint64_t *size = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
-        const DeviceState *dev = DEVICE(obj);
-        const MemoryDeviceState *md = MEMORY_DEVICE(obj);
-
-        if (dev->realized) {
-            *size += memory_device_get_region_size(md, &error_abort);
-        }
-    }
-
-    object_child_foreach(obj, memory_device_used_region_size, opaque);
-    return 0;
-}
-
 static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
                                         Error **errp)
 {
+    const uint64_t used_region_size = ms->device_memory->used_region_size;
     const uint64_t size = memory_region_size(mr);
-    uint64_t used_region_size = 0;
 
     /* we will need a new memory slot for kvm and vhost */
     if (kvm_enabled() && !kvm_has_free_slot(ms)) {
@@ -86,7 +69,6 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
     }
 
     /* will we exceed the total amount of memory specified */
-    memory_device_used_region_size(OBJECT(ms), &used_region_size);
     if (used_region_size + size < used_region_size ||
         used_region_size + size > ms->maxram_size - ms->ram_size) {
         error_setg(errp, "not enough space, currently 0x%" PRIx64
@@ -292,6 +274,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
     mr = mdc->get_memory_region(md, &error_abort);
     g_assert(ms->device_memory);
 
+    ms->device_memory->used_region_size += memory_region_size(mr);
     memory_region_add_subregion(&ms->device_memory->mr,
                                 addr - ms->device_memory->base, mr);
     trace_memory_device_plug(DEVICE(md)->id ? DEVICE(md)->id : "", addr);
@@ -310,6 +293,7 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
+    ms->device_memory->used_region_size -= memory_region_size(mr);
     trace_memory_device_unplug(DEVICE(md)->id ? DEVICE(md)->id : "",
                                mdc->get_addr(md));
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3b7c30e853..ed83360198 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -298,11 +298,13 @@ struct MachineClass {
  * address space for memory devices starts
  * @mr: address space container for memory devices
  * @dimm_size: the sum of plugged DIMMs' sizes
+ * @used_region_size: the part of @mr already used by memory devices
  */
 typedef struct DeviceMemoryState {
     hwaddr base;
     MemoryRegion mr;
     uint64_t dimm_size;
+    uint64_t used_region_size;
 } DeviceMemoryState;
 
 /**
-- 
2.41.0



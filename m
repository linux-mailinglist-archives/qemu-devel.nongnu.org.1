Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A097D715D75
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xhC-0007u9-M6; Tue, 30 May 2023 07:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3xgq-0007ru-O4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3xgm-0003zt-QF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685446736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEpFnrqBabMN09y+0YSZgUsRDzt7crbSSBiCNJQKLNQ=;
 b=VCZ3kqGgvBMls93JDTrbtJPFASNb8/GK+bWCA7+2R+LP648yekUlor8ULD6OQUVWqMdBtp
 uCnQYfKVp4Y8zCjsae7iIXV2MNZXe00K5aCDfrRnE4eNGVc6BCvn45S0vxgSLqsoXQVugF
 jFZwfXb4NCWtppSTzwSkKjldm+YEUhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-MtdJrl9CMjGhTs1Ksiq0Gg-1; Tue, 30 May 2023 07:38:53 -0400
X-MC-Unique: MtdJrl9CMjGhTs1Ksiq0Gg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27F80802A55;
 Tue, 30 May 2023 11:38:52 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 882A240CFD45;
 Tue, 30 May 2023 11:38:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH 02/10] memory-device: Introduce memory_devices_init()
Date: Tue, 30 May 2023 13:38:30 +0200
Message-Id: <20230530113838.257755-3-david@redhat.com>
In-Reply-To: <20230530113838.257755-1-david@redhat.com>
References: <20230530113838.257755-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's intrduce a new helper that we will use to replace existing memory
device setup code during machine initialization. We'll enforce that the
size has to be > 0.

Once all machines were converted, we'll only allocate ms->device_memory
if the size > 0.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 14 ++++++++++++++
 include/hw/mem/memory-device.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 49f86ec8a8..2197dcf356 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -17,6 +17,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/kvm.h"
+#include "exec/address-spaces.h"
 #include "trace.h"
 
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
@@ -328,6 +329,19 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
     return memory_region_size(mr);
 }
 
+void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
+{
+    g_assert(size);
+    g_assert(!ms->device_memory);
+    ms->device_memory = g_new0(DeviceMemoryState, 1);
+    ms->device_memory->base = base;
+
+    memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
+                       size);
+    memory_region_add_subregion(get_system_memory(), ms->device_memory->base,
+                                &ms->device_memory->mr);
+}
+
 static const TypeInfo memory_device_info = {
     .name          = TYPE_MEMORY_DEVICE,
     .parent        = TYPE_INTERFACE,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 48d2611fc5..6e8a10e2f5 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -16,6 +16,7 @@
 #include "hw/qdev-core.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
+#include "exec/hwaddr.h"
 
 #define TYPE_MEMORY_DEVICE "memory-device"
 
@@ -113,5 +114,6 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
                                        Error **errp);
+void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
 #endif
-- 
2.40.1



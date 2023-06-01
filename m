Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FD719BC5
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hDS-0000fw-72; Thu, 01 Jun 2023 08:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCm-0000SC-T6
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4hCk-0006PE-KY
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZwikLA6WEV50lQOcrHMyhhRsDNuPxp6wdeJAdkCAGE=;
 b=R3FhRdPsIlFtua+ilMUIjKvg+SJGoI8Fb9v0bp7HrYV00nKus08Fsz96jBCcGQcpH/PLAa
 C4RqGqr472X0cPNOiF4yOAzOgwONEpq6WA526AsD31FHRWydXvWhadN3uIlFMVNcHaW84h
 u4Z/ZTxovmBSgud0JkseUsLtz69ECzw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-fqnlxfwvMp-d84sSDxiIlg-1; Thu, 01 Jun 2023 08:14:54 -0400
X-MC-Unique: fqnlxfwvMp-d84sSDxiIlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F48E8032FE;
 Thu,  1 Jun 2023 12:14:54 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.8.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 710922166B29;
 Thu,  1 Jun 2023 12:14:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 02/10] memory-device: Introduce
 machine_memory_devices_init()
Date: Thu,  1 Jun 2023 14:14:39 +0200
Message-Id: <20230601121447.272487-4-david@redhat.com>
In-Reply-To: <20230601121447.272487-1-david@redhat.com>
References: <20230601121447.272487-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 14 ++++++++++++++
 include/hw/boards.h    |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 49f86ec8a8..bb9d7c2a20 100644
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
 
+void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
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
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a385010909..be06e8a41f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -35,6 +35,8 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
 void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp);
+void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
+
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
-- 
2.40.1



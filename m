Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7773B71A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoU-0006XR-EI; Fri, 23 Jun 2023 08:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCfn5-0003qP-GI
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCfn1-0003pe-By
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687522879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrY1SQ3Yj748vZYwX+qtv1yxXYFJfWvl6z14L8OHuKE=;
 b=Vlrk3G2a66VyQmfwtbWTmsrsQS2JePFxWtTTuiczEp6CJsW5CsClVosy46pf3MswIMFfdt
 ARZjgYyjGiOqUrd3goQwhIjU19Rf5XhNmy23J7zGGDmMJt3aO9+7BNTxP//lwXgPMtOGTi
 mb+3FI42h6IK9Bnc3/6ZJZ6Pbd1hTgw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-M_bOkhEZNnSpGhsVAjVVRA-1; Fri, 23 Jun 2023 08:21:15 -0400
X-MC-Unique: M_bOkhEZNnSpGhsVAjVVRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73ED71C06EEC;
 Fri, 23 Jun 2023 12:21:14 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.32.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D26840C2063;
 Fri, 23 Jun 2023 12:21:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v2 6/7] virtio-mem: Prepare for device unplug support
Date: Fri, 23 Jun 2023 14:20:55 +0200
Message-Id: <20230623122056.374312-7-david@redhat.com>
In-Reply-To: <20230623122056.374312-1-david@redhat.com>
References: <20230623122056.374312-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

In many cases, blindly unplugging a virtio-mem device is problematic. We
can only safely remove a device once:
* The guest is not expecting to be able to read unplugged memory
  (unplugged-inaccessible == on)
* The virtio-mem device does not have memory plugged (size == 0)
* The virtio-mem device does not have outstanding requests to the VM to
  plug memory (requested-size == 0)

So let's add a callback to the virtio-mem device class to check for that.
We'll wire-up virtio-mem-pci next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c         | 25 +++++++++++++++++++++++++
 include/hw/virtio/virtio-mem.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 538b695c29..f32f95a7dc 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1468,6 +1468,30 @@ static void virtio_mem_rdm_unregister_listener(RamDiscardManager *rdm,
     QLIST_REMOVE(rdl, next);
 }
 
+static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
+{
+    if (vmem->unplugged_inaccessible == ON_OFF_AUTO_OFF) {
+        /*
+         * We could allow it with a usable region size of 0, but let's just
+         * not care about that legacy setting.
+         */
+        error_setg(errp, "virtio-mem device cannot get unplugged while"
+                   " '" VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP "' != 'on'");
+        return;
+    }
+
+    if (vmem->size) {
+        error_setg(errp, "virtio-mem device cannot get unplugged while"
+                   " '" VIRTIO_MEM_SIZE_PROP "' != '0'");
+        return;
+    }
+    if (vmem->requested_size) {
+        error_setg(errp, "virtio-mem device cannot get unplugged while"
+                   " '" VIRTIO_MEM_REQUESTED_SIZE_PROP "' != '0'");
+        return;
+    }
+}
+
 static void virtio_mem_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1490,6 +1514,7 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     vmc->get_memory_region = virtio_mem_get_memory_region;
     vmc->add_size_change_notifier = virtio_mem_add_size_change_notifier;
     vmc->remove_size_change_notifier = virtio_mem_remove_size_change_notifier;
+    vmc->unplug_request_check = virtio_mem_unplug_request_check;
 
     rdmc->get_min_granularity = virtio_mem_rdm_get_min_granularity;
     rdmc->is_populated = virtio_mem_rdm_is_populated;
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index f15e561785..ab0fe2b4f2 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -98,6 +98,7 @@ struct VirtIOMEMClass {
     MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
     void (*add_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier);
     void (*remove_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier);
+    void (*unplug_request_check)(VirtIOMEM *vmem, Error **errp);
 };
 
 #endif
-- 
2.40.1



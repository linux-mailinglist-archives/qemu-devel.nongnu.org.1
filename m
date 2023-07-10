Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2674D2E3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIno4-0003vM-Ck; Mon, 10 Jul 2023 06:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qIno2-0003uI-MX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qIno1-0004or-6A
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688983664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RlCAvRjZ5/LfrOrTT8T4Hqv6jYLbdlgGcFAODbrGDM=;
 b=Ln+1bO9OlPlogXtnOMqigAFMwFrIp1USCj6GVyqPuAiXTgI/MzYROct15P//vug76HRXeC
 IyYt/WgSY0Brvekfi2vQa/QsxSIO+jRly/t1Qz/BpKBFXA+073dol5dY+xrwle6ZBkD+H4
 1CLZ3N9pS5TxH0pM4aA+ty5oDhyq9kE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-2R8R2_5JOoeXcmIPWK6R2Q-1; Mon, 10 Jul 2023 06:07:39 -0400
X-MC-Unique: 2R8R2_5JOoeXcmIPWK6R2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8660800159;
 Mon, 10 Jul 2023 10:07:38 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8F7C111CA01;
 Mon, 10 Jul 2023 10:07:36 +0000 (UTC)
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
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v3 6/7] virtio-mem: Prepare for device unplug support
Date: Mon, 10 Jul 2023 12:07:13 +0200
Message-ID: <20230710100714.228867-7-david@redhat.com>
In-Reply-To: <20230710100714.228867-1-david@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index ec0ae32589..27b3aac87c 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1483,6 +1483,30 @@ static void virtio_mem_rdm_unregister_listener(RamDiscardManager *rdm,
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
@@ -1505,6 +1529,7 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
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
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CDB950944
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Aug 2024 17:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtcx-0002hP-Bj; Tue, 13 Aug 2024 11:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtcu-0002gi-B5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtcr-0007PT-LO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723563596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBfTLrt0IJ3bIc4wcoVt1ra0+tOl5RxGmL3k9Bo2YpY=;
 b=Ghi+EeVa4G27rXUGy+GoBUFg86VmeAtaMFzQqhIXmKn9tfGfCMei474UthM641m6uRjRi9
 ijEdtQZcSkuJ8ABbYYFiPbQZqDtJyCntTMOMTeriMXLxO7SOyRAQ4NQVt2iBuVEAkV09Oi
 njKdIn8DVBMRIlrbVTT3uh423v5pI9c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-IOzfPOHcMcmxF8CQaVaYSA-1; Tue,
 13 Aug 2024 11:39:53 -0400
X-MC-Unique: IOzfPOHcMcmxF8CQaVaYSA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 319201954207; Tue, 13 Aug 2024 15:39:52 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F5DD300019C; Tue, 13 Aug 2024 15:39:49 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/4] virtio-mem: Add support for suspend+wake-up with
 plugged memory
Date: Tue, 13 Aug 2024 17:39:20 +0200
Message-ID: <20240813153922.311788-5-jmarcin@redhat.com>
In-Reply-To: <20240813153922.311788-1-jmarcin@redhat.com>
References: <20240813153922.311788-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Before, the virtio-mem device would unplug all the memory with any reset
of the device, including during the wake-up of the guest from a
suspended state. Due to this, the virtio-mem driver in the Linux kernel
disallowed suspend-to-ram requests in the guest when the
VIRTIO_MEM_F_PERSISTENT_SUSPEND feature is not exposed by QEMU.

This patch adds the code to skip the reset on wake-up and exposes
theVIRTIO_MEM_F_PERSISTENT_SUSPEND feature to the guest kernel driver
when suspending is possible in QEMU (currently only x86).

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 10 ++++++++++
 hw/virtio/virtio-qmp.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index aeee381eb2..ce228da369 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -883,6 +883,9 @@ static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t features,
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_ON) {
         virtio_add_feature(&features, VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE);
     }
+    if (qemu_wakeup_suspend_enabled()) {
+        virtio_add_feature(&features, VIRTIO_MEM_F_PERSISTENT_SUSPEND);
+    }
     return features;
 }
 
@@ -1841,6 +1844,13 @@ static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
 {
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
+    /*
+     * When waking up from standby/suspend-to-ram, do not unplug any memory.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
     /*
      * During usual resets, we will unplug all memory and shrink the usable
      * region size. This is, however, not possible in all scenarios. Then,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..cccc6fe761 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -450,6 +450,9 @@ static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
             "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
             "accessed"),
+    FEATURE_ENTRY(VIRTIO_MEM_F_PERSISTENT_SUSPEND, \
+            "VIRTIO_MEM_F_PERSISTENT_SUSPND: Plugged memory will remain "
+            "plugged when suspending+resuming"),
     { -1, "" }
 };
 #endif
-- 
2.46.0



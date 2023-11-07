Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459D7E388C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2h-0001tO-HL; Tue, 07 Nov 2023 05:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2Q-0001ZW-Ku
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2G-0002PV-Vt
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUpG4ajzCq4chZHh+UY3ExxDXvLs2vmtbHEleG49rFc=;
 b=fgcv6sBiyoxJtSuDOjHX4IpZBwrJJfTez2aEj6Yf/X4mx+7mzklxASymLvFSERLEWmgqj1
 KrY7w5JDtLHE/hbck4H9PN4bGn2jNALhWm/iekJw1CJyRWh52opva85UCfjkgGDrrEcRJt
 cjA3lVHgdvZvvwv9gxkVW46l9ZG2Qn0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-3AqSQ5PmOdu8mq7WkegHNA-1; Tue, 07 Nov 2023 05:10:06 -0500
X-MC-Unique: 3AqSQ5PmOdu8mq7WkegHNA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c515541a25so58553161fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351804; x=1699956604;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bUpG4ajzCq4chZHh+UY3ExxDXvLs2vmtbHEleG49rFc=;
 b=ESrkw/owiFERXq0xYm0fPWAOZck1av5Mas1xvZmzqwVW/DmkbZA1z9C5ilY/HKfUln
 +o+iea9nNEjrGin9hmrySMARypT+e/eHlZVUZhyhF4UyEcTZ3yCO5ZC+CkNAxAyF4/UG
 dBltPIY+V7Vr+vj4GyHplxrjJD1E++3YtWuKNI2pk/h/v2Po4WcT9ftgiGWgweyY0s8m
 8auobKQMlEvR5pt9ra7p14oIdXGNAisY3DT8IBX+q4aEn+STYVSW67jt4JvnBr/t+ipE
 Ut2RWYUXEyLaaW94J96y1CiCAWYOS60EOawwoUa0+Uf46TBhelNBgELfpbmu2Z7V/hIa
 +Jvw==
X-Gm-Message-State: AOJu0Yx27JhT+zTPS7gSUbbe8U4Ig0Mninjm1H04QHioc4tMIQyibWLV
 9m1mx14zhZ09rIdQbsch+ceLitUV5ca4ohmykUjPE/8OR+j6i87slzuGDKGpI7npEpq91NEzZhw
 eOPLprUeaQ9gSsXy1uzsMzspHmal7uN/wQ8EwcgaV4DVk4wwYAvahCvRyIBQxUMkV/jaO
X-Received: by 2002:a2e:9d47:0:b0:2c2:c450:c2d0 with SMTP id
 y7-20020a2e9d47000000b002c2c450c2d0mr23051543ljj.24.1699351804024; 
 Tue, 07 Nov 2023 02:10:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyj45OiPLDi7YzptjNp44dzRQCmCoKSgcGtTesl3q+kf1GNl24hs45W7JH+2FeLZ5wx2phvQ==
X-Received: by 2002:a2e:9d47:0:b0:2c2:c450:c2d0 with SMTP id
 y7-20020a2e9d47000000b002c2c450c2d0mr23051523ljj.24.1699351803583; 
 Tue, 07 Nov 2023 02:10:03 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b00407efbc4361sm15237356wmq.9.2023.11.07.02.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:02 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 08/63] Add virtio-sound device stub
Message-ID: <2880e676c000a62828d3d9ece7b2ec7a513560a2.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add a new VIRTIO device for the virtio sound device id. Functionality
will be added in the following commits.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <f9678a41fe97b5886c1b04795f1be046509de866.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/audio/virtio-snd.h |  79 ++++++++++++
 hw/audio/virtio-snd.c         | 233 ++++++++++++++++++++++++++++++++++
 system/qdev-monitor.c         |   1 +
 MAINTAINERS                   |   7 +
 hw/audio/Kconfig              |   5 +
 hw/audio/meson.build          |   1 +
 hw/audio/trace-events         |   9 ++
 7 files changed, 335 insertions(+)
 create mode 100644 include/hw/audio/virtio-snd.h
 create mode 100644 hw/audio/virtio-snd.c

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
new file mode 100644
index 0000000000..d08065941c
--- /dev/null
+++ b/include/hw/audio/virtio-snd.h
@@ -0,0 +1,79 @@
+/*
+ * VIRTIO Sound Device conforming to
+ *
+ * "Virtual I/O Device (VIRTIO) Version 1.2
+ * Committee Specification Draft 01
+ * 09 May 2022"
+ *
+ * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright (C) 2019 OpenSynergy GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_SOUND_H
+#define QEMU_VIRTIO_SOUND_H
+
+#include "hw/virtio/virtio.h"
+#include "audio/audio.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_snd.h"
+
+#define TYPE_VIRTIO_SND "virtio-sound-device"
+#define VIRTIO_SND(obj) \
+        OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
+
+/* CONFIGURATION SPACE */
+
+typedef struct virtio_snd_config virtio_snd_config;
+
+/* COMMON DEFINITIONS */
+
+/* common header for request/response*/
+typedef struct virtio_snd_hdr virtio_snd_hdr;
+
+/* event notification */
+typedef struct virtio_snd_event virtio_snd_event;
+
+/* common control request to query an item information */
+typedef struct virtio_snd_query_info virtio_snd_query_info;
+
+/* JACK CONTROL MESSAGES */
+
+typedef struct virtio_snd_jack_hdr virtio_snd_jack_hdr;
+
+/* jack information structure */
+typedef struct virtio_snd_jack_info virtio_snd_jack_info;
+
+/* jack remapping control request */
+typedef struct virtio_snd_jack_remap virtio_snd_jack_remap;
+
+/*
+ * PCM CONTROL MESSAGES
+ */
+typedef struct virtio_snd_pcm_hdr virtio_snd_pcm_hdr;
+
+/* PCM stream info structure */
+typedef struct virtio_snd_pcm_info virtio_snd_pcm_info;
+
+/* set PCM stream params */
+typedef struct virtio_snd_pcm_set_params virtio_snd_pcm_set_params;
+
+/* I/O request header */
+typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
+
+/* I/O request status */
+typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
+
+typedef struct VirtIOSound {
+    VirtIODevice parent_obj;
+
+    VirtQueue *queues[VIRTIO_SND_VQ_MAX];
+    uint64_t features;
+    QEMUSoundCard card;
+    VMChangeStateEntry *vmstate;
+    virtio_snd_config snd_conf;
+} VirtIOSound;
+#endif
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
new file mode 100644
index 0000000000..3a4b441c20
--- /dev/null
+++ b/hw/audio/virtio-snd.c
@@ -0,0 +1,233 @@
+/*
+ * VIRTIO Sound Device conforming to
+ *
+ * "Virtual I/O Device (VIRTIO) Version 1.2
+ * Committee Specification Draft 01
+ * 09 May 2022"
+ *
+ * <https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-52900014>
+ *
+ * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright (C) 2019 OpenSynergy GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "include/qemu/lockable.h"
+#include "sysemu/runstate.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "hw/audio/virtio-snd.h"
+#include "hw/core/cpu.h"
+
+#define VIRTIO_SOUND_VM_VERSION 1
+#define VIRTIO_SOUND_JACK_DEFAULT 0
+#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_CHMAP_DEFAULT 0
+#define VIRTIO_SOUND_HDA_FN_NID 0
+
+static const VMStateDescription vmstate_virtio_snd_device = {
+    .name = TYPE_VIRTIO_SND,
+    .version_id = VIRTIO_SOUND_VM_VERSION,
+    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
+};
+
+static const VMStateDescription vmstate_virtio_snd = {
+    .name = TYPE_VIRTIO_SND,
+    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
+    .version_id = VIRTIO_SOUND_VM_VERSION,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property virtio_snd_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
+    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
+                       VIRTIO_SOUND_JACK_DEFAULT),
+    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
+                       VIRTIO_SOUND_STREAM_DEFAULT),
+    DEFINE_PROP_UINT32("chmaps", VirtIOSound, snd_conf.chmaps,
+                       VIRTIO_SOUND_CHMAP_DEFAULT),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void
+virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    virtio_snd_config *sndconfig =
+        (virtio_snd_config *)config;
+    trace_virtio_snd_get_config(vdev,
+                                s->snd_conf.jacks,
+                                s->snd_conf.streams,
+                                s->snd_conf.chmaps);
+
+    memcpy(sndconfig, &s->snd_conf, sizeof(s->snd_conf));
+    cpu_to_le32s(&sndconfig->jacks);
+    cpu_to_le32s(&sndconfig->streams);
+    cpu_to_le32s(&sndconfig->chmaps);
+
+}
+
+static void
+virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    const virtio_snd_config *sndconfig =
+        (const virtio_snd_config *)config;
+
+
+   trace_virtio_snd_set_config(vdev,
+                               s->snd_conf.jacks,
+                               sndconfig->jacks,
+                               s->snd_conf.streams,
+                               sndconfig->streams,
+                               s->snd_conf.chmaps,
+                               sndconfig->chmaps);
+
+    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
+    le32_to_cpus(&s->snd_conf.jacks);
+    le32_to_cpus(&s->snd_conf.streams);
+    le32_to_cpus(&s->snd_conf.chmaps);
+
+}
+
+/*
+ * Queue handler stub.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: virtqueue
+ */
+static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {}
+
+static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
+                             Error **errp)
+{
+    /*
+     * virtio-v1.2-csd01, 5.14.3,
+     * Feature Bits
+     * None currently defined.
+     */
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    features |= s->features;
+
+    trace_virtio_snd_get_features(vdev, features);
+
+    return features;
+}
+
+static void
+virtio_snd_vm_state_change(void *opaque, bool running,
+                                       RunState state)
+{
+    if (running) {
+        trace_virtio_snd_vm_state_running();
+    } else {
+        trace_virtio_snd_vm_state_stopped();
+    }
+}
+
+static void virtio_snd_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    vsnd->vmstate =
+        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
+
+    trace_virtio_snd_realize(vsnd);
+
+    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
+    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
+
+    /* set number of jacks and streams */
+    if (vsnd->snd_conf.jacks > 8) {
+        error_setg(errp,
+                   "Invalid number of jacks: %"PRIu32,
+                   vsnd->snd_conf.jacks);
+        return;
+    }
+    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
+        error_setg(errp,
+                   "Invalid number of streams: %"PRIu32,
+                    vsnd->snd_conf.streams);
+        return;
+    }
+
+    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
+        error_setg(errp,
+                   "Invalid number of channel maps: %"PRIu32,
+                   vsnd->snd_conf.chmaps);
+        return;
+    }
+
+    AUD_register_card("virtio-sound", &vsnd->card, errp);
+
+    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
+        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+    vsnd->queues[VIRTIO_SND_VQ_EVENT] =
+        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+    vsnd->queues[VIRTIO_SND_VQ_TX] =
+        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+    vsnd->queues[VIRTIO_SND_VQ_RX] =
+        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+}
+
+static void virtio_snd_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+
+    qemu_del_vm_change_state_handler(vsnd->vmstate);
+    trace_virtio_snd_unrealize(vsnd);
+
+    AUD_remove_card(&vsnd->card);
+    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
+    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
+    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
+    virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_RX]);
+    virtio_cleanup(vdev);
+}
+
+
+static void virtio_snd_reset(VirtIODevice *vdev) {}
+
+static void virtio_snd_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+    device_class_set_props(dc, virtio_snd_properties);
+
+    dc->vmsd = &vmstate_virtio_snd;
+    vdc->vmsd = &vmstate_virtio_snd_device;
+    vdc->realize = virtio_snd_realize;
+    vdc->unrealize = virtio_snd_unrealize;
+    vdc->get_config = virtio_snd_get_config;
+    vdc->set_config = virtio_snd_set_config;
+    vdc->get_features = get_features;
+    vdc->reset = virtio_snd_reset;
+    vdc->legacy_features = 0;
+}
+
+static const TypeInfo virtio_snd_types[] = {
+    {
+      .name          = TYPE_VIRTIO_SND,
+      .parent        = TYPE_VIRTIO_DEVICE,
+      .instance_size = sizeof(VirtIOSound),
+      .class_init    = virtio_snd_class_init,
+    }
+};
+
+DEFINE_TYPES(virtio_snd_types)
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1b8005ae55..3c0aabec4b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -111,6 +111,7 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
+    { "virtio-sound-device", "virtio-sound", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8a7d5be5..d3ee463d21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2310,6 +2310,13 @@ F: hw/virtio/virtio-mem-pci.h
 F: hw/virtio/virtio-mem-pci.c
 F: include/hw/virtio/virtio-mem.h
 
+virtio-snd
+M: Gerd Hoffmann <kraxel@redhat.com>
+R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Supported
+F: hw/audio/virtio-snd.c
+F: include/hw/audio/virtio-snd.h
+
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index d0993514a1..daf060e1be 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -50,3 +50,8 @@ config CS4231
 
 config ASC
     bool
+
+config VIRTIO_SND
+    bool
+    default y
+    depends on VIRTIO
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index 8805322f5c..7a503be1fd 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
 system_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('via-ac97.c'))
 system_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
+system_ss.add(when: ['CONFIG_VIRTIO_SND', 'CONFIG_VIRTIO'], if_true: files('virtio-snd.c'))
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 059ce451f5..525ced2b34 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -38,3 +38,12 @@ asc_write_fifo(const char fifo, int reg, unsigned size, int wrptr, int cnt, uint
 asc_write_reg(int reg, unsigned size, uint64_t value) "reg=0x%03x size=%u value=0x%"PRIx64
 asc_write_extreg(const char fifo, int reg, unsigned size, uint64_t value) "fifo %c reg=0x%03x size=%u value=0x%"PRIx64
 asc_update_irq(int irq, int a, int b) "set IRQ to %d (A: 0x%x B: 0x%x)"
+
+#virtio-snd.c
+virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%"PRIu32" streams=%"PRIu32" chmaps=%"PRIu32""
+virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
+virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
+virtio_snd_vm_state_running(void) "vm state running"
+virtio_snd_vm_state_stopped(void) "vm state stopped"
+virtio_snd_realize(void *snd) "snd %p: realize"
+virtio_snd_unrealize(void *snd) "snd %p: unrealize"
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C717B344F
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEBV-00084q-Pk; Fri, 29 Sep 2023 10:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBT-00084g-Mt
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBO-0004Fc-1V
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405524e6740so123703305e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996567; x=1696601367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL16FoA4aCUaZDwnxCzdeBYyfY2gZY34jgRh7rb7Z1M=;
 b=XfwLkx1ZpNKZpYBUzOnEoiCcdnt5Y+tpTVNhhzTS4OH9FLo7fhHqlhBM4w66O9nfoR
 TDsTPQ9dxMdrOAqP0VNmU1vWCW4OtdNAgt8TVJCxRWm2J46COTxkG2s2A1YGqdnUqzUm
 tzX1ZTsUicOBoVo6nO16jFxbCIRXA1ZrUZdYQxJxTHGr7kn3KOrKB5EGGVnLwjkLLUE3
 aVJ5q9oJkMSkD8BVsfBdsHeGDo0/rzInpQUozR5GAP7L2QtDVI9GSPUPnqMRzNmh21SB
 sOZbuZrowfmtOVSB/ZLgoKXWNFi+kc4utJ/Ml1am6XKmZQwMM+dsczx+NtZH8FHp26PV
 4c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996567; x=1696601367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL16FoA4aCUaZDwnxCzdeBYyfY2gZY34jgRh7rb7Z1M=;
 b=p2KTtZ+1t4I6pDYjYPURyQTenI3Lp0BbUB+TpU8ZEMulkS2pg+zdAxzliH8UgFJ230
 6KePZFNFGAaqzrU6EUdLoSvJFzJl6CoYGzf7uebbuz88sBgc4FOfquCHNs9UG9yemJef
 TpiNDv8tMkmHv+XQHAgRJibOgKWCRIZJywEnE9tgEfOhmSaJ91LcQZdpQ8Qo1UA5sAv2
 H5acpmWa6Nn4RGtJwDzm310ZAZpfg+JkdE+GGCGtn7CAhQUms2v+eUM0NkNXyX9fjp26
 zJLvhMAxnimdtfKmyT20UVOIoYNfrMt4uNRrSJulWXKT/w8oMKUZSCjaBPmQgl8KPLa5
 18Cw==
X-Gm-Message-State: AOJu0Yyw6gzvR3g59+Av+tQDJDPfJYSaA7IFBQknZVAwovnqJWdBPoO/
 lfGuP08Jr4xJCUHw1u+tsncsXcqIexFKhA9Okz8=
X-Google-Smtp-Source: AGHT+IFwSW84r5Z+72G7H+uWEpg13akZhoPoQ5k5VYv/cJ+fCRyLE6CEnZDWU6uolQCy38n05BtUeQ==
X-Received: by 2002:a05:600c:2492:b0:405:3e9a:f1e3 with SMTP id
 18-20020a05600c249200b004053e9af1e3mr4187182wms.11.1695996566886; 
 Fri, 29 Sep 2023 07:09:26 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:09:26 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v10 01/11] Add virtio-sound device stub
Date: Fri, 29 Sep 2023 17:08:21 +0300
Message-Id: <6e7bdf6dda10d11fd21aefff25d52fa35d054b6c.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new VIRTIO device for the virtio sound device id. Functionality
will be added in the following commits.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                    |   6 +
 hw/virtio/Kconfig              |   5 +
 hw/virtio/meson.build          |   1 +
 hw/virtio/trace-events         |   9 ++
 hw/virtio/virtio-snd.c         | 223 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h |  79 ++++++++++++
 6 files changed, 323 insertions(+)
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..81ca61e90b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2241,6 +2241,12 @@ F: hw/virtio/virtio-mem-pci.h
 F: hw/virtio/virtio-mem-pci.c
 F: include/hw/virtio/virtio-mem.h
 
+virtio-snd
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Supported
+F: hw/virtio/virtio-snd*.c
+F: include/hw/virtio/virtio-snd.h
+
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 92c9cf6c96..d6f20657b3 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -17,6 +17,11 @@ config VIRTIO_PCI
     depends on PCI
     select VIRTIO
 
+config VIRTIO_SND
+    bool
+    default y
+    depends on VIRTIO
+
 config VIRTIO_MMIO
     bool
     select VIRTIO
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 13e7c6c272..120d4bfa0a 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -31,6 +31,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
+specific_virtio_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7109cf1a3b..3ed7da35f2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -154,3 +154,12 @@ virtio_pmem_flush_done(int type) "fsync return=%d"
 virtio_gpio_start(void) "start"
 virtio_gpio_stop(void) "stop"
 virtio_gpio_set_status(uint8_t status) "0x%x"
+
+#virtio-snd.c
+virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%"PRIu32" streams=%"PRIu32" chmaps=%"PRIu32""
+virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
+virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
+virtio_snd_vm_state_running(void) "vm state running"
+virtio_snd_vm_state_stopped(void) "vm state stopped"
+virtio_snd_realize(void *snd) "snd %p: realize"
+virtio_snd_unrealize(void *snd) "snd %p: unrealize"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
new file mode 100644
index 0000000000..a8204e8a02
--- /dev/null
+++ b/hw/virtio/virtio-snd.c
@@ -0,0 +1,223 @@
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
+#include "hw/virtio/virtio-snd.h"
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
+    .name = "virtio-sound",
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
+    trace_virtio_snd_get_config(vdev,
+                                s->snd_conf.jacks,
+                                s->snd_conf.streams,
+                                s->snd_conf.chmaps);
+
+    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
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
+    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
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
+    AUD_register_card("virtio-sound", &vsnd->card);
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
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
new file mode 100644
index 0000000000..934e854a80
--- /dev/null
+++ b/include/hw/virtio/virtio-snd.h
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
+#define TYPE_VIRTIO_SND "virtio-sound"
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
-- 
2.39.2



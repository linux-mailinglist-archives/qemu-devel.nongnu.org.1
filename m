Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7679E0E3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKO1-0006TA-2k; Wed, 13 Sep 2023 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKNy-0006Si-SP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKNv-0001iJ-O3
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d20548adso6570932f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590441; x=1695195241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8hO5QNbGralRHHrdWYyHBbr9SEt/GWODu1IHzcLc3I=;
 b=XrTX+ax+UxMQwxsedntHOcRkebiW1raZSH3MSocrSv/t7DZSb3UyAve22yC/Asq2qh
 Ho1uUyAL7qtTx4e9GNrxBHMH/FykD8W8Ee0qKFtac30d5EZDWmHdae6NDIibrA+ZGe3k
 YN/0TqMdslZkd7jNFC/Vdn31pWjlJ5BGkyZ6mIu3FPd/84rM/Y5lVVjwPNaTr6Riyq4u
 T5WdYBf61scmPA86uH11WkDz3zWHDL0jVN8/0FnkNB9ueOjHPn3epR8u2Q9XKrjJAQXM
 sad+ALYslehjSGHwqn091GmoH29bmg9zVWHZuAfAP4QL4ca0nL+kXqpnMhXkITZFOImj
 Z1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590441; x=1695195241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8hO5QNbGralRHHrdWYyHBbr9SEt/GWODu1IHzcLc3I=;
 b=mXA5Yc1DlY3N6fNM2W3JTwTb2ez2NTdvp+B3uqYtWVHTpj6ZMj4eHsu8fGdVIiEhhH
 gbO6n0SkyC1W4i84mio/rizt86Yqgh2ZSFRG6qEnsS30RTEy0sZVMmZfgQ3u8D9SjaIM
 eN5uiBauqfEl3H3ekrKM8kxKIQ6tepm3eAsVROL4GkWkkb0f4+aSHEj+eH01kQ98pR1o
 l3T9LPEqr4hiUZLSMqHp6zyZu/MHunYuMQc2xJ6dHdxKd9hKxRoTtUY0XZ9MmbCzdl62
 ts/dee5M8bdq1tlSFgFVdtozkrkipEKeBp/X+TIpBclblKKnjaweYlE2k2NRGfxIsmPo
 8y0g==
X-Gm-Message-State: AOJu0YyHgdrZeWCQkk3kCAhxOg96Q8jez2OrXAmRaBj2W1CZU3cVjI6l
 Es2YPaV4h1OleXrOo2sQVC0Eu7d1XOmBEj8m394=
X-Google-Smtp-Source: AGHT+IGlH7I52jlvvjdJanr5ov//P5S+HS4ylB48vzOic358rxvQ6GK65+ezo2tWC80dIjXfOrWWOw==
X-Received: by 2002:a5d:54cc:0:b0:319:7b57:8dc5 with SMTP id
 x12-20020a5d54cc000000b003197b578dc5mr1354469wrv.54.1694590440942; 
 Wed, 13 Sep 2023 00:34:00 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:00 -0700 (PDT)
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
Subject: [PATCH v9 01/12] Add virtio-sound device stub
Date: Wed, 13 Sep 2023 10:33:08 +0300
Message-Id: <5173e2c243728b82698b849e4f450cba260f7e00.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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
index 00562f924f..c6d395cc04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2247,6 +2247,12 @@ F: hw/virtio/virtio-mem-pci.h
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



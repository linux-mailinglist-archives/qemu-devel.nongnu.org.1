Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7C7D361A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutfH-0005Ei-D7; Mon, 23 Oct 2023 08:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfE-0005EE-RO
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfB-0001vd-6D
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so27719495e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062643; x=1698667443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5bEh/UwZJNLOlMLBgyLw9SN22NrMuoXxTmZDmPQu4E=;
 b=LlWUGQw9CVPf9U67nXQr3I9tX3emM44BQcX7POkTSmPDD38619UibE0ijCUjs9CQ6/
 ZR4w/h7inO+Ydl31L7mFFleCysavxzQQWuZB5IwS+qtVTc/x9sKWtELNFZc4r3VRozek
 t7NUGzm4eHGElW+WpE44mulnV01Y014tW2HmsjUcpWpH2eMCCG7zghUsqJWLhoa3jEpK
 eNS1jzpzLIeb+Z3fvi73Go7AoIwZMPCzQlsTxI0+79RZBkq1dVHjA4miilQS6f4ys7h3
 be+BQHlTEXWB2bIk7YK4UYkSdGhUdwy2Z3qoicPHb19yeMb3UbRCLxefu/B/IHXN4L/q
 9VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062643; x=1698667443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5bEh/UwZJNLOlMLBgyLw9SN22NrMuoXxTmZDmPQu4E=;
 b=hPkDnYJjSjnzukRPEmmrU6lUHebmJ23fkMaNcXwX5QCsH5WgISVq0i7eMBDy4+QQes
 AF5cHlhZWiwZrgB3J+veZhoAEUniTJr0GsodG2BH1++chUkWrF3XAIQQnZOtiYlbmGYb
 3zh1x5gi868/pAleZG9h8Kb++1Xz8kx7NOcuD7YxkS8JUO7mmUJilvGlfO3ONdHTeGar
 bLYHprVs8FuIjGZD6nOXSIFXwVQ58ueqxKtGdnzncpyt85FvfKa0yMvQmr85FsMWGVvj
 0h/rih2+jmrseT8MdmsK+CrzIjo6hukX8j4aUFs6wYcaO4LsWfRi576ZyRyvhwXOUj2s
 HW2Q==
X-Gm-Message-State: AOJu0Yzqh262yQ0wWLi9FZw6AU1me/t1+oaEkZ+eKM4eaSi/2IzTC60s
 PeME5ByPOy+Qn3AloLVs78LSRh4WxIJfmUn5Hls=
X-Google-Smtp-Source: AGHT+IG+bhjQlN7rkReHg4mDHnAia9erxJacHBFBxG1EeesGypuTOrMHvF08/DOKTVzqzfVLpCAgXQ==
X-Received: by 2002:a05:600c:3b1e:b0:405:3d41:5646 with SMTP id
 m30-20020a05600c3b1e00b004053d415646mr7681093wms.2.1698062641896; 
 Mon, 23 Oct 2023 05:04:01 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:00 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v13 01/11] Add virtio-sound device stub
Date: Mon, 23 Oct 2023 15:03:18 +0300
Message-Id: <f9678a41fe97b5886c1b04795f1be046509de866.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                   |   7 +
 hw/audio/Kconfig              |   5 +
 hw/audio/meson.build          |   1 +
 hw/audio/trace-events         |   9 ++
 hw/audio/virtio-snd.c         | 233 ++++++++++++++++++++++++++++++++++
 include/hw/audio/virtio-snd.h |  79 ++++++++++++
 system/qdev-monitor.c         |   1 +
 7 files changed, 335 insertions(+)
 create mode 100644 hw/audio/virtio-snd.c
 create mode 100644 include/hw/audio/virtio-snd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f9912baa0..0e628f9e1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2282,6 +2282,13 @@ F: hw/virtio/virtio-mem-pci.h
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
-- 
2.39.2



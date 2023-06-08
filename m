Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1372845C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7I0O-0005ba-9R; Thu, 08 Jun 2023 11:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7I0F-0005Vz-GU
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:56:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7I0B-0000WF-KB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:56:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7bso5568435e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686239802; x=1688831802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnHjY9PCFvj9YNaFERDvs5/M7DhqvqbGQ32N3fPu7LI=;
 b=DI+r6ZlDXZz9nHe/ex2qAVA2OsIqU3BNCpA10CwtijiRH/6SaLFebND+JEAgIoonds
 UNgzb0v6hPmmQgMy0wN8S3m8ZGeHVg5GT1WOii2g31Pn8pKgR1hJVLHkMxRm+Y4lsxSV
 Eqm4mO72U3k7KRFY5GunnWO40XEL6oUxgeod1K9LiUWmBI86bkp0ajs+X79Y/NHy834m
 ru9F5AUk9hTo4oWiLeJd1hhJCo6rVHu4NFZ4Rnk2H7XiMR8Bih4Ha6Zf3eobx2HgaR+I
 fATFm+R25OGYO2ix7isuTYd+wIOGVvcBSfl4K7fVrgE+6uQxFb5BqK08BC6rj9EwFsFU
 NlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686239802; x=1688831802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnHjY9PCFvj9YNaFERDvs5/M7DhqvqbGQ32N3fPu7LI=;
 b=Mmlrp8PSnrBaT7i1IValcfUP4JQGpqSC1CAyCNii2M97x8geFERWr8CLiLrwL5uEHH
 H/DyW+EWnlbNRieSsUA1cCt2aPnalXpqzzZ4LUGduP6NMfJYOFaXV+DucHPH/xmOO1rt
 Z1rWUgfwIVq7p7xJZYnEx87H3KPsUs+iAmu8ELlArpb+TAPtG5YzL1bogUf18hEnMGJY
 nJ7IMjBTu9HDxJ30x3vKAl7oiSut4Wxz9cuyhxnEntyMdq/YqAl+mEeVQ8cuURPJeA+y
 fnpCjpIIqdrglce8S7bV2NtFMcAdY30xfqRbsff6dIQgcMBnkI2r0oxYcmz/EJATcu9I
 FSTA==
X-Gm-Message-State: AC+VfDxje9lE64QcdN35BfWpqX0QY0xCSpSmFWxe93B9QtX7MZfjRmjS
 PpiY8jZ7qkL7aK67JbSg9W1o65aoWpNnsLCi0gs=
X-Google-Smtp-Source: ACHHUZ69gqvqbiVFb1V+6AQwToFC8LH5jrjHEr3yV7rZbS8qcauFYlOWWmGfSIrlIphc5/7KmCkWuQ==
X-Received: by 2002:a05:6000:52:b0:30a:e511:e65c with SMTP id
 k18-20020a056000005200b0030ae511e65cmr7765334wrx.37.1686239801142; 
 Thu, 08 Jun 2023 08:56:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-175.37.6.3.tellas.gr. [37.6.3.175])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb51000000b00307bc4e39e5sm1927105wrs.117.2023.06.08.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:56:40 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Subject: [PATCH v2 1/3] Add virtio-sound device
Date: Thu,  8 Jun 2023 18:56:17 +0300
Message-Id: <95d564fc1f36c9e12b466c07ea000b38d14aec4e.1686238728.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
References: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This patch adds an audio device implementing the recent virtio sound
spec (1.2).

PCM functionality is implemented, and jack[0], chmaps[1] messages are
at the moment left unimplemented.

PS2: This patch was based on a draft patch posted by OpenSynergy in 2019. [2]

[0]: https://www.kernel.org/doc/html/latest/sound/designs/jack-controls.html
[1]: https://www.kernel.org/doc/html/latest/sound/designs/channel-mapping-api.html
[2]: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471#diff-fa5c10be8476fb5385a280885d527b0b40dfc11ddcc74369fce085d8b5b17bbd

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
---
 MAINTAINERS                    |    6 +
 hw/virtio/Kconfig              |    5 +
 hw/virtio/meson.build          |    1 +
 hw/virtio/trace-events         |   21 +
 hw/virtio/virtio-snd.c         | 1121 ++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h |  194 ++++++
 6 files changed, 1348 insertions(+)
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c93ab0ee5..5d5475b1c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2218,6 +2218,12 @@ F: hw/virtio/virtio-mem-pci.h
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
index 89e9e426d8..fcc522ed21 100644
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
index bdec78bfc6..8cf49af618 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -68,5 +68,6 @@ softmmu_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('virtio-stub.c'))
 softmmu_ss.add(files('virtio-hmp-cmds.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f8d05cf9b..b77d78abdc 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -151,3 +151,24 @@ virtio_pmem_flush_done(int type) "fsync return=%d"
 virtio_gpio_start(void) "start"
 virtio_gpio_stop(void) "stop"
 virtio_gpio_set_status(uint8_t status) "0x%x"
+
+#virtio-snd.c
+virtio_snd_pcm_stream_flush(int stream) "flushing stream %d"
+virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+#virtio_snd_handle_jack_info(int jack) "VIRTIO_SND_JACK_INFO called for jack %d"
+#virtio_snd_handle_jack_remap(void) "VIRTIO_SND_PCM_JACK_REMAP called"
+virtio_snd_handle_pcm_info(int stream) "VIRTIO_SND_R_PCM_INFO called for stream %d"
+virtio_snd_handle_pcm_set_params(int stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %d"
+virtio_snd_handle_pcm_start_stop(const char *code, int stream) "%s called for stream %d"
+virtio_snd_handle_pcm_release(int stream) "VIRTIO_SND_PCM_RELEASE called for stream %d"
+virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
+virtio_snd_handle_xfer(void) "tx/rx queue callback called"
+virtio_snd_handle_event(void) "event queue callback called"
+virtio_snd_realize(void *snd) "snd %p: realize"
+virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
+virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%d streams=%d chmaps=%d"
+virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %d->%d, streams from %d->%d, chmaps from %d->%d"
+virtio_snd_vm_state_running(void) "vm state running"
+virtio_snd_vm_state_stopped(void) "vm state stopped"
+virtio_snd_handle_code(int val, const char *code) "ctrl code msg val = %d == %s"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
new file mode 100644
index 0000000000..e3b6c353ad
--- /dev/null
+++ b/hw/virtio/virtio-snd.c
@@ -0,0 +1,1121 @@
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
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu/log.h"
+#include "include/qemu/lockable.h"
+#include "sysemu/runstate.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "hw/virtio/virtio-snd.h"
+
+#define VIRTIO_SOUND_VM_VERSION 1
+
+#define VIRTIO_SOUND_JACK_DEFAULT 0
+#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_CHMAP_DEFAULT 0
+
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
+static void virtio_snd_process_cmdq(VirtIOSound *s);
+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_out_cb(void *data, int available);
+static uint32_t virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+                                          VirtQueue *vq,
+                                          VirtQueueElement *element,
+                                          bool read);
+
+/*
+ * Get a specific stream from the virtio sound card device.
+ * Returns NULL if @stream_id is invalid or not allocated.
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
+                                                       uint32_t stream_id)
+{
+    if (stream_id >= s->snd_conf.streams) {
+        return NULL;
+    }
+    return s->pcm->streams[stream_id];
+}
+
+/*
+ * Get params for a specific stream.
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
+                                                       uint32_t stream_id)
+{
+    if (stream_id >= s->snd_conf.streams) {
+        return NULL;
+    }
+    return s->pcm->pcm_params[stream_id];
+}
+
+/*
+ * Handle the VIRTIO_SND_R_PCM_INFO request.
+ * The function writes the info structs to the request element.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_info(VirtIOSound *s,
+                                       virtio_snd_ctrl_command *cmd)
+{
+    virtio_snd_query_info req;
+    uint32_t sz;
+    VirtIOSoundPCMStream *stream = NULL;
+    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
+
+    sz = iov_to_buf(cmd->elem->out_sg,
+                    cmd->elem->out_num,
+                    0,
+                    &req,
+                    sizeof(req));
+    assert(sz == sizeof(virtio_snd_query_info));
+
+    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+        sizeof(virtio_snd_hdr) + req.size * req.count) {
+        error_report("pcm info: buffer too small, got: %lu, needed: %lu",
+                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
+                sizeof(virtio_snd_pcm_info));
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    pcm_info = g_new0(virtio_snd_pcm_info, req.count);
+    for (int i = req.start_id; i < req.start_id + req.count; i++) {
+        trace_virtio_snd_handle_pcm_info(i);
+        stream = virtio_snd_pcm_get_stream(s, i);
+
+        if (!stream) {
+            error_report("Invalid stream id: %d", i);
+            cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+            return;
+        }
+
+        pcm_info[i - req.start_id].hdr.hda_fn_nid = stream->info.hdr.hda_fn_nid;
+        pcm_info[i - req.start_id].features = stream->features;
+        pcm_info[i - req.start_id].formats = stream->formats;
+        pcm_info[i - req.start_id].rates = stream->rates;
+        pcm_info[i - req.start_id].direction = stream->direction;
+        pcm_info[i - req.start_id].channels_min = stream->channels_min;
+        pcm_info[i - req.start_id].channels_max = stream->channels_max;
+
+        memset(&pcm_info[i].padding, 0, sizeof(pcm_info[i].padding));
+    }
+
+    cmd->resp.code = VIRTIO_SND_S_OK;
+
+    sz = iov_from_buf(cmd->elem->in_sg,
+                      cmd->elem->in_num,
+                      sizeof(virtio_snd_hdr),
+                      pcm_info,
+                      sizeof(virtio_snd_pcm_info) * req.count);
+    assert(sz == req.size * req.count);
+
+    return;
+}
+
+/*
+ * Set the given stream params.
+ * Called by both virtio_snd_handle_pcm_set_params and during device
+ * initialization.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @params: The PCM params as defined in the virtio specification
+ */
+static
+uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
+                                       virtio_snd_pcm_set_params *params)
+{
+    uint32_t supported_formats, supported_rates;
+    VirtIOSoundPCMParams *st_params;
+    uint32_t stream_id = params->hdr.stream_id;
+
+    if (stream_id > s->snd_conf.streams || !(s->pcm->pcm_params)) {
+        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
+        return VIRTIO_SND_S_BAD_MSG;
+    }
+
+    if (!s->pcm->pcm_params[stream_id]) {
+        s->pcm->pcm_params[stream_id] = g_new0(VirtIOSoundPCMParams, 1);
+    }
+    st_params = virtio_snd_pcm_get_params(s, stream_id);
+
+    st_params->features = params->features;
+    st_params->buffer_bytes = params->buffer_bytes;
+    st_params->period_bytes = params->period_bytes;
+
+    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
+        error_report("Number of channels is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    st_params->channels = params->channels;
+
+    supported_formats = 1 << VIRTIO_SND_PCM_FMT_S8
+                      | 1 << VIRTIO_SND_PCM_FMT_U8
+                      | 1 << VIRTIO_SND_PCM_FMT_S16
+                      | 1 << VIRTIO_SND_PCM_FMT_U16
+                      | 1 << VIRTIO_SND_PCM_FMT_S32
+                      | 1 << VIRTIO_SND_PCM_FMT_U32
+                      | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
+
+    supported_rates = 1 << VIRTIO_SND_PCM_RATE_5512
+                    | 1 << VIRTIO_SND_PCM_RATE_8000
+                    | 1 << VIRTIO_SND_PCM_RATE_11025
+                    | 1 << VIRTIO_SND_PCM_RATE_16000
+                    | 1 << VIRTIO_SND_PCM_RATE_22050
+                    | 1 << VIRTIO_SND_PCM_RATE_32000
+                    | 1 << VIRTIO_SND_PCM_RATE_44100
+                    | 1 << VIRTIO_SND_PCM_RATE_48000
+                    | 1 << VIRTIO_SND_PCM_RATE_64000
+                    | 1 << VIRTIO_SND_PCM_RATE_88200
+                    | 1 << VIRTIO_SND_PCM_RATE_96000
+                    | 1 << VIRTIO_SND_PCM_RATE_176400
+                    | 1 << VIRTIO_SND_PCM_RATE_192000
+                    | 1 << VIRTIO_SND_PCM_RATE_384000;
+
+    if (!(supported_formats & (1 << params->format))) {
+        error_report("Stream format is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    st_params->format = params->format;
+
+    if (!(supported_rates & (1 << params->rate))) {
+        error_report("Stream rate is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    st_params->rate = params->rate;
+    st_params->period_bytes = params->period_bytes;
+    st_params->buffer_bytes = params->buffer_bytes;
+
+    return VIRTIO_SND_S_OK;
+}
+
+/*
+ * Handles the VIRTIO_SND_R_PCM_SET_PARAMS request.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd)
+{
+    virtio_snd_pcm_set_params req;
+    uint32_t sz;
+
+    sz = iov_to_buf(cmd->elem->out_sg,
+                    cmd->elem->out_num,
+                    0,
+                    &req,
+                    sizeof(req));
+    assert(sz == sizeof(virtio_snd_pcm_set_params));
+
+    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
+    cmd->resp.code = virtio_snd_pcm_set_params_impl(s, &req);
+
+    return;
+}
+
+/*
+ * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
+ */
+static AudioFormat virtio_snd_get_qemu_format(uint32_t format)
+{
+    switch (format) {
+    case VIRTIO_SND_PCM_FMT_U8:
+        return AUDIO_FORMAT_U8;
+    case VIRTIO_SND_PCM_FMT_S8:
+        return AUDIO_FORMAT_S8;
+    case VIRTIO_SND_PCM_FMT_U16:
+        return AUDIO_FORMAT_U16;
+    case VIRTIO_SND_PCM_FMT_S16:
+        return AUDIO_FORMAT_S16;
+    case VIRTIO_SND_PCM_FMT_U32:
+        return AUDIO_FORMAT_U32;
+    case VIRTIO_SND_PCM_FMT_S32:
+        return AUDIO_FORMAT_S32;
+    case VIRTIO_SND_PCM_FMT_FLOAT:
+        return AUDIO_FORMAT_F32;
+    default:
+        return -1;
+    }
+}
+
+/*
+ * Get a QEMU Audiosystem compatible frequency value from a
+ * VIRTIO_SND_PCM_RATE_*
+ */
+static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
+{
+    switch (rate) {
+    case VIRTIO_SND_PCM_RATE_5512:
+        return 5512;
+    case VIRTIO_SND_PCM_RATE_8000:
+        return 8000;
+    case VIRTIO_SND_PCM_RATE_11025:
+        return 11025;
+    case VIRTIO_SND_PCM_RATE_16000:
+        return 16000;
+    case VIRTIO_SND_PCM_RATE_22050:
+        return 22050;
+    case VIRTIO_SND_PCM_RATE_32000:
+        return 32000;
+    case VIRTIO_SND_PCM_RATE_44100:
+        return 44100;
+    case VIRTIO_SND_PCM_RATE_48000:
+        return 48000;
+    case VIRTIO_SND_PCM_RATE_64000:
+        return 64000;
+    case VIRTIO_SND_PCM_RATE_88200:
+        return 88200;
+    case VIRTIO_SND_PCM_RATE_96000:
+        return 96000;
+    case VIRTIO_SND_PCM_RATE_176400:
+        return 176400;
+    case VIRTIO_SND_PCM_RATE_192000:
+        return 192000;
+    case VIRTIO_SND_PCM_RATE_384000:
+        return 384000;
+    default:
+        return -1;
+    }
+}
+
+/*
+ * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
+ * params.
+ */
+static void virtio_snd_get_qemu_audsettings(audsettings *as,
+                                            VirtIOSoundPCMParams *params)
+{
+    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
+    as->fmt = virtio_snd_get_qemu_format(params->format);
+    as->freq = virtio_snd_get_qemu_freq(params->rate);
+    as->endianness = AUDIO_HOST_ENDIANNESS;
+}
+
+/*
+ * Prepares a VirtIOSound card stream.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
+{
+    audsettings as;
+    uint32_t supported_formats, supported_rates;
+    VirtIOSoundPCMParams *params;
+    VirtIOSoundPCMStream *stream;
+
+    if (!s->pcm->streams
+            || !s->pcm->pcm_params
+            || !s->pcm->pcm_params[stream_id]) {
+        return VIRTIO_SND_S_BAD_MSG;
+    }
+
+    supported_formats = 1 << VIRTIO_SND_PCM_FMT_S8
+                      | 1 << VIRTIO_SND_PCM_FMT_U8
+                      | 1 << VIRTIO_SND_PCM_FMT_S16
+                      | 1 << VIRTIO_SND_PCM_FMT_U16
+                      | 1 << VIRTIO_SND_PCM_FMT_S32
+                      | 1 << VIRTIO_SND_PCM_FMT_U32
+                      | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
+
+    supported_rates = 1 << VIRTIO_SND_PCM_RATE_5512
+                    | 1 << VIRTIO_SND_PCM_RATE_8000
+                    | 1 << VIRTIO_SND_PCM_RATE_11025
+                    | 1 << VIRTIO_SND_PCM_RATE_16000
+                    | 1 << VIRTIO_SND_PCM_RATE_22050
+                    | 1 << VIRTIO_SND_PCM_RATE_32000
+                    | 1 << VIRTIO_SND_PCM_RATE_44100
+                    | 1 << VIRTIO_SND_PCM_RATE_48000
+                    | 1 << VIRTIO_SND_PCM_RATE_64000
+                    | 1 << VIRTIO_SND_PCM_RATE_88200
+                    | 1 << VIRTIO_SND_PCM_RATE_96000
+                    | 1 << VIRTIO_SND_PCM_RATE_176400
+                    | 1 << VIRTIO_SND_PCM_RATE_192000
+                    | 1 << VIRTIO_SND_PCM_RATE_384000;
+
+    params = virtio_snd_pcm_get_params(s, stream_id);
+    assert(params);
+
+    virtio_snd_get_qemu_audsettings(&as, params);
+
+    stream = g_new0(VirtIOSoundPCMStream, 1);
+
+    stream->id = stream_id;
+    stream->pcm = s->pcm;
+    stream->direction = stream_id < s->snd_conf.streams / 2 +
+        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+    stream->features = 0;
+    stream->channels_min = 1;
+    stream->channels_max = as.nchannels;
+    stream->formats = supported_formats;
+    stream->rates = supported_rates;
+    stream->s = s;
+
+    stream->buffer_bytes = params->buffer_bytes;
+    stream->period_bytes = params->period_bytes;
+
+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
+
+
+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = AUD_open_out(&s->card,
+                                         stream->voice.out,
+                                         "virtio_snd_card",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &as);
+
+    } else {
+        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+        /*
+         * stream->voice.in = AUD_open_in(&s->card,
+         *                                stream->voice.in,
+         *                                "virtio_snd_card",
+         *                                stream,
+         *                                virtio_snd_input_cb,
+         *                                &as);
+         */
+    }
+
+    stream->as = as;
+    stream->desired_as = stream->as;
+    qemu_mutex_init(&stream->queue_mutex);
+    QSIMPLEQ_INIT(&stream->queue);
+
+    s->pcm->streams[stream_id] = stream;
+
+    return VIRTIO_SND_S_OK;
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_PREPARE.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    size_t sz;
+
+    sz = iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num,
+                    sizeof(virtio_snd_hdr), &stream_id, sizeof(stream_id));
+    assert(sz == sizeof(uint32_t));
+
+    cmd->resp.code = virtio_snd_pcm_prepare_impl(s, stream_id);
+    return;
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_START.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ * @start: whether to start or stop the device
+ */
+static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd,
+                                             bool start)
+{
+    VirtIOSoundPCMStream *stream;
+    virtio_snd_pcm_hdr req;
+    size_t sz;
+
+    sz = iov_to_buf(cmd->elem->out_sg,
+                    cmd->elem->out_num,
+                    0,
+                    &req,
+                    sizeof(req));
+    assert(sz == sizeof(virtio_snd_pcm_hdr));
+
+    cmd->resp.code = VIRTIO_SND_S_OK;
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+            "VIRTIO_SND_R_PCM_STOP", req.stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, req.stream_id);
+
+    if (stream) {
+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+            AUD_set_active_out(stream->voice.out, start);
+        }
+    } else {
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+    }
+    return;
+}
+
+/*
+ * Returns the number of bytes that have not been passed to AUD_write yet.
+ *
+ * @stream: VirtIOSoundPCMStream
+ */
+static int virtio_snd_pcm_get_pending_bytes(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+    int size = 0;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            size += block->size;
+        }
+    }
+    return size;
+}
+
+/*
+ * Releases the buffer resources allocated to a stream. Seperated from the
+ * handler so that the code can be reused in the unrealize function. Returns
+ * the response status code. (VIRTIO_SND_S_*).
+ *
+ * @stream: VirtIOSoundPCMStream stream
+ * @stream_id: stream id
+ */
+static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
+                                            uint32_t stream_id)
+{
+    assert(stream->s->pcm->streams[stream_id] == stream);
+
+    if (virtio_snd_pcm_get_pending_bytes(stream)) {
+        /*
+         * virtio-v1.2-csd01, 5.14.6.6.5.1,
+         * Device Requirements: Stream Release
+         *
+         * - The device MUST complete all pending I/O messages for the
+         *   specified stream ID.
+         * - The device MUST NOT complete the control request while there
+         *   are pending I/O messages for the specified stream ID.
+         */
+        virtio_snd_process_cmdq(stream->s);
+        trace_virtio_snd_pcm_stream_flush(stream_id);
+        virtio_snd_pcm_flush(stream);
+    }
+
+    return VIRTIO_SND_S_OK;
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_RELEASE.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_release(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    size_t sz;
+    VirtIOSoundPCMStream *stream;
+
+    sz = iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num,
+            sizeof(virtio_snd_hdr), &stream_id, sizeof(stream_id));
+    assert(sz == sizeof(uint32_t));
+
+    trace_virtio_snd_handle_pcm_release(stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        error_report("already released stream %d", stream_id);
+        virtio_error(VIRTIO_DEVICE(s), "already released stream %d", stream_id);
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+    cmd->resp.code = virtio_snd_pcm_release_impl(stream, stream_id);
+    return;
+}
+
+/*
+ * The actual processing done in virtio_snd_process_cmdq().
+ *
+ * @s: VirtIOSound device
+ * @cmd: control command request
+ */
+static inline void
+process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
+{
+    VIRTIO_SND_FILL_CMD(cmd->ctrl);
+    size_t sz;
+
+    trace_virtio_snd_handle_code(cmd->ctrl.code,
+                                 print_code(cmd->ctrl.code));
+
+    switch (cmd->ctrl.code) {
+    case VIRTIO_SND_R_JACK_INFO:
+    case VIRTIO_SND_R_JACK_REMAP:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: jack functionality is unimplemented.");
+        break;
+    case VIRTIO_SND_R_PCM_INFO:
+        virtio_snd_handle_pcm_info(s, cmd);
+        break;
+    case VIRTIO_SND_R_PCM_SET_PARAMS:
+        virtio_snd_handle_pcm_set_params(s, cmd);
+        break;
+    case VIRTIO_SND_R_PCM_PREPARE:
+        virtio_snd_handle_pcm_prepare(s, cmd);
+        break;
+    case VIRTIO_SND_R_PCM_START:
+        virtio_snd_handle_pcm_start_stop(s, cmd, true);
+        break;
+    case VIRTIO_SND_R_PCM_STOP:
+        virtio_snd_handle_pcm_start_stop(s, cmd, false);
+        break;
+    case VIRTIO_SND_R_PCM_RELEASE:
+        virtio_snd_handle_pcm_release(s, cmd);
+        break;
+    case VIRTIO_SND_R_CHMAP_INFO:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: chmap info functionality is unimplemented.");
+        trace_virtio_snd_handle_chmap_info();
+        break;
+    default:
+        /* error */
+        error_report("virtio snd header not recognized: %d", cmd->ctrl.code);
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+    }
+
+    sz = iov_from_buf(cmd->elem->in_sg,
+                      cmd->elem->in_num,
+                      0,
+                      &cmd->resp,
+                      sizeof(cmd->resp));
+    assert(sz == sizeof(cmd->resp));
+    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
+    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
+    cmd->finished = true;
+}
+
+/*
+ * Consume all elements in command queue.
+ *
+ * @s: VirtIOSound device
+ */
+static void virtio_snd_process_cmdq(VirtIOSound *s)
+{
+    virtio_snd_ctrl_command *cmd;
+
+    if (unlikely(qatomic_read(&s->processing_cmdq))) {
+        return;
+    }
+
+    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
+        qatomic_set(&s->processing_cmdq, true);
+        while (!QTAILQ_EMPTY(&s->cmdq)) {
+            cmd = QTAILQ_FIRST(&s->cmdq);
+
+            /* process command */
+            process_cmd(s, cmd);
+
+            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+
+            assert(cmd->finished);
+            g_free(cmd);
+        }
+        qatomic_set(&s->processing_cmdq, false);
+    }
+}
+
+/*
+ * The control message handler. Pops an element from the control virtqueue,
+ * and stores them to VirtIOSound's cmdq queue and finally calls
+ * virtio_snd_process_cmdq() for processing.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: Control virtqueue
+ */
+static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtQueueElement *elem;
+    virtio_snd_ctrl_command *cmd;
+
+    trace_virtio_snd_handle_ctrl(vdev, vq);
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    while (elem) {
+        cmd = g_new0(virtio_snd_ctrl_command, 1);
+        cmd->elem = elem;
+        cmd->vq = vq;
+        cmd->finished = false;
+        cmd->resp.code = VIRTIO_SND_S_OK;
+        QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    }
+
+    virtio_snd_process_cmdq(s);
+}
+
+/*
+ * The event virtqueue handler.
+ * Not implemented yet.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: event vq
+ */
+static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
+{
+    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.");
+    trace_virtio_snd_handle_event();
+}
+
+/*
+ * The tx virtqueue handler. Makes the buffers available to their respective
+ * streams for consumption.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: tx virtqueue
+ */
+static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSoundPCMStream *stream = NULL;
+    VirtQueueElement *elem;
+    size_t sz;
+    virtio_snd_pcm_xfer hdr;
+    virtio_snd_pcm_status resp = { 0 };
+
+    trace_virtio_snd_handle_xfer();
+
+    for (;;) {
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        /* get the message hdr object */
+        sz = iov_to_buf(elem->out_sg,
+                        elem->out_num,
+                        0,
+                        &hdr,
+                        sizeof(hdr));
+        assert(sz == sizeof(hdr));
+        stream = s->pcm->streams[hdr.stream_id];
+        assert(stream);
+
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            virtio_snd_pcm_read_write(stream,
+                    vq,
+                    elem,
+                    hdr.stream_id == VIRTIO_SND_D_INPUT);
+
+            resp.status = VIRTIO_SND_S_OK;
+            sz = iov_from_buf(elem->in_sg,
+                    elem->in_num,
+                    0,
+                    &resp,
+                    sizeof(resp));
+            assert(sz == sizeof(virtio_snd_pcm_status));
+        }
+    }
+
+    /*
+     * Notify vq about virtio_snd_pcm_status responses.
+     * Buffer responses must be notified separately later.
+     */
+    virtio_notify(VIRTIO_DEVICE(s), vq);
+}
+
+static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
+                             Error **errp)
+{
+    /*
+     * virtio-v1.2-csd01, 5.14.3,
+     * Feature Bits
+     * None currently defined.
+     */
+    trace_virtio_snd_get_features(vdev, features);
+    return features | 1UL << VIRTIO_F_VERSION_1 | 1UL << VIRTIO_F_IN_ORDER;
+}
+
+static void virtio_snd_set_pcm(VirtIOSound *snd)
+{
+    VirtIOSoundPCM *pcm;
+
+    pcm = g_new0(VirtIOSoundPCM, 1);
+    pcm->snd = snd;
+
+    pcm->streams = g_new0(VirtIOSoundPCMStream *, snd->snd_conf.streams);
+    pcm->pcm_params = g_new0(VirtIOSoundPCMParams *, snd->snd_conf.streams);
+    pcm->jacks = g_new0(struct virtio_snd_jack *, snd->snd_conf.jacks);
+
+    snd->pcm = pcm;
+
+    return;
+}
+
+void virtio_snd_common_realize(DeviceState *dev,
+                               VirtIOHandleOutput ctrl,
+                               VirtIOHandleOutput evt,
+                               VirtIOHandleOutput txq,
+                               VirtIOHandleOutput rxq,
+                               Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+    virtio_snd_pcm_set_params default_params;
+    uint32_t status;
+
+    virtio_snd_set_pcm(vsnd);
+
+    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
+
+    /* set number of jacks and streams */
+    if (vsnd->snd_conf.jacks > 8) {
+        error_setg(errp,
+                   "Invalid number of jacks: %d",
+                   vsnd->snd_conf.jacks);
+        return;
+    }
+    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
+        error_setg(errp,
+                   "Invalid number of streams: %d",
+                    vsnd->snd_conf.streams);
+        return;
+    }
+
+    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
+        error_setg(errp,
+                   "Invalid number of channel maps: %d",
+                   vsnd->snd_conf.chmaps);
+        return;
+    }
+
+    AUD_register_card("virtio-sound", &vsnd->card);
+
+    /* set default params for all streams */
+    default_params.features = 0;
+    default_params.buffer_bytes = 8192;
+    default_params.period_bytes = 4096;
+    default_params.channels = 2;
+    default_params.format = VIRTIO_SND_PCM_FMT_S16;
+    default_params.rate = VIRTIO_SND_PCM_RATE_44100;
+
+    vsnd->queues[VIRTIO_SND_VQ_CONTROL] = virtio_add_queue(vdev, 64, ctrl);
+    vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
+    vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
+    vsnd->queues[VIRTIO_SND_VQ_RX] = virtio_add_queue(vdev, 64, rxq);
+    qemu_mutex_init(&vsnd->cmdq_mutex);
+    QTAILQ_INIT(&vsnd->cmdq);
+
+    for (int i = 0; i < vsnd->snd_conf.streams; i++) {
+        default_params.hdr.stream_id = i;
+        status = virtio_snd_pcm_set_params_impl(vsnd, &default_params);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't initalize stream params, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+        status = virtio_snd_pcm_prepare_impl(vsnd, i);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't prepare streams, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+    }
+}
+
+static void
+virtio_snd_vm_state_change(void *opaque, bool running, RunState state)
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
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+    Error *err = NULL;
+
+    vsnd->pcm = NULL;
+    vsnd->vmstate =
+        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
+
+    trace_virtio_snd_realize(vsnd);
+
+    virtio_snd_common_realize(dev,
+                              virtio_snd_handle_ctrl,
+                              virtio_snd_handle_event,
+                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_xfer,
+                              &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+}
+
+/*
+ * AUD_* output callback.
+ *
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be written with AUD_write()
+ */
+static void virtio_snd_pcm_out_cb(void *data, int available)
+{
+    VirtIOSoundPCMStream *stream = data;
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+    int size;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            for (;;) {
+                size = MIN(block->size, available);
+                size = AUD_write(stream->voice.out,
+                        block->data + block->offset,
+                        size);
+                block->size -= size;
+                block->offset += size;
+                if (!block->size) {
+                    virtqueue_push(block->vq,
+                            block->elem,
+                            sizeof(block->elem));
+                    virtio_notify(VIRTIO_DEVICE(stream->s),
+                            block->vq);
+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                    g_free(block);
+                    available -= size;
+                    break;
+                }
+
+                available -= size;
+                if (!available) {
+                    break;
+                }
+            }
+            if (!available) {
+                break;
+            }
+        }
+    }
+}
+
+/*
+ * Flush all buffer data from this stream's queue into the driver's virtual
+ * queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            AUD_write(stream->voice.out, block->data, block->size);
+            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
+            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
+            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
+        }
+    }
+}
+
+/*
+ * Close the sound card.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_process_cmdq(stream->s);
+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+        AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
+        stream->voice.out = NULL;
+    } else {
+        AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+        stream->voice.in = NULL;
+    }
+
+}
+
+static void virtio_snd_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+    VirtIOSoundPCMStream *stream;
+
+    qemu_del_vm_change_state_handler(vsnd->vmstate);
+    virtio_del_queue(vdev, 0);
+
+    trace_virtio_snd_unrealize(vsnd);
+
+    for (int i = VIRTIO_SND_D_OUTPUT; i <= VIRTIO_SND_D_INPUT; i++) {
+        stream = vsnd->pcm->streams[i];
+        virtio_snd_pcm_close(stream);
+        g_free(stream);
+    }
+
+    AUD_remove_card(&vsnd->card);
+    g_free(vsnd->pcm);
+    virtio_cleanup(vdev);
+}
+
+
+static uint32_t
+virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+                          VirtQueue *vq,
+                          VirtQueueElement *element,
+                          bool read)
+{
+    VirtIOSoundPCMBlock *fragment;
+    size_t size = iov_size(element->out_sg, element->out_num) -
+        sizeof(virtio_snd_pcm_xfer);
+    assert(size <= stream->period_bytes);
+
+    fragment = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
+    fragment->elem = element;
+    fragment->vq = vq;
+    fragment->size = size;
+    fragment->offset = 0;
+
+    iov_to_buf(element->out_sg, element->out_num,
+               sizeof(virtio_snd_pcm_xfer),
+               fragment->data,
+               size);
+
+    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
+
+    return fragment->size;
+}
+
+static void virtio_snd_reset(VirtIODevice *vdev)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    virtio_snd_ctrl_command *cmd;
+
+    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
+        while (!QTAILQ_EMPTY(&s->cmdq)) {
+            cmd = QTAILQ_FIRST(&s->cmdq);
+            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+            g_free(cmd);
+        }
+    }
+}
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
+static const TypeInfo virtio_snd_info = {
+    .name          = TYPE_VIRTIO_SND,
+    .parent        = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOSound),
+    .class_init    = virtio_snd_class_init,
+};
+
+static void virtio_snd_register(void)
+{
+    type_register_static(&virtio_snd_info);
+}
+
+type_init(virtio_snd_register);
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
new file mode 100644
index 0000000000..c19e71f40f
--- /dev/null
+++ b/include/hw/virtio/virtio-snd.h
@@ -0,0 +1,194 @@
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
+typedef struct VirtIOSound {
+    VirtIODevice parent_obj;
+    struct VirtQueue *queues[VIRTIO_SND_VQ_MAX];
+    struct VirtIOSoundPCM *pcm;
+    bool virtio_access_is_big_endian;
+    QEMUSoundCard card;
+    VMChangeStateEntry *vmstate;
+    char *audiodev;
+    struct virtio_snd_config snd_conf;
+    QemuMutex cmdq_mutex;
+    QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
+    bool processing_cmdq;
+} VirtIOSound;
+
+typedef struct virtio_snd_ctrl_command {
+    struct VirtQueueElement *elem;
+    struct VirtQueue *vq;
+    struct virtio_snd_hdr ctrl;
+    struct virtio_snd_hdr resp;
+    bool finished;
+    QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
+} virtio_snd_ctrl_command;
+
+#define VIRTIO_SND_FILL_CMD(out) do {                                   \
+        size_t s;                                                       \
+        s = iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num, 0,        \
+                       &out, sizeof(out));                              \
+        if (s != sizeof(out)) {                                         \
+            qemu_log_mask(LOG_GUEST_ERROR,                              \
+                          "%s: virtio-snd command size incorrect %zu vs \
+                          %zu\n", __func__, s, sizeof(out));            \
+            return;                                                     \
+        }                                                               \
+    } while (0)
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
+/* Stream params */
+typedef struct VirtIOSoundPCMParams {
+    uint32_t features;
+    uint32_t buffer_bytes;          /* size of hardware buffer in bytes */
+    uint32_t period_bytes;          /* size of hardware period in bytes */
+    uint8_t channels;
+    uint8_t format;
+    uint8_t rate;
+} VirtIOSoundPCMParams;
+
+#define VIRTIO_SND_PCM_MIN_CHANNELS     2
+
+typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
+typedef struct VirtIOSoundPCM VirtIOSoundPCM;
+
+struct VirtIOSoundPCMBlock {
+    QSIMPLEQ_ENTRY(VirtIOSoundPCMBlock) entry;
+    struct VirtQueueElement *elem;
+    struct VirtQueue *vq;
+    int size;
+    int offset;
+    uint8_t data[];
+};
+
+typedef struct VirtIOSoundPCMStream {
+    VirtIOSoundPCM *pcm;
+    struct virtio_snd_pcm_info info;
+    uint32_t id;
+    uint32_t buffer_bytes;
+    uint32_t period_bytes;
+    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
+    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
+    VirtIOSound *s;
+    uint32_t features; /* 1 << VIRTIO_SND_PCM_F_XXX */
+    uint64_t formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
+    uint64_t rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
+    uint8_t direction;
+    uint8_t channels_min;
+    uint8_t channels_max;
+    bool flushing;
+    struct audsettings as;
+    struct audsettings desired_as;
+    union {
+        SWVoiceIn *in;
+        SWVoiceOut *out;
+    } voice;
+    QemuMutex queue_mutex;
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBlock) queue;
+} VirtIOSoundPCMStream;
+
+struct VirtIOSoundPCM {
+    VirtIOSound *snd;
+    struct VirtIOSoundPCMParams **pcm_params;
+    VirtIOSoundPCMStream **streams;
+    struct virtio_snd_jack **jacks;
+};
+
+void virtio_snd_common_realize(DeviceState *dev,
+                               VirtIOHandleOutput ctrl,
+                               VirtIOHandleOutput evt,
+                               VirtIOHandleOutput txq,
+                               VirtIOHandleOutput rxq,
+                               Error **errp);
+
+static inline const char *print_code(int code)
+{
+  switch (code) {
+  case VIRTIO_SND_R_JACK_INFO:
+    return "VIRTIO_SND_R_JACK_INFO";
+  case VIRTIO_SND_R_JACK_REMAP:
+    return "VIRTIO_SND_R_JACK_REMAP";
+  case VIRTIO_SND_R_PCM_INFO:
+    return "VIRTIO_SND_R_PCM_INFO";
+  case VIRTIO_SND_R_PCM_SET_PARAMS:
+    return "VIRTIO_SND_R_PCM_SET_PARAMS";
+  case VIRTIO_SND_R_PCM_PREPARE:
+    return "VIRTIO_SND_R_PCM_PREPARE";
+  case VIRTIO_SND_R_PCM_RELEASE:
+    return "VIRTIO_SND_R_PCM_RELEASE";
+  case VIRTIO_SND_R_PCM_START:
+    return "VIRTIO_SND_R_PCM_START";
+  case VIRTIO_SND_R_PCM_STOP:
+    return "VIRTIO_SND_R_PCM_STOP";
+  case VIRTIO_SND_R_CHMAP_INFO:
+    return "VIRTIO_SND_R_CHMAP_INFO";
+  default:
+    return "invalid code";
+  }
+};
+#endif
-- 
2.39.2



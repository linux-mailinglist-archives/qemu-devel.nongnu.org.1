Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6A79E0E7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOE-0006UX-Gd; Wed, 13 Sep 2023 03:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOC-0006UG-Vu
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKO6-0001ls-EO
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso68632915e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590452; x=1695195252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kpdi7FDSHFZz0vhXkSETQZK1kF5uLCfh2FpGGjaKoU=;
 b=iPfwtwfn1Y3S8RP9Xx+vt73F1N/zTPGGcn7vnOxIGKxc9uClPnlXaH6gyY4mYI4+fO
 +NDqEl2d/cLIyP3+mN8p1FZrzV17aQ/IRWuQYBi/SZ4S4LxhLDnFDbZFuju9z3qKd08X
 AClRtO57i6Qt1tBLgz7P6rwRqOYZiIQu3m2V9or1x0XfXk6HqGR9Of4WMG6FaRrpTgTa
 d3YtYpbysHUYGRpgbLM4Zl9aOLRqBq/AwVApqyg0XsgYnOgivu/Oz9UQ5H+g5OSFkAvy
 DXhGtX7YQ/FoZ4zF4f9gIDLlJl/lDMcvJtr0CqMMHns9JOLPYVUoC0lSQ5/7cWtrKa2K
 UE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590452; x=1695195252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kpdi7FDSHFZz0vhXkSETQZK1kF5uLCfh2FpGGjaKoU=;
 b=Xfb2ofit+rhJ/6nYVig6QXYMAYmhMFO9vY8Oj1eBe55LOW6ciUgnFYrEw9RFzju+dX
 P2U/9+WVKiYg1WvUHXoteqnGY9deDUWpqkqGEznSvVv9TIa4fHT3U626aV/dd1ZPrhAV
 lo6ycujBithoZPKcuFtRF7lC1mqz22bjCOM9gwOxgy+Nnc0idOtVica+6EIqPWIsLCYV
 mT+GczgnaRrdqXaTxfiDGbjqPHwscpCC3lHeZ3wOzQGi/4P/KCdgi0YRCfHDvdU0HF+b
 IP3shoKpnHc2fIG5uByZpPZPD5fddvnWQf9kgvcZnQxPRoa7GhgOA1slaZHeUxKdpfi0
 ePnQ==
X-Gm-Message-State: AOJu0YwPIVAwg9lFcw/M1heRaHpzZCj3XW2hR/dZoLe1hGecpfZpfgXs
 iiSsIq0LsK0/zaOnu0nEu+kqR0hckCaV79hdCpc=
X-Google-Smtp-Source: AGHT+IFzZefUwGfhC1T1fLGlQjhgbCn2P+axkzl3fqje69/zlxA0+K5NQ0cy7f+93HdPZZMdwIrDag==
X-Received: by 2002:a05:600c:ac5:b0:3fe:d6bf:f314 with SMTP id
 c5-20020a05600c0ac500b003fed6bff314mr1217987wmr.39.1694590452533; 
 Wed, 13 Sep 2023 00:34:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:12 -0700 (PDT)
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
Subject: [PATCH v9 03/12] virtio-sound: handle control messages and streams
Date: Wed, 13 Sep 2023 10:33:10 +0300
Message-Id: <8e07c6dcae0d5272d917f3960f44a3a86593d19e.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Receive guest requests in the control (CTRL) queue of the virtio sound
device and reply with a NOT SUPPORTED error to all control commands.

The receiving handler is virtio_snd_handle_ctrl(). It stores all control
messages in the queue in the device's command queue. Then it calls
virtio_snd_process_cmdq() to handle each message.

The handler is process_cmd() which replies with VIRTIO_SND_S_NOT_SUPP.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events         |   4 +
 hw/virtio/virtio-snd.c         | 229 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-snd.h | 107 ++++++++++++++-
 3 files changed, 331 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3ed7da35f2..8a223e36e9 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -163,3 +163,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
+virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
+virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index a8204e8a02..cb5573935d 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -90,13 +90,181 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
 }
 
+static void
+virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
+{
+    g_free(cmd->elem);
+    g_free(cmd);
+}
+
+static const char *print_code(uint32_t code)
+{
+    #define CASE(CODE)            \
+    case VIRTIO_SND_R_##CODE:     \
+        return "VIRTIO_SND_R_"#CODE
+
+    switch (code) {
+    CASE(JACK_INFO);
+    CASE(JACK_REMAP);
+    CASE(PCM_INFO);
+    CASE(PCM_SET_PARAMS);
+    CASE(PCM_PREPARE);
+    CASE(PCM_RELEASE);
+    CASE(PCM_START);
+    CASE(PCM_STOP);
+    CASE(CHMAP_INFO);
+    default:
+        return "invalid code";
+    }
+
+    #undef CASE
+};
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
+    uint32_t code;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &cmd->ctrl,
+                               sizeof(cmd->ctrl));
+
+    if (msg_sz != sizeof(cmd->ctrl)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(cmd->ctrl));
+        return;
+    }
+
+    code = le32_to_cpu(cmd->ctrl.code);
+
+    trace_virtio_snd_handle_code(code, print_code(code));
+
+    switch (code) {
+    case VIRTIO_SND_R_JACK_INFO:
+    case VIRTIO_SND_R_JACK_REMAP:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: jack functionality is unimplemented.\n");
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        break;
+    case VIRTIO_SND_R_PCM_INFO:
+    case VIRTIO_SND_R_PCM_SET_PARAMS:
+    case VIRTIO_SND_R_PCM_PREPARE:
+    case VIRTIO_SND_R_PCM_START:
+    case VIRTIO_SND_R_PCM_STOP:
+    case VIRTIO_SND_R_PCM_RELEASE:
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        break;
+    case VIRTIO_SND_R_CHMAP_INFO:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: chmap info functionality is unimplemented.\n");
+        trace_virtio_snd_handle_chmap_info();
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        break;
+    default:
+        /* error */
+        error_report("virtio snd header not recognized: %"PRIu32, code);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    iov_from_buf(cmd->elem->in_sg,
+                 cmd->elem->in_num,
+                 0,
+                 &cmd->resp,
+                 sizeof(cmd->resp));
+    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
+    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
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
+            virtio_snd_ctrl_cmd_free(cmd);
+        }
+        qatomic_set(&s->processing_cmdq, false);
+    }
+}
+
 /*
- * Queue handler stub.
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
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
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
+    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.\n");
+    trace_virtio_snd_handle_event();
+}
+
+/*
+ * Stub buffer virtqueue handler.
  *
  * @vdev: VirtIOSound device
  * @vq: virtqueue
  */
-static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -131,11 +299,17 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
 
+    vsnd->pcm = NULL;
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
     trace_virtio_snd_realize(vsnd);
 
+    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
+    vsnd->pcm->snd = vsnd;
+    vsnd->pcm->streams = g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
+    vsnd->pcm->pcm_params = g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
+
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
 
@@ -163,24 +337,53 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     AUD_register_card("virtio-sound", &vsnd->card);
 
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+    qemu_mutex_init(&vsnd->cmdq_mutex);
+    QTAILQ_INIT(&vsnd->cmdq);
+}
+
+/*
+ * Close the stream and free its resources.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
+{
 }
 
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSound *vsnd = VIRTIO_SND(dev);
+    VirtIOSoundPCMStream *stream;
 
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
+    if (vsnd->pcm) {
+        if (vsnd->pcm->streams) {
+            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+                stream = vsnd->pcm->streams[i];
+                if (stream) {
+                    virtio_snd_process_cmdq(stream->s);
+                    virtio_snd_pcm_close(stream);
+                    g_free(stream);
+                }
+            }
+            g_free(vsnd->pcm->streams);
+        }
+        g_free(vsnd->pcm->pcm_params);
+        g_free(vsnd->pcm);
+        vsnd->pcm = NULL;
+    }
     AUD_remove_card(&vsnd->card);
+    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
@@ -189,7 +392,19 @@ static void virtio_snd_unrealize(DeviceState *dev)
 }
 
 
-static void virtio_snd_reset(VirtIODevice *vdev) {}
+static void virtio_snd_reset(VirtIODevice *vdev)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    virtio_snd_ctrl_command *cmd;
+
+    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
+        while (!QTAILQ_EMPTY(&s->cmdq)) {
+            cmd = QTAILQ_FIRST(&s->cmdq);
+            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+            virtio_snd_ctrl_cmd_free(cmd);
+        }
+    }
+}
 
 static void virtio_snd_class_init(ObjectClass *klass, void *data)
 {
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
index 934e854a80..6642abb4e9 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
@@ -67,13 +67,116 @@ typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
 /* I/O request status */
 typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
 
-typedef struct VirtIOSound {
+/* device structs */
+
+typedef struct VirtIOSound VirtIOSound;
+
+typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
+
+typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
+
+typedef struct VirtIOSoundPCM VirtIOSoundPCM;
+
+struct VirtIOSoundPCM {
+    VirtIOSound *snd;
+    virtio_snd_pcm_set_params *pcm_params;
+    VirtIOSoundPCMStream **streams;
+};
+
+/*
+ * PCM stream state machine.
+ * -------------------------
+ *
+ * 5.14.6.6.1 PCM Command Lifecycle
+ * ================================
+ *
+ * A PCM stream has the following command lifecycle:
+ * - `SET PARAMETERS`
+ *   The driver negotiates the stream parameters (format, transport, etc) with
+ *   the device.
+ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
+ * - `PREPARE`
+ *   The device prepares the stream (allocates resources, etc).
+ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`, `START`,
+ *   `RELEASE`. Output only: the driver transfers data for pre-buffing.
+ * - `START`
+ *   The device starts the stream (unmute, putting into running state, etc).
+ *   Possible valid transitions: `STOP`.
+ *   The driver transfers data to/from the stream.
+ * - `STOP`
+ *   The device stops the stream (mute, putting into non-running state, etc).
+ *   Possible valid transitions: `START`, `RELEASE`.
+ * - `RELEASE`
+ *   The device releases the stream (frees resources, etc).
+ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
+ *
+ * +---------------+ +---------+ +---------+ +-------+ +-------+
+ * | SetParameters | | Prepare | | Release | | Start | | Stop  |
+ * +---------------+ +---------+ +---------+ +-------+ +-------+
+ *         |-             |           |          |         |
+ *         ||             |           |          |         |
+ *         |<             |           |          |         |
+ *         |------------->|           |          |         |
+ *         |<-------------|           |          |         |
+ *         |              |-          |          |         |
+ *         |              ||          |          |         |
+ *         |              |<          |          |         |
+ *         |              |--------------------->|         |
+ *         |              |---------->|          |         |
+ *         |              |           |          |-------->|
+ *         |              |           |          |<--------|
+ *         |              |           |<-------------------|
+ *         |<-------------------------|          |         |
+ *         |              |<----------|          |         |
+ *
+ * CTRL in the VirtIOSound device
+ * ==============================
+ *
+ * The control messages that affect the state of a stream arrive in the
+ * `virtio_snd_handle_ctrl()` queue callback and are of type `struct
+ * virtio_snd_ctrl_command`. They are stored in a queue field in the device
+ * type, `VirtIOSound`. This allows deferring the CTRL request completion if
+ * it's not immediately possible due to locking/state reasons.
+ *
+ * The CTRL message is finally handled in `process_cmd()`.
+ */
+struct VirtIOSoundPCMStream {
+    VirtIOSoundPCM *pcm;
+    virtio_snd_pcm_info info;
+    virtio_snd_pcm_set_params params;
+    uint32_t id;
+    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
+    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
+    VirtIOSound *s;
+    bool flushing;
+    audsettings as;
+    union {
+        SWVoiceIn *in;
+        SWVoiceOut *out;
+    } voice;
+    QemuMutex queue_mutex;
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBlock) queue;
+};
+
+struct VirtIOSound {
     VirtIODevice parent_obj;
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
+    VirtIOSoundPCM *pcm;
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-} VirtIOSound;
+    QemuMutex cmdq_mutex;
+    QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
+    bool processing_cmdq;
+};
+
+struct virtio_snd_ctrl_command {
+    VirtQueueElement *elem;
+    VirtQueue *vq;
+    virtio_snd_hdr ctrl;
+    virtio_snd_hdr resp;
+    QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
+};
 #endif
-- 
2.39.2



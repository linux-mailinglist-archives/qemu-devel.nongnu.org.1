Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF3767E80
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLa-0007xa-M5; Sat, 29 Jul 2023 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLY-0007us-OY
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:38:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLW-00013y-NE
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:38:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3172144c084so3064689f8f.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627129; x=1691231929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIplqeqnlPnNjqYb3o46pvPaOA2xEJui0krDQluV7OM=;
 b=UdFBCGY4pUnzmaVOr7rGGY+n1hITXNrBDpY/6DmpMwCCLRYAiYNASTKVlz+kNOFJ//
 dOvaVDOmiMkealwcK2tGYVTkA8L1LVsloRmu/9ad4k7MZ5KXt8MeiTkeiFKBLKqKDiL4
 vKtrrF2gzIy+suYejKCv0QKbK9+Am/uqsw4TITl2RrJDLK50U5RYBw/HTXOr3SdEdOM1
 JJ1xtA1MIsA5alHcQioNALpt6BtalJRzSx7vMl/uheNb/7u0LrSPBJHkGRoEC9/HmuQ9
 rg3D8LQhyRV35iiwCijIGkbNCwkpsy7YzI+i29pJZWyWDPhXLxFs3nbsoMNNp+lhvMI6
 KfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627129; x=1691231929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIplqeqnlPnNjqYb3o46pvPaOA2xEJui0krDQluV7OM=;
 b=NNhki+qbkhcs52mf0DmOXvB1/yszGua3ncgk9f0M6ob3bROHvEpAXEUVU8/gIh4JY3
 NLdfYnSXI6vUDXj+7czi834cc+UOfN+y06BoLPSyirtND2QpmXMpol3vyDd0mSwNKHya
 Ht+ll2HJrCKkCIE/Clu2GJ9MTl/BS2SqmiHC+5aAOa2xWH2G7XeWH/La3Q9SG52rv+3c
 LtFpryGvqow+R1W+2T/o68ogwVdlIrCMpazPae+lnQ9BWxXOqp6iwwH7lMLbNFLdtvSA
 Td1ngxfzQDusBwf/9yzgO0gYsU/vp1RMj943cd0PJncdWrYKSedlxWEAhQF95pAcJhef
 SB/A==
X-Gm-Message-State: ABy/qLaQ7aXyzcFv3hRhdEelsfzkZ0R4AK8bVptGWNlxnGvhQba+ka23
 isvWPgJtqUytIEXMtbofo8yDluRTH9NGkMjR55VhVA==
X-Google-Smtp-Source: APBJJlF8Pgzchv2K/7JFm65iIu5qbJtRG0S5GXV6IbWbBjkB9EZqd0ZisR3eXiBkF34lvLCfnvCjrQ==
X-Received: by 2002:a5d:574d:0:b0:314:748:d59d with SMTP id
 q13-20020a5d574d000000b003140748d59dmr3981157wrw.27.1690627129140; 
 Sat, 29 Jul 2023 03:38:49 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:38:48 -0700 (PDT)
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
 "Alex Bennee" <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 03/12] virtio-sound: handle control messages and streams
Date: Sat, 29 Jul 2023 13:36:55 +0300
Message-Id: <e6a3624f899752b796d666611f05fcb5ee771849.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Receive guest requests in the control (CTRL) queue of the virtio sound
device and reply with a NOT SUPPORTED error to all control commands.

The receiving handler is virtio_snd_handle_ctrl(). It stores all control
messages in the queue in the device's command queue. Then it calls
virtio_snd_process_cmdq() to handle each message.

The handler is process_cmd() which replies with VIRTIO_SND_S_NOT_SUPP.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events         |   4 +
 hw/virtio/virtio-snd.c         | 221 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-snd.h |  71 ++++++++++-
 3 files changed, 287 insertions(+), 9 deletions(-)

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
index f301054541..c49c17ea76 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -30,6 +30,29 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
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
 static const VMStateDescription vmstate_virtio_snd_device = {
     .name = TYPE_VIRTIO_SND,
     .version_id = VIRTIO_SOUND_VM_VERSION,
@@ -89,12 +112,148 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
 }
 
 /*
- * Queue handler stub.
+ * The actual processing done in virtio_snd_process_cmdq().
+ *
+ * @s: VirtIOSound device
+ * @cmd: control command request
+ */
+static inline void
+process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
+{
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           0,
+                           &cmd->ctrl,
+                           sizeof(cmd->ctrl));
+    if (sz != sizeof(cmd->ctrl)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, sz, sizeof(cmd->ctrl));
+        return;
+    }
+
+    trace_virtio_snd_handle_code(cmd->ctrl.code,
+                                 print_code(cmd->ctrl.code));
+
+    switch (cmd->ctrl.code) {
+    case VIRTIO_SND_R_JACK_INFO:
+    case VIRTIO_SND_R_JACK_REMAP:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: jack functionality is unimplemented.");
+        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
+        break;
+    case VIRTIO_SND_R_PCM_INFO:
+    case VIRTIO_SND_R_PCM_SET_PARAMS:
+    case VIRTIO_SND_R_PCM_PREPARE:
+    case VIRTIO_SND_R_PCM_START:
+    case VIRTIO_SND_R_PCM_STOP:
+    case VIRTIO_SND_R_PCM_RELEASE:
+        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
+        break;
+    case VIRTIO_SND_R_CHMAP_INFO:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: chmap info functionality is unimplemented.");
+        trace_virtio_snd_handle_chmap_info();
+        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
+        break;
+    default:
+        /* error */
+        error_report("virtio snd header not recognized: %"PRIu32,
+                     cmd->ctrl.code);
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
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
+ * Stub buffer virtqueue handler.
  *
  * @vdev: VirtIOSound device
  * @vq: virtqueue
  */
-static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -112,6 +271,20 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
     return features;
 }
 
+static void virtio_snd_set_pcm(VirtIOSound *snd)
+{
+    VirtIOSoundPCM *pcm;
+
+    pcm = g_new0(VirtIOSoundPCM, 1);
+    pcm->snd = snd;
+
+    pcm->streams = g_new0(VirtIOSoundPCMStream *, snd->snd_conf.streams);
+    pcm->pcm_params = g_new0(VirtIOSoundPCMParams *, snd->snd_conf.streams);
+    pcm->jacks = g_new0(virtio_snd_jack *, snd->snd_conf.jacks);
+
+    snd->pcm = pcm;
+}
+
 static void virtio_snd_common_realize(DeviceState *dev,
                                       VirtIOHandleOutput ctrl,
                                       VirtIOHandleOutput evt,
@@ -122,6 +295,8 @@ static void virtio_snd_common_realize(DeviceState *dev,
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSound *vsnd = VIRTIO_SND(dev);
 
+    virtio_snd_set_pcm(vsnd);
+
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
 
@@ -152,6 +327,8 @@ static void virtio_snd_common_realize(DeviceState *dev,
     vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
     vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
     vsnd->queues[VIRTIO_SND_VQ_RX] = virtio_add_queue(vdev, 64, rxq);
+    qemu_mutex_init(&vsnd->cmdq_mutex);
+    QTAILQ_INIT(&vsnd->cmdq);
 }
 
 static void
@@ -169,35 +346,65 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
 
+    vsnd->pcm = NULL;
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
     trace_virtio_snd_realize(vsnd);
 
     virtio_snd_common_realize(dev,
-                              virtio_snd_handle_queue,
-                              virtio_snd_handle_queue,
-                              virtio_snd_handle_queue,
-                              virtio_snd_handle_queue,
+                              virtio_snd_handle_ctrl,
+                              virtio_snd_handle_event,
+                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_xfer,
                               errp);
 }
 
+/*
+ * Close the sound card.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_process_cmdq(stream->s);
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSound *vsnd = VIRTIO_SND(dev);
+    VirtIOSoundPCMStream *stream;
 
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     virtio_del_queue(vdev, 0);
 
     trace_virtio_snd_unrealize(vsnd);
 
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        stream = vsnd->pcm->streams[i];
+        virtio_snd_pcm_close(stream);
+        g_free(stream);
+    }
     AUD_remove_card(&vsnd->card);
+    g_free(vsnd->pcm);
     virtio_cleanup(vdev);
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
+            g_free(cmd);
+        }
+    }
+}
 
 static void virtio_snd_class_init(ObjectClass *klass, void *data)
 {
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
index 0a7d8b0f77..7cc5061fa8 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
@@ -69,12 +69,79 @@ typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
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
+typedef struct VirtIOSoundPCMParams VirtIOSoundPCMParams;
+
+typedef struct VirtIOSoundPCM VirtIOSoundPCM;
+
+/* Stream params */
+struct VirtIOSoundPCMParams {
+    uint32_t features;
+    uint32_t buffer_bytes;          /* size of hardware buffer in bytes */
+    uint32_t period_bytes;          /* size of hardware period in bytes */
+    uint8_t channels;
+    uint8_t format;
+    uint8_t rate;
+};
+
+struct VirtIOSoundPCM {
+    VirtIOSound *snd;
+    VirtIOSoundPCMParams **pcm_params;
+    VirtIOSoundPCMStream **streams;
+    virtio_snd_jack **jacks;
+};
+
+struct VirtIOSoundPCMStream {
+    VirtIOSoundPCM *pcm;
+    virtio_snd_pcm_info info;
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
+    audsettings as;
+    audsettings desired_as;
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550578B8C0
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLR-0002ko-JE; Mon, 28 Aug 2023 15:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiL9-0002gV-N9
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiL6-0005H5-DD
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401d2e11dacso1936695e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252555; x=1693857355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjLJjlPGOeRZ8nGUMia7MUG/UtpiQe332FzSZqe0PjE=;
 b=oUvMKUqEf+tcSTT5nXOuj+z+hmcU9HcdlEKvOk5Js2SxBKEPKix5oNS8LvxL6Ujw/u
 XAHqf6AyLcmsTy4FU8aL/+11+Lhpxu/xEjUyw6dpPQOGi8dq0Zfiz9S5c9BAjKoLSNnK
 N4Fqn7tZQyy+QszKOZFT0mjELECnFc/N/BSObgtx5JoXqFKlgDUvosgUaBGQBVfkowIk
 Y6U05cF7E43UmW2USTgwd8+p1uIX387iT36lZRvNOKfv5BLvfRq97G8is7SwW85dgnR1
 sgu7uZIn7toctI5NaKFhyIku7yiZrSrB616/Ide0QRMSjJHSXwY1duTWqY63BxOvyO7N
 x/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252555; x=1693857355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjLJjlPGOeRZ8nGUMia7MUG/UtpiQe332FzSZqe0PjE=;
 b=bvILduv39BhZkHOU4AZ2+9okXyv2u5ioF5Bu+io49w8awj+989C/mWAgu5ZsBaCKG8
 KOlU9S09ZiEOfdfC5qg+RjRUg3eqSbqJPcKAs6v2nMZlpcR3pYiCdNt2WJhh5Q2NOJ56
 x645+A49jKiaKepsPersrT0zex85L9U6L4YBp5/tmjG01tOkP2oMZf+EqoeeltHZGWlE
 3AvrFgx+FiZHR27vjfg6FsZY4s47rxGPFIrrYp9kreKlpndwe5awgdgUO9rZvtvcmtXF
 cejDHNMG8/M4JdzFVheTzQxfnKjC+my/OHgXfw1fv23D5301mqw5hb8XXfJUOKsgaPIJ
 0YHQ==
X-Gm-Message-State: AOJu0YwjLXHuAPxvd4x8fLzs8AkK0G7ilz6X2/x0mRrg9qDebN5K4dOA
 SSz4FpCDYzJfbF+y9c3DOMnRxyjhnrLkjSAgaQM=
X-Google-Smtp-Source: AGHT+IH5cbwCsRGIvBXtvKusWMclevHL22jAgMW82bH4G/YspA+97bI+IjG8EsFHolPVoQ1ZYHBlQw==
X-Received: by 2002:adf:ea01:0:b0:31a:e3df:f719 with SMTP id
 q1-20020adfea01000000b0031ae3dff719mr390527wrm.17.1693252554770; 
 Mon, 28 Aug 2023 12:55:54 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:55:54 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 05/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Mon, 28 Aug 2023 22:55:02 +0300
Message-Id: <974d88412dd4ee18ae35efdbec657fa558c13fbf.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
of each requested PCM stream.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8a223e36e9..3e619f778b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 25c3539509..ab82c786f2 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -134,6 +134,19 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
 }
 
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
+    return stream_id >= s->snd_conf.streams ? NULL : s->pcm->streams[stream_id];
+}
+
 /*
  * Get params for a specific stream.
  *
@@ -147,6 +160,67 @@ static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
         : &s->pcm->pcm_params[stream_id];
 }
 
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
+    VirtIOSoundPCMStream *stream = NULL;
+    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           0,
+                           &req,
+                           sizeof(req));
+    if (sz != sizeof(virtio_snd_query_info)) {
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+        sizeof(virtio_snd_hdr) + req.size * req.count) {
+        error_report("pcm info: buffer too small, got: %zu, needed: %zu",
+                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
+                sizeof(virtio_snd_pcm_info));
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    pcm_info = g_new0(virtio_snd_pcm_info, req.count);
+    for (uint32_t i = req.start_id; i < req.start_id + req.count; i++) {
+        trace_virtio_snd_handle_pcm_info(i);
+        stream = virtio_snd_pcm_get_stream(s, i);
+
+        if (!stream) {
+            error_report("Invalid stream id: %"PRIu32, i);
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
+    }
+
+    cmd->resp.code = VIRTIO_SND_S_OK;
+
+    iov_from_buf(cmd->elem->in_sg,
+                 cmd->elem->in_num,
+                 sizeof(virtio_snd_hdr),
+                 pcm_info,
+                 sizeof(virtio_snd_pcm_info) * req.count);
+}
+
 /*
  * Set the given stream params.
  * Called by both virtio_snd_handle_pcm_set_params and during device
@@ -366,6 +440,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
         break;
     case VIRTIO_SND_R_PCM_INFO:
+        virtio_snd_handle_pcm_info(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_START:
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B56767E7D
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLo-0000GB-7z; Sat, 29 Jul 2023 06:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLl-00005p-Q8
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLk-000179-82
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso32834685e9.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627142; x=1691231942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wk0psUlwpn5O2EJ9JAYIFQ5jJ/30Ny4RuRauf3NTG8A=;
 b=lIQVdSsFcz6dbBcColSJR2tvESG6y+1PaBGxFtk1Uo5z7sg7KaWoS1nJC2FFgX0Dgc
 9ofzzekBUlCmyMf08sfcTS+pWHob/LU6n1kDivGIsRPHtwwt9ulyvniF7YMFrP1Og6tD
 xmbgNJydqqzP3+oHS+kwniXOGnVflK1hKtOwgxFmme6E6It3v+aw61AQoeSkyiBTfU1k
 NCPUazo2rCsh5JRsmObGDSbQPZFl4y5fBAeHgrglg5l8TW6ootn46gdIXODS6h7eVbON
 8j/AjAnDWfTlZlIBBGfDcpxB7/ecF3K3h/qJyKspo9fEw/wxg6h4K6pWw7IA6QKk8NNo
 EfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627142; x=1691231942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wk0psUlwpn5O2EJ9JAYIFQ5jJ/30Ny4RuRauf3NTG8A=;
 b=kTWrm7vOcVTsupzvWt9rqP7OPWyLE9AsbTpL139uImPIrOUT/W+tU5vwjoKXEbDMhh
 OcpK+ODX3EVOHRtyVZMOBc1FB1IbIjAO5zE9ZSyK4mrBy5YBWPkt/mWpS9CTUC8BqJ4g
 BkUhEetEvicf3weISPjph8u6lvHtAY23lxA8CzuZAcNLC/PbfQEitf8gpm+tVxE+TrC/
 HbL/oRHKtFoxG69blBSNUkwJiB6m9bPwnDrwYx/K+szKpAKYIfKVewZ+uoCulAH4XhZz
 ILNxTg96AL58Bb68pTEDyFFFgMDT2pFKQIQEFoppGaD8MbdP6HsfrcHEIkspiOA6l+vk
 OZmQ==
X-Gm-Message-State: ABy/qLabWaCq3oIGtxP08CsvmZpRz/8qAb76n4i65z0GMzMQ4raACFgO
 EizOaDOGcgXFk3HhTBXzNSsWTaDukK4IDXl8uCaoGw==
X-Google-Smtp-Source: APBJJlE6gyOb6O2PmwEGfVQJLmIuPrHKVvOgFKm5AiNdHroHb+18wwfidgJhgrm1+11uMCSZlhKTvw==
X-Received: by 2002:a05:600c:3657:b0:3fd:e86b:f098 with SMTP id
 y23-20020a05600c365700b003fde86bf098mr4134852wmq.4.1690627142603; 
 Sat, 29 Jul 2023 03:39:02 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:39:02 -0700 (PDT)
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
Subject: [PATCH v5 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Sat, 29 Jul 2023 13:36:58 +0300
Message-Id: <78777fb46fa86180fa0654bb82c8ff976635cd86.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
of each requested PCM stream.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

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
index 4d69f2003a..eccb156e44 100644
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
@@ -147,6 +160,69 @@ static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
         : s->pcm->pcm_params[stream_id];
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
+
+        memset(&pcm_info[i].padding, 0, sizeof(pcm_info[i].padding));
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
@@ -358,6 +434,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



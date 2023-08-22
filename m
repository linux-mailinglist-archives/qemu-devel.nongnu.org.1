Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7AD784A38
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuT-00053j-8M; Tue, 22 Aug 2023 15:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuR-00050K-Jx
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuO-0000pj-GN
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso48508285e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731959; x=1693336759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05E3qWCxOLnolBhqx1j7qIfk/Zw58cg/mH4nyqdMMsg=;
 b=M+N1U5fyTkkOwfXvCXwdmiHxTM0Bllww85DmOhQWF8SV9mQCj4oNsUGIUDF33QNaKc
 EqycBV6aOm99e2T2dYgQIAndNgRQGLKyk0NBdaDcsLNTlGtZAsIqLpr5B603kRtCZ+cw
 U9GUirxmVihMOFznQxiHXJCaJTQx6hViit/gRuTzAheVaeLH8OC2WsrLRFG3ukDD0X52
 JESLtsSxotVy7hnnKRtSpYQtBCn9R4F61qulM1Me8giC1dGehlYOLe5Yd951X7v0IqwF
 wZTSsIyoVbThcwsqQCrf7EVnxPySx87bb8DvNIJ55x6SGk/KlkZIbWwURznEfE6U1xwl
 /lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731959; x=1693336759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05E3qWCxOLnolBhqx1j7qIfk/Zw58cg/mH4nyqdMMsg=;
 b=i0e1UwZgVX41pveq02annS1tIsw9/OFGtYQpcMf4L50o868duj6T07xWP09l4ifEFR
 xLMM1j4KSOVO8nhaVX5xp46sypxrBqKAIbNWgSf8O9fpwVCR0w5px+o/puz8I4UW/vVo
 LvOt+wR8WIqD1jhjGbq3eHTg/4mDEHCsN/z6pqkHSBJ25wYcwQlLZWIeRuhhsasUX5kN
 sqGkWVZY4fTucMZpgmk9lmd5ScqEqVgpql17s4pi6OXIjG3iVnuSOYCFjadMxV6s32Cq
 H+ExkWEh19HtvJ96xgBc5Y7vfsuJ8yKvyiBy4mtdcNOPeKpLh6PR6rnfN4rPGy4UKPcV
 s8BQ==
X-Gm-Message-State: AOJu0Yx6cE0LpczYimoGMWYhsppctbLnplabKiyDGKAju7TJ09zOpAWv
 s8Bn3/ymn3k3G1+x/9YQ1cc4A+bQvAfc59jVfdU=
X-Google-Smtp-Source: AGHT+IE16/ER1C2hpXHg3psEB35JeqgX3R/hKzSAo4MvsgMe8sW9l9j+6rK27czHzTjy+7wOMaOnVA==
X-Received: by 2002:a5d:4683:0:b0:318:f7a:e3cb with SMTP id
 u3-20020a5d4683000000b003180f7ae3cbmr8489205wrq.31.1692731958950; 
 Tue, 22 Aug 2023 12:19:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:18 -0700 (PDT)
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
Subject: [PATCH v7 05/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Tue, 22 Aug 2023 22:18:28 +0300
Message-Id: <0f433debd3f5b28d2fb30d88a6a5a07c65875de5.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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
index dec76ffcb1..59b648b509 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -133,6 +133,19 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
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
@@ -146,6 +159,67 @@ static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
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
@@ -365,6 +439,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



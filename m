Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA317D361F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutfh-0005Hd-GJ; Mon, 23 Oct 2023 08:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfe-0005HO-1V
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfP-0001y2-P0
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so26908425e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062657; x=1698667457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmZOtgdkPmiV8HTMnM0nPx4fSedl9ZSXpPdeym2pt+I=;
 b=L1rNDN+GBR/ucA/g6snga0uIGLAIIt1syemOqE2U6jmceQgt+0UM5Hl6RhyQtht5cD
 EJi0SF2pAwoRPNv+YR+S/aoL2eaY2dCYFhclCRfRDDZHtjhTIFYnhp/1k+Z8r40yJB+L
 R/2ThHZ7CE17p2acKCWaxjDTC4m3zFVJBflXE+ceHmXeUQ1pDoP+yOM+N1ZPNlFVPdOh
 vwlEIDmU4NUuRva45bvhpAh6rocvJKhQHg+yU7tsm4fsUxUmp36YdC6fcR8za+I0zpfr
 VUQ9HkKl/5ErIz7KmaFHeCG6xWibKNz4lavLEXx3gk2v6qHbOEPAfgmGHIRPCBtF0yXU
 gJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062657; x=1698667457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LmZOtgdkPmiV8HTMnM0nPx4fSedl9ZSXpPdeym2pt+I=;
 b=F08G1JMV0yfIevFlqNF0ZzyZUbz+Th7N2DPLIFM/th4xhhnX2QHTm1PcsOB5+PHrZ8
 fWS93D2+sRO1REvJv4ugiP6B8Cvsz+d9FexDBMVlvyTB9bCb0sNXbbeGxgnf8jbHPBkm
 vw2fUg0UxChXxg5wO8qDKmXUEr4rBTin5yB+JWd6S58f9mmaYgPfzPejUehIJs0QxEYa
 jHcjX1oW941XVl9wFsv/wiq35ugT7G3yJ/qepqg5T0CofxwJLxA6SzyA8FpOKPzFbbsK
 MZUjfk0phIZcC54qgdKEHF4XHzC2MEj1/IYuMHrXS27rMi86RsaLaXGLhtF5I9xBgyoC
 Yy4Q==
X-Gm-Message-State: AOJu0YzCAEWrPRTmXSpKHVoRSjCMdKwxnJHEsSVsbkNfUHrM6lPlO1lL
 vAdw8nUBBdvAnHHak2bRQG+Que78tc8Sl/cKjUE=
X-Google-Smtp-Source: AGHT+IE35No9v4qdn1BywyFPYWIfy0o1+QhEuXhX42Z3s9NQdm6FgIQD3Xpt94xA6Upm9r4dEp4PPg==
X-Received: by 2002:a05:600c:4ec6:b0:408:54be:d961 with SMTP id
 g6-20020a05600c4ec600b0040854bed961mr6420235wmq.35.1698062656743; 
 Mon, 23 Oct 2023 05:04:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:15 -0700 (PDT)
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
Subject: [PATCH v13 04/11] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Mon, 23 Oct 2023 15:03:21 +0300
Message-Id: <5ecea6ba2fb0e3957d7d90bc4dbac521a3d1f678.1698062525.git.manos.pitsidianakis@linaro.org>
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

Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
of each requested PCM stream.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/trace-events |  1 +
 hw/audio/virtio-snd.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 122d1403ef..6def414f96 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -48,6 +48,7 @@ virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 4eae76f638..fd0c50de6e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -157,6 +157,86 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
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
+    uint32_t stream_id, start_id, count, size;
+    virtio_snd_pcm_info val;
+    virtio_snd_query_info req;
+    VirtIOSoundPCMStream *stream = NULL;
+    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_query_info));
+
+    if (msg_sz != sizeof(virtio_snd_query_info)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_query_info));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    start_id = le32_to_cpu(req.start_id);
+    count = le32_to_cpu(req.count);
+    size = le32_to_cpu(req.size);
+
+    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+        sizeof(virtio_snd_hdr) + size * count) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        error_report("pcm info: buffer too small, got: %zu, needed: %zu",
+                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
+                sizeof(virtio_snd_pcm_info));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    pcm_info = g_new0(virtio_snd_pcm_info, count);
+    for (uint32_t i = 0; i < count; i++) {
+        stream_id = i + start_id;
+        trace_virtio_snd_handle_pcm_info(stream_id);
+        stream = virtio_snd_pcm_get_stream(s, stream_id);
+        if (!stream) {
+            error_report("Invalid stream id: %"PRIu32, stream_id);
+            cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+            return;
+        }
+        val = stream->info;
+        val.hdr.hda_fn_nid = cpu_to_le32(val.hdr.hda_fn_nid);
+        val.features = cpu_to_le32(val.features);
+        val.formats = cpu_to_le64(val.formats);
+        val.rates = cpu_to_le64(val.rates);
+        /*
+         * 5.14.6.6.2.1 Device Requirements: Stream Information The device MUST
+         * NOT set undefined feature, format, rate and direction values. The
+         * device MUST initialize the padding bytes to 0.
+         */
+        pcm_info[i] = val;
+        memset(&pcm_info[i].padding, 0, 5);
+    }
+
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+    iov_from_buf(cmd->elem->in_sg,
+                 cmd->elem->in_num,
+                 sizeof(virtio_snd_hdr),
+                 pcm_info,
+                 sizeof(virtio_snd_pcm_info) * count);
+}
+
 /*
  * Set the given stream params.
  * Called by both virtio_snd_handle_pcm_set_params and during device
@@ -404,6 +484,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
     case VIRTIO_SND_R_PCM_INFO:
+        virtio_snd_handle_pcm_info(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_START:
-- 
2.39.2



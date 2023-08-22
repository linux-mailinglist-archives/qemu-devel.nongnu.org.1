Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD744784A36
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWup-0005mC-3m; Tue, 22 Aug 2023 15:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuk-0005l1-Tf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWui-0000sW-KI
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso2212040f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731977; x=1693336777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGxUwfY2869OmuNnPOu/iFU43yjS0y4Fj0jkn9ZyHBM=;
 b=hli6Ej/4FUAogvGrsXOGte2ADPpXbOhf/DF4PfleycybpcTSJLpQ5V0aEXwZ6tjLyH
 tT05QNu0hIcMcmGRXXJiJtAAkVIVOd4TMFLgwOiNMxrKaapKeKf+IgNJz0LfajNL9qum
 qUP2qq3miXLqKPALi8Z0nYjuU34sEKARyzOeZuEx8xv7Lc1QDia5cDq/efpi77EjGTLV
 +jQIZKYg66TBXXDM7fhYLVYWD0gNShibnZJ0IXOfeb/26LZgQZjLkwxGPoQY0Ip0hzjU
 ZU4kUYWE8906fc9Q6FVO8RO/waEYUJ441xJYyenZQcB5T+eeIvaiDIhu9d0OIUneAfQP
 lSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731977; x=1693336777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGxUwfY2869OmuNnPOu/iFU43yjS0y4Fj0jkn9ZyHBM=;
 b=fKjwqJmLNRtyGg+4sqSe8Q1aoKOsR6kcic4h9dzgkPWebMICfFHnQNPo3u86ues/JT
 XrHi3dqoUclkJknOCpWb9SXDrKIJQh3Deoc36UT2rceJVlNaT8wlE9aaEt4y2S+YlYqw
 KxuMToj7TQkvoBef04hA4SPs/gd1Uiq6IlmwS8hKdPgNdsMpJ3FUASRKRmQJuFeUA/0v
 Dt/UbVTG2wMNxRzyvPGAuL/0SmavSyUOOQLnceeOBS6AnPtSS8H29iljAqXvkKdM40TX
 l8h/YGoWrpRIqXd3RQkBCumV7AJa6mUsKzmgN0BSdHwnxVsuSoC6Bnd7RNg7qEYrk32b
 T5CA==
X-Gm-Message-State: AOJu0YxdFcjPQlR7jkvgJaNOti0BHYbI74jkTvyvXVJfrajLoOuDvtAo
 my2yuB4wImngbji/ffv87Pr1hNor2nu6x66An+8=
X-Google-Smtp-Source: AGHT+IGlYYuwvhRhTtqnTRmm0plXlvy3+NIzwAzHXthm+XzHO7aw/uaKF1Y49DEgafAcEekJs3fCCw==
X-Received: by 2002:a5d:45c6:0:b0:319:854a:9ea1 with SMTP id
 b6-20020a5d45c6000000b00319854a9ea1mr7395039wrs.15.1692731977718; 
 Tue, 22 Aug 2023 12:19:37 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:37 -0700 (PDT)
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
Subject: [PATCH v7 09/12] virtio-sound: handle VIRTIO_SND_PCM_RELEASE
Date: Tue, 22 Aug 2023 22:18:32 +0300
Message-Id: <b1bc6e7c21bba013054ea874c8a9eeacad0d689f.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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

Handle the PCM release control request, which is necessary for flushing
pending sound IO. No IO is handled yet so currently it only replies to
the request.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f70cde4f01..60ab62a80d 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -167,6 +167,7 @@ virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS cal
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
+virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 87f8469f14..7052aa4e89 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -486,6 +486,42 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     }
 }
 
+/*
+ * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
+ * a stream.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_release(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    VirtIOSoundPCMStream *stream;
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           sizeof(virtio_snd_hdr),
+                           &stream_id,
+                           sizeof(stream_id));
+    if (sz != sizeof(uint32_t)) {
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    trace_virtio_snd_handle_pcm_release(stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        error_report("already released stream %"PRIu32, stream_id);
+        virtio_error(VIRTIO_DEVICE(s),
+                     "already released stream %"PRIu32,
+                     stream_id);
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+    cmd->resp.code = VIRTIO_SND_S_OK;
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -533,7 +569,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_prepare(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_RELEASE:
-        cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
+        virtio_snd_handle_pcm_release(s, cmd);
         break;
     case VIRTIO_SND_R_CHMAP_INFO:
         qemu_log_mask(LOG_UNIMP,
-- 
2.39.2



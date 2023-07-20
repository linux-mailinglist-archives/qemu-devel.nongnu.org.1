Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D57675AEF7
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTF2-0006Ah-9r; Thu, 20 Jul 2023 08:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEu-0005wc-FD
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEr-0004Ve-4J
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso621338f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857913; x=1690462713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVcCqT33aYYqa+SnwavtcwXTmT9T8ESgXcng0tddxmo=;
 b=R39UoUmJnBKRKyMOKnA41ngwac5wD18yPB5tvUUofHBeTu9vzkk/VKRGtNmEYJwKsE
 DOHf0FpZMxrr/xLrIUe3JfdQETfDXMVSQoLXgC6KMbPFOTC1R9FqGYvwTBiFul0RyN7J
 z4uoCTAfiIAM5tDr5F/ozKXSCjzlcbjFbM2x+QQgCIAGkwtDFM3tS1GhFeIkYC+hKw7O
 eMFEDzAGP74LaC7N3iY/2RFdhOiOgJK5kFGSwRWGAPqBlTznlkaaKiB9pUBSXweo9ZVX
 bqzIJJ3Vx1oiWN9juqwLJeVNOgRU+i7WRcUIobFbR3lSs6skNMEbFSKJW2uc80M5BREt
 F0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857913; x=1690462713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVcCqT33aYYqa+SnwavtcwXTmT9T8ESgXcng0tddxmo=;
 b=V0a+eLJ+kf4Dlx0XJ446IuhGbcoNiOlVIqI4bMxZ3hnE9rFrVPT8/2d8K0MXFqjzP5
 QfLD3fYT1LOW69y+xixZjpmnAfO0L8JKmedypUxtnZILlzb1/stlsoX7VP3qwtncdtMI
 NkByhuF3RuF3FuVCo62r7MjyWTvicyRZPUIIC09zjmwm3b4UHFBiBFTHUGxldLuP8HHg
 R/VVMLssdUrXlSZ7ftH+E/bBqv/PDEUE6+H5rItcmc3Uecvlg6Kr+f6RPePJq9JU0RUl
 FBuzfgvOW2cXdTmgrEp2u/pESQZKwK3FrG15g22gJgPzgf1GmV77BI1qEjG729U8nwgQ
 YG5w==
X-Gm-Message-State: ABy/qLbSGhYwWC2+zAUitgUskNOzE0rx5eJLs6GJMfwWDMKBBTZKRxOr
 VX7yCNW/jqmr7VWqnL1w9woln6/b6t3FJ/AjXa9drQ==
X-Google-Smtp-Source: APBJJlG+Tmi4RB7gzH3CeC4iMY1z2SjVEhikdbb9wr3uZ0V99WGgNQdw8l4GpEXdWzw1MH5iXp6CLA==
X-Received: by 2002:a5d:6e53:0:b0:313:f463:9d40 with SMTP id
 j19-20020a5d6e53000000b00313f4639d40mr2044628wrz.65.1689857913125; 
 Thu, 20 Jul 2023 05:58:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-41.37.6.162.tellas.gr.
 [37.6.162.41]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm1294816wrs.70.2023.07.20.05.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:58:32 -0700 (PDT)
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
Subject: [PATCH v4 10/12] virtio-sound: handle VIRTIO_SND_PCM_RELEASE
Date: Thu, 20 Jul 2023 15:57:11 +0300
Message-Id: <4e14b2d129ffac210cde100381c38a86265799f6.1689857559.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

Handle the PCM release control request, which is necessary for flushing
pending sound IO. No IO is handled yet so currently it only replies to
the request.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 51 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

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
index de82ed60ad..e87783c38a 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -481,6 +481,55 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     }
 }
 
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
+    cmd->resp.code = virtio_snd_pcm_release_impl(stream, stream_id);
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -528,7 +577,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



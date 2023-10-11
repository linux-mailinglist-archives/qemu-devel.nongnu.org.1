Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654C7C56FF
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJo-0000WU-UC; Wed, 11 Oct 2023 10:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJn-0000Qr-Da
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJl-0005iA-DL
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so6549863f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034966; x=1697639766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TDi/nXVyf7XMp9ikxQgSEBIh+2+xuwQ3eJjsMsNyQ0=;
 b=wNpxiUdzHfibTvZ/+og2gqvB9zqSd8e6NmygIyyGCRn67GojPPRQpslyx9gGFyI88h
 0jf3l/DhefguRuljW1gP4AshcDTR8ro97znlD2IvoYhHC9K/jpM51eM/VOERt5vYYjM7
 t9suaLpE+TAaIiexZyGgpGjDspC4u5KnWKjWUQ+YspraVQqeBcsPMbIuOi1ZsaQzKjE1
 fQ2ps33F7UfLylBD9C8Kr66SsvvLIfxccpN6sZOgVTn+LHr+HKXy6un4eQZuyHneM2sT
 /cfJGq4LtvWW8uCMDB9jYLLV8JV7Xl2WLNIgRTjMHuIIL+1lbcKMy6heAN9mch5P2QNS
 nZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034966; x=1697639766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TDi/nXVyf7XMp9ikxQgSEBIh+2+xuwQ3eJjsMsNyQ0=;
 b=ozOg63+FSt3YB+CnbWbx5U/dS5v1AMnNcQyB3aL96Vlw4sdQW6H8+SxQ4okiQ/ZO9p
 9igeVEBNaW2u5aqIG3fnG+NYAdNhvTj4utZjhNU6aaw4Kl0YCixCjXJecfUs6VJ3hEk1
 S7s4n2dCWm1ZX+NoJ5FT/RaB0V9lO6o3ejNxmyUPYU8udbq25h7UoR/Pdg8ZytTsNrE7
 mdA7dMHCGfhHqaDI+R6mmaXNBIQfc/jc1KMjMsbvxcnouREXmok80fsMwJkyFXxtuuCr
 tgwbWQgXD7KimQQ5ISa1uaZBjAMhc6revHpQUBlBjgfa9v7CfoO9llddlQB2rLnaMJVt
 xguw==
X-Gm-Message-State: AOJu0Yzd6DkCSYN7EypCzwWm+OrzWa6clRBrIz5q0nckBuxQulA1tyOL
 WOALRcBh5NsdWab93bNXPs8O4pnaH+pEfOy4YGI=
X-Google-Smtp-Source: AGHT+IF4wB7j05FjHK4jEeiqJO0MxSlyZiLlHDr1uQfBbMrOEE0n38QViidA48CBbc5RO27fyHDasw==
X-Received: by 2002:a5d:664a:0:b0:31f:f91c:d872 with SMTP id
 f10-20020a5d664a000000b0031ff91cd872mr20594249wrw.19.1697034966549; 
 Wed, 11 Oct 2023 07:36:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:36:06 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Google-Original-From: Manos Pitsidianakis <manos@pitsidianak.is>
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
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v11 08/11] virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
Date: Wed, 11 Oct 2023 17:34:53 +0300
Message-Id: <93a5b96b58b6623e99953ce1440627760eca7cc2.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Handle the PCM release control request, which is necessary for flushing
pending sound IO. No IO is handled yet so currently it only replies to
the request.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 48 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7907b610c1..b0789a6e7e 100644
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
index 49cd9f3ca4..ca873fd6d4 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -503,47 +503,93 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
  * @start: whether to start or stop the device
  */
 static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
     VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
                                cmd->elem->out_num,
                                0,
                                &req,
                                sizeof(virtio_snd_pcm_hdr));
 
     if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_hdr));
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
 
     stream_id = le32_to_cpu(req.stream_id);
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
             "VIRTIO_SND_R_PCM_STOP", stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
         error_report("Invalid stream id: %"PRIu32, req.stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
     stream->active = start;
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
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               sizeof(virtio_snd_hdr),
+                               &stream_id,
+                               sizeof(stream_id));
+
+    if (msg_sz != sizeof(stream_id)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(stream_id));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    stream_id = le32_to_cpu(stream_id);
+    trace_virtio_snd_handle_pcm_release(stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (stream == NULL) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        error_report("already released stream %"PRIu32, stream_id);
+        virtio_error(VIRTIO_DEVICE(s),
+                     "already released stream %"PRIu32,
+                     stream_id);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
  * @s: VirtIOSound device
  * @cmd: control command request
  */
@@ -551,74 +597,74 @@ static inline void
 process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
 {
     uint32_t code;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
                                cmd->elem->out_num,
                                0,
                                &cmd->ctrl,
                                sizeof(virtio_snd_hdr));
 
     if (msg_sz != sizeof(virtio_snd_hdr)) {
         /*
          * TODO: do we need to set DEVICE_NEEDS_RESET?
          */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_hdr));
         return;
     }
 
     code = le32_to_cpu(cmd->ctrl.code);
 
     trace_virtio_snd_handle_code(code, print_code(code));
 
     switch (code) {
     case VIRTIO_SND_R_JACK_INFO:
     case VIRTIO_SND_R_JACK_REMAP:
         qemu_log_mask(LOG_UNIMP,
                      "virtio_snd: jack functionality is unimplemented.\n");
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
     case VIRTIO_SND_R_PCM_INFO:
         virtio_snd_handle_pcm_info(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_START:
         virtio_snd_handle_pcm_start_stop(s, cmd, true);
         break;
     case VIRTIO_SND_R_PCM_STOP:
         virtio_snd_handle_pcm_start_stop(s, cmd, false);
         break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
         virtio_snd_handle_pcm_set_params(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_PREPARE:
         virtio_snd_handle_pcm_prepare(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_RELEASE:
-        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        virtio_snd_handle_pcm_release(s, cmd);
         break;
     case VIRTIO_SND_R_CHMAP_INFO:
         qemu_log_mask(LOG_UNIMP,
                      "virtio_snd: chmap info functionality is unimplemented.\n");
         trace_virtio_snd_handle_chmap_info();
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
     default:
         /* error */
         error_report("virtio snd header not recognized: %"PRIu32, code);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
     iov_from_buf(cmd->elem->in_sg,
                  cmd->elem->in_num,
                  0,
                  &cmd->resp,
                  sizeof(virtio_snd_hdr));
     virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
 /*
  * Consume all elements in command queue.
  *
  * @s: VirtIOSound device
  */
-- 
2.39.2



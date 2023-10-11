Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D67C56FE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:36:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJm-0000Ne-Rg; Wed, 11 Oct 2023 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJj-0000MA-Kt
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:08 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJh-0005a4-1D
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:07 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so923286f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034959; x=1697639759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw730jgi6g3YenzrLg55f3D1p6dxBieuNtNcazwlqmU=;
 b=vlF+/erp5VGd98NqBgK1FXWHu8LT4U8Mxuv2B7CJ4+L1bLhKKJxwQ8yfHyj/S924ps
 aNIoBLRxcuM8K0ujXxVxb3U4rTR3BlQzssakQOWep1cJ4Xc0eHBV/hZC3Nand5LjCK+j
 60PEKlCUeX6C+46JOpnnzeNGq0O68t331/YEhHcwR4dYH8kd34yjOHQ1juRmizUHnExF
 hjLjaFmK5p8riFSmRPN/rnZinGBjHv9JZkRNqRbYbcBsSVDfthmMvxIX+sA3j59w9FFq
 nt/RnlKgK98qIvZXjVQZ6jzqYwQLMF4q2mevMCcVPJUSb7F0GYxjbZHNskzCE7nzUZoR
 fsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034959; x=1697639759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rw730jgi6g3YenzrLg55f3D1p6dxBieuNtNcazwlqmU=;
 b=GTGu74gEzkY3uA3zJe91fexGIv1OWvvTnnV24N4LAEu3JJFm+oO054rzb3W7Ok9aFw
 oMnQCCUSPGPefuLO/Vr7v7/Z1OCNdIId0l1DKtbFqJKybhNqoZb1yOhB9tmovlDr5XJy
 nEralgxXADNO4ZzhIDqT7rH/hC86W5W5BJIKEDY6+nv7/nWALrB7mJ7bW3Qw4RxN3coM
 X6NqzWt0WxWd+ipDeLoVmI6Iq/9/Q64fTvmOtyNLed1qYlBknUiQf9sUbXRTP6ExkIN3
 nBw6j0nN+s+QfXI0R2lC0dre2UvmnHdb4JDNK7Eg6WBo7H5WXv+YEUUjlMaIpey8hBUB
 z50w==
X-Gm-Message-State: AOJu0YxcN4btEKMQd4tYciV3NvgbW6pWzqtKSV4lIb5d+w6bQiZcGMz6
 Pb7IBw4LFx/GJ8DhxrA7rLTht7ey8JIDVzAP4m8=
X-Google-Smtp-Source: AGHT+IF+3L6b0MBszsmaOjc6DIX2F50wiSnpdQzbLyQt5nE7kus9Pdr8+R5HItSfKFp+DJtd0nikTQ==
X-Received: by 2002:adf:fdd0:0:b0:31f:f9aa:a456 with SMTP id
 i16-20020adffdd0000000b0031ff9aaa456mr18703176wrs.2.1697034958750; 
 Wed, 11 Oct 2023 07:35:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:35:58 -0700 (PDT)
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
Subject: [PATCH v11 06/11] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Wed, 11 Oct 2023 17:34:51 +0300
Message-Id: <68ac43df35b1be1a43ce56b5a3de7822b1315901.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

Handle the set parameters control request. It reconfigures a stream
based on a guest's preference if the values are valid and supported.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7044b110b7..7907b610c1 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -163,6 +163,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 50b5a9d5df..6a7545536b 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -250,43 +250,75 @@ static
 uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
                                    uint32_t stream_id,
                                    virtio_snd_pcm_set_params *params)
 {
     virtio_snd_pcm_set_params *st_params;
 
     if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
         /*
          * TODO: do we need to set DEVICE_NEEDS_RESET?
          */
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 
     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
         error_report("Number of channels is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
     if (!(supported_formats & BIT(params->format))) {
         error_report("Stream format is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
     if (!(supported_rates & BIT(params->rate))) {
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
 
     st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
     st_params->period_bytes = le32_to_cpu(params->period_bytes);
     st_params->features = le32_to_cpu(params->features);
     /* the following are uint8_t, so there's no need to bswap the values. */
     st_params->channels = params->channels;
     st_params->format = params->format;
     st_params->rate = params->rate;
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
+/*
+ * Handles the VIRTIO_SND_R_PCM_SET_PARAMS request.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd)
+{
+    virtio_snd_pcm_set_params req = { 0 };
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_pcm_set_params));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    stream_id = le32_to_cpu(req.hdr.stream_id);
+    trace_virtio_snd_handle_pcm_set_params(stream_id);
+    cmd->resp.code = virtio_snd_set_pcm_params(s, stream_id, &req);
+}
+
 /*
  * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
  */
@@ -497,70 +529,72 @@ static inline void
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
+        virtio_snd_handle_pcm_set_params(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8F7C570C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJp-0000Z1-Kx; Wed, 11 Oct 2023 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJh-0000LA-Mr
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJY-0005TL-7G
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:35:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso6474653f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034951; x=1697639751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9MdLvdr3TSH2bUvE9n7JeOkT2T6hYu0LDOeAx0W1vs=;
 b=egkjcbsjyJGzl/T8r+GbW4tCIbGyxObnkZjBbN1zXMBBvLKcB0F0SkxJBI1hyVj69U
 dqGvwviA0VDeTLUFG5N1FDhEJxqQq+hJnf6c5KXsjbmyxSQRqfh8KM+ARfW6Ot06uOQq
 NFrcNihzSmz5KRerh7qLGhqQuMRv/+9ZikwecVpus1i4wRYYMs3ios/lnS48IZjZoDqe
 TVAaAz8PbbIQ/kI4EffJN0BS7iwm3uqm96kbmCP8qCZ+8OY3auDcvgAyDNysC9zT90Fr
 Lf41AlujfF6FQd9Qwz8YuoLzltDKyKwGb5UQxm/rxMuwLamfqxHnYgqvf6qw7gSvZPXt
 OLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034951; x=1697639751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9MdLvdr3TSH2bUvE9n7JeOkT2T6hYu0LDOeAx0W1vs=;
 b=HbPBTtHeVvnPOfn/HG389U1kudUBLgfHza/zf0Sl1FAVtcBzPvLJRXHxU8xsRWvgHX
 4w8De0LPVQqOtAUww7hyB457qMPtbrWvfG4PHOdnqEuUsAC2gP88KBfbHPn8O73/SJS3
 ysUnU0e/13cdHK7/og6CBBn3ddXErk+DLHKlqJ35tL1g6FXMWSW5iA7b9trYKHUE8eKj
 f8rmY503OcNHh7gCUaT3yIt+tgnC16bd8yTrtkgGbRse/qZyq/QC9vPmDKvNeK1s6zDD
 fd67Vg4s7dG+vDlkXvmpo4zoq0C/kBIkmxHQWQaAvukiKRCjJmmzTI5N8HpHPuvLFN26
 gOpA==
X-Gm-Message-State: AOJu0YxRFN0zH8RqUve2NrDN30UhIOZ/wS9n+VRpF3p/Ruvsi2/shw52
 XxaNbSUQ3+qTSCgOmW1J+4VuNh/rfXccyQ4B4Ek=
X-Google-Smtp-Source: AGHT+IG0MaZt8+YUIEvJA8GkWMPNgEgpTaNESYOBd3hOajR1HAOe6QU24RiuW/Y479bBLhnU9xwZBg==
X-Received: by 2002:a05:6000:1f87:b0:32d:24c7:a268 with SMTP id
 bw7-20020a0560001f8700b0032d24c7a268mr5347003wrb.4.1697034951607; 
 Wed, 11 Oct 2023 07:35:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:35:51 -0700 (PDT)
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
Subject: [PATCH v11 04/11] virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
Date: Wed, 11 Oct 2023 17:34:49 +0300
Message-Id: <425cbc2986aaf318fdb6a604baebf5a2f03cfe31.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
of each requested PCM stream.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 48043fed3e..88de2021c8 100644
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
index 705dc07212..ec945d55a7 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -147,22 +147,102 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
 /*
  * Get params for a specific stream.
  *
  * @s: VirtIOSound device
  * @stream_id: stream id
  */
 static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
                                                             uint32_t stream_id)
 {
     return stream_id >= s->snd_conf.streams ? NULL
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
  * initialization.
  * Returns the response status code. (VIRTIO_SND_S_*).
  *
  * @s: VirtIOSound device
  * @params: The PCM params as defined in the virtio specification
  */
@@ -376,64 +456,66 @@ static inline void
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
+        virtio_snd_handle_pcm_info(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_START:
     case VIRTIO_SND_R_PCM_STOP:
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



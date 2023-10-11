Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875BB7C56FA
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJn-0000QC-Tw; Wed, 11 Oct 2023 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJh-0000L9-Mn
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJZ-0005VX-Mo
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so68238125e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034955; x=1697639755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGiHMYRv14IcSlmSupNGhirJ2/W4kMmOARPqHyE4VPU=;
 b=ocGmUlDFV56yc8FW7voih73me7Ck53FbVyc7q0UYt7B78FRgzTERZKkJlENLxzG53Y
 l2IGcbDYNpD90Lgp+SQXcCgHXUabvcRmeBul0VAKi4CN4Vmver0ewLnNVLaZ6XcTQ4sj
 ELTDUkFEgKe17wSSp1qSBJDdrEMhH7zZJyqFxgqu2blQUfeqMNJ9Ir4Y12t2s+6WzIDM
 ouFVTKq0/F0/spWYVybAspqSAe1a/IGt+gGgDxdyyKlZqpEvh3WprCp8WZdTY4JRNQbH
 knHjclZQjF5e33v4deJeXztORiz5smc0YvVZ0PuydGMYklAmjwVah7Nm1McNwgTPguEp
 OJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034955; x=1697639755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGiHMYRv14IcSlmSupNGhirJ2/W4kMmOARPqHyE4VPU=;
 b=v6NZzBo0cjQJA7nN92TcoN2E4oWgu0f3zIy7ZYfQVGK4WppSiGK0VvP811TqqlklBM
 TkOdQoi7PptKZE9vv2tqrU4JRPuCYMAwBf3ZNTu+NEje4rvb9bLtysipXsHPGYLJM3cy
 EJ7QC5SU3GgXPQSS+/DRasDQ7ZTvWbfYdXw2Q7rjqqOMWohzbKaadz7MKuSkNXAx4Bn/
 zlVznB4Dwg3+8mteHz1d++XGQtqDr4sOfKsvmhURVseoNj4Jm1aATnGSd/IGjOprvrSG
 6fAJbVsIyi/QBsX9S5RcgW7M97x/GgW3cuuOMQE4kDnZ17loaPfRH1TKHWwATyJ8jLPM
 NDGw==
X-Gm-Message-State: AOJu0YyS2Me1nNIr9TWfNUyBeF0a8dbmGZ/aoYKqJcSWyICxM7gW4OGc
 DxSXfPAk5t/lqZcsYH/swiz2wPuIDTBWFZ3hpKw=
X-Google-Smtp-Source: AGHT+IHfm/GVSkYzi/jgBe1C94QEHCsWNcA+O2R/2IjjIVGBKERH6RyOyullypRFo9aPnC6grME+5Q==
X-Received: by 2002:adf:9795:0:b0:32d:8547:e440 with SMTP id
 s21-20020adf9795000000b0032d8547e440mr1808033wrb.38.1697034955079; 
 Wed, 11 Oct 2023 07:35:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:35:54 -0700 (PDT)
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
Subject: [PATCH v11 05/11] virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
Date: Wed, 11 Oct 2023 17:34:50 +0300
Message-Id: <d1403721faae175b7f212c8ee942888981ae2e63.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

Handle the start and stop control messages for a stream_id. This request
does nothing at the moment except for replying to it. Audio playback
or capture will be started/stopped here in follow-up commits.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 49 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 88de2021c8..7044b110b7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -165,6 +165,7 @@ virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
+virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index ec945d55a7..50b5a9d5df 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -426,29 +426,70 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 static const char *print_code(uint32_t code)
 {
     #define CASE(CODE)            \
     case VIRTIO_SND_R_##CODE:     \
         return "VIRTIO_SND_R_"#CODE
 
     switch (code) {
     CASE(JACK_INFO);
     CASE(JACK_REMAP);
     CASE(PCM_INFO);
     CASE(PCM_SET_PARAMS);
     CASE(PCM_PREPARE);
     CASE(PCM_RELEASE);
     CASE(PCM_START);
     CASE(PCM_STOP);
     CASE(CHMAP_INFO);
     default:
         return "invalid code";
     }
 
     #undef CASE
 };
 
+/*
+ * Handles VIRTIO_SND_R_PCM_START.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ * @start: whether to start or stop the device
+ */
+static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd,
+                                             bool start)
+{
+    VirtIOSoundPCMStream *stream;
+    virtio_snd_pcm_hdr req;
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_pcm_hdr));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_hdr));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    stream_id = le32_to_cpu(req.stream_id);
+    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+            "VIRTIO_SND_R_PCM_STOP", stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (stream == NULL) {
+        error_report("Invalid stream id: %"PRIu32, req.stream_id);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    stream->active = start;
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
  * @s: VirtIOSound device
  * @cmd: control command request
  */
@@ -456,66 +497,70 @@ static inline void
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
-    case VIRTIO_SND_R_PCM_SET_PARAMS:
-    case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_START:
+        virtio_snd_handle_pcm_start_stop(s, cmd, true);
+        break;
     case VIRTIO_SND_R_PCM_STOP:
+        virtio_snd_handle_pcm_start_stop(s, cmd, false);
+        break;
+    case VIRTIO_SND_R_PCM_SET_PARAMS:
+    case VIRTIO_SND_R_PCM_PREPARE:
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



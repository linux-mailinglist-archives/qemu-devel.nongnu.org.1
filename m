Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FDE7C56F7
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJp-0000Z3-JL; Wed, 11 Oct 2023 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJk-0000Mi-KH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJh-0005ax-1M
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4075c58ac39so13207195e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034962; x=1697639762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlzxZ7mnmxeFu1X7bYV06Uym0W+edwy+53fqD4+XWAg=;
 b=muO63A2Hn9kdJcsKpR4gLBvPdLpvury6wZhkrYLahzK0A+uDI+XYhG1ynBxWKaFmDM
 koy0CjJAcIqFL/CefN/X0RupLTIUq0Fxj3bIobp8z/tJw7Ld43uXeCOcka1/PHY0I7tD
 KTuGX5Ca7Mc2s4CkISgHaWV884P24QQT6QwnmK8BIe3jOhZYvgdxSdvxogRriadMqLiG
 SqaR61LqNVMHRTcEXLnRBieGWGmAwO8mbZ8JrRf+9fD6fKFC3qhTd5o6bUc0da7Cgx8q
 po9/xH44bHlNBifDNivKQ2OdQtpiPQj4rEUOD6B/hds6CokEajNmz3f3j09yELP4SUOD
 oquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034962; x=1697639762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlzxZ7mnmxeFu1X7bYV06Uym0W+edwy+53fqD4+XWAg=;
 b=spXbqZoI0u3qe/ZeXxC1jtnCbtogbJd1XzmLl+jaj1bNJ9LMlfv9E9GtXbd2EFsH+K
 LXX/EtfQJP7bXJkGBsr71nwgfoOLMF8wzrdaA6PR9MiS0BifjCXvAGuCLMSM0oS26bii
 TTuO9y3ZhcnVX0eGDBqPmBBCHpPz9g5FADB9WcQNXv+wiGjkJ1NkfvXqpfIzAX5AaoYC
 NQHzYfyoGb3oEuKBpMp8CQD5pC0L3OabN76VVF05fEiESLHq0aLwYDtMkLvHSJnMpXwh
 lOUm8fIcIM0nR1g0Y5z8OvdSgI3NvbaQoODiEHFyepVIYl8fVtsYmNC5+nHal38vSXlx
 WjKA==
X-Gm-Message-State: AOJu0YxaB/r/jqkUYf7WPKvhEPHkducejDi6fKXzdQ9YtqEZCIY00Ukq
 RlmS6hxbVnHbA9JmoWmzjgnJbBVA1yu4tofZCA4=
X-Google-Smtp-Source: AGHT+IEy6ANFVjRMsVaA3+MuAHnAnbppknfU49sJ+rmVaBGev697aR7wsA2mUOEhe5/eExPyJ00l+w==
X-Received: by 2002:a7b:cd85:0:b0:406:5463:3f51 with SMTP id
 y5-20020a7bcd85000000b0040654633f51mr19162956wmj.25.1697034962538; 
 Wed, 11 Oct 2023 07:36:02 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:36:02 -0700 (PDT)
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
Subject: [PATCH v11 07/11] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Wed, 11 Oct 2023 17:34:52 +0300
Message-Id: <175e6fbe7501f27a1b6d8fcfaa3f47a4ba2ece74.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Handles the PCM prepare control request. It initializes a PCM stream
when the guests asks for it.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/virtio-snd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 6a7545536b..49cd9f3ca4 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -458,30 +458,52 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
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
+ * Handles VIRTIO_SND_R_PCM_PREPARE.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               sizeof(virtio_snd_hdr),
+                               &stream_id,
+                               sizeof(stream_id));
+
+    stream_id = le32_to_cpu(stream_id);
+    cmd->resp.code = msg_sz == sizeof(stream_id)
+                   ? virtio_snd_pcm_prepare(s, stream_id)
+                   : cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+}
+
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
  * @start: whether to start or stop the device
  */
@@ -529,72 +551,74 @@ static inline void
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
+        virtio_snd_handle_pcm_prepare(s, cmd);
+        break;
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



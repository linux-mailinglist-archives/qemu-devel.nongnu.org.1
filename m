Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EF77C9FD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq2b-0005VF-7K; Tue, 15 Aug 2023 05:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2Z-0005V7-O9
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2X-0005DF-0b
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe490c05c9so35718205e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090515; x=1692695315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jai3kYbDrbVt8a/lKYVq34m+ds4YVtihqI4vAIOnNHA=;
 b=svN+oxc3SxmWpsH546r59FJC6Cu90e6JTQreqoKItRjLhifuInb9kbRtR6+B0gBGdO
 RW1X2550knTyE5/z7hIYJlHkQAvtm0SA6dRfPhFlJEGtp+Kw3s8YlFAcbMTB4mRvpyeo
 eK124VwCZR7Ibyv0SuK+mWmQN6ZQSQ7FRtVcvc1IVdTZMPLHbX+QgLyq8ZFGlyKBGX9H
 eNJQE32EErdqB82RBdaT7OZZu7mhHAn8JDKxpM/rWd8LCTHXtl0Cy1svYsDBtNnc+qQ9
 n7dePAk8gpBzgNM1w8pV5VAiimVwCunN5j+iuZ2+deYqJmWszxYPffVil2LpQUPOrEQp
 Yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090515; x=1692695315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jai3kYbDrbVt8a/lKYVq34m+ds4YVtihqI4vAIOnNHA=;
 b=dYbaoG5R98gUtDxeeJRjfynAnFxVQLBe8+jFwSO1w2YwjgQ0b0GYxRgSK5o2guqEyE
 sqAk3fjH1Tu4VgyWwBcIj91fApE1lmyaBY0iD0pMWMtjCOeBxwxYX5N9p25u20nHyrfH
 1qNK3HmHLsOvoNEhOIO23mwbrGDtWo/j+LFZpzSz3VDZbo5YS9vWCj5eMpg3ssTbwNbm
 B4NZSoXTPuaEgQqdJ+HSUuIEOVo8uhfoCzgIafh2EBIhwadi8pPwnKzknnVxgtI8HecY
 P0uSQiu1h78CIyC1DpEx9KsaZ0GyQB/ilxpOjKj2EYWjSgjMWADCmz+G4HLldTASQ36T
 4RkA==
X-Gm-Message-State: AOJu0YxyvIeVzPBm4lXY3zUU5EMAhcViob0B+qvsI6CJmQscCVTId+VX
 VNhKBAcxvLNKY15/ZeJL1xUQInojOO4nJP5Gt1Q=
X-Google-Smtp-Source: AGHT+IGdAsepZq04jAtwfN6++BCf5Fs4mhWlAUuW40hIBs/Psc1oVcFG5MLqqo2JMmBZ5F2ghjgMHA==
X-Received: by 2002:a7b:c3d8:0:b0:3fa:aeac:e978 with SMTP id
 t24-20020a7bc3d8000000b003faaeace978mr1157059wmj.0.1692090515509; 
 Tue, 15 Aug 2023 02:08:35 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:08:35 -0700 (PDT)
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
Subject: [PATCH v6 08/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Tue, 15 Aug 2023 12:07:13 +0300
Message-Id: <894b52532b7277b25409d73ae8dbe994c08d2940.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
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

Handles the PCM prepare control request. It initializes a PCM stream
when the guests asks for it.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-snd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index c9909a29af..f314b6270f 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -441,6 +441,27 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
     return VIRTIO_SND_S_OK;
 }
 
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
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           sizeof(virtio_snd_hdr),
+                           &stream_id,
+                           sizeof(stream_id));
+
+    cmd->resp.code = sz == sizeof(uint32_t)
+                   ? virtio_snd_pcm_prepare_impl(s, stream_id)
+                   : VIRTIO_SND_S_BAD_MSG;
+}
+
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
@@ -519,6 +540,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_set_params(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_PREPARE:
+        virtio_snd_handle_pcm_prepare(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
         break;
-- 
2.39.2



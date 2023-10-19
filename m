Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC167CF4B4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPuZ-0004iw-G2; Thu, 19 Oct 2023 06:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuP-0004No-Hy
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPuN-0003Zf-QI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so23282635e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709937; x=1698314737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW3FGiZ27CY4pjdZQjWNUADEm0uplCiJTAc7oydW+5Y=;
 b=oF6kzB2ZzCraaK2o2mYzNmww0Zu9UzP6U1EORj9yJOpGMqifOF85LhmR7xpXaHPhwv
 7J0V9/mw088PkhIsdC/NDPdmoY0lKySZ1G5F60AKAirTAQQ2IfzzpO69JrRlrCDj6DKj
 e3wH3fEIAbtajfYwpKho1bZ0vJjgEkzV7aBhoSceAx+/uMvlUpHO+JzoHN+OooRfYpRY
 uNF9C3Is2C/LaCDaERTPAOxeHHTy0VW1sPgzUO63kwnhVeSau8VHwAAe3h9jr6VdEUZ+
 YNuTlB0rL960LRTDMgv/Ym5gEzKxnkBSXipVROEPQTGWFqEREpt7JzjCI047v+HCcEiX
 ndmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709937; x=1698314737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW3FGiZ27CY4pjdZQjWNUADEm0uplCiJTAc7oydW+5Y=;
 b=vi2tFxSYEAHecElmMkuZiVEVNyU73p+JsBPd8d3rEO3B4djlv+t4c85e3aw2z1oLUV
 BaKJ8zRfw5KNPp131wWfReL0zhKhPcz5LwLJCP1r1noutqqOUiVMrhs9Pbdj2xBrhlgL
 DQicJlRlQLtbjxpIusxo0rjLVSwb1Pevhj3R8OYh6zK9swVoHuTJlTh7Sx7CGVmDg4k/
 nuPzPs6G6g2qAfqk+jBYMA1fpD1sf2SzKAoTQYVbsCITmk6VMD3Aw1RJlu7qDtxpDd28
 8vRjYrr2nDy13rjj1jYkQHdoyUhzUJXjkf0aMmsiUiUKgzuUNKEvzFVQ9otEX4TqlihQ
 jZCA==
X-Gm-Message-State: AOJu0YyddPHcOwycC6ggsS1wcyNOa70F6qaT1Y9NSp5667ARLu84hdKb
 w2YJLH0tR3euaBDMOXYR3apc47FEoYd0H1G8p4E=
X-Google-Smtp-Source: AGHT+IHluSEbnkNQxHOdTEYjnUxfG7qELxaqH0Z3IP3WR0Qu76Sktjh/TLPvNSTHJLtC/jWJohH7Xg==
X-Received: by 2002:adf:ed8b:0:b0:32d:888a:c2cf with SMTP id
 c11-20020adfed8b000000b0032d888ac2cfmr1013770wro.7.1697709937274; 
 Thu, 19 Oct 2023 03:05:37 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:05:36 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
Subject: [PATCH v12 07/11] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Thu, 19 Oct 2023 13:03:51 +0300
Message-Id: <7553c0dc2c6996613c3ac06a81ff75df5020c1e2.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/virtio-snd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 8c8d26fd3c..aa4a193508 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -478,6 +478,28 @@ static const char *print_code(uint32_t code)
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
@@ -569,6 +591,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_set_params(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_PREPARE:
+        virtio_snd_handle_pcm_prepare(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
-- 
2.39.2



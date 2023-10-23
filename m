Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052257D3618
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutfk-0005I4-SQ; Mon, 23 Oct 2023 08:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutff-0005HW-50
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfd-0001zQ-Du
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4083f613275so26558545e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062672; x=1698667472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+4RW3Zm8X6t5MTpeBt5QIrdEFSSkBf0HOZCTHYq9aI=;
 b=Qd/u0Sqr7VH9ASzeGw4yxNRSGx9SKhckanNh2vaaNiej2XMZAStJxEXNF/sQtDoYYP
 bDsyhvJ98EAaWhb4sKZ9TQ3d2Y8aWKRRH1plnlJQ+K++b0Jlu+nrPuMY5va8x/3CagiC
 k6AfKB9O89g5KMWFh1LUUqyDAOg4S63LQLJMtYqoIlZ3rneXBhWrVBF9nKRTzKlF7DVW
 fL7NUs3vLVuYiw3QOY0/mZuabrPb440Hzwgv7LxvQGaDN9X6xbosuODxSZzjEpKaaPOQ
 BS1vIJsZXFGSBTc1caBIOquC7hb8H8gF8kEXTmiO0tnr8eJw711EeuWSfW6LI68TaFCC
 OODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062672; x=1698667472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+4RW3Zm8X6t5MTpeBt5QIrdEFSSkBf0HOZCTHYq9aI=;
 b=MEV+lJkPck2ktb1tI/LJTmT/eZ0Sw6l96+53AEaJa+knnzTa441UI99KUjgPSxmDVI
 83XJeA9kJ2xfBcGWrMhMUKup0kjNbHWWmuOZGcdDCggD+zOq7bLA5eDrvg1mJrpd87RM
 D6K3tlQxwEFbc+DhlJIIscLR5c/QQLufQAnupaFMHhYKVw0h7W2YoTlwlP1tN0iE3A97
 eBM5+ImQX/a4K5nonGDKlggsE9DOwBdpgW/6Hl35nBM3HviPhPSqKccaIenbZneXYfV0
 gNOC68WMZXN7khaXkq0HglpwtP+CO/jhi+C21GpQqyGylXUwoYqlaT4cmld9IEb1LI3k
 Iw4A==
X-Gm-Message-State: AOJu0Yw8v4dW6030YajUMog3M4YleprExtevoBvDIwC6/VSz67CFntmU
 IVAMc5ho5CCR9qwsY6kt1pVnsNO4fuLKb0KuDZE=
X-Google-Smtp-Source: AGHT+IEqxB6i7natNIkx2JWJRL+JU0sMR+Bou8nthTvvgJoWt8UnWZOWPRyELqTg4Q10ye+fZrpfkw==
X-Received: by 2002:a05:600c:35c7:b0:406:535a:cfb4 with SMTP id
 r7-20020a05600c35c700b00406535acfb4mr7171939wmq.1.1698062671943; 
 Mon, 23 Oct 2023 05:04:31 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:30 -0700 (PDT)
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
Subject: [PATCH v13 07/11] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Mon, 23 Oct 2023 15:03:24 +0300
Message-Id: <c6a9c437ef48e45f083fc957dcf7fe18a028e657.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
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

Handles the PCM prepare control request. It initializes a PCM stream
when the guests asks for it.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/virtio-snd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 084890e52b..31a1942754 100644
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



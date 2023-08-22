Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A55784A2A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuo-0005ll-DQ; Tue, 22 Aug 2023 15:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuk-0005ky-Pk
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWui-0000rm-KH
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-319e93a1594so4438011f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731971; x=1693336771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AGKeTlgEQufWXz+jQaxQMPXl1nt41VP3hKGMfA/IkQ=;
 b=HVnohcVfYdp1mSbLqoHgs5S35jBS29f7QH7jt9V5A2vu0RehlNHSO5GkMxhleWYTxs
 Zp68xRsf3LKD8VfiaOCzBAL/Av3h7kwSx5oL9rOLa377A/EDmGSrTLjV6YMdQOqwa8DC
 lrksbTXvtQHjU5JrOE2nJhq3WMBd4JL2U+rf6dpdyh3z8geTOBDXbwdxvFLAy42mqWrF
 6+j+BWIFpQsVsI0YAO4Nc6QmyA3kavRnKUtW22JBNnrJdZ8K01cTxYF+xRdI6O8/MQQo
 Qkhu3v90WRPlTV86yT3qGJcbCTjn8SsLMKcoJbuZZD4P9h7tPzXM01/GAGA7zWSSL1y7
 qU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731971; x=1693336771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AGKeTlgEQufWXz+jQaxQMPXl1nt41VP3hKGMfA/IkQ=;
 b=L8qppfAgQlMbm6v5NPYGXB06nOiZyUMW3Z2ozbacr1BcbLBKAaH1y/Zke9DLBvof1i
 OA0GGJ6UDhNBCedd7xhbUqujInqYvDd20bKsfY8dnAU3N9P0/cYqZ52WCCudYGqBpdfY
 M9vgHlawwuPlMNPXXrSHa+JGlBIAB46z/LprZedW9oJfOzuhLtdbal3rSqrm4X1GgL0l
 2vHqfNnQzmcRx5xE4flAb8aUxvlgMPv8OQTAYrqQJusy5Zf6WDe2WNRIXYdi2JVFedeg
 soLxBHO1Y3YciC+MwlRztMt70JiXDRs7s//dtxGE4dnBRwxPI6vc3axZyw7wt1Iq41D9
 nWFw==
X-Gm-Message-State: AOJu0YwbBWdpx2VXl55fpdSOYun3TMSjgnrMN0QCFM6fjJBIq9gLs3Ym
 o96+Z+4pn8Bm3ZxwboLoM/aCQdWx7zAFzk5p4fM=
X-Google-Smtp-Source: AGHT+IGL+HhvwsKuWMZobxhMUvyw6FHi/0Do0DzsyjaD/4NpdaPLQB55eB9u+eyXzTDg4nFS/O4BPg==
X-Received: by 2002:a5d:4850:0:b0:319:79b4:a8ba with SMTP id
 n16-20020a5d4850000000b0031979b4a8bamr7705367wrs.41.1692731971240; 
 Tue, 22 Aug 2023 12:19:31 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:30 -0700 (PDT)
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
Subject: [PATCH v7 08/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Tue, 22 Aug 2023 22:18:31 +0300
Message-Id: <1e4bef953f4d7de41a54106e2ffc43a447181747.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
index b9d17c29a4..87f8469f14 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -431,6 +431,27 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -509,6 +530,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



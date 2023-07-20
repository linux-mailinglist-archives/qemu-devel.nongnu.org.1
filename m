Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019075AEF8
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:59:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTF7-0006sT-QR; Thu, 20 Jul 2023 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTF5-0006jm-4Y
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEp-0004VI-1D
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so6080655e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857910; x=1690462710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktiuq0APAZpJtp1zCEE3+1kHE62a0w0gFPRmMA4ENgw=;
 b=I70Y+LkJR+dy8QIOB7/UgA0Wn07uPIG+RVMhAmg5tRQj++rNA97jzEBYXXczSyp2v8
 0jv1e6Znn8XZAyw32WGkK5l3lmKBLFKiR749f9fJTeMxbpbnjeqOXTawsgNG5iD0xemy
 92IXGncWztphoMnwodBFCTOTOEzwd+geKsIXPQIDCfp0Bo9DA3FwawuZcGtVFL5SL5Ca
 k7VSgYNS06FbfWu+N4KrwRHO1gUSNZnG97mLdGKf9hAtmL+tK+h6ciHqRZeJSdSLUR5W
 QsnlqCoF4FaxGmyZB4coqO61zxPLg/9f6/2hpv0LgwWF/rHnjupHRjxWPFzTkrH+RlTe
 Q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857910; x=1690462710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktiuq0APAZpJtp1zCEE3+1kHE62a0w0gFPRmMA4ENgw=;
 b=Uiv9bpT56G5d+OZsiA+fJuIS5+yn55LXcYPqBvku44HeX6VC0KPstxxP5Btv9xe6pt
 oNK9ouEqF4Y5JhorPcTRZt43ocElVei9/Lhxih8nHFjeJ8UBJWZyIT9NN20KZK2KKDfa
 80tR7HMUMY51wsP/HT8QUU5Il7f5puDvsuxKlRVoIvLO4tfzGDACzX1zhj6cvhWFgXtI
 ngWKBO4Njmr64DrGJ8+MXPXyQsGHJv3egtm5cLkHabO6f1OwgJHI16tmnNcdfB/hSYjY
 OfCfC+IPjBmiTefWVpe1405qRBMykH19+EkpYBh6MzNcKNNi/74W3luG0RYlmPgYFsWy
 1ONQ==
X-Gm-Message-State: ABy/qLaJEU7nGlSfu/oiCKPmVPU+9RJybBWEOpaGT5Xo4Zrhoxh5HrTD
 33It/JuqVNQ0phTK+i9bkiYqRHMWY/jrJ1/mBn1UyA==
X-Google-Smtp-Source: APBJJlEui7lvRGn1e2efHh/aK6VQak3oIV2Tqh3oiltxSyg4xmnwwxdjItpCr3i3hQ3DgD1h3BpmuA==
X-Received: by 2002:a7b:c417:0:b0:3fc:a49:4c05 with SMTP id
 k23-20020a7bc417000000b003fc0a494c05mr3833144wmi.40.1689857909712; 
 Thu, 20 Jul 2023 05:58:29 -0700 (PDT)
Received: from localhost.localdomain (adsl-41.37.6.162.tellas.gr.
 [37.6.162.41]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm1294816wrs.70.2023.07.20.05.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:58:29 -0700 (PDT)
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
Subject: [PATCH v4 09/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Thu, 20 Jul 2023 15:57:10 +0300
Message-Id: <d2b385408426082509f59ad47555aea5db8e8a69.1689857559.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index ea1f07a66a..de82ed60ad 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -426,6 +426,27 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -504,6 +525,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



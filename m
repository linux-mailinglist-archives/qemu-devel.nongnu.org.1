Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D2767ED7
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:50:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLz-0000gE-9p; Sat, 29 Jul 2023 06:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLy-0000g5-7F
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:18 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLw-00019V-OY
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-314172bac25so2730119f8f.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627155; x=1691231955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeWkGnZPslfwAExkWiwvEET430rj7LZsI1bWG/GhhK4=;
 b=dW19i1iwf5jA7MO5+SdAiW6BROzVFNpFgqsbTm3045ByhHlwx8Ml9arPxKkdkAdRAL
 9MxRyY9JDsX1CJ7E+3hyeQbBTSC5stAkDJTShXP5R6znew5ey2QTs3sg0140HWbns8rd
 BOddFj1VNcNPiRf8Difm20ViuSn8I83jLuHJqDVp9wYoOheSJRviEqAnI26Os6INYedB
 2biUXs/Hj0LSdgjvMgWtGxGw05RBqrsD6NT3dk7PBFVmEkQsUSk4XQahaeSJwFcbEZF6
 hUjIke/tTEFVDd1dCLxSnlhIbN8nTPEBiN1XITwIZqRGgnYF7+D+LwFms2ew5AkheG6y
 TTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627155; x=1691231955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QeWkGnZPslfwAExkWiwvEET430rj7LZsI1bWG/GhhK4=;
 b=eoze7zXPmZz2KMwjFygm+fKVbm96bNIG4zsGL4JvYjxDFQqcdWXuT4rULUN9GiEyiH
 enu01zfrpLVZi95uJxgo3NZN/7mDoZrMBSyVOmbWbuhP75XWmgx6B0jxCEIHUccRrr4T
 pNeiOgtUfxuCzh6CSQQ9rpT4LpKiPQUTqFbU8umkmvt0AvVxkZDlxl1245kRen9q2rbW
 3ddE2UXKWu3VGib4dHmR48kNG5HKgJHVYLVzTo755fV3aAidzas+LZxSYc2DIeu0ZM1Y
 vlBjnR0r1yc+EfnJ8MAQh6/zy0oCKmYBUINynFdOOnqnwBUUHQ1tpYlt7QwbfN8TxYqN
 FcPw==
X-Gm-Message-State: ABy/qLZ6BXua/7hnVfxCpO3Iu9bSobUgDco1+TodeQYn68mQqoaXlUXc
 wfZyppIb2vFaqK9eoALblmlIsEG7VOJu7fYlWw/shg==
X-Google-Smtp-Source: APBJJlHDTQH73glKMgm1enzChvANP3xYavync5GIBrgISQlszf6d6jhtbFvRsxbGKPxyoQy6cbP0aw==
X-Received: by 2002:adf:e807:0:b0:317:5e58:3fd with SMTP id
 o7-20020adfe807000000b003175e5803fdmr3962927wrm.47.1690627155084; 
 Sat, 29 Jul 2023 03:39:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:39:14 -0700 (PDT)
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
Subject: [PATCH v5 09/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Sat, 29 Jul 2023 13:37:01 +0300
Message-Id: <cdb8ab3ee2e4a7fa93d9faaf9fb67744941b01ff.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 85a0565543..a1cccf8ac8 100644
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 201EF79E0E1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOY-0006Zo-EJ; Wed, 13 Sep 2023 03:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOT-0006ZR-TO
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOR-0001q3-F8
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso68363335e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590474; x=1695195274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb+BOww9UjWc3wiMIi+noKl89pgk5khfPRBLJHVDNrA=;
 b=cuSrSdLQcK8sQ/JkBphNBIXhJku1/dHYmNjVhm1jRYt5/ZbF+60I1dsAvmneGK417Y
 rlVV2BukgNQnKZEcBIvfhNtZ8De51tQXAJY0Vt/L8nSzzBClA+DO9RS9i71T4DS/Y/o5
 2bQ7b4J0Xs+J4XLwT8pp7vtJ3iYV2+E69LUDgrIG/hFLB0q9pswqn3y2necDo3aV9pUS
 njjAv9scneruOIBJkW4GUoT0kyf9N9nHJemMRczqKdurlHT3HDrPgg/P86z6htU42PGm
 nFTGFqR2Zt59TX14s28uxal2IqAtsXQVyxEeuJT4BY7RxNg45Weg4LPokzcaTyktPN06
 F5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590474; x=1695195274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb+BOww9UjWc3wiMIi+noKl89pgk5khfPRBLJHVDNrA=;
 b=J/0F+Kf7UJiBC0qmTsGHq3prwO8RGPH7vwmur7HGjWS+g4UI6Kn/Ne0x6ar/NhFJ9N
 BApa5QdIzA/1dIHOWzrWJI5qAKP4jFLPiVpbeHjp0XK2Z16PoC8MTQCNAxfoAV5CuxcH
 lL5S7uMIcrIy/n6d3gIOt01GYIZFSyMdA3MqjNL5nYbNhT15CFad1J/2MOvSDFS8HMKI
 hoBacWbmRMlM2nN3q9RwlNct4GZUDK+VRKLKe7ap5YongiG2WmZtYqko452n/SWZHyfP
 RVylZMak85Mm4PFjpSPDNIa+q3LoMpmTSLht6G6h4C98ESPmks6LS8MUgymHwR/sP/qM
 2LTw==
X-Gm-Message-State: AOJu0YwGSig9Y/AuTa3x3jNIHXxeLO2rnJi9thA7OS0QtKTjOGfIqUO4
 ob54aRCThnC/HLAVTSLqdzIkYI4SeRa1ISUhuas=
X-Google-Smtp-Source: AGHT+IEUGGMj0T4YD8va8Z+p5AC6hlbK4np2PMCNKSXXvNHZsCVT6qYk7V9LPFuYuVGoo6FVTue80w==
X-Received: by 2002:adf:ee4e:0:b0:319:6001:978c with SMTP id
 w14-20020adfee4e000000b003196001978cmr1238314wro.53.1694590473828; 
 Wed, 13 Sep 2023 00:34:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:33 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v9 08/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Wed, 13 Sep 2023 10:33:15 +0300
Message-Id: <6029975cf95c71573a461025f8cd6730cc93c010.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
---
 hw/virtio/virtio-snd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 29a70cd7e8..343afc0531 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -452,6 +452,28 @@ static const char *print_code(uint32_t code)
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
+    cmd->resp.code = msg_sz == sizeof(uint32_t)
+                   ? virtio_snd_pcm_prepare(s, stream_id)
+                   : cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+}
+
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
@@ -535,6 +557,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



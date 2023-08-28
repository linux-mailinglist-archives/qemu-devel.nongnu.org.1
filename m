Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95A78B8B9
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:56:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLY-0002oh-Hy; Mon, 28 Aug 2023 15:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLK-0002k5-EY
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLH-0005Ik-TZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso2976012f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252566; x=1693857366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXujS9CnlQ+FYN9oqFszd4Lr4yVOKL3YH3bu5Ahjhig=;
 b=Z4dUcnybkWAXU39j96i3lQkD9LYvbec5o+6Qga+8glV1o8rFMF5B209HhZFGr0LDWh
 mbtXK9lxG3MpwGyAZf1EoIlPP9KNgKKBdd11tOihSuo5yEVCmbZy/m2GzQA804IJU9ub
 U2/YZT3LpY4Awj85J+RYQRFKM7gAdmAqTFGo1QPfNxIJL9mmwTRHiPwx4I8tc3KPn0qQ
 Lx/ntaPGJpZCbIexc+nnc/ugiaSfLN0WcRyJLjT2WaBYi07nfx9MWkOiPxqkcG6+VDQe
 CG+i3rOb+TVSKme3DNmN9FcuskX3b10/CRihD/SmXJsHyMkudG71NrinTzz6htisf3M2
 p7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252566; x=1693857366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXujS9CnlQ+FYN9oqFszd4Lr4yVOKL3YH3bu5Ahjhig=;
 b=TuJcK/7WCkjrG9tk78Kg1t90jd1UidA1iR/lbuqCsLpjE5yhYLytBv/8K5gJSSgury
 yJfOb61iNmxk2SxqX9FJuAF7gSFINDBAf8sBg9bbYXi1yF+wh+3ito1+6i/QkUwGtl+c
 ogUpUbDR3XVmNo4BhZbE2pCbEDMwPWSWPCuR6s1AE/ty6AKziRnDyUFxJpM5Mg1Urnnt
 jyMLKZgPwlrgOcUdyRycXiVTLCjIG63CLcPeGjiOT/j/imXaT+wtCcCY76mfh5q87SFj
 2RYRKfxypy+NmnfMLDJVn/vg6brmCkfRlvBvBKOKcgMxLWdciig4boxZxC3PvwJNM1Gk
 IW7A==
X-Gm-Message-State: AOJu0YyxJWRP7JtF2jl69mZNSnnARKI82NtdSmsvz2QcoWNbkhfIheu4
 rnqT5m7EnWVm6SGlJiMoDBg08qTMcsF+dQjuH/4=
X-Google-Smtp-Source: AGHT+IE6NDF20bKFRW1lED8RvaIB09hEgIlTksT5tXbo3hxf1zutZJ0OMTl4jd7J7PoZjH8JqF5Irg==
X-Received: by 2002:a5d:6949:0:b0:319:7471:2965 with SMTP id
 r9-20020a5d6949000000b0031974712965mr19972163wrw.21.1693252566191; 
 Mon, 28 Aug 2023 12:56:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:56:05 -0700 (PDT)
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
Subject: [PATCH v8 08/12] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Date: Mon, 28 Aug 2023 22:55:05 +0300
Message-Id: <36ce5f4d63892e36f0ebd4cdb0660df75deda6bb.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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
 hw/virtio/virtio-snd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index a05f637dc3..be6eb2c36d 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -432,6 +432,27 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
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
+                   ? virtio_snd_pcm_prepare(s, stream_id)
+                   : VIRTIO_SND_S_BAD_MSG;
+}
+
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
@@ -510,6 +531,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



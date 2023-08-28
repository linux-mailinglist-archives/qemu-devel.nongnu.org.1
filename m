Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182B78B8B8
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLc-0002ub-2k; Mon, 28 Aug 2023 15:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLH-0002jk-FC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLE-0005IV-PC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401b393df02so35192955e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252563; x=1693857363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MgTXBizPwlrDkblMIoH2TwyWpn8VChhTVuRq6Fll3Q=;
 b=sVFQ4ov31UC1vIOeRkEuh3ltOCZQRNB2TPSVzAkEvSqyDpGDrDpXCkEYytAAsOyNI+
 E7biayi1v0MCOD02ti7wEjcKgweQvWIETU/V62/xDOfFY+4KBxlzFTTaH0qf8saW61+K
 OTd+lDPn0Q+JA/yKmFO0YVnvU87QUyt6uE7CW87MaEO62vWf4CrPa8LxvAPyBpNhVT2b
 Tx9+AlYzamXOT4WB5qr3/gEkIVMn8aVPvTaCY2g2hwU19fJ5APk8vztAbPndEgk4IkNu
 7BHh+yAxa119mwV71y9EhOjxSU5lWRof2aWrkeeBvImjzr2rDpViaQhPphXfPAAewMGS
 pHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252563; x=1693857363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MgTXBizPwlrDkblMIoH2TwyWpn8VChhTVuRq6Fll3Q=;
 b=d/LuKCNcRkWIFnh4FvkyKiEi7upc1hCRXb2YvreiBVJKZZUwwGJpoO0mJCpSAr4HCi
 XCfe7l1dqlBODROAyTAGBiBJo5mzZ1vN8oFgpOxGZKsWjxnwH/shgAZvwNyF96UxM/NV
 ceLgRt5W+PYzC3JbWkkqJGzV2QX4PHFatavqhXCeEwG6SiIuUW/IOJM3v9Z0m/o7KNv9
 2AX0tkdAROSJuSsnzWZ/8Ph8TuZIpUWL0monzwwq43zUN1srIy1lDAVOl0rI/5bWB0eZ
 BS7TOIfJtRtD7uhmPWafTf1XMUbg2g3ybNPiuyJa2IEX2hbeBbGqHLMENZ620ZixBbSj
 N/6A==
X-Gm-Message-State: AOJu0YwXKDf6yYPnlfgfQmDijdFbSwoEgWKn+Ryy1AiAFHz7AP9b/Och
 YQskHJMoRoaKtRUIGRN6VO29tupyaF7iSMwi3qU=
X-Google-Smtp-Source: AGHT+IGwaBoSNEAWMS6IKOda7NTBNqPPyF4pZHDrsGwNhAx5tnuncKFoSKwkyL6nKHWje7dVP2j7sw==
X-Received: by 2002:a05:6000:18d:b0:317:e04c:6791 with SMTP id
 p13-20020a056000018d00b00317e04c6791mr19166280wrx.62.1693252563246; 
 Mon, 28 Aug 2023 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:56:02 -0700 (PDT)
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
Subject: [PATCH v8 07/12] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Mon, 28 Aug 2023 22:55:04 +0300
Message-Id: <993e6af394dc5e687abaf2d6eeb8443fd636fa1a.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

Handle the set parameters control request. It reconfigures a stream
based on a guest's preference if the values are valid and supported.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8eae1bf881..f70cde4f01 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -163,6 +163,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
 virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index ae014d946c..a05f637dc3 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -267,6 +267,30 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     return VIRTIO_SND_S_OK;
 }
 
+/*
+ * Handles the VIRTIO_SND_R_PCM_SET_PARAMS request.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
+                                             virtio_snd_ctrl_command *cmd)
+{
+    virtio_snd_pcm_set_params req;
+    size_t sz = iov_to_buf(cmd->elem->out_sg,
+                           cmd->elem->out_num,
+                           0,
+                           &req,
+                           sizeof(req));
+    if (sz != sizeof(virtio_snd_pcm_set_params)) {
+        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
+        return;
+    }
+
+    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
+    cmd->resp.code = virtio_snd_set_pcm_params(s, &req);
+}
+
 /*
  * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
  */
@@ -483,6 +507,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_start_stop(s, cmd, false);
         break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
+        virtio_snd_handle_pcm_set_params(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = VIRTIO_SND_S_NOT_SUPP;
-- 
2.39.2



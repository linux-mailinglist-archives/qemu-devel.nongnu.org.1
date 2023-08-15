Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD777C9F7
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq2X-0005Ul-Cg; Tue, 15 Aug 2023 05:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2U-0005UW-TT
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:34 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2S-0005CM-Ld
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:34 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9a2033978so77784551fa.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090510; x=1692695310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUy/6DHierwoc7TV/kX1bp4W6C9FWPkhXSVzla4nZks=;
 b=fFzqpBfop4/cphPMk8MArSxP7dZn9IxSFKigK6jFJOiXeR2OLsxAM3QOVxW4BarFov
 zMqSZgT6Vq6VXKH5hMA4fxCYYB9TjyrdyIl99gFSrNhXwERXRqpd8iQX8OY/twRYF6Lr
 IE7D5qGdSc4ra0JWB1/84C5Bw22a36vp31WdIX25wXUw/nk9lzV76SmaNu1adTYtWnR9
 s+zJAe/rZHiUIzPBgrO29vcu/bAE8or4B6kRJM0MpOxNZTj3xjhctWP5eB9A8nJpGfpW
 jDbayMEmoXdu2m8Vn278Ei4Jeciu3EL8Bbx7qQqvyI+ljvMcBbYiVDJrnu7yHL37tnuh
 pQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090510; x=1692695310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUy/6DHierwoc7TV/kX1bp4W6C9FWPkhXSVzla4nZks=;
 b=Rmb6nwC641N09wahOriI6ABydy3Q8VT/pdzHQX0Gz3kov0yWDcLUhG8jA8+B2FLPO/
 raksNxQuiMoZreW/SAFoUIbCdSfyHoFCoy386Cwas/aqo3O/MAQVeVh9B8XdpYcrJJ4s
 D9lHO5ZxAC+02Rhq/EChiS4Lvf9B8IMmprZGCGIW25riwBfHHn7NgypzK2VG/CtlxVVJ
 augfvYTkC4vpILyb8drim4XKQ9tdBxt5m1BXzj8Le4MrvkXVioYWhCfOisL5K9XlNnaV
 LHE/HUigyMakNJtuNf3D30X5ioHr/gh9Lg/kiieTCZU5o62JQwxnA903/xewvVSymBzT
 oDyQ==
X-Gm-Message-State: AOJu0YxEt3FuIXuUDc0s56OtR/5yCKZXSwny5DpOwreDeT+gj0MtoAGZ
 tHT1fmmwa0E7Q6KTHsNMlqXN8O/N/h4ohZQWhpY=
X-Google-Smtp-Source: AGHT+IEXRIOHd9Wd3/DruwVkZY64I0Lj7J081iUmHygX2oos0rdwAcxF+JqHIoALOtHQTsORvN897w==
X-Received: by 2002:a2e:2e18:0:b0:2b6:b6c4:6e79 with SMTP id
 u24-20020a2e2e18000000b002b6b6c46e79mr8341049lju.1.1692090510448; 
 Tue, 15 Aug 2023 02:08:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:08:29 -0700 (PDT)
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
Subject: [PATCH v6 07/12] virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
Date: Tue, 15 Aug 2023 12:07:12 +0300
Message-Id: <0cb3e8a3b599f6e082f239032aa20b3cad6d6ad7.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x234.google.com
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
index 8fbad8f07f..c9909a29af 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -276,6 +276,30 @@ uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
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
+    cmd->resp.code = virtio_snd_pcm_set_params_impl(s, &req);
+}
+
 /*
  * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
  */
@@ -492,6 +516,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



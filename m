Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81631767E7E
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLv-0000aD-PY; Sat, 29 Jul 2023 06:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLu-0000a5-6V
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLs-00018u-Ju
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso28620275e9.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627151; x=1691231951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luWiixk055IHbxaWLp3VrLOmzNxb5Lg5G+xPDpAlQSE=;
 b=MF0NAqUnnwKUbuiMdnWGDHRZv+EFrIqIk0kiNxhxE3xQX8WS1UYtd+JEfd/Je+/BvR
 ZT25li2i36uHdSi4fko40zrAYaw/d/aeGY1Fub+k41cTnUae3W1eVT6C0ttkERAgjW3A
 aVyBfhehjBCbVRSqqqPGTsh1Z6kaEBYp5ETbc0T1rQbEzk3/SXucf5sP4whCWRyhb+t+
 77obk+6K5dFgteJbkiSLdmRqs5Nm3zsxkGmCBUku81j/NxMJM5vgEXvEMZYzCr7Go3op
 G/ej2EfhOvCkkeYRRqGRXIMSCN9Pl2xeRopRuPx/5dzOzt6BmlxRigmFwMUZAxzJliWQ
 yIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627151; x=1691231951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luWiixk055IHbxaWLp3VrLOmzNxb5Lg5G+xPDpAlQSE=;
 b=A4/eYixZ6xLGMZRKsrdD5DRId0diMGQatvW62HFzBroQ+ZEcmFRiglO53I10okCZwz
 fK3N/W7kx+OS996Xdt4Ysqgl1Q9JnfX+ayNWt9zKizN0aAFhyTKNXTlfYv0EFV52EiQs
 uUxydoLzBEwFTBPkSfn0Obni+t/X71tPqszOAE+dKhUuCfpRj+JF9BH/6MjupgIspzzC
 N3J48ziVLS93Qs6YEgXLRqrLGLDtC+EQH2yromSTaZEKSgEXr2gHKBA4m28x3Oy1Kh+E
 WKBS9mtduSzZnHDKtk8jAVokU5UxBvBcrdlCZnmsszIbwWxVhXxPAQUZPzaC+v67TM2A
 ON0A==
X-Gm-Message-State: ABy/qLbh/dgrLkRKFTw0vN+vRoaBRVqy5HpCbX8yh/ClUrgslOP2Efzd
 yAVnV+Mi0xtvsZVOFZ4xsqvg+tquxrv1jcgqtIdwyw==
X-Google-Smtp-Source: APBJJlEBSHgvhKVq83+150vtysOz5/TshCijWBgJNJ5wtA6QOhmfcrsiQ7OI8y+ZVxf93jYwW3OyNw==
X-Received: by 2002:a1c:7917:0:b0:3fe:16f4:d865 with SMTP id
 l23-20020a1c7917000000b003fe16f4d865mr876213wme.23.1690627151129; 
 Sat, 29 Jul 2023 03:39:11 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:39:10 -0700 (PDT)
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
Subject: [PATCH v5 08/12] virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
Date: Sat, 29 Jul 2023 13:37:00 +0300
Message-Id: <48f9b776f5b90c560b8731ed96747e5429e781ec.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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
index c8adc7614c..85a0565543 100644
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
@@ -477,6 +501,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



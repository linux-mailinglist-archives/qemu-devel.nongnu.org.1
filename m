Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742A67B345D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEC3-0000Op-O5; Fri, 29 Sep 2023 10:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBv-0008Qm-JM
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBm-0004IO-D8
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-406619b53caso3029505e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996592; x=1696601392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2c58PMRfiWVzFfPNmTUFgbVlkykRzMjuZTeJYY6qnc=;
 b=SbahxLf/4kV4qw4jZ06YcAVO9mZXYT66mses4GOUFXEiJCerryQmff4HsOebjoQVdE
 YPGuYx3cV81TtHDAEVHmQmWgl6SevBmXdamI2urS1acsIJ9UXyXc2TV2JKTBPdEeiakF
 mRkUgCac4R/LwziQYd0pM5uD1eAU+PZI283RaNY/A7L0LcBK+kyHtN48L9H/G5b2ckPv
 9aav5QvQWC9v4RFW97Xe00r5GO6KeSRIDV711Amugf1z23dv6+9cZGuhtgQMR9qHhjJt
 F4kKcQ+HlWysEXtWa0jQx1v4KFDvkbljFFS2pXaeWPQYfOg2Ah5pkn3MiPOXX9q1VDql
 FTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996592; x=1696601392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2c58PMRfiWVzFfPNmTUFgbVlkykRzMjuZTeJYY6qnc=;
 b=Gkh/PVcvGNkQkPqX8egpTUr6oObHSlMU8fu0a3nfeAkw4+nK7vtfgutVjb9OHniF+j
 0wAUC3QjQYsU9L6SxCwl3t+nk78y4iiLLa6OyDV48z7vdp0s1n0rBqcsAwa9Wxw71Np2
 XPOfVGP8RHECtZyLsJGNeYPq/FhIKhq8gkJYWKNHk4regnsJOwo1mjeJLd6sU49lHD3c
 kAZZDukmfwx0A/kmR3RHA+tddOgMR1bQAb3MXkwiBvppB8yDqLYMzljjUOm6WWGsu9g8
 f2CvF12MZi9p1veJTrjnyLAYktQRg8x+9i9xDLBfzvG/mcb7H/4hTmSBHS2QPY9O6971
 thdg==
X-Gm-Message-State: AOJu0YyPhRw1tjMRqGhTyPZbK9PooztifNjMzOdjYHTh1s3S6tOo1lBv
 JeccwM7RG6Inc337OxXSqAJQv7dPbF2DOTONbVY=
X-Google-Smtp-Source: AGHT+IGvFewxNQWp/D+wNZVY8S1Cus1om9u2pLaf6RaRomQQRJ05JUGQRlHRC7A669g1NOjAkWnxJw==
X-Received: by 2002:a05:600c:210e:b0:401:bdf9:c336 with SMTP id
 u14-20020a05600c210e00b00401bdf9c336mr3968199wml.27.1695996591664; 
 Fri, 29 Sep 2023 07:09:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:09:51 -0700 (PDT)
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
Subject: [PATCH v10 06/11] virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
Date: Fri, 29 Sep 2023 17:08:26 +0300
Message-Id: <25fbb2eb250920858e06267d834d24395e4a648f.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Handle the set parameters control request. It reconfigures a stream
based on a guest's preference if the values are valid and supported.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/virtio-snd.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

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
index de1fad32c6..4b5cb6b01f 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -287,6 +287,38 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     return cpu_to_le32(VIRTIO_SND_S_OK);
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
+    virtio_snd_pcm_set_params req = { 0 };
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &req,
+                               sizeof(virtio_snd_pcm_set_params));
+
+    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+    stream_id = le32_to_cpu(req.hdr.stream_id);
+    trace_virtio_snd_handle_pcm_set_params(stream_id);
+    cmd->resp.code = virtio_snd_set_pcm_params(s, stream_id, &req);
+}
+
 /*
  * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
  */
@@ -534,6 +566,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_start_stop(s, cmd, false);
         break;
     case VIRTIO_SND_R_PCM_SET_PARAMS:
+        virtio_snd_handle_pcm_set_params(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_PREPARE:
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
-- 
2.39.2



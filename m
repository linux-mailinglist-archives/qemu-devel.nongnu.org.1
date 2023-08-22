Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D3784A32
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWud-0005U8-OU; Tue, 22 Aug 2023 15:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuZ-0005M8-G9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuX-0000rE-9G
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so46056215e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731967; x=1693336767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5iZG4bPWzKkvM8Z0+53PvEM7QYkoL7FbC+/HrJ6i9g=;
 b=MXfaUorU36e5d9MhteShr/AQyitrclq6DD6Y6BYwANlmzMAex04pgjvtNfKshZ9ILI
 GPCn3hF9vwoOd+5w0+aakCHGtFZWjAS3JTAbqYhRSFjE5T+haj4INNfi0I4W4GQxO9CA
 sTMKbpyh6u5++I2E1sdRkXYS73Q3xFBPTBi+ZLad5jol8Rw/gbJezzDabXggS5f6pJY1
 w4vE8ARTdHyl3ny0sqnT7Zz0mDw4xnoCL35D8rFTbLO8RTAOeMkrw/iA6rN9RNFidktK
 O1kOncJYHoPnUm64ZlqJ+63H1bv7Uw4wSPof7BOBjUJi3+VXllMFO0kS9RSMc1TrF6ga
 jo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731967; x=1693336767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5iZG4bPWzKkvM8Z0+53PvEM7QYkoL7FbC+/HrJ6i9g=;
 b=JtQ8bs+khMRPBoVqkVzLRbWS4JGeexGHD+e8bHNofAH2QukRT8N7iTQ274SAggf+aL
 3StfDGFqBNixh4wHtymtZUZ3QV4pFv7pEOCbcW3APbRRk8KgQ9SMG3K1wpzz3Xznw6yz
 Duj1SCdCR7QE6MBHrf/fqTkZ1d9/VK7QBuiAbWum8GN2YOXCxTvQnf2Bu0t3TGWbnpma
 viFSm3WqxG0QEH64k8zsHYW7hbDkRD2Jn+QBIEqCZ4jWkFZNW06MdvZ8LmRR72P+4iBd
 UWyrjVLz+fwgJR4e7YiKu4tRB2lsoTwB5bNf2v6QAss51PXT/7RPmNzWF2OKyUsSiROQ
 P8gA==
X-Gm-Message-State: AOJu0YyQnODkxgJ6K/LmThD0OD2vEm94OV3Ic7n1E2TLENFG4cAE4uTm
 NYGBrRBLuiXbDTSshakpEdrKIWYUZLxKFyWzzvA=
X-Google-Smtp-Source: AGHT+IFk2ycBYThKf9iGxP+PJZQxW0ne5tf9rC41GWRvLP9QTavB44WDcDs3MUVyHJS1njn/U+L/eg==
X-Received: by 2002:a05:600c:2102:b0:3fc:dd9:91fd with SMTP id
 u2-20020a05600c210200b003fc0dd991fdmr7484157wml.40.1692731967561; 
 Tue, 22 Aug 2023 12:19:27 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:27 -0700 (PDT)
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
Subject: [PATCH v7 07/12] virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
Date: Tue, 22 Aug 2023 22:18:30 +0300
Message-Id: <fb37cca76aa8eefde9147e59891dc8ac428948c5.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
index 6946309e40..b9d17c29a4 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -266,6 +266,30 @@ uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
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
@@ -482,6 +506,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
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



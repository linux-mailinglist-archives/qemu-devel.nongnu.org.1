Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA057EDBE2
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:21:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WgS-00020t-Kg; Thu, 16 Nov 2023 02:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3WgJ-00020c-2L
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:20:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3WgH-0005gQ-4p
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:20:54 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so3767785e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700119249; x=1700724049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lu21GTMrE/Fd6RB9xPp7uKaBjCcGX00UOnkKroiWaQo=;
 b=IQqniXPsg8WUojDsBI+JITUD+ddwth739hIPTqo9mp1ZXcuCqLpJOjRrbm4fC0WsN8
 PgmaN6OLDnUk6ewpJAE3NAwYgpIv0E1mysUJVS1GfWOZ2gFOoA0S7H19E3eSUQ0NLU8I
 vGe6ANQieFRkLephp4mBMm+yYldL14Rwrx4XvwB1oMfacwsegx8pGuhcbPIoM3INc13J
 Fpm165XmWcrkdB39GUfWO31X8xO/rCzhZNJ6zAw7L85X3yL71E+R64AuTdVemKC2ihRb
 64DBbUeEq+uWN7N8RbR83DD9I3d+6WcLGKY5GH+hTqnmCyV4Rbe0iuzTpO5siuMdwAJe
 A2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119249; x=1700724049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lu21GTMrE/Fd6RB9xPp7uKaBjCcGX00UOnkKroiWaQo=;
 b=vLpSVoPEzIilOueErT2D9BlOdL4j9kUHh4yzSXDjbPWZb2/dn5NwOmC0qwcXEeBziu
 cYMTOsX608nt+aRKLuZf2PpnMF7T92cUfW53RxeyrWO278GQPnrIRCBJM2yAKXmbT61F
 wq8IDjnBwdu/XlFE07/mXe8wkI+sBX0kVFpKHsj2MdBKjA4XqVftezJvcEaqwQpywZ+K
 PX1OSrJ9AuzcmEwwXst5LLlhibZj7mYeuBpyXvrf9a49qXpL3MOskLyU40aCuOLK1vEg
 QFl+m8Ol2HUJ4N9V/DaiSg6TeFovIM3X/dPMfbd0NbvJ8MuZ/j6kkYd71rQ4rs4Sk6P7
 0M7g==
X-Gm-Message-State: AOJu0YyBUDzd62S7ZxYkyq2Mt8o784r+UbWN2oo5UMG/pWDOIit+rfuy
 Yla/bVUNfRxUT2CGnzR2CXq9x5Y50EYQxycE/J8Y/g==
X-Google-Smtp-Source: AGHT+IEhlLnu4a+Ad+GyLKk3y6WTl6LmLaFQ8Ifz0vOWw9509o6TqFpyIpBVEvRiYM2LCuJoLQG6Rg==
X-Received: by 2002:a05:600c:138b:b0:408:4160:150a with SMTP id
 u11-20020a05600c138b00b004084160150amr1179687wmf.33.1700119249548; 
 Wed, 15 Nov 2023 23:20:49 -0800 (PST)
Received: from localhost.localdomain (adsl-29.109.242.224.tellas.gr.
 [109.242.224.29]) by smtp.gmail.com with ESMTPSA id
 m10-20020a7bca4a000000b00407b93d8085sm2284006wml.27.2023.11.15.23.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 23:20:49 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
Date: Thu, 16 Nov 2023 09:20:46 +0200
Message-Id: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

QEMU crashes on exit when a virtio-sound device has failed to
realise. Its vmstate field was not cleaned up properly with
qemu_del_vm_change_state_handler().

This patch changes the realize() order as

1. Validate the given configuration values (no resources allocated
   by us either on success or failure)
2. Try AUD_register_card() and return on failure (no resources allocated
   by us on failure)
3. Initialize vmstate, virtio device, heap allocations and stream
   parameters at once.
   If error occurs, goto error_cleanup label which calls
   virtio_snd_unrealize(). This cleans up all resources made in steps
   1-3.

Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Fixes: 2880e676c000 ("Add virtio-sound device stub")
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---

Notes:
    Requires patch <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>

 hw/audio/virtio-snd.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index ccf5fcf99e..c17eb435dc 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -36,6 +36,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
 static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
 static void virtio_snd_pcm_in_cb(void *data, int available);
+static void virtio_snd_unrealize(DeviceState *dev);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -1065,23 +1066,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     virtio_snd_pcm_set_params default_params = { 0 };
     uint32_t status;
 
-    vsnd->pcm = NULL;
-    vsnd->vmstate =
-        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
-
     trace_virtio_snd_realize(vsnd);
 
-    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
-    vsnd->pcm->snd = vsnd;
-    vsnd->pcm->streams =
-        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
-    vsnd->pcm->pcm_params =
-        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
-
-    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
-    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
-
-    /* set number of jacks and streams */
+    /* check number of jacks and streams */
     if (vsnd->snd_conf.jacks > 8) {
         error_setg(errp,
                    "Invalid number of jacks: %"PRIu32,
@@ -1106,6 +1093,19 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    vsnd->vmstate =
+        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
+
+    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
+    vsnd->pcm->snd = vsnd;
+    vsnd->pcm->streams =
+        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
+    vsnd->pcm->pcm_params =
+        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
+
+    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
+    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
+
     /* set default params for all streams */
     default_params.features = 0;
     default_params.buffer_bytes = cpu_to_le32(8192);
@@ -1130,16 +1130,21 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
             error_setg(errp,
                        "Can't initalize stream params, device responded with %s.",
                        print_code(status));
-            return;
+            goto error_cleanup;
         }
         status = virtio_snd_pcm_prepare(vsnd, i);
         if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
             error_setg(errp,
                        "Can't prepare streams, device responded with %s.",
                        print_code(status));
-            return;
+            goto error_cleanup;
         }
     }
+
+    return;
+
+error_cleanup:
+    virtio_snd_unrealize(dev);
 }
 
 static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,

base-commit: 34a5cb6d8434303c170230644b2a7c1d5781d197
prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
-- 
2.39.2



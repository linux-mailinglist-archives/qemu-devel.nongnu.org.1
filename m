Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9668010FC
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977T-0003CC-Vf; Fri, 01 Dec 2023 12:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977D-0002vP-SE
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9778-0007lV-2j
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkSuEMY7eg9OPeE/cImzfydS6aY0SjSJDRrKw0XJ32c=;
 b=IpaHU76y4hs9b/srg2atKpcKzfZyOY/LNeUIIG9hUiy4fyE+BUlyPgrq85nnuSzLSTeXIb
 AWccwAbIC1MLkCjk03Cls6ALKYwXKDI+GY/76/EwVj4g82L/sLbSJc3r91EqRzSYWW5rSv
 qCnv5kI9Ljql2F7btEHfPR1FgIWzQzQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-DMQBFfJ_OWyezrJdVXRFWQ-1; Fri, 01 Dec 2023 12:15:33 -0500
X-MC-Unique: DMQBFfJ_OWyezrJdVXRFWQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-333120f8976so1819595f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450931; x=1702055731;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkSuEMY7eg9OPeE/cImzfydS6aY0SjSJDRrKw0XJ32c=;
 b=s/2Rq+br45MS0W8XXssOR0okA7ALtdIW75M/LsIKXVLNFxu/ZITOszYMonCtbMC15y
 bV4H4y0KmJ1d9dKsE5cJ4fPb18StpHH/UScpBUaKMbqwfcaQwVAGGNIFpktScVkOUE58
 +wW17nGoIChblvR+ELpN3Rm0xkA6GB3ZqY54ET2sw2+vClBJSp1SqnFUBh3lkkyps88N
 DdnzGQau3aaG/tsYmEVm4iTQ4e5nIFJUXS9avmPaDuBcO9XG7kQ6C5BlroDEjhWmHgfr
 xLQMn6c7mH89dQAeBiHWT6vo2ACPn+E4zk+eXgBM23NcLx5ZlOuQM//J5nTQI7CvngyQ
 NUhg==
X-Gm-Message-State: AOJu0YxTAGFFpgUN+quMLApXGJnWOs637J9hvUVh22oQSj7JQOXG/mb0
 jisngonfl8u/e6j4Ua3Z0CK5lb7KQOtzbTWvv06Nz2yXhpB1G6zwACOQwb0GVyujMGHW7au/eaN
 c+huHsDWIqZHP3QqLAq0Ne2lSRDUbFjSDebV/BZBkg/fOQQLx+MSXoNNZL/W3kLD5i2Jq
X-Received: by 2002:a5d:6888:0:b0:333:2fd2:3bc5 with SMTP id
 h8-20020a5d6888000000b003332fd23bc5mr695866wru.126.1701450930906; 
 Fri, 01 Dec 2023 09:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh+mncPwZfVHMDg0vl60RbA/AInXSW2HqNIUpYKxXjR6LRh429Rg6QTGagCjGgURj2CKW+ww==
X-Received: by 2002:a5d:6888:0:b0:333:2fd2:3bc5 with SMTP id
 h8-20020a5d6888000000b003332fd23bc5mr695856wru.126.1701450930663; 
 Fri, 01 Dec 2023 09:15:30 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a5d6283000000b0033335cabb9csm228957wru.28.2023.12.01.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:30 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/15] virtio-sound: add realize() error cleanup path
Message-ID: <8cb7b5b8ac46e49c86ada1738e10690e64aeaea9.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

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
Message-Id: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 83e97858e0..3c9f94e94a 100644
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
                        "Can't initialize stream params, device responded with %s.",
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
-- 
MST



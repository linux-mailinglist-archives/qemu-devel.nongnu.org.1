Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500AD74DA1C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIt32-0002ZO-Dq; Mon, 10 Jul 2023 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2v-0002Xa-3s
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2q-0006MN-Mn
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso51989205e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003803; x=1691595803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVoZ+61FKCrNdklMoUuKRwdzJcWCiwu+9oFevqFhgNQ=;
 b=Vr0iX5PBlhO1Adj/4b7VlrHQkVn7GTOo5wyPKAYyOoIZEHmtrmf2CnnHEjUWaj3r5E
 gN1/wrYb3QfFv9cJ7Q+onYHROjTQ7g4Zk2+NvhwEx5lQUiRVDTA3Vspem0wuleZKlBTw
 HxZ5kfqcc4mZ5OGvHc4DKl1bxmJcccfgaf1hFufn/FOtw3wsH314q4Bjfx9ltnd83Dbg
 RvbJfwf39Lt2h6ddlusjcgwbBsceZCUeizDw6Aj5TX5ZaGT/rwtKPWaPWC5SFUqnexVj
 cNOLUD3riwHeX40BdeiIYBWMhiTu09Cv6qL4s4sfSUpe+/RCFyr7dZl0XKiMfrbRFWG9
 2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003803; x=1691595803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVoZ+61FKCrNdklMoUuKRwdzJcWCiwu+9oFevqFhgNQ=;
 b=M4XFUAq8ZIhWit1Fq4cxgw1uzJngQ5eqtvj8fV5RIkHub6nxswGFJmBPufglyYpwXu
 wv2VUDT6F+gEN78AavQsACpbBul0z7uQ9PWT0wZlnfn09HCblKuQFYj+dpTNaEHlO/zU
 IFN4aIBbhfr+u5fMVaKHMqHuvnivlUqLCsbbwAb2Bme+cs+P1gHsMR+hmSSVopLjUK3g
 FgVY4KBAukLkzSIseBH5AzaHy0aOFfn/9amhdRDwvDv7BededZ7lvprq70DcHGbrn/X6
 P3rRFbH0+1nQKl8ngonVjhh0B8vpwwi1rHL0IsLAn+6BBXl5dFZoN1K1XoslKrN0tEEX
 oRSw==
X-Gm-Message-State: ABy/qLbyv23JxHEHlR0OFn35V/J8x9RfUP+UIsaPdcUsN6x562Q3f2yc
 2+6nf1jKEQq/DzcsA8zbdtT1oA==
X-Google-Smtp-Source: APBJJlFV7i5pJ4Xx1ytDGRxyHvenlKG5RJ/M0Ppqrbw83Wt5Nieq4FrA1qclRRUY+8w123UbxzbeLg==
X-Received: by 2002:a7b:c5d6:0:b0:3f7:3991:e12e with SMTP id
 n22-20020a7bc5d6000000b003f73991e12emr12593197wmk.1.1689003803383; 
 Mon, 10 Jul 2023 08:43:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h5-20020adffd45000000b00313f07ccca4sm12027136wrs.117.2023.07.10.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:43:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AFD81FFBC;
 Mon, 10 Jul 2023 16:35:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH v3 20/20] hw/virtio: allow vhost-user-device to be driven
 by backend
Date: Mon, 10 Jul 2023 16:35:22 +0100
Message-Id: <20230710153522.3469097-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Instead of requiring all the information up front allow the
vhost_dev_init to complete and then see what information we have from
the backend.

This does change the order around somewhat.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/vhost-user-device.c | 45 +++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 0109d4829d..b30b6265fb 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -243,7 +243,6 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
 
     if (!vub->chardev.chr) {
         error_setg(errp, "vhost-user-device: missing chardev");
@@ -254,13 +253,43 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
+                       VHOST_BACKEND_TYPE_USER, 0, errp)!=0) {
+        error_setg(errp, "vhost-user-device: unable to start connection");
+        return;
+    }
+
+    if (vub->vhost_dev.specs.device_id) {
+        if (vub->virtio_id && vub->virtio_id != vub->vhost_dev.specs.device_id) {
+            error_setg(errp, "vhost-user-device: backend id %d doesn't match cli %d",
+                       vub->vhost_dev.specs.device_id, vub->virtio_id);
+            return;
+        }
+        vub->virtio_id = vub->vhost_dev.specs.device_id;
+    }
+
     if (!vub->virtio_id) {
-        error_setg(errp, "vhost-user-device: need to define device id");
+        error_setg(errp, "vhost-user-device: need to define or be told device id");
         return;
     }
 
+    if (vub->vhost_dev.specs.min_vqs) {
+        if (vub->num_vqs) {
+            if (vub->num_vqs < vub->vhost_dev.specs.min_vqs ||
+                vub->num_vqs > vub->vhost_dev.specs.max_vqs) {
+                error_setg(errp,
+                           "vhost-user-device: selected nvqs (%d) out of bounds (%d->%d)",
+                           vub->num_vqs,
+                           vub->vhost_dev.specs.min_vqs, vub->vhost_dev.specs.max_vqs);
+                return;
+            }
+        } else {
+            vub->num_vqs = vub->vhost_dev.specs.min_vqs;
+        }
+    }
+
     if (!vub->num_vqs) {
-        vub->num_vqs = 1; /* reasonable default? */
+        error_setg(errp, "vhost-user-device: need to define number of vqs");
     }
 
     /*
@@ -287,16 +316,6 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                         virtio_add_queue(vdev, 4, vub_handle_output));
     }
 
-    vub->vhost_dev.nvqs = vub->num_vqs;
-
-    /* connect to backend */
-    ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
-
-    if (ret < 0) {
-        do_vhost_user_cleanup(vdev, vub);
-    }
-
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
 }
-- 
2.39.2



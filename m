Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26074DA1F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIt2z-0002Ym-2n; Mon, 10 Jul 2023 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2u-0002XG-Fj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIt2r-0006ML-Lh
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so52052015e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003803; x=1691595803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0ilIKM9UzrdIh1IGF/Dd3LVm1ZupBEQeVXkMJAA6OY=;
 b=jxGO4ib/7xl0KK29LlO6eT9Q5mPWTQSH5ZA7JO+oBfOkMqUt48G2424F2Bggu4Y1K3
 eS2gJn5s4IsmfRA6Kc/PilOY0eGLJw4sNZeWsuLAixtkcOazolJEBW7CL/YrIHY8FHJj
 3c+NEJI2MRqwC777n7sf2C9xufCHv0AZAB5dhUfiAkk0XXpqIkTAQ7lR+Z7RWmAsBAJr
 lPTXknQqVPkLZV4RoInWpXcqE/7b7zFU273iwgIKba0oT2gNA8d+ouUl7WzxoWIICMuU
 i+dVpkZfIJq03Kc2NV3o702IJl6f4MErKzukJkkniZ61uOcqlaspvsIWuX4mB8RqtOhn
 UlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003803; x=1691595803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0ilIKM9UzrdIh1IGF/Dd3LVm1ZupBEQeVXkMJAA6OY=;
 b=JMhdxkTmx3jp61XWutaHyi+WjCXNPJcRRKUdXlkj0F1+YjXsO7Gbw06Y7PhU0Cr3Hv
 T1rod3W8KluLrbOpggaer5f/RMcB54pO7pTeHhUXYyVrT/aMgEG3a1Guwh5QCZlYqqR7
 H0bU1kbgPAeCLLg8ySXJpVgBp3/POlRi0lsBmFoU9C/wuWOiDaUYv61NPosJepyPSGku
 byPBo6bbicXRLWxcQqfSF4weJD2fFIm1dysmJTIDIGcHN2/HMw/Fbqju6Y4v9ILI77L+
 OPWI9Z0N6kXmW8VVwIel6rKPR5xteN1LcM3NuTLJm2NQllhBt2Gt9ObcF15deV/1gmjA
 Jw0g==
X-Gm-Message-State: ABy/qLZrFdkZ9cJMAR289xadAu9HNKemZ3H9B0k+knRcCGvRefcVFRwa
 XLS0C9L5c+e6yKzunwW8HchREw==
X-Google-Smtp-Source: APBJJlHUXNHxChY+8roemZ4sSKd6hp54OCTEB/l9M5S7ynqBXXFkvShQjrkEpf0gnIJqjOEwL2qqtg==
X-Received: by 2002:a05:600c:378d:b0:3fc:e1:24b5 with SMTP id
 o13-20020a05600c378d00b003fc00e124b5mr8012473wmr.23.1689003803192; 
 Mon, 10 Jul 2023 08:43:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a7bc7d6000000b003fbcdba1a63sm206655wmk.12.2023.07.10.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:43:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C1731FFCA;
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
Subject: [RFC PATCH v3 16/20] hw/virtio: move virtq initialisation into
 internal helper
Date: Mon, 10 Jul 2023 16:35:18 +0100
Message-Id: <20230710153522.3469097-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

This will be useful if we end up having to consider initialising the
virtqs at a seperate time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/vhost.c | 60 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 82394331bf..971df8ccc5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1382,12 +1382,47 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
+/*
+ * Initialise the virtqs. This can happen soon after the initial
+ * connection if we have all the details we need or be deferred until
+ * later.
+ */
+static bool vhost_init_virtqs(struct vhost_dev *hdev, uint32_t busyloop_timeout,
+                              Error **errp)
+{
+    int i, r, n_initialized_vqs = 0;
+
+    for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
+        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
+        if (r < 0) {
+            error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
+            /* not sure what the point of this is if we have failed... */
+            hdev->nvqs = n_initialized_vqs;
+            return false;
+        }
+    }
+
+    if (busyloop_timeout) {
+        for (i = 0; i < hdev->nvqs; ++i) {
+            r = vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i,
+                                                     busyloop_timeout);
+            if (r < 0) {
+                error_setg_errno(errp, -r, "Failed to set busyloop timeout");
+                return false;
+            }
+        }
+    }
+
+    g_assert(hdev->nvqs == n_initialized_vqs);
+    return true;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
     uint64_t features;
-    int i, r, n_initialized_vqs = 0;
+    int i, r;
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
@@ -1412,22 +1447,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
-        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
-        if (r < 0) {
-            error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
-            goto fail;
-        }
-    }
-
-    if (busyloop_timeout) {
-        for (i = 0; i < hdev->nvqs; ++i) {
-            r = vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i,
-                                                     busyloop_timeout);
-            if (r < 0) {
-                error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail_busyloop;
-            }
+    /* Skip if we don't yet have number of vqs */
+    if (hdev->vqs && hdev->nvqs) {
+        if (!vhost_init_virtqs(hdev, busyloop_timeout, errp)) {
+            goto fail_busyloop;
         }
     }
 
@@ -1492,12 +1515,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
 fail_busyloop:
     if (busyloop_timeout) {
-        while (--i >= 0) {
+        for (i = 0; i < hdev->nvqs; ++i) {
             vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i, 0);
         }
     }
 fail:
-    hdev->nvqs = n_initialized_vqs;
     vhost_dev_cleanup(hdev);
     return r;
 }
-- 
2.39.2



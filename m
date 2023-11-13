Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC17E93F8
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 02:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2LZt-0000Wh-LO; Sun, 12 Nov 2023 20:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LZs-0000WY-35
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:24 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LZq-0003oA-Gk
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:23 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35961c61ffaso14541415ab.3
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699838241; x=1700443041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9oQMwnfds7gwheh540NHUto9x6gbHU1X9JBynkAdpY=;
 b=ev7Aoz0RQQXg4pPjoOFp2SwBvsQxtqYpYRSnGfXD+GiusY4A41crdiqodOZCI/biCh
 4ya+743tVbSlPZYRz3oShYY3odmWeOaenhWJyrjfq0SfiQh/A4UAyvtvvKsw8csb79in
 +a4agFyPaRmAT3Ss34kclFTPwK6HzV9cD3grjKoDRc03ZF2oIC1AEWZWJnAaBFa7eT1J
 KQlXJYYnZmwXHj9eYbkkYBYB2rVfIFOTKoLu/jHe1SsAQIBaqNUHeVEqc/yJ2jRRWYCT
 +JblokgVih09wfKy1KvU/ZyR1dlr6AJ2cw9d/O6a7uvJEShs0joYVfX751+fszSKyfDi
 V2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699838241; x=1700443041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9oQMwnfds7gwheh540NHUto9x6gbHU1X9JBynkAdpY=;
 b=JZARux/8IIh0UPer9tiLR0pTjve6pWlwK3E3gi1WbJE6U9EsU3nrUWBLev6H9Nuw1W
 7KkBK4vA8dhmIcMTSvOMfi7FcuK/95t0WcOE3/Zh+uk+X696KL3FNI1koN0p0c8T0p2J
 OjWUkDi9UVhRDAMSnLehD6+/MEqqRQLpUFluZ0e/CAuL6KPGXKFqqYUjhmvAQ4c1cNYT
 Y8MZkfDEKEgHZ0Cvl5nE1glAJfpOmdFn6gV7MFZEoRIu9hYZgelnSGL5UPbEEcbwJtaq
 5hmiQM9HFVlqfpzmbDTn43lIWDSeZLgbIBnoOINgS7iCUszwBBd/hplVq9CHcqyUz3yA
 1Jcw==
X-Gm-Message-State: AOJu0Ywclfs3jrW9cvK+RiBDEfccK6kwEGn/hsyaXRzhfyauqsDgecNg
 49N+LhRFXdQVLsfqNOJgNzaq+8OJIXX85tPOy2qFQBS33iw=
X-Google-Smtp-Source: AGHT+IHKR4CsnmusKb4AW8oMWPqQETiCSuUuu6u1363qsh76ppVhx48CmTjaAMWqFoSTRHqzkAicMQ==
X-Received: by 2002:a05:6e02:1a65:b0:359:d425:618c with SMTP id
 w5-20020a056e021a6500b00359d425618cmr7979912ilv.19.1699838241202; 
 Sun, 12 Nov 2023 17:17:21 -0800 (PST)
Received: from localhost.localdomain ([128.1.74.235])
 by smtp.gmail.com with ESMTPSA id
 r6-20020aa78b86000000b0064f76992905sm2918511pfd.202.2023.11.12.17.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:17:20 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/4] hw/virtio: Support set_config() callback in
 vhost-user-base
Date: Mon, 13 Nov 2023 09:16:39 +0800
Message-Id: <20231113011642.48176-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113011642.48176-1-leo.yan@linaro.org>
References: <20231113011642.48176-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=leo.yan@linaro.org; helo=mail-il1-x12a.google.com
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

The Virtio input device invokes set_config() callback for retrieving
the event configuration info, but the callback is not supported in
vhost-user-base.

This patch adds support set_config() callback in vhost-user-base.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 hw/virtio/vhost-user-base.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 78cfa9a5bb..a83167191e 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -140,6 +140,22 @@ static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
     }
 }
 
+static void vub_set_config(VirtIODevice *vdev, const uint8_t *config_data)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    int ret;
+
+    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
+
+    ret = vhost_dev_set_config(&vub->vhost_dev, config_data,
+                               0, vub->config_size,
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
+    if (ret) {
+        error_report("vhost guest set device config space failed: %d", ret);
+        return;
+    }
+}
+
 /*
  * When the daemon signals an update to the config we just need to
  * signal the guest as we re-read the config on demand above.
@@ -337,6 +353,7 @@ static void vub_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = vub_device_unrealize;
     vdc->get_features = vub_get_features;
     vdc->get_config = vub_get_config;
+    vdc->set_config = vub_set_config;
     vdc->set_status = vub_set_status;
 }
 
-- 
2.34.1



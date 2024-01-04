Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98915824A16
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:13:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUzZ-0007gA-NX; Thu, 04 Jan 2024 16:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyR-0006vj-1v
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyO-0007SL-QZ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:54 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d88724fb9so10213285e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402591; x=1705007391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUJr8BLQDLPEix8Bguij0E5/vO2xzpMTsHXu8b9VU1E=;
 b=aNDpaX4xV/syJ0BOIdcdBECwNiKxKBmHS+8AoTSFZA2FcfTmUFXRYfxUI1q63xv20P
 KAxacvNESVz6G+xmeolpSSpgkoiNaI3hAoGi68yE05zZ1ZXU7XpEtnij/SsbMZrrpsm2
 AI5B6lzjsSoT93UJKDrbqJOfzb6f6teQnzraek1jh5cisWvWT+RofznY7SATpb06qelu
 YgvBr1N837bhe59SdS58Q5kUXOvhJHKc2NqfozFJZbmBlsAmBlWselVLTFWZ3NDaT9+z
 FkD6Qkv5PWMDker75ZsGa773Dkc/s9KShJXED0AqStlw+48IBRI7e60+IwuAMnqDrv6Y
 u/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402591; x=1705007391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUJr8BLQDLPEix8Bguij0E5/vO2xzpMTsHXu8b9VU1E=;
 b=i7Flu8kw1YwY6YXWSt4GKX2xXC99DmiHYqmqEJf8j4v/KayhKz4TuS0RTKgcXtzHbI
 kLa70YRhtiKWPcndadHuWqHRdqgHevdQnVNvaAkxwQnBlfJ/+d2ZGWUEZhKQLmjrwNgL
 ySVJkbg9xTkjI2+oZfq6Mtm489huNGZstCoCOu4q8xFBGdoEUU3uov8TAIIlB/T6mFJp
 SyRDKqzQLs9SPt4V1qBUOmS+0GFIRfy9q3lMYNA12ZGor3DL8X9s0RUyixUwvYOuETE7
 7hWcomz+TfO4srIXmXC5NBUhaaLe9ghG/vgYIScFKMo1KL9WOxyUf0tUZn02fslKFVHa
 x1Ww==
X-Gm-Message-State: AOJu0YwQBYrJAjkfMoGkxE11X1/mvo1HEYBUGa816Vg5aXrkSv1O4Iub
 1ZWO7qAhtEMdEueSad4C6n7wb9jELIEmgg==
X-Google-Smtp-Source: AGHT+IHIPMTwnUuD18EpXCpeIsVSMmw0nk/XMTOqLFP7apwR//nI3xeuercqEuI8WWhBtv/qhVsLpQ==
X-Received: by 2002:a05:600c:a45:b0:40e:3511:2c39 with SMTP id
 c5-20020a05600c0a4500b0040e35112c39mr674820wmq.172.1704402590686; 
 Thu, 04 Jan 2024 13:09:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c0a0a00b0040d91fa270fsm352701wmp.36.2024.01.04.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D828E5F940;
 Thu,  4 Jan 2024 21:09:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 08/11] hw/virtio: Support set_config() callback in
 vhost-user-base
Date: Thu,  4 Jan 2024 21:09:42 +0000
Message-Id: <20240104210945.1223134-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Leo Yan <leo.yan@linaro.org>

The Virtio input device invokes set_config() callback for retrieving
the event configuration info, but the callback is not supported in
vhost-user-base.

This patch adds support set_config() callback in vhost-user-base.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231120043721.50555-2-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/vhost-user-base.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 78cfa9a5bbc..a83167191ee 100644
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
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE07EA341
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cCk-0002dL-4B; Mon, 13 Nov 2023 14:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCf-0002d4-Ut
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:34 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCd-0000Ki-5K
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:32 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41b7ec4cceeso27832551cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699902150; x=1700506950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9oQMwnfds7gwheh540NHUto9x6gbHU1X9JBynkAdpY=;
 b=M2ajJyqkCwRwWifWXQDJKrticpN6AaK1rVJmE7ZLew2NefgoQr7IjqMMmhSBfp/8+H
 aCkQaB+x+5jIHF4FjjYFluMN/bxdeOuUuGRkxDagCGekar7RZRuvYrq5DQbF2C86nnkJ
 +iF7FF6rPmmOXbi6oo+3nD2lcsr1ihsYSRIuqbIugPh+WnTRe3NehfDU7T0csdx/2RLO
 mwMi2HvsxmhUQBUBF8AsQy2CbNBCOF83m13HkSe6wrP4xnVXH5Rg+77nR4Jw2sVOZSkV
 R8wbr3jPjY4meLunUspjaV+WInbxrasRVbc1xXlRfr+KQIJqxyt0keMpHlAwwgPVdoJs
 dAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902150; x=1700506950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9oQMwnfds7gwheh540NHUto9x6gbHU1X9JBynkAdpY=;
 b=kbDYjoPTwTgR8SHyfqGxKHNHilCWHODM0jfgO9610ZtnmmYh0+fN+PpQBqhBfA3G+r
 7JfEOUJ0mYivxZFzZiC4oKe//9ksRYkYUk8MrfgP8t3BdILSSgV5DT0O0IBr781PLV0b
 cji40AEepKrrsblTKrb+5evgQ3Yv8FwzSLunEGXslMjsKt+RJcydCTdoL1CGZyaxm8s+
 c1d52pGmwsyUGjd9JWlcZ96PF1PpcsoY7sEZDwassNMc3oklLsK1g7xiazk5rVyFGkdN
 +DlvzjOtn8HSODpCci3ksuP0nZe613cyy5/P9UVQkqOPlGoIAyQPgqT1Iwg+iuJL9YfI
 yfWw==
X-Gm-Message-State: AOJu0YxWvRyqgJn99Y22Hedtr/jTfARDV2KYNXti5Kdg7VU7oXoarW9J
 EFooQjdwfT9DTYaAdrzYTw0wdQt+Vsh2R/5JqzbJ8GyfwBA=
X-Google-Smtp-Source: AGHT+IHPoFxzYvVu79GJZPGxA5Gn5C5BIkMBWS6C0V1ERvKXH7v6HeU/b6exAxFcVLjf11W+t7xeaQ==
X-Received: by 2002:ac8:5a83:0:b0:418:194a:f9fe with SMTP id
 c3-20020ac85a83000000b00418194af9femr9009254qtc.62.1699902149795; 
 Mon, 13 Nov 2023 11:02:29 -0800 (PST)
Received: from localhost.localdomain ([12.186.190.1])
 by smtp.gmail.com with ESMTPSA id
 kq4-20020ac86184000000b004181c32dcc3sm2124834qtb.16.2023.11.13.11.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:02:29 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] hw/virtio: Support set_config() callback in
 vhost-user-base
Date: Tue, 14 Nov 2023 03:02:08 +0800
Message-Id: <20231113190211.92412-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113190211.92412-1-leo.yan@linaro.org>
References: <20231113190211.92412-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=leo.yan@linaro.org; helo=mail-qt1-x82e.google.com
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



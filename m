Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F36B74DA08
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvj-0005xh-DM; Mon, 10 Jul 2023 11:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvX-0005qS-E5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvJ-0004np-Gx
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31434226a2eso5489673f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003336; x=1691595336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hje6WZSjT0couLKOVg8pz8KNazy1XWWPGcIUxlVXlw=;
 b=dScf+GYEj3ctwO9WuCXFy0yxJ3B0LV0V0i8bC1r6JpbiaAldVwo/K8eKPwhd/jg/pI
 2jLPNATky/tXkRu2pPN8+ioJ97SQUzIlDpQLrxDSlvwfVfWbThhbQrbNBYSEtrCnRtL5
 D7roIwllb2KQ2lhMVeuxvMyeE2bCgCOyJkHj3vWjkJEK1eQXm1PDbsr1y9RPsbHqxK3g
 g4i9CY2MWPTZZ7n5c5jqdl6l5dtXGUHtrMNgwnkAFio/uKQe5zWfwF+Y7TdFKDOJDEbr
 Vwxa/MDPutQf07jM78ZWbk5VhP2xZwFAsmcLSL7K34PP8WESfI9RNkae8oYxfTJ0FcqJ
 n/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003336; x=1691595336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hje6WZSjT0couLKOVg8pz8KNazy1XWWPGcIUxlVXlw=;
 b=juLsGsN2GYm+88d9Xng2f5LLd/5xLMWRSE9ycmgrsOsOcq93SjcKOn/3D4hvWut0VJ
 S32kp7t1tkhXR3TnLmNLydqiUZq9uqpdLMlmPZM9xdYM5zZD7CX2X6uLmjpnb28XW23R
 88l0VxB+M8il4OagXimRbzyqJX8V7LP2lj1V1LpfGBN624M9sy82YFz5WAlGy+WMX6b8
 7AM9YqPIx430jkQQb9/AuK01HhwkOHTeHtRsURPS2WL3gxSKx9OzYI8tcbpAmdMxX9rW
 WjLlQCjj6q4KayW18Jl6CIweR+0qMXOV+uGksh4yI+Eff5jhmyvPNupJA8smoa7vMpO/
 hySw==
X-Gm-Message-State: ABy/qLZMuG9sA+dmPUgWXZuoRA8smlmz9+SHaYyhMdF4RPv44yf7xbmM
 xnT6dJnBvUzlIt1FLYpnOcweqg==
X-Google-Smtp-Source: APBJJlHosrDV4/fj+buzQzqyeFYq6lRgxzw+ioERIOpcbRimrQjw+84hQismSCjZ+W0apNrUO0J75w==
X-Received: by 2002:a5d:52cc:0:b0:314:f7e:8755 with SMTP id
 r12-20020a5d52cc000000b003140f7e8755mr14618439wrv.55.1689003335788; 
 Mon, 10 Jul 2023 08:35:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k6-20020adfd846000000b00314315071bbsm12040583wrl.38.2023.07.10.08.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 553FF1FFCC;
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
Subject: [RFC PATCH v3 18/20] hw/virtio: validate F_STANDALONE also supports
 other protocol features
Date: Mon, 10 Jul 2023 16:35:20 +0100
Message-Id: <20230710153522.3469097-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

If the backend advertises F_STANDALONE validate that it supports the
other mandatory features or error out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/vhost-user.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 28b021d5d3..3116b3e46a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -74,6 +74,8 @@ enum VhostUserProtocolFeature {
     /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
+    VHOST_USER_PROTOCOL_F_XEN_MMAP = 17,
+    VHOST_USER_PROTOCOL_F_STANDALONE = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -2048,6 +2050,21 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             }
         }
 
+        /*
+         * If the backend supports F_STANDALONE we should validate it
+         * supports the other features we expect. We can't check for
+         * F_CONFIG support until we know if there is a config space
+         * to manage.
+         */
+        if (virtio_has_feature(protocol_features,
+                               VHOST_USER_PROTOCOL_F_STANDALONE)) {
+            if (!virtio_has_feature(protocol_features, VHOST_USER_PROTOCOL_F_STATUS)) {
+                error_setg(errp, "vhost-user device expecting F_STANDALONE device to also "
+                           "support F_STATUS but it does not.");
+                return -EPROTO;
+            }
+        }
+
         /* final set of protocol features */
         dev->protocol_features = protocol_features;
         err = vhost_user_set_protocol_features(dev, dev->protocol_features);
-- 
2.39.2



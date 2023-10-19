Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759B7D03F0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:25:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTp-0005Oh-80; Thu, 19 Oct 2023 17:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTn-0005Hu-JG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:55 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTl-0001Ut-A7
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:55 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso1797631fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750571; x=1698355371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAIq9fwE+HBUXOdrKkuK6NI9pJuWSCDleAybIfCpGM4=;
 b=PSuRZZvtf/+4cQrSYMjvDM7kQElQpNV6uK/avnGzAbJXwrFDiC/Bci0nSzsV4LZ7I9
 HvFD0mnHWN9n1hwMYcZV2+KXQXpckSyFWtYVgDwMFTiRTCFcEObeofWY71IBZ8gyHAHJ
 d4oMjjLWAPhR5P0m8PSD8pc7MLwaRHejZZLUC7uc8QEkhOGgIEUPpas5qGw9RaJL72S0
 NslZa95f99EzPUheeKs4KVE++3HCDB/6p9UJRR2DXnZSKGUg+qKJSGzNnHwhqHsPjdXU
 mQ8wGxzQsYSphPom14JxSufvIh1PIHI5vBbnpn6kk4cwWWsEvIGx/ewz7OsfPMlU/iIx
 82cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750571; x=1698355371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAIq9fwE+HBUXOdrKkuK6NI9pJuWSCDleAybIfCpGM4=;
 b=WzZI1FhWHmG+vjYFTDRfEyazdQm5yCNKIJfXrP0PkIKQLLWPs+g6Q5a5bz8aWNhh9r
 pFgVGjN3xO8WiKsWLQdDNVuCBQptWqt9ufSNoZNYnbFkuwmNvkoIqwoqBmaFqA+GnEzf
 2Od86amHjj2t8gLHXJzWAaqjc1xWFlvm3iEr9NcZaxDeFbB+9YCOPcmK5v707MuctBHV
 lF5U9RsptHUI+Dp2594zTlGsbMBLoa2Sxvcv8BLo20i5KKtd0YEgtx+WMoyE6pTx70bi
 yjQPJ9R3R0nhLp15FLzEh7bckUJXMOOE3Ett/tzfT9MXl7HapdGUbRS+2+y2FuGjmPf8
 RW7g==
X-Gm-Message-State: AOJu0YyNecpp0evbpOxGeuZK8KZjUr7rnyL9Cj6xbopuzLxV8VvCT/rH
 0CwzCmXZpH+PZsiNN8ShrROl+8LldfeEdxq84TYHCg==
X-Google-Smtp-Source: AGHT+IEvM29YYW7XZ9xfDYVKMt9CprgzlQ9QcQMDhD/d9BVWcUiwsL4Gee5KW9NmDyP3bfmnF4H7nA==
X-Received: by 2002:a2e:3a03:0:b0:2c5:1482:719a with SMTP id
 h3-20020a2e3a03000000b002c51482719amr133394lja.21.1697750571533; 
 Thu, 19 Oct 2023 14:22:51 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a05600c150c00b0040586360a36sm5254311wmg.17.2023.10.19.14.22.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 41/46] hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE()
 macros
Date: Thu, 19 Oct 2023 23:18:06 +0200
Message-ID: <20231019211814.30576-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Access QOM parent with the proper QOM [VIRTIO_]DEVICE() macros.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231017140150.44995-3-philmd@linaro.org>
---
 hw/block/vhost-user-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index eecf3f7a81..4b37e26120 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -405,7 +405,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 
 static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
 {
-    DeviceState *dev = &s->parent_obj.parent_obj;
+    DeviceState *dev = DEVICE(s);
     int ret;
 
     s->connected = false;
@@ -423,7 +423,7 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
     assert(s->connected);
 
     ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
-                               s->parent_obj.config_len, errp);
+                               VIRTIO_DEVICE(s)->config_len, errp);
     if (ret < 0) {
         qemu_chr_fe_disconnect(&s->chardev);
         vhost_dev_cleanup(&s->dev);
-- 
2.41.0



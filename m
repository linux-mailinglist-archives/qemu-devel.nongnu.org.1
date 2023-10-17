Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC707CC57F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskeI-0003zw-9y; Tue, 17 Oct 2023 10:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskeD-0003yP-P6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskeA-0008MC-8Y
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so5047461f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551328; x=1698156128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7R3ShGuEPvQsYMJ+sC0uKzUQHXrwcjcpcC+wh9jeQo=;
 b=fQ1fBQCwqY6aUlwdW7UDuH77GInRel443gr4dloLqxr055WFYebtDGSJI0GceqlrEv
 C9ZNxk/isWLsm0SjpEG8G9GEjd1Qv0kedttqluzabjGwD1YL3Gtr4Ks4Ug9BD9x9Y0Ew
 sEdgyxX29y+67IZxUpr4u4kzijPnT4IAPJ2Z34pEFwEa2PAff/Wypp50Vn+DpVAYIK14
 t5SWgbEdGeyv6dRRrqPjWTDPfCpp12SBpYgjlWuxie+S3CiFBmEC7e5tV+VQjs0Av6kw
 QTPmva+slRGEa+U8l64grud/ctDIeABGUxSD6KriOfz06W6pdFxL1RKbWJf50H6lI9Jg
 mxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551328; x=1698156128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7R3ShGuEPvQsYMJ+sC0uKzUQHXrwcjcpcC+wh9jeQo=;
 b=UGDzcGzvdeF3VMevFI59d5XDC3rJ1ZYT9sufpby9Hrh3xEEv2m4wSIEF+sBgBoeUu4
 /Bjl6ziBAOUWD3EjKNXmYjfp7kyaP3OxFTeiP0xGl7LYfdenNo05yhPT+5j5tAGDI2V6
 PhrpXT4XaO9Jv+gnrtMvirz5fGT2PdMt9JWiF+RLR5m+7Jqou03N6pMVC4xl8ik+keaV
 zqUZyMOgEuvrV809ELCFaxKHcQs/LwtjBEpMy72L7a4Dfru6SFVf0O9xpUepOiYrlT9Q
 AemsdfyLcCMnX6Gg4xwCgiSAl/RS9DL09ym+WQzB2oSVHsuNmVm8jT47x8UZ4wkg293f
 G1Gw==
X-Gm-Message-State: AOJu0Yx7asVOxeBOgfTP1gp9FmnPfRjVINkrr9IgW7RMM4nXXTkLqDlJ
 3xvV/6oIAEvNvRqklG5s5H3SZZYCGriNXXIFelI3Lw==
X-Google-Smtp-Source: AGHT+IEYn4+LuclmkKRHORiND9cC5xRSMqaBci1mv6L3hiu+9suatqZQQ0anISsAFrdixPBr+8OWHQ==
X-Received: by 2002:a5d:408c:0:b0:32d:a818:a74d with SMTP id
 o12-20020a5d408c000000b0032da818a74dmr1952521wrp.47.1697551328607; 
 Tue, 17 Oct 2023 07:02:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 p5-20020adfe605000000b0031fb91f23e9sm1752461wrm.43.2023.10.17.07.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE()
 macros
Date: Tue, 17 Oct 2023 16:01:45 +0200
Message-ID: <20231017140150.44995-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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



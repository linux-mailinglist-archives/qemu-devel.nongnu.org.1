Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE07CC578
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskew-00054K-0F; Tue, 17 Oct 2023 10:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskem-0004OL-JA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskei-0008RF-Kt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso2280392f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551359; x=1698156159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NToGoJ6Wynf9U+JMhRHgYhmueSEj1NaVzBYgpFOz3E4=;
 b=ud+JuwQq1dph6KsVXgWvspTQVI7sdDS3ycspcbTA4YwwurxLANaNIB6FsnvepHr7fX
 2MYfvF49fVzTptSTTeusr5O6e0Egr0RIeyUhmVpZ32V5p+uB0/Nugd63oD/4wkb1Kqk/
 J8eOjbsWY3XgKRsRBebsK4nCGhy2E+uKev06hDx+EWV/urBhuBzghfqd5alMcQxIfw2B
 c4TENnQhggLvnnaMQhecFUMDyDJnWG/6N8rNtG7lkt1hythIW5Oa7EyVGbs4wOpJtYjn
 JxIRdtQD9fzS6HzIXscCLAN+keWIVrLYbmP1VStmLbVSUDmoHDpxosQqEBXBeFSiSFYG
 +IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551359; x=1698156159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NToGoJ6Wynf9U+JMhRHgYhmueSEj1NaVzBYgpFOz3E4=;
 b=c+uLL0LZIQBK/ZG4YTF0MZyfkRRZTJLd0GHTcBE+aRwxtHBM3x60PcJBHeiqzL7mGU
 Zjo/cyIY9+QhRtGGJ2mAbX3WpTEfExbLestN3Cc6G2E9vY45cgOkf/gx9K65N9NroIOA
 Ks0oDuuMQXZs2fYkSnZcrLucshuqxaVu7okXFtlfW1w9H8S9KrmBSeoxzpJ4KbxHLFPF
 651HRqew5VduUykOatXpUk7Ez4ZFbuEarUKfVMeHJqROV71LWVtt4Z+7Mgco527gsbdh
 n9DI4voTiZSFqAE9zva38VN45q5GwpgFdve2PMLb1tQRQ7Wl6ZtTNxuJVDQ+EvlfLIFD
 +rSQ==
X-Gm-Message-State: AOJu0YzesZ6LFpLx2SMKB1AEWM0jLHZLwGzPcr+Yqcy5z2KrWfN7jSQj
 eDo3bpwAuZSBYs2eDiW1B5HpnAAECvbLVYBreFgyRg==
X-Google-Smtp-Source: AGHT+IGhgG0b3reIcu7lWBb/lz877Z4WbBMxh0rskgGJApF6w4nMLlruOttAl8rOuMA3za6q+pCy/Q==
X-Received: by 2002:a5d:5107:0:b0:32d:937c:9ac9 with SMTP id
 s7-20020a5d5107000000b0032d937c9ac9mr2373929wrt.31.1697551358060; 
 Tue, 17 Oct 2023 07:02:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a5d6751000000b003200c918c81sm1735455wrw.112.2023.10.17.07.02.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:37 -0700 (PDT)
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
Subject: [PATCH 6/7] hw/net: Declare link using static DEFINE_PROP_LINK() macro
Date: Tue, 17 Oct 2023 16:01:49 +0200
Message-ID: <20231017140150.44995-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Declare link statically using DEFINE_PROP_LINK().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/cadence_gem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f445d8bb5e..37e209cda6 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1654,11 +1654,6 @@ static void gem_init(Object *obj)
                           "enet", sizeof(s->regs));
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
-
-    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
-                             (Object **)&s->dma_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
 }
 
 static const VMStateDescription vmstate_cadence_gem = {
@@ -1691,6 +1686,8 @@ static Property gem_properties[] = {
                       num_type2_screeners, 4),
     DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
                        jumbo_max_len, 10240),
+    DEFINE_PROP_LINK("dma", CadenceGEMState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0



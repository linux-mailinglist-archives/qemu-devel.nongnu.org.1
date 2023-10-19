Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA947CF0EA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:17:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNHG-0005B5-7M; Thu, 19 Oct 2023 03:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNH3-0004zQ-Kp
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNH0-0003CS-OP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso10967625e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699809; x=1698304609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG/eTeWn+OzUtyx8iBSPb0Amcuu5LlJ9K/x3TvIXfKM=;
 b=LMTy28ilQ4PoOMyTvYA2M5rnGT0R0/HVQydI9FutXMXoovWq4qcPQPdg1iHItGy+jq
 MoSI+taehZIBbjJEipGErf0Dnj5diwcPRzKeKg3vQs1S5MTw3LO2Hk6bDCqhleQMUX+C
 3Du3VQmlb7LZHow6U0p/xe6FC/AYRtbz2P9g2SrHxuNEGj7fW0DX5mHtNewToNZErJYG
 abL+XtOh2VCBGFKdd2AKZp/b5jQsz9NX0Sgy7tWUbMgtSx3vs6QT5Xu1BEF3Y465YQdy
 c56HjY18zGk7QQyn3dZFVPRJvSZPGtpC1H+P5yMLHWNjn/1V2eHNvqVs2RCVJHGs17jd
 afnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699809; x=1698304609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OG/eTeWn+OzUtyx8iBSPb0Amcuu5LlJ9K/x3TvIXfKM=;
 b=U0a/xiu/e9Vyuitwic6hSczBHflMqY9uXK2UCvvIDHo+Kj7XBWgnZX6QpPJTIUFUyv
 s+XMj39vqTSJ2Ghk5MH+usTZHXAaQs/6u2v1xXEDQuxkhjdTC2MAoMildUM+IZejptFV
 UslpMXZM/ggTPyD7rgsswCEya2vAVb85FUQ3rNxShcgvZqmQtJkAoBLfOQb7N/yLwCC8
 jms1/KRbHGkseCkY6bkmlYbt1a0ZS30+MVD8WrqFUtg0z1NJ+2JFZJVQSGgtdYE4Q2nc
 tIIz5bappq2iBHfnqJ24+Gl5lXTy5SHhfp/KtRfVexPfF/N0F/C+6JLQVwCFQJRCnaOF
 OG1w==
X-Gm-Message-State: AOJu0Yx3q4eF3Ey7AB8k7QKv7LlCDj8tRX/PoVK0PWvgYokx26sVLC5T
 RfgyXyqyKdmuKI4NU05E+hQgJWOd0+do9CflDMyjJw==
X-Google-Smtp-Source: AGHT+IFRphPgz/cSzbKF11fcElSyD1nEqeTSRPuX8tC6CR1/f/6RFtKKwS3QnPhdBl0+B2RgyvnPCA==
X-Received: by 2002:a05:600c:3587:b0:408:3a67:f6f5 with SMTP id
 p7-20020a05600c358700b004083a67f6f5mr1130034wmq.18.1697699808913; 
 Thu, 19 Oct 2023 00:16:48 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040813e14b49sm3620516wmo.30.2023.10.19.00.16.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:16:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 03/12] hw/misc/allwinner-dramc: Move sysbus_mmio_map call
 from init -> realize
Date: Thu, 19 Oct 2023 09:16:01 +0200
Message-ID: <20231019071611.98885-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

In order to make the next commit trivial, move the sysbus_init_mmio()
call in allwinner_r40_dramc_init() just before the corresponding
sysbus_mmio_map_overlap() call in allwinner_r40_dramc_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/allwinner-r40-dramc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 6944f84455..2cc0254a55 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -414,6 +414,7 @@ static void allwinner_r40_dramc_reset(DeviceState *dev)
 static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
 {
     AwR40DramCtlState *s = AW_R40_DRAMC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     if (!get_match_ddr(s->ram_size)) {
         error_report("%s: ram-size %u MiB is not supported",
@@ -421,8 +422,12 @@ static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
         exit(1);
     }
 
-    /* detect_cells */
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s), 3, s->ram_addr, 10);
+    /* R40 support max 2G memory but we only support up to 1G now. index 3 */
+    memory_region_init_io(&s->detect_cells, OBJECT(s),
+                          &allwinner_r40_detect_ops, s,
+                          "DRAMCELLS", 1 * GiB);
+    sysbus_init_mmio(sbd, &s->detect_cells);
+    sysbus_mmio_map_overlap(sbd, 3, s->ram_addr, 10);
     memory_region_set_enabled(&s->detect_cells, false);
 
     /*
@@ -458,12 +463,6 @@ static void allwinner_r40_dramc_init(Object *obj)
                           &allwinner_r40_dramphy_ops, s,
                           "DRAMPHY", 4 * KiB);
     sysbus_init_mmio(sbd, &s->dramphy_iomem);
-
-    /* R40 support max 2G memory but we only support up to 1G now. index 3 */
-    memory_region_init_io(&s->detect_cells, OBJECT(s),
-                          &allwinner_r40_detect_ops, s,
-                          "DRAMCELLS", 1 * GiB);
-    sysbus_init_mmio(sbd, &s->detect_cells);
 }
 
 static Property allwinner_r40_dramc_properties[] = {
-- 
2.41.0



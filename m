Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B917CFA72
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSms-0004wn-Od; Thu, 19 Oct 2023 09:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSma-0004N6-BT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmY-0007bT-Qh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso7085965f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697720985; x=1698325785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3Wrm2+hEgcQGJPeHM5sv3LDR90OXcyWyLu0fpUZ2rw=;
 b=zbK9Zyo417DCzyH8E4A2HqVhjOUKdl3LFcSRuAj0WoDsv5eHBCDCMtpLheDO6Iy6fJ
 2UQBb/wFbEXf/J1V7NkpTbd1gVVRirNQkErukNcO/9rST5QWUhZipCO40GjqYzQE2yim
 Mf9lh0NitDKZIfPqBjmFAFjL0KMQumHvDUjYjj33IImM7f6+Lnn7baha9O2U/JZRCtc/
 SSweHfJhqk6P1AFaEqgh2SmqVc9zEMXaHl/FYEeueJQFJy7PrpdmAdQqHQybk298gtrS
 gKMtfdbUlE0juqPMOh6Kq+ATOgUt8ZNfKFslTz0d0/H0i1FbmH052alT+Jpf7wZfEq/L
 XKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697720985; x=1698325785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3Wrm2+hEgcQGJPeHM5sv3LDR90OXcyWyLu0fpUZ2rw=;
 b=o9wPyL7LC9SmriqJ9yG18r3bBkKah6YJ24EI3yPDmFEwj+uPnHdJS9g5nnFOR5lWeR
 dEVBxeQ/rE0vzZveCtG5FLvl9g1khhfA+GHcNKjyWNK8MQ6V6xGCdlucwPGO59o5Flyf
 4wYLztY/rN0fzSQAuy3I8EMAghj8wc23ifOtm1xg5ttdpJsYg2N9Mc7KWZmWj1xNn7Yb
 GSWqPWfyqGyDpgjaWSgWB5vcd2Z0HMFuAeGYpmgfXUz/H0IJQ3rXxsEhMAsjmLW4RK3c
 p1nQ6Lacw/IygfTFQHi04kgB26YM6O3bsnHzRVRQzXejQza5zAaZcsfY/gC4jadK6BrA
 tIlw==
X-Gm-Message-State: AOJu0Ywu8t6dzzv3qHqs8CRqrbkg9LkoXQ/ELlDhuTDqMheMmUpJhDru
 83l9uv99Qe0pFxcOYydGKq3K9aZsxQdeuPQLy39gFA==
X-Google-Smtp-Source: AGHT+IH8VKmpFMKpWsr5yUKLtS3GjfrEb3jNSIq11op5ZVpQw4bpWTJo6zuFMfsxvlH63u2VmuJxCw==
X-Received: by 2002:adf:db4b:0:b0:32d:b06c:80b5 with SMTP id
 f11-20020adfdb4b000000b0032db06c80b5mr1581493wrj.2.1697720985190; 
 Thu, 19 Oct 2023 06:09:45 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a5d66c1000000b0032dbf99bf4fsm4439609wrw.89.2023.10.19.06.09.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:09:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/9] hw/pcmcia/pxa2xx: Realize sysbus device before
 accessing it
Date: Thu, 19 Oct 2023 15:09:18 +0200
Message-ID: <20231019130925.18744-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index fcca7e571b..e7264feb45 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -142,15 +142,12 @@ PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
                                       hwaddr base)
 {
     DeviceState *dev;
-    PXA2xxPCMCIAState *s;
 
     dev = qdev_new(TYPE_PXA2XX_PCMCIA);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    s = PXA2XX_PCMCIA(dev);
-
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
-    return s;
+    return PXA2XX_PCMCIA(dev);
 }
 
 static void pxa2xx_pcmcia_initfn(Object *obj)
-- 
2.41.0



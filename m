Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D337A46C8
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBKF-0006I6-80; Mon, 18 Sep 2023 06:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBKC-0006Hi-7N
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:17:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBKA-0006nu-C8
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:17:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3808291f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695032268; x=1695637068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+N+N/3iRKVrfEHVPUQcucmLszQ7ytIQTEiwcco5Pois=;
 b=R6YxzazMzK0pyfjwwiHM9RVk2MMjey8oBDhjW/fpjUzLkhZYYJCr25tewfft2L+yeA
 yuL+sLmxgnyX1pI3O4/ZulhFh48pvZIGO8DQ8PIFs1O+NkS/C86tSG6bJM1zH7ayoyLu
 +vpOEJDjlTpCzyJb4FUHGb07zzVdVRI4jw3KoAtPCYIF2atsoaT/Vcpyiym5uTlokO85
 hsI4ZU+TcySkH4bk1MJ4cQ0yFmCLvIiFPG7kxrhtYSQzuduTMOC1gp7/245hr3okYHdn
 VIMlSWfzUbwXxit9QC2lClyRF7XnWMp34RM5Qv6V5afA3WpatRjuIHtGESp59X5VSd1Z
 EJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695032268; x=1695637068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+N+N/3iRKVrfEHVPUQcucmLszQ7ytIQTEiwcco5Pois=;
 b=FZsCgjWl2/jZHmZXDx3/ilJ/ca2D7reOL/koOPafzUbAUHG4tNiU6p8ILtPSGmvGZU
 0fdNPacG8NYJzlRK13BZrAHGLKZ7eGDBul3mwpyCUlAhyuq0x2UJotJh3FG4xuGpElcK
 VS7oMeO+nJ7fAEnCdqIj/KIapOcT2dduGYJDtDR6oiXpqerts4br1ceeGFlhN+pRHZzE
 YIQM0YXGTyFJcuTUXykZo7lHokBLH0i/pzD9uCkb9bC5xs6wggAPdQ8od7yqkTDTxhCE
 4258eawA/wAp4aA8Ro9HYVZbRcr/GVWqTYIf3tpXMoaWi7rprPaeJLSUVSP5AqhIjVeM
 GHTQ==
X-Gm-Message-State: AOJu0YyNRGoE2FpyrbpzBy1S2OIC3ADzDjRPgos6X9EKKUojLeDgCCd9
 PazGTXklmHgJEjRqnHgfAW9VHnFACuEpVdf9I8Yxlyz9
X-Google-Smtp-Source: AGHT+IHWMSpr0y6MCVX2hooNyuRT1fVi428WYsZ88A7x03zFL0krS2oMP2+1KEjkccO2CaSgsJp+4Q==
X-Received: by 2002:a05:6000:703:b0:320:121:2300 with SMTP id
 bs3-20020a056000070300b0032001212300mr5316225wrb.1.1695032268227; 
 Mon, 18 Sep 2023 03:17:48 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 z2-20020adfd0c2000000b0030ada01ca78sm1139386wrh.10.2023.09.18.03.17.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:17:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/sd/omap_mmc: Do not reset SDCard until being fully
 realized
Date: Mon, 18 Sep 2023 12:17:35 +0200
Message-ID: <20230918101736.23905-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918101736.23905-1-philmd@linaro.org>
References: <20230918101736.23905-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We shouldn't call QDev DeviceReset() before DeviceRealize().

Since the OMAP MMC model is not QDev'ified, it has to manually
call the SDCard reset() handler. This breaks QDev assumptions
that DeviceReset() is never called before a device is fully
realized. In order to avoid that, pass a 'realized' argument
to omap_mmc_reset(). All cases are explicit manual resets,
except in omap_mmc_write() where we expect the sdcard to be
realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/omap.h |  2 +-
 hw/arm/omap1.c        |  2 +-
 hw/arm/omap2.c        |  2 +-
 hw/sd/omap_mmc.c      | 21 ++++++++++++---------
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 067e9419f7..d331467946 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -808,7 +808,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
 struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
                 BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
                 omap_clk fclk, omap_clk iclk);
-void omap_mmc_reset(struct omap_mmc_s *s);
+void omap_mmc_reset(struct omap_mmc_s *s, bool realized);
 void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover);
 void omap_mmc_enable(struct omap_mmc_s *s, int enable);
 
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index d5438156ee..3afeba6f86 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3728,7 +3728,7 @@ static void omap1_mpu_reset(void *opaque)
     omap_uart_reset(mpu->uart[0]);
     omap_uart_reset(mpu->uart[1]);
     omap_uart_reset(mpu->uart[2]);
-    omap_mmc_reset(mpu->mmc);
+    omap_mmc_reset(mpu->mmc, false);
     omap_mpuio_reset(mpu->mpuio);
     omap_uwire_reset(mpu->microwire);
     omap_pwl_reset(mpu->pwl);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index d5a2ae7af6..ef9b0dd60a 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2253,7 +2253,7 @@ static void omap2_mpu_reset(void *opaque)
     omap_uart_reset(mpu->uart[0]);
     omap_uart_reset(mpu->uart[1]);
     omap_uart_reset(mpu->uart[2]);
-    omap_mmc_reset(mpu->mmc);
+    omap_mmc_reset(mpu->mmc, false);
     omap_mcspi_reset(mpu->mcspi[0]);
     omap_mcspi_reset(mpu->mcspi[1]);
     cpu_reset(CPU(mpu->cpu));
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index edd3cf2a1e..3c906993eb 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -287,7 +287,7 @@ static void omap_mmc_pseudo_reset(struct omap_mmc_s *host)
     host->fifo_len = 0;
 }
 
-void omap_mmc_reset(struct omap_mmc_s *host)
+void omap_mmc_reset(struct omap_mmc_s *host, bool realized)
 {
     host->last_cmd = 0;
     memset(host->rsp, 0, sizeof(host->rsp));
@@ -314,11 +314,14 @@ void omap_mmc_reset(struct omap_mmc_s *host)
 
     omap_mmc_pseudo_reset(host);
 
-    /* Since we're still using the legacy SD API the card is not plugged
-     * into any bus, and we must reset it manually. When omap_mmc is
-     * QOMified this must move into the QOM reset function.
-     */
-    device_cold_reset(DEVICE(host->card));
+    if (realized) {
+        /*
+         * Since we're still using the legacy SD API the card is not plugged
+         * into any bus, and we must reset it manually. When omap_mmc is
+         * QOMified this must move into the QOM reset function.
+         */
+        device_cold_reset(DEVICE(host->card));
+    }
 }
 
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
@@ -556,7 +559,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         break;
     case 0x64:	/* MMC_SYSC */
         if (value & (1 << 2))					/* SRTS */
-            omap_mmc_reset(s);
+            omap_mmc_reset(s, true);
         break;
     case 0x68:	/* MMC_SYSS */
         OMAP_RO_REG(offset);
@@ -613,7 +616,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
         exit(1);
     }
 
-    omap_mmc_reset(s);
+    omap_mmc_reset(s, false);
 
     return s;
 }
@@ -643,7 +646,7 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
     s->cdet = qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
     sd_set_cb(s->card, NULL, s->cdet);
 
-    omap_mmc_reset(s);
+    omap_mmc_reset(s, false);
 
     return s;
 }
-- 
2.41.0



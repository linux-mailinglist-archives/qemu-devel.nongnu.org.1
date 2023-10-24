Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87C7D4A16
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCoQ-0001fk-DM; Tue, 24 Oct 2023 04:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCoM-0001fY-J3
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:50 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCoK-0001CN-G5
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:50 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso62310381fa.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136246; x=1698741046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=he7WJqvEltVxRP8YaDhG1VvbH+UnVaFuryry2MF/wd8=;
 b=PyHYI7+SqssB5XC7I33R4At8I/pAynzuNYJ8Nt5er3Mmtm9BJ9odugLiZibx9VjSi9
 v6R6aDEBzjLCgugg/8LT0pU0Qw3OdPJ9nYi0ltw4XG898DJCc0hm7nQJA/T/F5PQsbtE
 aqSuaMOGKskeG/sLFqq7q1ZlhW4hNM33SWh3dn6z804Y/tUaBsIOrwwDd8n3w3i5ESGn
 ASuzGuvwzcsPhKuzg8Ota6eosxUVQRWB7XibMXKp4pPVSexOHomhzdJg3OOcmZHtJnlr
 7LMRdDQay6axalNZaw5iTqKJO0ylLzFxWhI64mFnNhJa8eWmeoDflcNR0X/tCu8WrfpF
 kLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136246; x=1698741046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=he7WJqvEltVxRP8YaDhG1VvbH+UnVaFuryry2MF/wd8=;
 b=mTGAVJuvNprW79+4ootmXKkn9sty5/VLHJptrgKuBVKVv3q/6TFehxtstSvzbkEBHo
 fqKwlWDE1cgDyeaTs8pvg3xuFcBDW2+NN9G7ShRYQ95OfcyNsxFbLt/Cc0TvdqN74Qbr
 jBnXLuROoPSYo5sTNwQ+00XGICk8PAqrgSjBnEh5UyN1o9+1aME10MZu29Zal8QvUcXA
 uSSqC83GxNr2gCRh7/VJiNRU301TDJ9yeSqPM2/+BbKLgV/hWMiIAbASp/kQus2iCnBd
 YS7QSHq93m24ci9crohsLLyW7qIdQ74j+SGB2NCxfYx3rpe9dFju5b7EetFs9kvyBwy9
 3CIA==
X-Gm-Message-State: AOJu0YxFpqqWuG5rsCieDwkMuqRrwv2G1Gj93J+LEoC9rzupuIwVAh2l
 1+eqMkznkIln/zPDc0/9bzSZ5OIQ+u/J00C5x0Q=
X-Google-Smtp-Source: AGHT+IGg4Ef1pcPeGA4RRPgBEWCkFAyk5IKSRmuZ3gdLMQ6kUo1WvkyLxh5ovudHfVP46FOZEx4esQ==
X-Received: by 2002:a05:651c:a0c:b0:2c5:24a8:c22d with SMTP id
 k12-20020a05651c0a0c00b002c524a8c22dmr11253759ljq.3.1698136246643; 
 Tue, 24 Oct 2023 01:30:46 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b0040775fd5bf9sm11594619wmq.0.2023.10.24.01.30.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 6/6] hw/m68k/virt: Do not open-code sysbus_create_simple()
Date: Tue, 24 Oct 2023 10:30:09 +0200
Message-ID: <20231024083010.12453-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024083010.12453-1-philmd@linaro.org>
References: <20231024083010.12453-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Mechanical change using the following coccinelle script:

  @@
  identifier dev;
  expression qom_type;
  expression addr;
  expression irq;
  @@
  -    dev = qdev_new(qom_type);
  -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
  -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
  -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
  +    dev = sysbus_create_simple(qom_type, addr, irq);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/virt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e7dc188855..2e49e262ee 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -201,11 +201,8 @@ static void virt_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_TTY_IRQ_BASE));
 
     /* virt controller */
-    dev = qdev_new(TYPE_VIRT_CTRL);
-    sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_mmio_map(sysbus, 0, VIRT_CTRL_MMIO_BASE);
-    sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_CTRL_IRQ_BASE));
+    dev = sysbus_create_simple(TYPE_VIRT_CTRL, VIRT_CTRL_MMIO_BASE,
+                               PIC_GPIO(VIRT_CTRL_IRQ_BASE));
 
     /* virtio-mmio */
     io_base = VIRT_VIRTIO_MMIO_BASE;
-- 
2.41.0



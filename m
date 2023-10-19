Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E717CFA84
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSnA-0005h6-3k; Thu, 19 Oct 2023 09:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSn0-0005OE-30
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmx-0007z8-QH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so72834785e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721009; x=1698325809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG5zLlWN/LC4pJbPVJoFLnGQz4i0tpH2bVvTXsYTeOI=;
 b=RWD6Xe2o+7QqJPE/q0O/ioZ6oa6/FeioX42H3ci+ZkC0xlXqvGcWUdZPtG6DohKyMM
 4YXeJ/ZyYJcXuxV6Y5ANEfh1Sw/qDjFkvcpMk67/FfQDC29D31VHzpnFrGCfowrKI7BM
 DdVxZEetBnixBT1MLTp7waEkZ218k9hZACsybrywvFrjReWYGhNVTjjirNJWU6DUzwQ3
 iKjj1szTRt7THElIGZYDXPxe5vRSjNRY34IDpCFGQIasITr6uWGtlX5mAbcxhrNe7/Si
 IJKKSscCj/qxnuJ71sudOtkctqbuaozrYKo7eFD1BYlxu1kibz4mggJMFNgu+5ltpHSK
 Ch3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721009; x=1698325809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG5zLlWN/LC4pJbPVJoFLnGQz4i0tpH2bVvTXsYTeOI=;
 b=LW6m9ZdOV8a5A8kqw7Anu+SjIlNbVrH/Q5O+eqr0TeMNncvj5cN8eKdpZuVVHMBA7w
 50tDYUIVjyc1IpnU+jqPJaaD0+ronBiFx873rBVLMB8k+ylD8xsA2dxLc90Ow654eEqS
 a5jnxOwaxFM7V1tnb0t08vQk18oB3UItKe+LnbwVgN5E5a5mfjYsjZwY4+hdM3QuHG0k
 Vw6M28XD2vnBUqSCLbThN3UFsIICSvrYcvIXvw14o81hx+Ra0ON73cdGBh+hyoT2FpXF
 QC6SpeL8YSN/UyMhqI/qUWNdPZTAeuLwuSRUKoOprjwMXpuBLRS2Ew9aos8uqwl9mzSW
 +7FQ==
X-Gm-Message-State: AOJu0YzvVlc5M/qS3qjGvEMzouI3lpoMqytCkLxx5ZZYbpu6N/I4hv17
 6VmdKfx7h0vIJxTPzs3ZA6mSW3mMuwsfuX2AsV2Ycw==
X-Google-Smtp-Source: AGHT+IGguIz8HbEEBSOgkoYgF/ZH0ySW9aMvXrUwrP1ergEhLHkHT1zMRiSJKeZZiU21k24B/gca1w==
X-Received: by 2002:a05:600c:a07:b0:408:3f64:6553 with SMTP id
 z7-20020a05600c0a0700b004083f646553mr1746777wmp.16.1697721008600; 
 Thu, 19 Oct 2023 06:10:08 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a05600c459000b00405391f485fsm4456618wmo.41.2023.10.19.06.10.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:10:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/9] hw/intc/pxa2xx: Pass CPU reference using QOM link
 property
Date: Thu, 19 Oct 2023 15:09:22 +0200
Message-ID: <20231019130925.18744-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/pxa2xx_pic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 2eb869a605..7e180635c2 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
@@ -288,7 +289,8 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
     PXA2xxPICState *s = PXA2XX_PIC(dev);
 
-    s->cpu = cpu;
+    object_property_set_link(OBJECT(dev), "arm-cpu",
+                             OBJECT(cpu), &error_abort);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -321,11 +323,18 @@ static const VMStateDescription vmstate_pxa2xx_pic_regs = {
     },
 };
 
+static Property pxa2xx_pic_properties[] = {
+    DEFINE_PROP_LINK("arm-cpu", PXA2xxPICState, cpu,
+                     TYPE_ARM_CPU, ARMCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pxa2xx_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    device_class_set_props(dc, pxa2xx_pic_properties);
     dc->desc = "PXA2xx PIC";
     dc->vmsd = &vmstate_pxa2xx_pic_regs;
     rc->phases.hold = pxa2xx_pic_reset_hold;
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CCE7D0E01
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnAI-0006Zi-I1; Fri, 20 Oct 2023 06:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnAA-0006SG-Ro
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnA2-0005KZ-4t
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so483776f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697799320; x=1698404120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlikVhR9pm9KIliEUk0Cuop74S2gqM0uH/MGQp63tm4=;
 b=FtPgTjijBRfyLhqK9MA1yCgZSwNSBRjtcErE6LCxH/phcPMuwiUt3yRJFTzxXDkxIy
 lNa+lu2qN/Cqj1qhp8bQ4YfpHv78zjLLFhoy4+ljWlP5zVzeLjVQ64x95u1Wzw/xVLw4
 dxySL53XZdKd+sQEQlDFif7mrW8R3vRZ2tfoJmfo9HIq4Dp2+z+WJQb0fLIygVbzDJyf
 qPzHEnb7C6FLPi6LcZX+XdmOskczEzX6r2el5X4J049O2zbCRkwiG9bAshAQJXFb3aQE
 S/6yWHCJlW5sA1C+SVHfqShf6axI1XpjfOA+9W6OZyY2bHxgxpDe3Vk/llB1l8ZJgSid
 7A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697799320; x=1698404120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlikVhR9pm9KIliEUk0Cuop74S2gqM0uH/MGQp63tm4=;
 b=tZh5ME4h0dfCMwTnM9v4BtQf0p01uab9LqCtdlXKSAfW94PdiEpAyzsNxTmbNa3NBg
 ou21mcqgN+MzD19TQySHk53TYZwPDaCidmPCThG0a3FWH8fHyCOPgKNKDuvDe2cMj62+
 NWebqyQZLmhNC6qnoo2FhVW0+9sFEV91AHDA6Tu+hCasmntrLgGatHTXtbNfANXzIU79
 iPO7VvJF8t2CLuEDB/ygVFacXhAqPpnk1p6wZyVpnoWOckwF77ahmj13e5FT4g3w1SOK
 DTlv1qFTfKATlzlWPlsXwTrVArMrLdlV/1c9yiaz1pDW/ssjNrdmOPaV9x02JeSSRLVc
 NyCA==
X-Gm-Message-State: AOJu0Yw0AHE4pZP1wre/lmYVXOYxHWggzgvzosJ7w6ljTz643qm5Ot5j
 YlKAUhjAi6apFs3ajxnn1qmLShwPQngGuW2A9s0=
X-Google-Smtp-Source: AGHT+IFdMcbjKySFcFf6Iz8CRJFdnI2dFAuBBBbfhEeSCqeurkykPXFGP3Fa9mbl6JNN0999eDzYhw==
X-Received: by 2002:adf:e590:0:b0:32d:8357:42dd with SMTP id
 l16-20020adfe590000000b0032d835742ddmr1043121wrm.68.1697799319888; 
 Fri, 20 Oct 2023 03:55:19 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 h2-20020a5d5042000000b0032d886039easm1444297wrt.14.2023.10.20.03.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 03:55:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 5/5] hw/mips/jazz: Inline and remove legacy pcspk_init()
Date: Fri, 20 Oct 2023 12:54:46 +0200
Message-ID: <20231020105447.43482-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020105447.43482-1-philmd@linaro.org>
References: <20231020105447.43482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

pcspk_init() is a legacy init function, inline and remove it.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/pcspk.h | 10 ----------
 hw/mips/jazz.c           |  5 ++++-
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 9506179587..6be75a6b86 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -25,16 +25,6 @@
 #ifndef HW_PCSPK_H
 #define HW_PCSPK_H
 
-#include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
-#include "qapi/error.h"
-
 #define TYPE_PC_SPEAKER "isa-pcspk"
 
-static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
-{
-    object_property_set_link(OBJECT(isadev), "pit", OBJECT(pit), NULL);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-}
-
 #endif /* HW_PCSPK_H */
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c32d2b0b0a..cdc37126c2 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -177,6 +177,7 @@ static void mips_jazz_init(MachineState *machine,
     SysBusDevice *sysbus;
     ISABus *isa_bus;
     ISADevice *pit;
+    ISADevice *pcspk;
     DriveInfo *fds[MAX_FD];
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
@@ -279,7 +280,9 @@ static void mips_jazz_init(MachineState *machine,
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
+    pcspk = isa_new(TYPE_PC_SPEAKER);
+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
+    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
 
     /* Video card */
     switch (jazz_model) {
-- 
2.41.0



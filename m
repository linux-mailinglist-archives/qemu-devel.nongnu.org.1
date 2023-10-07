Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD37BC79F
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aJ-0002qg-1F; Sat, 07 Oct 2023 08:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aF-0002q8-C9
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:03 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aD-0002kU-Ol
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:03 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so533750166b.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682340; x=1697287140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTKsd4QCtNkgXD/Z781AtMarzdn14SdPNuf52xlMXyc=;
 b=URIhcmuxCrhkxcdH1WgGsP+Sb8mlqznRZsHj9EYctprIAq0da2vECe3A+0rIkrEKRW
 M9IO5s8Gt3GlLM1Jj+yN65S5J/1xdBkRhMo1w75kFVhG1Cs6EbzHu2LT0FFThxiV45oo
 7bJWtNwiN7OoykP7khPwFjQtopFBiM6HLWyezr50lCMB8H6qd3er7CPFTI6H8G3gM3F6
 dBosBa/PawPlYf1DDikbITD9qDPLF4LSdv6CW4pImRfAWYpVz6e2VsgB5MKNwSltRTUx
 nQ9Zwy26FOrwr7i+ZXh8jNep9KXRAQyx4b4VX4tP8O4OYLNR3ufh9Xc+kDK0Qnhwt7UU
 PisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682340; x=1697287140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTKsd4QCtNkgXD/Z781AtMarzdn14SdPNuf52xlMXyc=;
 b=gDkHhSQBqtndnVNrAS5NMVXzNySlzuh9O+UBPg/IhMkJramJ1l84gAJHRa+S6Lyeuj
 IRfaurDg0516rwWCkqW6d79YvNuvTtplpfv8oKkiZj9aQD0SYphNnaz3Kfr5e9yCwAFA
 xQgSqeasC0nWQYLpZiHhOgm8AtnR5lYaShhsbIwp0t0b3sfH8blrmT2/lGvUHYBeeyOf
 cWYz8X0DpjFzEMfF7usB24tRvFssa00RAhfoLXJ8lCKgbksC2mXCbgyQnq5mR9LyFK3Y
 BUzkB2o70gfxGXBFGPO9Gy2iRF0M+6e55ba5pejQlsSc71HS+e1MOrLSFAKOgIiloH/e
 OmVQ==
X-Gm-Message-State: AOJu0YwxUOYcIaSNk4GySbXvCHTJFlKAOwAOZH2Fr1xZ5m0x/84+graw
 pOP6nIwsRMbH/ykbwAZ2gAotsUzAw1o=
X-Google-Smtp-Source: AGHT+IGImYMSJIoFJQzLKUF1+HPqIyQT9iJapsGPaIjLfIGFtINbilJ63iyHXB4ocC9yZT52jw2bjQ==
X-Received: by 2002:a17:907:7603:b0:9ae:3d56:1ef1 with SMTP id
 jx3-20020a170907760300b009ae3d561ef1mr10020576ejc.8.1696682339941; 
 Sat, 07 Oct 2023 05:38:59 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:59 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 07/29] hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
Date: Sat,  7 Oct 2023 14:38:15 +0200
Message-ID: <20231007123843.127151-8-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

TYPE_PIIX3_DEVICE doesn't instantiate a PIC since it relies on the board to do
so. The "pic" attribute, however, suggests that there is one. Rename the
attribute to reflect that it represents ISA interrupt lines. Use the same naming
convention as in the VIA south bridges as well as in TYPE_I82378.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/isa/piix3.c                | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index bb898c6c88..b07ff6bb26 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq pic[ISA_NUM_IRQS];
+    qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index c17547a2c0..616f5418fa 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -36,7 +36,7 @@
 
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
-    qemu_set_irq(piix3->pic[pic_irq],
+    qemu_set_irq(piix3->isa_irqs_in[pic_irq],
                  !!(piix3->pic_levels &
                     (((1ULL << PIIX_NUM_PIRQS) - 1) <<
                      (pic_irq * PIIX_NUM_PIRQS))));
@@ -312,7 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
-    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+    qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
+                             ISA_NUM_IRQS);
 
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
-- 
2.42.0



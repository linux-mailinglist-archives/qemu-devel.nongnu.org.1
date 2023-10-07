Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3987BC7BA
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6am-0003MT-6r; Sat, 07 Oct 2023 08:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aQ-0002sD-VD
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aO-0002mC-Ln
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:14 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so559808066b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682351; x=1697287151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLuRhETE2fQnG1NeR539twN0V5knh5QS69IeRjUD3vk=;
 b=GFxZsopWydtkMV08OBmVWbLz3uwUoqaAIn59jyb6lAQ7HWMyVvjiS2GGHlYcqHlUtv
 6iMS5HPddZk2UnLGDdNvR+HUtg/Jk16hooPmwf9YLLupYw3w0wr0SU5Kt/lTP5UR7jHL
 +bpiLSHzEuIRDt2RG+bwhMmXY4AGV82KNdIyYFK1LZLCt3czA4GpIeu6DvFdPSHigAVL
 479B+pkUmdYsQXTX19llApgOfnk/I8PIH9OZ/ffyjZknFpIIXC4g6pg9GX7OvEVzH10j
 T/11gOWulszNO089m/MG8jEhZFyhdRsbJHOcEb+P9wkH5YkgS/MxZphyviNW4bq4Zgh9
 tkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682351; x=1697287151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLuRhETE2fQnG1NeR539twN0V5knh5QS69IeRjUD3vk=;
 b=vvclWFg7UUU7yI0tx3P7bdjptPY4fjVXCQHbG5aXaTsf42khzlwC5vwyyHc8bsQr42
 76nfTDUaCVdRZITL64/dZ8AqtleLZbEI4trszmTamTdeigve3fzpy65Vhed+9wc+uSex
 1N1bdM01IrxBgbFRNYmfvpAh+UE06+aVDSNRgGMh3iPihuxztIRKXv6gpUG9DkZZ4jh6
 gRDgVVjckPOLsy6bAfxRCzpF0SoiDgAGC1r3yVeRza+cm9SVKDSOUUb870CYQEo4ox6+
 EUX4aCaSSUEVr2+9GTXHuz8vSlZWzO3O86HggbXUOw4u1gfCgV+sGZNbACqRAul2gSSG
 13Sg==
X-Gm-Message-State: AOJu0Yx2NvmCwmG0bU92LUcGX1PXBDhedN5rr8jLG4pAO6WQVi42+W9d
 ux3k/vuQe6iHwiQwXXqx7gs5PrH9+WI=
X-Google-Smtp-Source: AGHT+IHxfyREnkqRwFRL6qRyto9O0ypdyFX95nCFHHt9h2El0ZZcwe5oUXLmHAkx7J7I2WnsG09VNg==
X-Received: by 2002:a17:907:7818:b0:9a1:ddb9:6546 with SMTP id
 la24-20020a170907781800b009a1ddb96546mr9274009ejc.61.1696682350765; 
 Sat, 07 Oct 2023 05:39:10 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:10 -0700 (PDT)
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
Subject: [PATCH v8 16/29] hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
Date: Sat,  7 Oct 2023 14:38:24 +0200
Message-ID: <20231007123843.127151-17-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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

Rename the "isa" attribute to align it with PIIX3 for consolidation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/piix4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 3c3c7a094c..9c8b6c98ab 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -45,7 +45,7 @@
 struct PIIX4State {
     PCIDevice dev;
     qemu_irq cpu_intr;
-    qemu_irq *isa;
+    qemu_irq *isa_irqs_in;
 
     MC146818RtcState rtc;
     PCIIDEState ide;
@@ -75,7 +75,7 @@ static void piix4_set_irq(void *opaque, int irq_num, int level)
                 pic_level |= pci_bus_get_irq_level(bus, i);
             }
         }
-        qemu_set_irq(s->isa[pic_irq], pic_level);
+        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
     }
 }
 
@@ -201,10 +201,10 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* initialize i8259 pic */
     i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
-    s->isa = i8259_init(isa_bus, *i8259_out_irq);
+    s->isa_irqs_in = i8259_init(isa_bus, *i8259_out_irq);
 
     /* initialize ISA irqs */
-    isa_bus_register_input_irqs(isa_bus, s->isa);
+    isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
 
     /* initialize pit */
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
@@ -236,7 +236,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
         return;
     }
-    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa[9]);
+    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa_irqs_in[9]);
 
     pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
 }
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5767BC7AA
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aj-0003Au-Nf; Sat, 07 Oct 2023 08:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aS-0002u4-CI
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:16 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aQ-0002mo-Ql
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:16 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so668405966b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682353; x=1697287153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hm2St5TpRyD2Ckf2ixWKhHCdQrygnANyVkd+tNFb2ig=;
 b=IJCqMQZRGgrILFsUJCL6IKD2oplI/pqlEhG/R1GJFPZSG17yRJfB13VFOKF+cfjuAj
 zzSVBUSzrvpN+QNbM0ASiX5OcateJX0wNsHLtAVqA+v89mAnKwgAyP6curJtfxaUntC8
 C8IochBxqJDOpq9IKMF8jL8fCF6ZolMFH3FQhEFAY+e4tZhTRlIiq+1C8M4WzoGY+Pup
 YRbfvKml2kWIboIdCpRbd5oIamYpMnAKTJ+lURHsC44XyeiLfGbDfF9JMaS2oTl0Nahl
 +ggtHoLRoDLOIzgZQ95xQO2BVYAvaH6Uoy4GgbsUsSXj+M4dNwQv2ylECcDqTZCIT1o6
 IgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682353; x=1697287153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hm2St5TpRyD2Ckf2ixWKhHCdQrygnANyVkd+tNFb2ig=;
 b=ozS0KF3KvDR8WPidRRlQrGvNGGY/7n+Hw5N7U5TXQ+9B80YRTpxGGQv6hp7EtHoOIX
 i71B3/KfjeacHoW7DsN7JMwcOjb7KznKd6vyGZkPVr3Ov3GlmFwASVcLB2o19q8fCcyK
 G7VXNVviaOpgk5rLySlhJQow5gEA1Wye9w9RMMGlVjKA/KO+Y5kvddo0LKJaAiGc0NfR
 7ggFunLkgMnI7SnWexVT8KWBwmA06b1ILAAx/wBDzyqy3HPfTCbSt8loLVMKbPnSWXFd
 tEeZ8gir4hu4F5h8I6f64FDB14y5XdBHdq+le/rABKM5b0uMrGmUv8KB8P/+d65B3b09
 BApg==
X-Gm-Message-State: AOJu0YzS46P5g24slET7t2vcVOtszQ8KLDYKVd8IeaNKOiGdfPQ9UMs/
 qUpBmFizFkMUxJViUnsSx+oLR+GntiM=
X-Google-Smtp-Source: AGHT+IHh6oXEDsFSXcYjJ3A0CDlIDhjwmUYdAWkVEIuyy+EUyStOS0I8CzhRic2ro5OdaVHjbCCKHg==
X-Received: by 2002:a17:907:7e97:b0:9ad:8a96:ad55 with SMTP id
 qb23-20020a1709077e9700b009ad8a96ad55mr6245442ejc.14.1696682353045; 
 Sat, 07 Oct 2023 05:39:13 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:12 -0700 (PDT)
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
Subject: [PATCH v8 18/29] hw/isa/piix4: Reuse struct PIIXState from PIIX3
Date: Sat,  7 Oct 2023 14:38:26 +0200
Message-ID: <20231007123843.127151-19-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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

PIIX4 has its own, private PIIX4State structure. PIIX3 has almost the
same structure, provided in a public header. So reuse it and add a
cpu_intr attribute to it which is only used by PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/southbridge/piix.h |  1 +
 hw/isa/piix4.c                | 26 +++++++++++---------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 0b257e1582..dd5f7b31c0 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -49,6 +49,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
+    qemu_irq cpu_intr;
     qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index eb456622c5..71899aaa69 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -42,21 +42,9 @@
 #include "sysemu/runstate.h"
 #include "qom/object.h"
 
-struct PIIX4State {
-    PCIDevice dev;
-    qemu_irq cpu_intr;
-    qemu_irq *isa_irqs_in;
-
-    MC146818RtcState rtc;
-    PCIIDEState ide;
-    UHCIState uhci;
-    PIIX4PMState pm;
-    /* Reset Control Register */
-    MemoryRegion rcr_mem;
-    uint8_t rcr;
-};
+typedef struct PIIXState PIIX4State;
 
-OBJECT_DECLARE_SIMPLE_TYPE(PIIX4State, PIIX4_PCI_DEVICE)
+DECLARE_INSTANCE_CHECKER(PIIX4State, PIIX4_PCI_DEVICE, TYPE_PIIX4_PCI_DEVICE)
 
 static void piix4_set_irq(void *opaque, int irq_num, int level)
 {
@@ -184,6 +172,8 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     PCIBus *pci_bus = pci_get_bus(dev);
     ISABus *isa_bus;
     qemu_irq *i8259_out_irq;
+    qemu_irq *i8259;
+    size_t i;
 
     isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
                           pci_address_space_io(dev), errp);
@@ -201,7 +191,13 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* initialize i8259 pic */
     i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
-    s->isa_irqs_in = i8259_init(isa_bus, *i8259_out_irq);
+    i8259 = i8259_init(isa_bus, *i8259_out_irq);
+
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        s->isa_irqs_in[i] = i8259[i];
+    }
+
+    g_free(i8259);
 
     /* initialize ISA irqs */
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
-- 
2.42.0



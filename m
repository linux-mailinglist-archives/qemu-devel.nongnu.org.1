Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F07D14A8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtt5m-0000pX-SG; Fri, 20 Oct 2023 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5l-0000mM-Bz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5j-0004Sr-EG
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so8975175e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697822118; x=1698426918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8OmoVLEg4TfDxQv28vslF4GB3HmpguafbZuBCuHq6Y=;
 b=JhBhlq3ntrJPytQrRcj9v+2IU+s8/uTnfLdHJZG3g32/yhlDzjYBA2y3vJrFBzByaN
 Dog+S+oOvhjNO0/4V3Z/ZTe4CNrMnR4Pcv+xBfhKnSvwgTy3WkTb3sjwtEkC0xg3yST9
 oXG1nT3Y7HKCfMshELLBKGgCKw/zROsNYoj7+UyjQLx4/9z+VfMj1EP8Ney0XKfRz7cZ
 nIFC6bTNgfCuHrRR+Y2LYg0hU57OzQoYuxYxIE0ZtUQQWv/gzyfv0gOBtSjgfwcY+yTB
 QtqVi1/0VxZvam0QWWWM6AwLSq/WZsIKtwL7Ix2cNRnQKefapMZ911lqkcu+wyrxxrzD
 1XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697822118; x=1698426918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8OmoVLEg4TfDxQv28vslF4GB3HmpguafbZuBCuHq6Y=;
 b=sjBqCM15+Jg1FUZ1UtWQBr6vXlrYIxXLmULIpuxQEBddAsMiQRGDUM5THP+Nee5qAO
 jfS7hgug1dtGe3Tr4qXHuFfpZKzDLo1uKcFr0zR6W27HmqraFn6ncSxIlp3vGjWpO1Q+
 dORIoER2EBRFvvgnv0tR/r6Am7TeHnQEuZzqUk2skoRxh7+MAnVTkcx9pVdWuKvwF1JY
 u3Dvg+NpMyX51j8WHCyxPAJSmZE9RpIsw/3YEFtm3JaFltKB4tslbCdJn6UQANEURTkd
 jgSJ8NJv9FEEyD82kkcQ3GU1bWQmxTwVfUl5gB5q5kU7FTjl/KYK6nxSY5AepA8wN3bl
 YHoA==
X-Gm-Message-State: AOJu0Yz4ylfJxK7W2l0gE3bF+eJU87/eV0+PuwGnXsRZd/suYYyFFIHa
 HE95MDHGzZP2OunH6jWiBr8ty/virymMSjXA81E=
X-Google-Smtp-Source: AGHT+IHAth6q2Yqgfkyft2IzvQOO8RJW+gCmUJU/f5MaLkf5Ek8bUvHC4lnuPJodNw8r0PMalUpcUQ==
X-Received: by 2002:a05:600c:19cb:b0:407:5adc:4497 with SMTP id
 u11-20020a05600c19cb00b004075adc4497mr1871420wmq.9.1697822117728; 
 Fri, 20 Oct 2023 10:15:17 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d50c4000000b0032da319a27asm2117375wrt.9.2023.10.20.10.15.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:15:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/4] hw/i386/pc: Pass Error** argument to
 pc_basic_device_init()
Date: Fri, 20 Oct 2023 19:15:05 +0200
Message-ID: <20231020171509.87839-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020171509.87839-1-philmd@linaro.org>
References: <20231020171509.87839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

pc_basic_device_init() creates devices which can fail,
allow to propagate error to caller.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 5 +++--
 hw/i386/pc.c         | 7 +++++--
 hw/i386/pc_piix.c    | 2 +-
 hw/i386/pc_q35.c     | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bec38cb92c..069c27368d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -174,11 +174,12 @@ void pc_memory_init(PCMachineState *pcms,
                     uint64_t pci_hole64_size);
 uint64_t pc_pci_hole64_start(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
-void pc_basic_device_init(struct PCMachineState *pcms,
+bool pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice *rtc_state,
                           bool create_fdctrl,
-                          uint32_t hpet_irqs);
+                          uint32_t hpet_irqs,
+                          Error **errp);
 void pc_cmos_init(PCMachineState *pcms,
                   BusState *ide0, BusState *ide1,
                   ISADevice *s);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f7ee638bec..2481c11e83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1189,11 +1189,12 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     g_free(a20_line);
 }
 
-void pc_basic_device_init(struct PCMachineState *pcms,
+bool pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice *rtc_state,
                           bool create_fdctrl,
-                          uint32_t hpet_irqs)
+                          uint32_t hpet_irqs,
+                          Error **errp)
 {
     int i;
     DeviceState *hpet = NULL;
@@ -1291,6 +1292,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON);
+
+    return true;
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e36a3262b2..0d9cdf773e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -320,7 +320,7 @@ static void pc_init1(MachineState *machine,
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
-                         0x4);
+                         0x4, &error_fatal);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a7386f2ca2..e4b05e3139 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -301,7 +301,7 @@ static void pc_q35_init(MachineState *machine)
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
-                         0xff0104);
+                         0xff0104, &error_fatal);
 
     if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-- 
2.41.0



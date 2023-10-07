Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24187BC7A9
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aj-00037T-Am; Sat, 07 Oct 2023 08:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aZ-000326-7g
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:23 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aV-0002ng-2J
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:20 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so8919872a12.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682357; x=1697287157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtpYpujhvvkSWUrWERoFFt7eVjobeT/TB7O7zxbhWS4=;
 b=DTFP2r1qufTrvBSrq5sDwy/7DEObeS3Zp8NdpwfcTtU17AwxRgkS34/gt/Nzbg89uG
 nO5ekRAGacTnr5ld7u9rdS/zHncT1o4Rq8wrI1p2sXOHS1addSyrlM89ls6pHdOFVAGO
 QArTiKJGue9McMzgY5n22Eew+8sG8DJoh+2SjB4Ved110sbqonIuCLbkk/xl/m7gRmfZ
 xDTJQ36Q4ZYsZqBim6Xc2J3pHqYXcWwzbY3W8jlcrIWJotwntVyuvkX4WGtNDwYhJ0A+
 hbjrylb0sMSmaXki33vHoVnk7BNBiRaXJ0XdsBgt1EwtAZCNAr/RprQ9Eow9wN8iE4K1
 NMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682357; x=1697287157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtpYpujhvvkSWUrWERoFFt7eVjobeT/TB7O7zxbhWS4=;
 b=jFN7cLybtzYjlrS9lQOpcyOxz3nvQ7HgCemy5vWGn0OB4FTjLOQKXb+D3Q+80AhE7i
 zWbLe3BYgjh90CQPSMIaIH9MuDStVfGKqguP1ICEsjxunaOn48m/HADp7xi6qTOWfAIe
 EigpHH18WG+L8uEKENMHUZTMjg6v0HQTyzPa6XxlxcbS2xi4XQQJRcXIbZU2B+w1+IjV
 gmSEXDAeNIlQ/ox0xldycFXiwbY2YwM+0G2CBp/oCu9MidCiX74I/zNpeD7HqY493s1L
 xPG1fn+MO+fGiSUuSXIqnFuuuZLpjP0mutVf8W4SnQWerp2aHRgt2JnlWziZneQFTtWc
 05iQ==
X-Gm-Message-State: AOJu0YwX5rt72on2S/oOkWE87o9F5GXdGO7NwLNw8sG4bfBja26LTTrC
 ZQyAhGS3RkEMrL7R6CHdwnEO7QKuJFU=
X-Google-Smtp-Source: AGHT+IGDQo+KBJqkEFE9/ep1MVqAa5O3cLlaDixYGcbrUGQGiYx0WL+OjGgd+jByb/JPnwE074HOVw==
X-Received: by 2002:a17:907:3da3:b0:9ae:614f:b159 with SMTP id
 he35-20020a1709073da300b009ae614fb159mr6177696ejc.36.1696682357001; 
 Sat, 07 Oct 2023 05:39:17 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:16 -0700 (PDT)
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
Subject: [PATCH v8 21/29] hw/isa/piix: Allow for optional PIT creation in PIIX3
Date: Sat,  7 Oct 2023 14:38:29 +0200
Message-ID: <20231007123843.127151-22-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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

In the PC machine, the PIT is created in board code to allow it to be
virtualized with various virtualization techniques. So explicitly disable its
creation in the PC machine via a property which defaults to enabled. Once the
PIIX implementations are consolidated this default will keep Malta working
without further ado.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/southbridge/piix.h | 1 +
 hw/i386/pc_piix.c             | 2 ++
 hw/isa/piix.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 08491693b4..86709ba2e4 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -70,6 +70,7 @@ struct PIIXState {
 
     bool has_acpi;
     bool has_pic;
+    bool has_pit;
     bool has_usb;
     bool smm_enabled;
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa39afd891..e38942a3c3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -270,6 +270,8 @@ static void pc_init1(MachineState *machine,
                                  &error_abort);
         object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
                                  &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
         qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
         object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
                                  x86_machine_is_smm_enabled(x86ms),
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index d6d9ac6473..270b8eb1f7 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -361,6 +361,11 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
 
     isa_bus_register_input_irqs(isa_bus, d->isa_irqs_in);
 
+    /* PIT */
+    if (d->has_pit) {
+        i8254_pit_init(isa_bus, 0x40, 0, NULL);
+    }
+
     i8257_dma_init(isa_bus, 0);
 
     /* RTC */
@@ -436,6 +441,7 @@ static Property pci_piix3_props[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
+    DEFINE_PROP_BOOL("has-pit", PIIXState, has_pit, true),
     DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
     DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B587BC79D
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aG-0002qH-26; Sat, 07 Oct 2023 08:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aE-0002pk-5z
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aC-0002kL-Lh
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so5307831a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682339; x=1697287139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7lAoYIu+F98xbss/ABuSWEf+mczDZ8b5YL0bkPgc1Y=;
 b=aEajc4rMeJlrenIliFKDC28YO7fxoL6KzWX+2NiDLbcRtdyj3hJBzWM5Xw85isuWcT
 GPxMU0aVR+yuZbOqQqxiBqziw28AMERPz/jea3gHVPd5v77GU5j7Yt/q3hngNe/wE6mo
 poYol4BtwjV6guVNTSzKAWhRQDqfXgCyw3+JIg6gDdkyP3+IYt3mcp3tprFlg3agn5kF
 y1UERH6cxv6AkasjQX3iU+aDsgDpc4kUvPcUYI3gGUZDaJ+iviMn4JA2avmkCCvepk3n
 CUYrgwAR3GSWVxTzy+gZRIatU5wEIFtoGbh1aA/ehWjlv06M6tnQTcYibscNyxjudmY9
 winw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682339; x=1697287139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7lAoYIu+F98xbss/ABuSWEf+mczDZ8b5YL0bkPgc1Y=;
 b=a8KELe/G8ctaQsoZq+ToVJ8AlPE9CIUtilwTe0Cy5n3aLkiihHjdhZdz1dCZCAbEnh
 T4IXokCBmvOPIgjLO8nu0SPhbfLdrJ1ls6FUjM5ZeOk/clGG3/AukasC7p4ueKvHS4oI
 uxCSy8WBkfnvBlpeKod2VPOCe1YybIwc7pPd6U1QFBEIZDMpqVNfhU3/aAX/hAe9p3oM
 q7srtp5I+B5FGDophrG5I/68Zgl5AvKdT7eGAYf7Kj347jgZvRT6TQb8sxn6Sxc61QCk
 YbZtNI9URwAmNv+N4ByheMSVNJj40cHwlz52mLkq1FRW2c/sjxzT6LdkDyTA0khWlkDq
 9vBg==
X-Gm-Message-State: AOJu0Yxe6tkShx4G77RZD5pidb4P0gcDY38B5MQlfzBkXIXtd5A7Y5Rz
 K2yGFD2pcRS4uEHw6m5jgyqoe16Mc80=
X-Google-Smtp-Source: AGHT+IEW4PdQXDVg14XZxo4GTC6CwVfUYOW+WDqye4UnG+/mfKbUxOVCKn9B2Qdk6cbh2ok+4jmiIw==
X-Received: by 2002:a17:907:b1b:b0:9b9:ff16:344c with SMTP id
 h27-20020a1709070b1b00b009b9ff16344cmr3956244ejl.50.1696682338729; 
 Sat, 07 Oct 2023 05:38:58 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:58 -0700 (PDT)
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
Subject: [PATCH v8 06/29] hw/i386/pc_piix: Remove redundant "piix3" variable
Date: Sat,  7 Oct 2023 14:38:14 +0200
Message-ID: <20231007123843.127151-7-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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

The variable is never used by its declared type. Eliminate it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4dc7298c15..cd6c00c0b3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -261,13 +261,11 @@ static void pc_init1(MachineState *machine,
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
     if (pcmc->pci_enabled) {
-        PIIX3State *piix3;
         PCIDevice *pci_dev;
         DeviceState *dev;
         size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
         dev = DEVICE(pci_dev);
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
@@ -288,8 +286,8 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3_devfn = piix3->dev.devfn;
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+        piix3_devfn = pci_dev->devfn;
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
     } else {
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD77D7532
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvkAQ-0007JJ-Mu; Wed, 25 Oct 2023 16:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qvkAO-0007Hj-07
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:07:48 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qvkAJ-0003QU-EF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:07:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so128140b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698264461; x=1698869261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrWB82mqgCwm3/T6+kc4cAacBf2kjxAiorZyTleLxk8=;
 b=I5MG31jXNjqA5oUTMvev5z+nW7ggzn2sP0luRadkhcU3vibUlVKRKrVvFLZE24uVO1
 yGzxWIgi94A6x2XudqLS6un+OAHJi8BWymHPTy9x67izmUrdCDKItg+PX3hc1NMrPrs5
 QerOuwpzEgeNHCgFsM/ayaOjBLSDh2R+Wt5vzbMVwv6P5jx2IyWmEIAJmlxZBJGv5E6G
 PNNvJJceCDaMbojYw3Q0YgIm0wJ8P2rPfFT/vNCaNH29xGFAZtCU+nk/QDr/957y0vsB
 Tw59SmJRQZUAdEee/Ew68mTtEFTB2VMgfIwvHUuwcO8XEk/tZlx6BYq62EEefptFFmS6
 QqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698264461; x=1698869261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrWB82mqgCwm3/T6+kc4cAacBf2kjxAiorZyTleLxk8=;
 b=em/PB4NM7Bb2L5KiUNMFFbFdLvipqjikGh5tQ/Q/IrKBPbpDqcywIud448N74rT30T
 WLbzrsny+d1ub8W7INQe/Dm9vZZOQo7Y9vc0FU58Hpq4T7YM1VN5mXnCTxrAqVo72uY0
 I7evEYw/RmV02GNzey/uIo6ni8uLw03r0yqDejhMMlh87g8GgtfU72e54YEUkLb0swOC
 LXFBt4theEbXfkoto8VAte2FGkWHuZNavxCM+t3cJHN1cGBuBF3mzFem80OucKk4Gs2G
 nvGJwmki5JYyYLFm4Es4SusNbFd/9OugoXqUVTEEBA7KE2tE/ox76HRnKH+4ECtgdYIQ
 Qwzg==
X-Gm-Message-State: AOJu0YzblmdTlwKZ7X4Yf+qoTdhPygpdKEQSccYGQcaxG9i7Tp/JfWLD
 E0yUEo+s98Miqm4xLJzXn5K1Kg==
X-Google-Smtp-Source: AGHT+IETMeUVgYVEWI8uYFPPLGDZqqFX3agBVDaIJx07BuRa2KJUMvJX8ZUsBotMENKJ/5lAPNPwrA==
X-Received: by 2002:a05:6a00:939a:b0:68c:638b:e2c6 with SMTP id
 ka26-20020a056a00939a00b0068c638be2c6mr18880464pfb.9.1698264461302; 
 Wed, 25 Oct 2023 13:07:41 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
 by smtp.gmail.com with ESMTPSA id
 f1-20020aa79681000000b0068fe7c4148fsm9696768pfk.57.2023.10.25.13.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 13:07:40 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 03/13] hw/i386/acpi-microvm.c: Use common function to add
 virtio in DSDT
Date: Thu, 26 Oct 2023 01:37:03 +0530
Message-Id: <20231025200713.580814-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025200713.580814-1-sunilvl@ventanamicro.com>
References: <20231025200713.580814-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With common function to add virtio in DSDT created now, update microvm
code also to use it instead of duplicate code.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/i386/acpi-microvm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 2909a73933..279da6b4aa 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -37,6 +37,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/usb/xhci.h"
+#include "hw/virtio/virtio-acpi.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/input/i8042.h"
 
@@ -77,19 +78,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
             uint32_t irq = mms->virtio_irq_base + index;
             hwaddr base = VIRTIO_MMIO_BASE + index * 512;
             hwaddr size = 512;
-
-            Aml *dev = aml_device("VR%02u", (unsigned)index);
-            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
-            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
-            Aml *crs = aml_resource_template();
-            aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
-            aml_append(crs,
-                       aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-                                     AML_EXCLUSIVE, &irq, 1));
-            aml_append(dev, aml_name_decl("_CRS", crs));
-            aml_append(scope, dev);
+            virtio_acpi_dsdt_add(scope, base, size, irq, index, 1);
         }
     }
 }
-- 
2.39.2



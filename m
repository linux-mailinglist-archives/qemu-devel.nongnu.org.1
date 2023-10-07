Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170777BC7B6
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:43:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6as-0003zi-5n; Sat, 07 Oct 2023 08:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ad-00037U-9v
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:27 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ab-0002qI-Ly
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:27 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so512222166b.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682364; x=1697287164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OjQQoPINpTboxJ+797J1CZFIdFdJqAWW/PGOUKMDOg=;
 b=TkMOaWPTrbry0d1GoVYJHlnA8s5z14OdM3Pif7/Mun7c3AGFRnAk/laeoulfQdgaD1
 lZifh12vuvm9YVI9/c4bRvtUNiQHGZ/qDYs4f9Dr+A/71CHkqEkbwIXgmn+sMGNKNqWY
 pMxWsbcez4MUspFAo4ukPIZrIj4Ox3VCJH3d6MG+Xx1UYJB8bB/fHcvjxuyE1AnVvU4k
 CdxGe8AKJyeKSieMiwb20+Eb0hKKy89WnAAo1cKXeDJmh+lgLyLL+ZWhkNOiUBABpE9Q
 Qwq+yPky90RM8TJKODBS5ByqPwZvz+cLGU1UXN01ovjcuN4THswYlLBlqaNxtVXWNEZL
 ti9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682364; x=1697287164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OjQQoPINpTboxJ+797J1CZFIdFdJqAWW/PGOUKMDOg=;
 b=h4tBt0HNxVAfyooKVxBNf4HGWZvJJp5vtg+Rqr3Wm+qKsX6356+xCrdQmHhMM3/5FT
 Sk9z83xhi74vXoykdXft72Jul9A8msnO1cN5PO0jY9NPaITjBfTIeSRbSdP6pE25jBB6
 NcCxS9a+SPbfkRLQlvUUFdFvyz2kpCV2TDG8RlaNz8me4Up4emLDTL06Q/gVWrjsEIJD
 h1sKKK1WefV/AqcUyWWm7F5ihiACDU07KkKy+10vWU97OgFh+hKM4Cmq8C5VUCHWNuoa
 QHbigvrQShUR+kcRzA9GICvJ7D3nEYni+YtzMdjq4pPktg/ak8pfQKRipl0JclfE58n1
 bC5A==
X-Gm-Message-State: AOJu0YwvvTNOGtiTJc3w9U5rXdGYuwq/980tYpbprc4imofbiDj2kGzu
 2zXEkVflcSXvhlF6U9O/gs6rBU/AdiA=
X-Google-Smtp-Source: AGHT+IF6gwAObMwuGsvNvJHv/Hlsdgb+fRo1Q2Z6avG3JvDPoipL9FZQy+c4sP0K8l4wqq6sKiUekQ==
X-Received: by 2002:a17:907:75da:b0:9ad:a46c:2936 with SMTP id
 jl26-20020a17090775da00b009ada46c2936mr9590414ejc.8.1696682363948; 
 Sat, 07 Oct 2023 05:39:23 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:23 -0700 (PDT)
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
Subject: [PATCH v8 27/29] hw/isa/piix: Resolve duplicate code regarding PCI
 interrupt wiring
Date: Sat,  7 Oct 2023 14:38:35 +0200
Message-ID: <20231007123843.127151-28-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Now that both PIIX3 and PIIX4 use piix_set_irq() to trigger PCI IRQs the wiring
in the respective realize methods can be shared, too.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 17677c2126..cba2098ca2 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -372,6 +372,8 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
         }
         qdev_connect_gpio_out(DEVICE(&d->pm), 0, d->isa_irqs_in[9]);
     }
+
+    pci_bus_irqs(pci_bus, piix_set_pci_irq, d, PIIX_NUM_PIRQS);
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -453,7 +455,6 @@ static const TypeInfo piix_pci_type_info = {
 static void piix3_realize(PCIDevice *dev, Error **errp)
 {
     ERRP_GUARD();
-    PIIXState *piix3 = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
 
     pci_piix_realize(dev, TYPE_PIIX3_USB_UHCI, errp);
@@ -461,7 +462,6 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci_bus_irqs(pci_bus, piix_set_pci_irq, piix3, PIIX_NUM_PIRQS);
     pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
@@ -492,16 +492,7 @@ static const TypeInfo piix3_info = {
 
 static void piix4_realize(PCIDevice *dev, Error **errp)
 {
-    ERRP_GUARD();
-    PIIXState *s = PIIX_PCI_DEVICE(dev);
-    PCIBus *pci_bus = pci_get_bus(dev);
-
     pci_piix_realize(dev, TYPE_PIIX4_USB_UHCI, errp);
-    if (*errp) {
-        return;
-    }
-
-    pci_bus_irqs(pci_bus, piix_set_pci_irq, s, PIIX_NUM_PIRQS);
 }
 
 static void piix4_init(Object *obj)
-- 
2.42.0



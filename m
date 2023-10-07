Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29D37BC7B7
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ao-0003ZY-JS; Sat, 07 Oct 2023 08:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ae-00037Y-1R
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ac-0002qU-JW
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso509321266b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682365; x=1697287165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8O26ECq55NzWTV3HBHbSLLDgPj98cdN3Udq2WWAJwg=;
 b=ANnjPu38U7vnR8XgU+WcTQPHswXklQX7/NqPGf+VgJJSvz1CMKj3rod9nJZr2LE/U3
 nC/4qmkXvsMGdW1LZLmZghqwq4jjaMFekEoFGJ2y6AxswtrdqQDRWUZUkg06cYQE5U2w
 F3SmIFuGTKYb02xp1UNZdQkMXdfJkOYtSaLNf01vQ4eXmTfUAr9twM3hMOAN+zwZtTkD
 W1ahcgyASqXUw76gAd786Wzdxwm/Za+0ev5QZ4tPMchRrM0YZPrWfncJZrK0o4VuZs2r
 nQn/yN9nPsx4Gc7hioKdkEO6XHfU/U01qOKdtSLy5puTjGltNeL4SYh8QiAPCUZ1dIqL
 cwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682365; x=1697287165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8O26ECq55NzWTV3HBHbSLLDgPj98cdN3Udq2WWAJwg=;
 b=A9e8XMts8TmGyA4QpCOteYuODAvflamwqJtdcHBLhqK/omYlm2CuQHC1+qax22QQd8
 qZxj09xrnxxX44ymQSfb2A534jCcTH8GfB2vCopfLPHTnUhyh0Hyx1usB1QCvHA3Jo8q
 eLfZutUgCrS9Ey5Y8+ww9BgmtYB2lhNKLlNe5k3Bcx6o4gwYDCVv5S7EnIbjrWZdD6Q5
 XCpcw2LiP9YdiXlCvjS/X4DBikDmhLzJDiiKFPFT8n9IrudS7YP2l66HM5PdoV/vEm7d
 zXKMiM9Ohtb8XtvDN+3K8LWbuhsbts3pISrvo80SK4IBQ853+95mSnclcLsgRS8JynKe
 8Fww==
X-Gm-Message-State: AOJu0YzMoSv6w+3XRcJtxPh/tc6EURM1yLOHs0F31Fu4/lUivKDzLMUp
 qFQAThy32Gd0z3bf2Z5MTnyC03XHImk=
X-Google-Smtp-Source: AGHT+IE1MQT+Q+mYI2az+RvtRMLAh5ix/YTujvtK5UkZHmTQzULnaMbkzuMM7LN9PBwi0NjS7YrBFw==
X-Received: by 2002:a17:907:7809:b0:9ae:5be8:ff90 with SMTP id
 la9-20020a170907780900b009ae5be8ff90mr9515572ejc.68.1696682364870; 
 Sat, 07 Oct 2023 05:39:24 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:24 -0700 (PDT)
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
Subject: [PATCH v8 28/29] hw/isa/piix: Implement multi-process QEMU support
 also for PIIX4
Date: Sat,  7 Oct 2023 14:38:36 +0200
Message-ID: <20231007123843.127151-29-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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

So far multi-process QEMU was only implemented for PIIX3. Move the support into
the base class to achieve feature parity between both device models.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/piix.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index cba2098ca2..04ebed5b52 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -374,6 +374,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
     }
 
     pci_bus_irqs(pci_bus, piix_set_pci_irq, d, PIIX_NUM_PIRQS);
+    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -454,15 +455,7 @@ static const TypeInfo piix_pci_type_info = {
 
 static void piix3_realize(PCIDevice *dev, Error **errp)
 {
-    ERRP_GUARD();
-    PCIBus *pci_bus = pci_get_bus(dev);
-
     pci_piix_realize(dev, TYPE_PIIX3_USB_UHCI, errp);
-    if (*errp) {
-        return;
-    }
-
-    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void piix3_init(Object *obj)
-- 
2.42.0



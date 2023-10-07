Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C047BC7A0
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ap-0003bA-10; Sat, 07 Oct 2023 08:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ac-000378-Hz
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aX-0002nz-Kq
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:26 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so515116266b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682358; x=1697287158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0XuN63nkTd3KYQHhUixjIMHmBNvDj80m6k9ANPL8Y8=;
 b=jYW3W5qn6GiOYnN7bJn9EcJI7CvyG/di5aLtV3ZilaukwhyqS0t6IA6q/9MlRGpXO7
 jG3sc3OmTK5944F05/XN90VpuEY8P0sXHdLFYp2lE0fSlUS7HgepToVhs5MHbnD6LoIB
 q/OWmQPuI9RxIaApPZHDDseKR3hD5gWLG4uGEwR7Qt5I+CdYqR3QFw3414irAY8J2uBJ
 PUrpAaUQgJP4kUcg0vBFWOqvYv3+5uCFPv9kmEoi5Mt3irKLMXP3R1dRMu55A1kS1l8G
 BcYrXsmfFQ5mYXIx8krbI/x1ds4zEIn8k+RtnfmaOV8gPUn4OwsXFi4uq2GXY9+PXxWR
 HLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682358; x=1697287158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0XuN63nkTd3KYQHhUixjIMHmBNvDj80m6k9ANPL8Y8=;
 b=mE0WhI0EMVCFNGms/CNnvG8LmgcGkvM0bfaslIeLLiQjZxuf7QT4FKe9e4Nbhx515x
 Hf6rbINlG1MFfKd7qvEoasyqpzlqXJ8ViD/BldWW7je95toD7G8cdhSppaEb5ny9n+Hm
 9/v/O7IkApOlefEltn7ZFv/KLAF4I50nSV+Z8hir2CoB+QYwkgLO7NpQe9bnNAPKGi0I
 icYKZ6vxJSKJbQAuhItM4ffGRdsA8U8YDOCj4ZC7Iwq0x0AzFoMUyC0FPS5ds99b2zFq
 TNMqp4EbGQOjUjduUsulYhJfzh30itW1qHN8psvHw2jsBe3hBUQGMuGArtzhD1kMCrMi
 G1Eg==
X-Gm-Message-State: AOJu0Yy74qGzcxlW026xum4a4af14I3cpm7qLDzTSrO18JYde+38jugN
 pMn6wPU/kRvJ7864PGhaOnDtMSUVt/A=
X-Google-Smtp-Source: AGHT+IElXZq6cObzA5NaJT+Ll8VaoCjG5GKlPayJl1f+QQMLLdMfImcx2IUa7WQQJ1tkAqtZTkDkVA==
X-Received: by 2002:a17:906:74dd:b0:9ae:5a9f:6aa0 with SMTP id
 z29-20020a17090674dd00b009ae5a9f6aa0mr10485042ejl.33.1696682358139; 
 Sat, 07 Oct 2023 05:39:18 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:17 -0700 (PDT)
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
Subject: [PATCH v8 22/29] hw/isa/piix: Harmonize names of reset control memory
 regions
Date: Sat,  7 Oct 2023 14:38:30 +0200
Message-ID: <20231007123843.127151-23-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

There is no need for having different names here. Having the same name
further allows code to be shared between PIIX3 and PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 270b8eb1f7..bd66fb7475 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -339,7 +339,7 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     }
 
     memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
-                          "piix3-reset-control", 1);
+                          "piix-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
@@ -532,7 +532,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
                              "intr", 1);
 
     memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
-                          "reset-control", 1);
+                          "piix-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &s->rcr_mem, 1);
 
-- 
2.42.0



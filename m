Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E237D03FB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRE-0007YS-Rn; Thu, 19 Oct 2023 17:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQz-0007HJ-FE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQx-0005B2-Eq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32db8f8441eso121773f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750396; x=1698355196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5L3KhgnR+wD3KYNvWp6CWYVG73hhXTbT/VSAj1bhVwM=;
 b=N5WPcaSWVaFJ9iyQSiuRHSaSFqeTfDy3aN+rLAwIRSFb8lkDR3U3gDDevC0h1uNg1S
 fvfeBgU6RUR1vhzG1etx6B0OqmJNt0ltCLqWLLKQhI4NRrvJ1anu+jYiVyU/3BEgnNs/
 qBip4i50VkqMfMXvW6I9cOds0er7OKesxl0Fa4nwwaaueswnR8zwx40+h8xL4Q0DK5yl
 BQk18LNSUu/dZJsfLGhzfToFAqoeGJm+BmkjTDBf7auKbBoBvqr5DszSVAjuyCJf4jfd
 m/U/5Y/N3Z3QejCz1WfH2r1RD9ZxYV55InHEA7D/S7SXmqTe5KZsZIzQbymg9guHfKow
 DGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750396; x=1698355196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5L3KhgnR+wD3KYNvWp6CWYVG73hhXTbT/VSAj1bhVwM=;
 b=T7i+ggGO7aR50uteZN57io2Kn6i4Z1H0JRWDnPC6bGeSYPcL3uO3mJImYaVKoz5Stv
 WYEF5tAq63r95sY1TzjhZWfBA4hDinqtbyQ4Adli3ROx0Y+WfHuYKep53VThUqKY73lT
 HgLFh+0kDYDAogXl+BgShNXkjd985BDpuiPvvKHh8GFX+zcm8J8ZRa77sOXE1dIgwMiJ
 pwAieSMfZG1SqV/YNeYYZn09kep0bV9ENzdUTv/zmUcvqEKyemmU9jGG5OFH5Iw08CT1
 LoROkaesme6v+5et73YeB7ShW0ZXXCqOpfIcm+orquUayL5mEP+7FedWWYbswI67opnr
 WIFg==
X-Gm-Message-State: AOJu0YzDpqJ3MLu7+jrFt+X4LI5T0gFSHyDtKJ/eMaF88lZdW8J4K0Mg
 SBIP63N+9uQ4nk3B0Gtq69gen0kjWEeuvSqsCkWT5g==
X-Google-Smtp-Source: AGHT+IFkfKfmZ74ngY6VCXu7rxerYlszFNMM4l4q7gr3TsTzH3fI9WBrpK8VxvXkWhsysuXL1jQjqw==
X-Received: by 2002:a5d:4202:0:b0:32d:9b80:e2c6 with SMTP id
 n2-20020a5d4202000000b0032d9b80e2c6mr1914430wrq.26.1697750396472; 
 Thu, 19 Oct 2023 14:19:56 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a5d5042000000b0032d886039easm233498wrt.14.2023.10.19.14.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:19:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PULL 15/46] hw/pci-host/sh_pcic: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Thu, 19 Oct 2023 23:17:40 +0200
Message-ID: <20231019211814.30576-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20231012041237.22281-2-philmd@linaro.org>
---
 hw/pci-host/sh_pci.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 77e7bbc65f..41aed48c85 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -167,17 +167,6 @@ static void sh_pci_host_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo sh_pci_host_info = {
-    .name          = "sh_pci_host",
-    .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PCIDevice),
-    .class_init    = sh_pci_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
 static void sh_pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -185,17 +174,22 @@ static void sh_pci_device_class_init(ObjectClass *klass, void *data)
     dc->realize = sh_pci_device_realize;
 }
 
-static const TypeInfo sh_pci_device_info = {
-    .name          = TYPE_SH_PCI_HOST_BRIDGE,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(SHPCIState),
-    .class_init    = sh_pci_device_class_init,
+static const TypeInfo sh_pcic_types[] = {
+    {
+        .name           = TYPE_SH_PCI_HOST_BRIDGE,
+        .parent         = TYPE_PCI_HOST_BRIDGE,
+        .instance_size  = sizeof(SHPCIState),
+        .class_init     = sh_pci_device_class_init,
+    }, {
+        .name           = "sh_pci_host",
+        .parent         = TYPE_PCI_DEVICE,
+        .instance_size  = sizeof(PCIDevice),
+        .class_init     = sh_pci_host_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
+    },
 };
 
-static void sh_pci_register_types(void)
-{
-    type_register_static(&sh_pci_device_info);
-    type_register_static(&sh_pci_host_info);
-}
-
-type_init(sh_pci_register_types)
+DEFINE_TYPES(sh_pcic_types)
-- 
2.41.0



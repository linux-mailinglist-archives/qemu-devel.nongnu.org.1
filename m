Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D6F7435F5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hf-0002Hm-BE; Fri, 30 Jun 2023 03:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hJ-00023w-Qp
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hH-0005QA-NZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-992ace062f3so173996166b.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110657; x=1690702657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQG3c1JuQ/m1rucP/1PJyI67+DN0jd3fnKoXjuafnIw=;
 b=UiEpxaEVGTEhLOzVh7deuAZVd9uuFCy8bSy1mqyzExduR3mxBduwWIAyvrXkVRWI/x
 P0LKklwxzMz8+llYatHRD6/6hdHw2LK1+eClKJS6pwg+iRecuwV/9GlyXwLcDlsIv2hg
 c+Qb3hMYqX3WIPopbc8GC5ElPR+IGzGMxQZmNGGkByjJyeDDkIGSoLGVN3rQFDaaxEUN
 yMd0wyPeBnWdWQCnriwhlIW1XQAiSuKrnTsfyjqrvIZLr4mNwqZ2xXGxx3CQMF6ErwfO
 +CCVzZyNnVHwSN4wvvY/f1av01qHQyxAPn8sEAmRg9a/0C+pQeIw82FNYS6vaaS7YGn3
 J8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110657; x=1690702657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQG3c1JuQ/m1rucP/1PJyI67+DN0jd3fnKoXjuafnIw=;
 b=K2cHAK6gF7AyBWtIr9qE06UAQS+plY4SMwkPw2ZJdbIjFfeyD+SY4AgSE6i2SOOF2Q
 cHUn0AE+cQJ5XaSGl7nSy71Ku+raLSaDGqdCmkeBQUeFoVdKsyuq5x5wgLEKwVgqhxPy
 za/q6uz4c6zqstexNC+6OB7wab5NNS4U+7wv+S4kEGVRSHJPZ63u2GjDTZB/JzknlCnU
 t/UtQmRvqpQJ8cq0XUymZxQ6rHptGTPzrzqBb9oqwAIw9bCXVJMn6CZQOG/2SBx6d1yD
 rhGminFCHUFIlNZ4f4U7jaWbZ92Vdo2tO0gDccXejoIYO/UzdnpwbVG7M1eqAkM41eXH
 EH4A==
X-Gm-Message-State: ABy/qLbh0u+bgJglgLb602YCs/ZTmiQkLnCcFiv1XyPCDT4zPCwqEIQE
 t7elruY/WTX3jZBC+xAKHElowjK5j3Q=
X-Google-Smtp-Source: APBJJlGhHqhJ3Sm0pBvpu8fuqahP62EnMwp3oenvd5iEb5HlWOXuOCeVT18fSbq/uFk1rLSWJQSZRw==
X-Received: by 2002:a17:906:a88b:b0:98b:dc6c:b304 with SMTP id
 ha11-20020a170906a88b00b0098bdc6cb304mr1403577ejb.38.1688110656824; 
 Fri, 30 Jun 2023 00:37:36 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/17] hw/pci-host/i440fx: Add "i440fx" child property in
 board code
Date: Fri, 30 Jun 2023 09:37:11 +0200
Message-ID: <20230630073720.21297-9-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The parent-child relation is usually established near a child's qdev_new(). For
i440fx this allows for reusing the machine parameter, thus avoiding
qdev_get_machine() which relies on a global variable.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c    | 2 ++
 hw/pci-host/i440fx.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6a5b6dad2f..26e8473a4d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -202,6 +202,8 @@ static void pc_init1(MachineState *machine,
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
         i440fx_host = qdev_new(host_type);
+        object_property_add_child(OBJECT(machine), "i440fx",
+                                  OBJECT(i440fx_host));
         hole64_size = object_property_get_uint(OBJECT(i440fx_host),
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 61e7b97ff4..d95d9229d3 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -259,7 +259,6 @@ PCIBus *i440fx_init(const char *pci_type,
     b = pci_root_bus_new(dev, NULL, pci_address_space,
                          address_space_io, 0, TYPE_PCI_BUS);
     s->bus = b;
-    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, pci_type);
-- 
2.41.0



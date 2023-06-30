Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF57435F4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hh-0002QC-Si; Fri, 30 Jun 2023 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hM-00024x-LR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:46 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hL-0005Qt-0X
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:44 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b6a1245542so24947511fa.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110661; x=1690702661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMIlHFAMK3fLP5aMHD94wBUzhhT77eW6RaGaDaJaRfk=;
 b=M55aKhWeFu16q+qPLUg1S7CIyB7lh0ree8lUgDI4DMK5ycy2XwMnOkqJzh28SdkuZG
 zBt0LlKDFYtjnsrPqzQjtWKzjuR4fxq9PVugFV4/zOVQeY3v9FKjrBe2/NmR65o2E0rO
 vt+0319ylYZjR/2DrOaiO6e4KsrogF5RSdFz4mkRJh7XC9YIzmHgIM/kJPo8E0NMCJFA
 4ICHmHJdUMAoJq9kqd4Vfrjx9rl6qlOVHp97zAf0ZOAGa8ZIVZfA0Q7l25qitJoolBoM
 N4jLpIKurhvll5t1OZU/Mi0HSpuQcvgzihYbLnDJHBjH6iZA/mGn7fjTGQrYNv1Y3pHF
 EjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110661; x=1690702661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMIlHFAMK3fLP5aMHD94wBUzhhT77eW6RaGaDaJaRfk=;
 b=YwLXNHxm9xuA/fQDLkhlsRosgvUYjsuDjy4gS3GDFIIWo8+m5B/tN4GGu9cFIbYO3g
 Zmx11LkYh03F00L6oUbavMDr9B4t3hbypd84WsORc+GV/kXmyNY9u862u8ccZddG4GLH
 PEill2j5hGW6U/KJabUTuMC87I9fMKt2T5PQE3EVqTJb/giNk8G47M5d3i8eFqgYj4kG
 UdoAMPvXPfBwEmpZnjncSH3IRJK0kIHwbHgHXOHB4yUmdAeQEZg7y2L1SY7NeR+8e7pd
 yFBz6Zq6Qm4jwFRwx50O8kvAK0hWYo9+VCM7jjD6DHMoVhXhmS0kLPvh3kMrcFkfNwqX
 m6qQ==
X-Gm-Message-State: ABy/qLb5nhFRGYPMQfDAR9XkB2Unqp9q6gXERVoLT/DrOQkrfomBmZEC
 nTWFIIiLekZHrAmYcjvswrAyT76quEo=
X-Google-Smtp-Source: APBJJlH+mzspbhNFDUDN3/XzGOaGKCqqLaK6LcYWx0Sfmrq2kHWq+vvprZknedJMPOAOtY1xqqz9oQ==
X-Received: by 2002:a2e:8756:0:b0:2b6:adc4:aa2d with SMTP id
 q22-20020a2e8756000000b002b6adc4aa2dmr1484981ljj.18.1688110660487; 
 Fri, 30 Jun 2023 00:37:40 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/17] hw/pci-host/i440fx: Move i440fx_realize() into
 PCII440FXState section
Date: Fri, 30 Jun 2023 09:37:14 +0200
Message-ID: <20230630073720.21297-12-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x236.google.com
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

i440fx_realize() realizes the PCI device inside the host bridge
(PCII440FXState), but is implemented between i440fx_pcihost_realize() and
i440fx_init() which deal with the host bridge itself (I440FXState). Since we
want to append i440fx_init() to i440fx_pcihost_realize() later let's move
i440fx_realize() out of the way.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/i440fx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 0b76fe71af..e84fcd50b6 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -65,6 +65,15 @@ struct I440FXState {
  */
 #define I440FX_COREBOOT_RAM_SIZE 0x57
 
+static void i440fx_realize(PCIDevice *dev, Error **errp)
+{
+    dev->config[I440FX_SMRAM] = 0x02;
+
+    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
+        warn_report("i440fx doesn't support emulated iommu");
+    }
+}
+
 static void i440fx_update_memory_mappings(PCII440FXState *d)
 {
     int i;
@@ -229,15 +238,6 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
     memory_region_add_coalescing(&phb->conf_mem, 0, 4);
 }
 
-static void i440fx_realize(PCIDevice *dev, Error **errp)
-{
-    dev->config[I440FX_SMRAM] = 0x02;
-
-    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
-        warn_report("i440fx doesn't support emulated iommu");
-    }
-}
-
 PCIBus *i440fx_init(const char *pci_type,
                     DeviceState *dev,
                     MemoryRegion *address_space_mem,
-- 
2.41.0



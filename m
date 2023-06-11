Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A272B16B
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IPG-0006Xd-8g; Sun, 11 Jun 2023 06:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP6-0006UF-7h
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:36 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP4-0008LR-N9
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:35 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9745c5fed21so491015266b.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479673; x=1689071673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4LwTDfA4GiIMUPsm2uiLdFbZNcdPtXv8XWumvoqJ00=;
 b=CCstUoE+2gX+aN6Xd41oM7MR6+Hrk7T7OHPWRMV9aOIx9bKm06zlX7GGmG47FYqysU
 Q2CaLXFYM/PB3WOG524cObu81Pruy46djbHbi0+DJSj02YusBgva2QAsYNdgkHUqdkhc
 yKy6o8QGLDLaLw8DYYZv8Gd5Q8uEzz+ULUAmPHNcpaIVyZ71XH6gVL6Kvh5PavcAZnfv
 /H7sMtqvaJVjAvRSLbGpWFD5s8I8fDy1Xz0q+/9kLPjFfkdXeP1Rk7sj2I/EbfnwCyeP
 TBnQLd8mLSs5DqHp8OlGbm/0aZ0SfftzHjVersVwSL+qg4JbAzID5dhIzyk9aUbMAhZl
 cS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479673; x=1689071673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4LwTDfA4GiIMUPsm2uiLdFbZNcdPtXv8XWumvoqJ00=;
 b=Tsj7TKtsyfN3UTQL7ATxDX7zNMmQ0eMdNRSSeL8J16pCSbYwIIaNRz3gmOsc9TcR4x
 0SqGms96o6qZfr5RjBxpY/hPX8D2GMa4y2E2yBMFvYLSsP6IcJUnGllWFWL1LEBIpLLl
 /beru7fR9oUEScz1XifR2P7dcPEyPhHDSuQZsz/CP8GrKpGgD4oJ9eXI2JA97/wbuuKA
 WhdkwTsAyWO5HvvDlRmkt0HTRKx3P3cimSBOCZbtDOziaDG0AG5L6VJKgv0HSqfARFBb
 CXkAIX7diAp2eya0kMcRyFSr1u6gtWFjyWcAFK6Sg14rFMaBnkc6eQoyij81zvLJMD9S
 4yeg==
X-Gm-Message-State: AC+VfDz5pYgB1D/SsU/mHTbvVKgTgcRQ8zyAl8l/KrkXhV3YuZK2JBT5
 H8xLod/M8r/tBOPmfsQlIyAVFptcB/Q=
X-Google-Smtp-Source: ACHHUZ6nNeZ6a+0zDUr7IlOydpDAn8gr/cUzGUbgoTGK8wvaSQ8ctFtUuBCz8SkzSTNTo8Rk82TGxQ==
X-Received: by 2002:a17:907:a40d:b0:94f:1c90:cb71 with SMTP id
 sg13-20020a170907a40d00b0094f1c90cb71mr7899569ejc.65.1686479672961; 
 Sun, 11 Jun 2023 03:34:32 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:32 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 13/15] hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE
 property
Date: Sun, 11 Jun 2023 12:34:10 +0200
Message-ID: <20230611103412.12109-14-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

I440FX needs a different PCI device model if the "igd-passthru" property is
enabled. The type name is currently passed as a parameter to i440fx_init(). This
parameter will be replaced by a property assignment once i440fx_init() gets
resolved.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/i440fx.h | 2 ++
 hw/pci-host/i440fx.c         | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index 7e38456ebb..2d7bae5a45 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -15,6 +15,8 @@
 #include "hw/pci-host/pam.h"
 #include "qom/object.h"
 
+#define I440FX_HOST_PROP_PCI_TYPE "pci-type"
+
 #define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
 #define TYPE_I440FX_PCI_DEVICE "i440FX"
 
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 3c44f24d2a..44ff3f7ea0 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -59,6 +59,8 @@ struct I440FXState {
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
     uint32_t short_root_bus;
+
+    char *pci_type;
 };
 
 #define I440FX_PAM      0x59
@@ -286,6 +288,7 @@ PCIBus *i440fx_init(const char *pci_type,
     s->ram_memory = ram_memory;
     s->below_4g_mem_size = below_4g_mem_size;
     s->above_4g_mem_size = above_4g_mem_size;
+    s->pci_type = (char *)pci_type;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->address_space_io, 0, TYPE_PCI_BUS);
@@ -293,7 +296,7 @@ PCIBus *i440fx_init(const char *pci_type,
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    d = pci_create_simple(b, 0, pci_type);
+    d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
 
     range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
@@ -392,6 +395,7 @@ static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
                      above_4g_mem_size, 0),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
+    DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0



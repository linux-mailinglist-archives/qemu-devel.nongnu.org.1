Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF274191C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDN-0004l8-3b; Wed, 28 Jun 2023 15:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDK-0004kJ-KE
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:30 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDI-0005kA-U6
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:30 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98d34f1e54fso20553266b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981947; x=1690573947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHBCVt28+gb3jtcCQXQp5cJeJRF2BGFVeWUg0BbI4/k=;
 b=eZ/0cBv/FdVLJYqU4zfdAw0zs6oqa4YrY4TficCbBxzk1J7cltsd8dvwx4sbZQ6bzc
 dMvHrRLPP3/M42D6AeasG3913gxalxX0tFBgdTgnb1zN/gNdoeeMMsMG/sjcEPSgSS0x
 dxMEw0w4HHdGia9995F69/NDh3UifkHvSD5RjHHpc/EvGJmunF+fwzxfDNp4rejQhdmd
 EP12FZIZWsfEEjWz+hg8L582dtUEoCampj1Fq1EiUG544xGMqnvTtykZQIytEda3U52F
 7iaxDsEH+kujZRVFicPOe0r7/nD92rINCGt1Al3t5UjzNBDnGR/hIGz/aYr6NiK1ZPzO
 iS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981947; x=1690573947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHBCVt28+gb3jtcCQXQp5cJeJRF2BGFVeWUg0BbI4/k=;
 b=dtHQzjRxPISZemdeYmQK82oBqh6OPrGIb+tUQBa2jtnYeDA++njtWPCIElej4DdtaS
 Oxw9CEnJAUUyQYfRgVjEDzqfJhfxSwzjIIuQa9Pz50O1TG/K9ggJ14Cm0pbbMk+rnL51
 uFzRfXCsotn/3EjfUq1FN1mhLsJbarVXXGNQc98TCEq6cw6/+PbCfvHP1qOM55scEU36
 LcTK5p8KYsH82UHJ+6xJg9WeXdPw1jwLyfsIX+X/rFmQTrp/LS5ShuXzUwsyZ5PSmC87
 hwqjcJLTVzcFzsacoC8+fMQGXhpcfoaCCX9dNePb0eLbcIqN07dofesIpcJTHsECfi+4
 2g2A==
X-Gm-Message-State: AC+VfDw/V0CEKQ5mGZ7XT9yo1+Ds8oBYoWUxs3Mv6l8qNNNcO79xza3G
 Ip/ZhFzBMjFArbxleZqYjFdIW27rv/M=
X-Google-Smtp-Source: ACHHUZ4RepXXgLbP386FB0BOYlZzPn/HivzuOujM9QncRDmT/Rj1hZIPNb2MY8426eMtLKgLTn69LQ==
X-Received: by 2002:a17:907:7b96:b0:982:3e2a:91a8 with SMTP id
 ne22-20020a1709077b9600b009823e2a91a8mr31056025ejc.72.1687981947114; 
 Wed, 28 Jun 2023 12:52:27 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 13/16] hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE
 property
Date: Wed, 28 Jun 2023 21:52:01 +0200
Message-ID: <20230628195204.1241-14-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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
index 4dd70e68fa..e8e66afc11 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -57,6 +57,8 @@ struct I440FXState {
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
     uint32_t short_root_bus;
+
+    char *pci_type;
 };
 
 #define I440FX_PAM      0x59
@@ -284,6 +286,7 @@ PCIBus *i440fx_init(const char *pci_type,
     s->ram_memory = ram_memory;
     s->below_4g_mem_size = below_4g_mem_size;
     s->above_4g_mem_size = above_4g_mem_size;
+    s->pci_type = (char *)pci_type;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->io_memory, 0, TYPE_PCI_BUS);
@@ -291,7 +294,7 @@ PCIBus *i440fx_init(const char *pci_type,
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    d = pci_create_simple(b, 0, pci_type);
+    d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
 
     range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
@@ -390,6 +393,7 @@ static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
                      above_4g_mem_size, 0),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
+    DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0



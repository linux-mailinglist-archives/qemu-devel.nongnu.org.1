Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB97BD7A6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmtQ-0003t1-Ds; Mon, 09 Oct 2023 05:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpms8-0001xw-Qa
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpms6-0005z9-7d
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53627feca49so7161460a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844896; x=1697449696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEGlN++LvrChCTNtyzB8Otj+nJkZt0M6Hyp5n7KviH8=;
 b=RShyQl0vPAPDG4mkiGyyGcC/uLFSknFmIiwrFXN2doJJtSmsQSlQXJjTO4xbp/JShI
 cHQdMs47IvZq8dOZz3iT4sI3HjLQroX+rPhVIaVg+aBxgP2LNCy7uCIe2mswWdTwb+qH
 YCxPBG1prWu+fxj8NCDe1ce3sSBADo7zSAU0h58LNHiF0pmIr5+Nm3WEcwSAWm0z53KU
 /R/PCuaHQxe089pNWgTSVFxiHgGuHu8yFEq5ZLluSLBrJVJn73O2PLcUHZg/vS+22q8L
 n5T2xhd5xYjg3enfMVFC59X9nVvAwvFNQWfn8DDUyuoLW9sCM8HsTZgG+uS0N5Z2rmlf
 9OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844896; x=1697449696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEGlN++LvrChCTNtyzB8Otj+nJkZt0M6Hyp5n7KviH8=;
 b=QJSwDQ+zJ38gdJHXv2OF3fPGsCPPZ9J18N3JiGqSRBUCPF+H1G/ro1F7BSBvuv7A/2
 FlH+4gilF74Kxy3E1E+2h3q5rHt44CeGjjFzpDRZAxY7YzZJOAsxlk+3/j6w41XLBdOC
 cbOnHRqefSazm+DihMKS17Txv46yPZlFA1PfCincJZ8OEyzZgmHCNB6ufiDpPH9S5Tw8
 4a+g9SYejASMR5ezDfmJ6Hub7Ki7plqSBWnygu3Ok/bj5BfjttTIJf9M/NesjMNe6T1C
 HVrvVhePzSaR+xnHbtFu+H0yh6Qq6XUHiC19BjrD4r0jAn5Y1WHCHucihG0fFYy4c1WD
 N+gg==
X-Gm-Message-State: AOJu0YzO+b+YRATxqoQCM5eEuiQ17CgCpIkvIFrxGxdfEBK+EfMXgpuw
 XrxcrGPPcrqqRwM0LCkW/b77gy7Q1QH4jjthMvk=
X-Google-Smtp-Source: AGHT+IG6M+3h1oW2IXoXrEnjepYjnpWMDtwMbWx1FMtafLJ46AG1qHwYwIwzLTy8SwNYFt0lYfBncw==
X-Received: by 2002:a05:6402:351:b0:532:e4d3:df83 with SMTP id
 r17-20020a056402035100b00532e4d3df83mr12894895edw.4.1696844895949; 
 Mon, 09 Oct 2023 02:48:15 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 bm15-20020a0564020b0f00b005346925a474sm5934082edb.43.2023.10.09.02.48.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/6] hw/acpi/pcihp: Clean up global variable shadowing in
 acpi_pcihp_init()
Date: Mon,  9 Oct 2023 11:47:44 +0200
Message-ID: <20231009094747.54240-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009094747.54240-1-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fix:

  hw/acpi/pcihp.c:499:36: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                       MemoryRegion *address_space_io,
                                     ^
  include/exec/address-spaces.h:35:21: note: previous declaration is here
  extern AddressSpace address_space_io;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/pcihp.h | 2 +-
 hw/acpi/pcihp.c         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ef59810c17..ac21a95913 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -56,7 +56,7 @@ typedef struct AcpiPciHpState {
 } AcpiPciHpState;
 
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
-                     MemoryRegion *address_space_io, uint16_t io_base);
+                     MemoryRegion *io, uint16_t io_base);
 
 bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus);
 void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index cdd6f775a1..4f75c873e2 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -496,8 +496,7 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
 };
 
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
-                     MemoryRegion *address_space_io,
-                     uint16_t io_base)
+                     MemoryRegion *io, uint16_t io_base)
 {
     s->io_len = ACPI_PCIHP_SIZE;
     s->io_base = io_base;
@@ -506,7 +505,7 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
 
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
-    memory_region_add_subregion(address_space_io, s->io_base, &s->io);
+    memory_region_add_subregion(io, s->io_base, &s->io);
 
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
                                    OBJ_PROP_FLAG_READ);
-- 
2.41.0



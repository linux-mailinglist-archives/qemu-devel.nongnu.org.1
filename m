Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431B47D0400
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRa-0008E8-2p; Thu, 19 Oct 2023 17:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRO-0007xx-LO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRL-0005X3-SN
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so1149745e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750422; x=1698355222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKYzU30OgfdGXu2rSoeATSatQXWleg69ZG3hrJerNH4=;
 b=PlxEt+r/svdMkbrxk8wG1+wdNwuVipLLJJXWHnX6yJVOjki844etI704Xdzno6KFJ7
 Jxk0tcd9zdirg7ncSjEPWFckJIoPKvBHRshPBTp7vLCOXAqekF3N5dHvSyxgVemtSCpk
 qo5bk/mNrG0Pni45/yLDVeD2+gEaLJSoxNUG4XD7jllqKFLQvmaD9sbpssyRnow7fOUq
 urIUlcX6zyqtvRrkENdhZ70E0C273L0l8cBdGVeC0f9VbQpnzX8Tm1RhLS5x+6/Cj9vt
 YIn1LZAPH1tG/gryuA5kEJxbl/bc4NoPXVEk/jBJv/RSKJkhcP7OX6b4yhgRTWfyrcWH
 Kz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750422; x=1698355222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKYzU30OgfdGXu2rSoeATSatQXWleg69ZG3hrJerNH4=;
 b=gnojtIK/j38HPiUYvXLbpEGjd997aeqJCqSqet5ozBpPcdhttDLs8XtfwMGYeZQrrf
 KeJDz+iSBGCciJ9EPH1lggTn0WQuah08JZwtE9N8nptMiJdozRUc/B/HrapE+OvXGZd/
 g8f9Lluk+hzthPzhxWK2pVlGjh2gFHEekVJgi9Art4K6uX1oST9xYT/Iu03BlCcgEzHb
 8uoIGnegAiZdp99R2JYSdz5SbqHVXCiKHFvkhHuwVfJC6kGlcPuwoPiMtuhF3KOGihEJ
 GQrCWMprK40MiWbfkQEPxNTZl2u6ogkY8mgZ+AFzIqH/FbyMgQ16F0e14rSR3WfdfvQ0
 8fEA==
X-Gm-Message-State: AOJu0YwbK+TihNfCX7ec/YvDGjMsCBtBaW/Yvz/yd6/SUX/YqG/fqCs3
 lTHPzzGUqIcnM9q5ilMOWV6Jlsdc9bLNrLZLQ1YEGw==
X-Google-Smtp-Source: AGHT+IF46GymaXmW4aKas9Fzfkfd0l+ORMfndUFAu5uUegUIH/BiL/+kDgcpIhE6TfBtNNE9KhzTRA==
X-Received: by 2002:a05:600c:3541:b0:405:40c6:2b96 with SMTP id
 i1-20020a05600c354100b0040540c62b96mr55632wmq.3.1697750422195; 
 Thu, 19 Oct 2023 14:20:22 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a05600c130e00b0040772934b12sm5256785wmf.7.2023.10.19.14.20.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 19/46] hw/acpi/pcihp: Clean up global variable shadowing in
 acpi_pcihp_init()
Date: Thu, 19 Oct 2023 23:17:44 +0200
Message-ID: <20231019211814.30576-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Fix:

  hw/acpi/pcihp.c:499:36: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                       MemoryRegion *address_space_io,
                                     ^
  include/exec/address-spaces.h:35:21: note: previous declaration is here
  extern AddressSpace address_space_io;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231010115048.11856-5-philmd@linaro.org>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BED7BFA5C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBGn-00082Z-KH; Tue, 10 Oct 2023 07:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGl-0007zi-5n
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:23 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGh-000756-4g
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso8546489a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696938677; x=1697543477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLUjh+Qx8MrulfYzvPkIHnb5yPwNt/v/tfPLH7EDgjM=;
 b=Pi4zl7ViF5ITYdQXmFBTH5LGteyeQUIObBvcIqV6ONYgkIYK1JEbcMw9RE9Umbcq9x
 o8G+iQMshstxTfgXRGRmuWv8J1NSAstKHpL4k0e5nEBWG2Xq17P5HXMaO1um2+XZeJGg
 5mG+S8sM7ioNM3A/nWf0kI0aiJxL8JCalo1vA8Jk6k+5pq/UI3kLzkU+nebjpj2SHXsX
 P1vR3B8TSfY1q58X8sDOfhCAXzMzJLtygD/etTlxlQM4d9ogRo1bz+Y6dVq5Ofs8POOj
 tB1dzrO02CRw/C6IouVM46pS5CMnqjIvawhf5UqpldmxsyfG9sMfK5r0KEWU4FfVdaZ4
 b8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938677; x=1697543477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLUjh+Qx8MrulfYzvPkIHnb5yPwNt/v/tfPLH7EDgjM=;
 b=WYqDbLGrkQYNcaEHGeew6/TnT8XRphOLKcaGw7/3Q30G9oy6w6CYX1sxZVysFNe1oK
 ai4tAN/oTBjdpZAHATcatXac13/ekULs1zeG3+d8COZfK1OJg9BvQ/Ls/z1/gU7DIgZE
 XQu2kfv5FLshvwARFxEr+SBB5yyGofontfsPqnsX4FQbXAmH3pVZSxXoQP+xzGxXGa31
 c4iEpSFcp6UPxN5ZyXtsuXxuYDQNCC1vA58pWphhwTWLBMaP3fYIRtP6OxjhJyL78Q7c
 j/GjZhJXf92u5tdG0hd8+toAGzXlwxYCEZ5OXjNVJkW4kd4cLtqVjhowjz1JO6jD7wE9
 hqKA==
X-Gm-Message-State: AOJu0YwOTRb4vpTlTOrTtQfPObSOBTFP9Wo+lra6bPdBHlo7L/qLayS1
 7RAJ+j9D36RT1SoQKBOwxC/Aie9nOyF+MI3DOqHY3w==
X-Google-Smtp-Source: AGHT+IFAeqkXNZhQkKsngpxTsZIi5neBGqpZSnvN/M+q9+DT1P936yWW2Jj8tKUIaG+yDoSDdbNCug==
X-Received: by 2002:aa7:dcc7:0:b0:522:b876:9ef5 with SMTP id
 w7-20020aa7dcc7000000b00522b8769ef5mr14362256edu.8.1696938677099; 
 Tue, 10 Oct 2023 04:51:17 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 bf14-20020a0564021a4e00b005362bcc089csm7382182edb.67.2023.10.10.04.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 04:51:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/6] hw/acpi/pcihp: Clean up global variable shadowing in
 acpi_pcihp_init()
Date: Tue, 10 Oct 2023 13:50:46 +0200
Message-ID: <20231010115048.11856-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010115048.11856-1-philmd@linaro.org>
References: <20231010115048.11856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF47A2373
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBZ0-0005YL-Ma; Fri, 15 Sep 2023 12:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBYy-0005Xf-GO
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:21:00 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhBYw-0000X2-Sn
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:21:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c136ee106so302833766b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694794857; x=1695399657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJh8A0itxnh0qEmv9jrQE8icd48ukduXjwQKR8H2Trw=;
 b=mRk/hP13IAqqt6bqnDTkWdw3Vq6JRYh+K9ksgAWqUVPjTys+z3/SyywN/XJ7XYoeYM
 /b+P6oAA4TX8gRqH1j5nkAaCaLTojdL3d0tEVRxLKKh+Cdnss+V1kj/XQ0FrZurNwGpd
 Y6cXDxnwR3QyO4UCU8RNfunsBzO7cO5o4gyrbow6oF4nmjpmuvVyAslQPZ/h79+hcfBn
 +OyxOFdzgtPeo0Cg/HL5NHX58rORbkZ93qA3sjQYrE629vJgcSD6aYon7gKAjKzufcwj
 xveb1xrU1dB7BEwJnTBSJwktblBCzKyFM8vfeaCZzhc0eZzkqdBETHh/zhpgB5FL/sYP
 XVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694794857; x=1695399657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJh8A0itxnh0qEmv9jrQE8icd48ukduXjwQKR8H2Trw=;
 b=sBpFvNQ3h5P0SIhwZeT0cL4zhFdIWAuzNZK5BvDR6idKtxjrD/Z5ShI4f7Nw1AyLem
 oKBxw3xdEnG6uBazppEpghcbN8RZDwS3IBY3o8P2RqHqqRiGfCBthqVxMMIB/TBi5IaE
 j6yoBC5mnkozOM0bLEqkMbag6l/6MLBJ6If6ugt7ZcBvdUk6NI2EpSPyHK2nbNS9C8gR
 bJ6g0McT7Czi4WLkJiiLdCIOBkaqNKHx0eGQ6vGs3Le/4MZRjmW+JjTiNtrF9zM/QX1n
 UnBvqcTUSuc3EY0g7vX8X60X2D8dKDbg8ka9G4s2HO8hIPReXiofrboeWH4tYp5/XfzU
 TRmA==
X-Gm-Message-State: AOJu0Yxz1/LC3go+aUHb6aEOXmDUs0rSEXYjwAwmBGH/G1zZxNUE+S2a
 gW2P5t9347XPPq/u1NnnC6Z0KSXfFB1YmD3jHlY=
X-Google-Smtp-Source: AGHT+IHT2Yke+L8gEW2RG4bPIZaWWYrsVFYbwfPw6b0jUVwd8IFHtmsBLr3J2czzcg/ebIMcyorYkQ==
X-Received: by 2002:a17:907:7714:b0:9a1:bb8f:17d0 with SMTP id
 kw20-20020a170907771400b009a1bb8f17d0mr2088528ejc.30.1694794857251; 
 Fri, 15 Sep 2023 09:20:57 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 gy18-20020a170906f25200b009a9fbeb15f5sm2606542ejb.46.2023.09.15.09.20.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 09:20:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/intc/apic: Pass CPU using QOM link property
Date: Fri, 15 Sep 2023 18:20:42 +0200
Message-ID: <20230915162042.55890-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915162042.55890-1-philmd@linaro.org>
References: <20230915162042.55890-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Declare the 'cpu' and 'base-addr' properties, set them
using object_property_set_link() and qdev_prop_set_uint32()
respectively.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic_common.c    |  2 ++
 target/i386/cpu-sysemu.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 68ad30e2f5..e28f7402ab 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -394,6 +394,8 @@ static Property apic_properties_common[] = {
                     true),
     DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
                      false),
+    DEFINE_PROP_LINK("cpu", APICCommonState, cpu, TYPE_X86_CPU, X86CPU *),
+    DEFINE_PROP_UINT32("base-addr", APICCommonState, apicbase, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 6a164d3769..6edfb7e2af 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -269,7 +269,6 @@ APICCommonClass *apic_get_class(Error **errp)
 
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
 {
-    APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class(errp);
 
     assert(apic_class);
@@ -279,11 +278,13 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
                               OBJECT(cpu->apic_state));
     object_unref(OBJECT(cpu->apic_state));
 
+    if (!object_property_set_link(OBJECT(cpu->apic_state), "cpu",
+                                  OBJECT(cpu), errp)) {
+        return;
+    }
     qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
-    /* TODO: convert to link<> */
-    apic = APIC_COMMON(cpu->apic_state);
-    apic->cpu = cpu;
-    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
+    qdev_prop_set_uint32(cpu->apic_state, "base-addr",
+                         APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE);
 }
 
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
-- 
2.41.0



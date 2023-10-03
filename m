Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8867B6409
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnald-0005Zv-Mg; Tue, 03 Oct 2023 04:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnalR-0005Vz-Vd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:28:22 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnalF-00089J-KW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:28:11 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5041335fb9cso729247e87.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696321686; x=1696926486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqRKfDmguxU9p8cA86t//6SsyEhs/b5kalnp32Nd8Eo=;
 b=uty5On1BG5CzT64CO1wB09KLzDFm1T0qtA5n1yDxEGFgF+aUG5CotBD1MpjT+vnwCa
 2N2fgdi0YlDIHt3DBj7tE2MNFuFypL3sxcWFJpPDxNqR07yI4o9BrUXAB6tUMchms97I
 3LMND5UE+5DEpy4gqxsOxVOsyeiXSmGbzzb6pkU6ALB8U9/wotYB2+ObGIRd4BFH1WXq
 BzvMZ0TbzL7a8yrrKzEjGFImHPEfY3W/N1mei2ErJ/WHeP8LFT1Gwe1cVUkuAsjVRd8J
 /G/WXE5N66W7mbarnREnJoRMoSnAY8125g5LsjbJp8A/B/6xSDggDnWCvSYOfXczpnrD
 xetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321686; x=1696926486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqRKfDmguxU9p8cA86t//6SsyEhs/b5kalnp32Nd8Eo=;
 b=qfqZXfCQIKKc1sXnvgPJJllhIwHqTm6VYL//oVFJN/fFVTJjhU2uio4AtOIVEMzp/P
 sc0smkudjxkNWJKjbWkcVsUue04p05zuVhvRB7jjEXnwD2PwJj/vFluKdRZe2j98hZVA
 8pgZMVg9EACl7IaivL92QdN1u9Mg+DJXeCAbuH6sbKFzWrYiSkmBSWQhYWYGF5ZRDrkz
 kOkAF8A+VkhtcGsMyl5qwBBc3mQgZmfxs22Z2sYQyDzSuSFZynRMvbUtETbl7CpWPHaJ
 W/HCWsLLVnnSYQhH7z4nKl5wI7P5kDIIhtgDiQM7/bicvpTpCZTCI3kAZV8480JUx5NZ
 z4Jg==
X-Gm-Message-State: AOJu0YyW1i+qlRzmoM0zvzVlpkvH0/XDWC/4yNuX2ta1KKBTSrEyoQi5
 3PrutlKdGJOqFETpEWnYbp43YTVbXLywTqeHtixXgg==
X-Google-Smtp-Source: AGHT+IGt0oUY9KgCOY/MUfisHFm0LrQcQ8RHWsA7q4N6aQ+f5ELUxmlwszSqmglHlULa7Ny7O4rmGg==
X-Received: by 2002:a19:a414:0:b0:504:3424:2157 with SMTP id
 q20-20020a19a414000000b0050434242157mr10764174lfc.42.1696321686586; 
 Tue, 03 Oct 2023 01:28:06 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c234900b00405c7591b09sm701014wmq.35.2023.10.03.01.28.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 01:28:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/5] hw/intc/apic: Pass CPU using QOM link property
Date: Tue,  3 Oct 2023 10:27:28 +0200
Message-ID: <20231003082728.83496-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003082728.83496-1-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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
respectively. Since the _set_link() call can't fail, use
&error_abort in case there is a programming error.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic_common.c    | 2 ++
 target/i386/cpu-sysemu.c | 9 ++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 8a79eacdb0..be7cf3b332 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -398,6 +398,8 @@ static Property apic_properties_common[] = {
                     true),
     DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
                      false),
+    DEFINE_PROP_LINK("cpu", APICCommonState, cpu, TYPE_X86_CPU, X86CPU *),
+    DEFINE_PROP_UINT32("base-addr", APICCommonState, apicbase, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 373dc6b1c7..b084706531 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -265,7 +265,6 @@ APICCommonClass *apic_get_class(void)
 
 void x86_cpu_apic_new(X86CPU *cpu)
 {
-    APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class();
 
     cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
@@ -273,11 +272,11 @@ void x86_cpu_apic_new(X86CPU *cpu)
                               OBJECT(cpu->apic_state));
     object_unref(OBJECT(cpu->apic_state));
 
+    object_property_set_link(OBJECT(cpu->apic_state), "cpu",
+                             OBJECT(cpu), &error_abort);
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



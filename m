Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE62797298
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEef-0006Yp-Ue; Thu, 07 Sep 2023 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdw-0004WI-II
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdt-0007Vn-MI
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCbm6ozKk3fuAa8+Z4gDpKuSJgbF8JCXqIUlO58WCyM=;
 b=h48tif8VJETDT5YKJpwoEqga/ZV/m0xh2D0fEu0nQ/ypSSh3ZvasE+45ZNz3cjWJxwZK3e
 p2sEelm4MNjVfHje/V7GLQo4AeU3z9eDTiabEn1SIu9B1dIGAo+X9fWKAmnQKvDx9ENCtJ
 MDC7WKaqkIhkXWf4jUT1eu105zCIASQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-tIM18cV1MmanC01zsvzoqw-1; Thu, 07 Sep 2023 09:01:50 -0400
X-MC-Unique: tIM18cV1MmanC01zsvzoqw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50081b0dba6so973579e87.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091703; x=1694696503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCbm6ozKk3fuAa8+Z4gDpKuSJgbF8JCXqIUlO58WCyM=;
 b=mCz0xe0wG0ovNps4u1VTqkUNW/qwl5Dt6T9GlFWpmgAsLMZ9n467I/4YsyLe5Svi6u
 mFwlv6pBHVqTbeqxQv2gngeQDTYyjrCzIwcb/SmSOXtqwLWYnrkLY/8xEhtbpHpCJmQU
 5zXtatmWUSDfK/yoJcXDR382tfIKETtiq4tVg4bAjFW6xRwTMUmBOkbyRSrlzNU4Wg+V
 N9AqX82PgjOzDqC+0YwJeFPS/NA47Tvzij87NKM2sF1n4iSuFYIyoOOe2NuICnFdC6M/
 g2Xbr6STL+gKE+5C65pwBEzyHWAIZwxYtpT5DZaqNQcI2C5ARJ0YbaTso8J1uJHPYbDm
 YHXg==
X-Gm-Message-State: AOJu0YzIyP9haN+dS3kvSXX7Gi5QIDiPqh09N21i6JHR4mbzJHuGnyTj
 o57PKqcGBczoLR1QOSWA15LprWyey8NZEnAQ4CDw3EJVjo/ciVc2SNiUqeLGYJe7y/H6Y+gjd4f
 m7wZNIVGCSNGe64iXT0DEADiumdsDi/EbD8N4YlgywiVQxwj+HzxvEOp7lajCoF5xh/JYOTfFff
 E=
X-Received: by 2002:a19:5054:0:b0:4fe:8ba8:16a9 with SMTP id
 z20-20020a195054000000b004fe8ba816a9mr4988065lfj.55.1694091702753; 
 Thu, 07 Sep 2023 06:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/OxFNG52dsgJioAGC/3m4Wi/ejSjNgPrc8uYimyiv/5dRfB+RF2ruBWFfbE0CMc/b0cypPQ==
X-Received: by 2002:a19:5054:0:b0:4fe:8ba8:16a9 with SMTP id
 z20-20020a195054000000b004fe8ba816a9mr4988046lfj.55.1694091702463; 
 Thu, 07 Sep 2023 06:01:42 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 a28-20020a5d457c000000b00317f70240afsm23314381wrc.27.2023.09.07.06.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 42/51] target/i386: Remove unused KVM stubs
Date: Thu,  7 Sep 2023 14:59:51 +0200
Message-ID: <20230907130004.500601-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All these functions:

 - kvm_arch_get_supported_cpuid()
 - kvm_has_smm(()
 - kvm_hyperv_expand_features()
 - kvm_set_max_apic_id()

are called after checking for kvm_enabled(), which is
false when KVM is not built. Since the compiler elides
these functions, their stubs are not used and can be
removed.

Inspired-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-7-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm-stub.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
index e052f1c7b0e..f985d9a1d39 100644
--- a/target/i386/kvm/kvm-stub.c
+++ b/target/i386/kvm/kvm-stub.c
@@ -10,42 +10,16 @@
  *
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "kvm_i386.h"
 
 #ifndef __OPTIMIZE__
-bool kvm_has_smm(void)
-{
-    return 1;
-}
-
 bool kvm_enable_x2apic(void)
 {
     return false;
 }
-
-/* This function is only called inside conditionals which we
- * rely on the compiler to optimize out when CONFIG_KVM is not
- * defined.
- */
-uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
-                                      uint32_t index, int reg)
-{
-    abort();
-}
 #endif
 
 bool kvm_hv_vpindex_settable(void)
 {
     return false;
 }
-
-bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
-{
-    abort();
-}
-
-void kvm_set_max_apic_id(uint32_t max_apic_id)
-{
-    return;
-}
-- 
2.41.0



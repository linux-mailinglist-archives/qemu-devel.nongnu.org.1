Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708967BB61F
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoin2-00084y-IF; Fri, 06 Oct 2023 07:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin0-00084V-FC
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimy-0000Ig-Qt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsB4uEpw6TQ/yGY1vvqEV3rLzLTAOPIU4fgZDEtmCyc=;
 b=AOfAOVSENiWBUp3uvMOXP3crJV0/oEvps9r9LZNOg8RUHwXPHbdaJ20nm10QCIpAOQhB2O
 c518UijIOCIM9amVesAKN9Jfa5thYrOPWtUpjuM54NTSTrJk+1J3vOZoVpiwMNe/5wkWlm
 f7I+oKWf1DO0557+REemjb3X5CS6P24=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-m1oqScArMbCmr5I0OXYnXg-1; Fri, 06 Oct 2023 07:14:19 -0400
X-MC-Unique: m1oqScArMbCmr5I0OXYnXg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae7663e604so168533666b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590858; x=1697195658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsB4uEpw6TQ/yGY1vvqEV3rLzLTAOPIU4fgZDEtmCyc=;
 b=ZSOshhLzM7wAhEF+0kSyp9lGlna3VcsWCG9Tt1KBaenpX4TgW+zmpEPnF7vY/0hoxB
 hpVxx6LBkyEDFlxIGRlZWbk9lK7fOyOBs3pVRCJqAccO49PUE77OJs0S/amqxLvKAcYe
 ktpJLosNeCpDFJZoP9Z89bfYZSq4GBU3+uwjPeF9yd+Q5KIL76gMAxVSVI3oxS8oOpGK
 Tk/d7suxF+sSxEx/sNM2ZT0TnsD4sHSY9ws4ncrOA7eFENcljsq7vHpRXMov7VuwlnOn
 zwhdNiADxKV4WDfK3gx1PmQTVD53BCtm0Ou8UEtTF6WS9NTjB200fEsQDTV4IEXL/kbN
 VvEQ==
X-Gm-Message-State: AOJu0Yx/wWGwVl/OjAQM6abXO1rGOcuEpV1EJrC2+7W1Ri1Tj6y49gi/
 4xRH/w0dkmC+FYt0TQLEdXsxzZAYUbm63Yw5bGp6XRumlxA9gj5VFmCCAGV3eFucgzf4Sr0ERb4
 fl1BDbsXlwvxbLK+E26pFP433JpxLr5lvDeAehoIbodVmn/EO56+dJAJ31NFVYF0cQQgoiW2Ock
 8=
X-Received: by 2002:a17:906:20d8:b0:9a1:bebc:8282 with SMTP id
 c24-20020a17090620d800b009a1bebc8282mr6758231ejc.32.1696590857952; 
 Fri, 06 Oct 2023 04:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSVGlhu6KwlMKPyY/emAI90D/7YGwYOhIy9VQdDOBhknp84SAXS8rkVnxQGxXMTTtSqEq6zQ==
X-Received: by 2002:a17:906:20d8:b0:9a1:bebc:8282 with SMTP id
 c24-20020a17090620d800b009a1bebc8282mr6758218ejc.32.1696590857535; 
 Fri, 06 Oct 2023 04:14:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1709061b4600b009ad81554c1bsm2702126ejg.55.2023.10.06.04.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/26] sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86
 targets
Date: Fri,  6 Oct 2023 13:13:48 +0200
Message-ID: <20231006111412.13130-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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

hvf_get_supported_cpuid() is only defined for x86 targets
(in target/i386/hvf/x86_cpuid.c).
Its declaration is pointless on all other targets.

All the calls to it in target/i386/cpu.c are guarded by
a call on hvf_enabled(), so are elided when HVF is not
built in. Therefore we can remove the unnecessary function
stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004092510.39498-3-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf.h        | 3 ---
 target/i386/cpu.c           | 1 +
 target/i386/hvf/hvf-cpu.c   | 1 +
 target/i386/hvf/hvf-i386.h  | 2 ++
 target/i386/hvf/x86_cpuid.c | 1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 4037cd6a738..4a7c6af3a5f 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -20,13 +20,10 @@
 #include "cpu.h"
 
 #ifdef CONFIG_HVF
-uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
-                                 int reg);
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 #else /* !CONFIG_HVF */
 #define hvf_enabled() 0
-#define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif /* !CONFIG_HVF */
 
 #endif /* NEED_CPU_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed72883bf33..5b620500abf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "sysemu/reset.h"
 #include "sysemu/hvf.h"
+#include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
 #include "qapi/error.h"
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 333db59898a..21c519be741 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -15,6 +15,7 @@
 #include "hw/boards.h"
 #include "sysemu/hvf.h"
 #include "hw/core/accel-cpu.h"
+#include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
 {
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 243bc111ccc..e99c02cd4bf 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,6 +16,8 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
+uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+
 void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 7323a7a94b1..9380b90496e 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -25,6 +25,7 @@
 #include "x86.h"
 #include "vmx.h"
 #include "sysemu/hvf.h"
+#include "hvf-i386.h"
 
 static bool xgetbv(uint32_t cpuid_ecx, uint32_t idx, uint64_t *xcr)
 {
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D015819081
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWn-0001kv-44; Tue, 19 Dec 2023 14:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWl-0001k3-0f
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWi-0001lO-DP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c38de1ee4so49389915e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013191; x=1703617991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jvn/OVUOD0Xhju1C/N/gil1Qe6DSfBId9X5CN10lS/s=;
 b=Sc/pNbIjAshxj3GnUIibJq3AjMHU1XUw0EbN/9/UGk4MV5pzYO5uwIjLOFc+qX+D1H
 R+fOHWWR5RE+sef3NiHPx0mLBU9tlNF/n/5ED/G6AZOPr9q6j4I08jEw+DJ9IB9kNTrO
 KYLwd6AsP4fU8m9NF27ehr9x5yJUip1rhdQOfSVNDYmRHtXMD3uuW7dZskuNx4kHHlmW
 xiIY4ArwsUtMdEuFJRgd17XiUszMgnwQ8AGGErs/+GsfdjX7KIb9PWCmtqsa2kROWNnh
 kGNsDlXsyDcYHjb0fAzVswxDZ4ptIUfsO1XgnwXktY8Sz+rqU/ft1z5w/kgdohoQduk3
 i+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013191; x=1703617991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jvn/OVUOD0Xhju1C/N/gil1Qe6DSfBId9X5CN10lS/s=;
 b=HSrcweyrx9dWlKJmSyqLJrwFPkOdovgIHKyt5zBAZoW2n3KyOHQIaw7xFOt/8lNr2L
 Ld77AYmQN79gRw1uIWbDHOojTJyFAUBG6Mt0vMcLamErl9WNhv41rmWCdsJwWcJ/GpIQ
 IgOTpDX+g37LfF8evp6KDBMh68C/ZgZLvAFuWjduLkg9uIOf9MJyNu789fCOF/yxzgN2
 MmkbiOLcvrqlQn6z0HwAmdhF6jdMcRu30we6+soXwV50vL/KNjAF1xJQKImrfBoRe+ZH
 F1Ajjrj3GCcqRKh0F7C7rapt80t5R79qytLJCvEvUGLaUVGvXM0Jcw/1bve41s/qkX2B
 ZPYg==
X-Gm-Message-State: AOJu0YxLff97PXP6R5j5dm4Pj/waFnh26JuYYD97MpSsCell2Ifba0/c
 DGUBoAc8gXNDBvE6xRX/JSo3UtmSxaJQpxCX7DQ=
X-Google-Smtp-Source: AGHT+IFqPuguhx1yQ8pU8oxyqluBWGzeTd8LbFkI1Zf3IzdKo5NeMo7SHJVEr9iXny8exY+/xm9LnA==
X-Received: by 2002:a05:600c:4714:b0:40c:6593:6290 with SMTP id
 v20-20020a05600c471400b0040c65936290mr4603904wmo.19.1703013190929; 
 Tue, 19 Dec 2023 11:13:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/43] target/arm/kvm: Merge kvm_arm_init_debug into
 kvm_arch_init
Date: Tue, 19 Dec 2023 19:12:27 +0000
Message-Id: <20231219191307.2895919-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  8 --------
 target/arm/kvm.c     |  8 +++++++-
 target/arm/kvm64.c   | 12 ------------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 051a0da41c4..fe6d824a52c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -18,14 +18,6 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
-/**
- * kvm_arm_init_debug() - initialize guest debug capabilities
- * @s: KVMState
- *
- * Should be called only once before using guest debug capabilities.
- */
-void kvm_arm_init_debug(KVMState *s);
-
 /**
  * kvm_arm_vcpu_init:
  * @cs: CPUState
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7903e2ddde1..b4836da6b25 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -308,7 +308,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    kvm_arm_init_debug(s);
+    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    hw_watchpoints = g_array_sized_new(true, true,
+                                       sizeof(HWWatchpoint), max_hw_wps);
+
+    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    hw_breakpoints = g_array_sized_new(true, true,
+                                       sizeof(HWBreakpoint), max_hw_bps);
 
     return ret;
 }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index b8bb25a1eaa..40f459b7862 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -33,18 +33,6 @@
 #include "hw/acpi/ghes.h"
 
 
-void kvm_arm_init_debug(KVMState *s)
-{
-    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
-    hw_watchpoints = g_array_sized_new(true, true,
-                                       sizeof(HWWatchpoint), max_hw_wps);
-
-    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
-    hw_breakpoints = g_array_sized_new(true, true,
-                                       sizeof(HWBreakpoint), max_hw_bps);
-    return;
-}
-
 int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
-- 
2.34.1



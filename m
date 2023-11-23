Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4FA7F577E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:44:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YI-0006Vs-1V; Wed, 22 Nov 2023 23:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xp-0006LE-Q4
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:30 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xn-00065r-Rl
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:29 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b842c1511fso330781b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714544; x=1701319344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH7qrfCWzzImD63ZDY8zW+pyuXHpfd4KHpoGwFQ2aTE=;
 b=C0mXLp+N/ir6oZPnPJOaQfni1Zcm5hcyzOGL4m7gq9l9pKRUiPwhE8gOpuHGk+INUX
 P2MlfbxFRo9nEP6uAt2TV/fHKigm0i4EN4PId3sXV4GtYHoeI3XwlJNU/hQs96vhbaW5
 IRE0ApQZcr8uQQ+C6Gnec0X/CS1CS87MexdHDHQTHAel5IFHTZcE5U73Y9se6YFA6/m+
 JzhfJi/wQjxVOBx3hDtobhQ2EktSJk7XPkFziaXb6i+iZfx9xPkV9NLPRP/Wa//g550w
 JGtt/f38da+RAlFAL9OvUh94MPzN63pAot+n0ouSEFCbe0AA/qjgxf0Zx1yS4nFDmFLE
 /6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714544; x=1701319344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NH7qrfCWzzImD63ZDY8zW+pyuXHpfd4KHpoGwFQ2aTE=;
 b=OfhBlTurue5GbuBX/n7X3/pDUhIiPY39fpdODNpmyblowXvbdYDJHKKMNB4I/p+mNx
 5wwrLA+GJswbajE/0b6VqsNCn9YEZzoJxn3aTZ47oCCHknl9jAVCNxdBskyxGuuAmC4g
 v3kCRo6e3hyNl0a6hJJmxkvie2HOTf/aTrsz2uzGvwQwEWY1DNtrQqjIZ4efcM9CTr72
 uia41YH7AXzMAHVUx6Y2VxEHgoIf1Zi+/06xPavkM+UuvL2LPkgEasn42uBq/X7m4s7t
 SWnfM3pEOwhliAjkz+z+Ipr1Wdx0qEV9HFep0QQkxd/4sQ+WidtglZXs9LuaoWcaCShT
 63wA==
X-Gm-Message-State: AOJu0YzWBT+Cysy3ySaQn+2uGOr5nBAQYI7BqXVIHw+8DD2dw+L+4Piu
 5smVLpU6zAg8GZa5nf9GdafA3gj0ld5JzkXJiHDiVJuw
X-Google-Smtp-Source: AGHT+IEw9yXohLNZRG/niwWeatM2t/epJ22uL90EuyBInvwBdeoKkIOzgXwFLyUtYlvWnQrcWLHGDQ==
X-Received: by 2002:a05:6808:2392:b0:3a7:37ae:4a47 with SMTP id
 bp18-20020a056808239200b003a737ae4a47mr5852535oib.12.1700714544330; 
 Wed, 22 Nov 2023 20:42:24 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/21] target/arm/kvm: Merge kvm_arm_init_debug into
 kvm_arch_init
Date: Wed, 22 Nov 2023 22:42:01 -0600
Message-Id: <20231123044219.896776-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h |  8 --------
 target/arm/kvm.c     |  8 +++++++-
 target/arm/kvm64.c   | 12 ------------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 051a0da41c..fe6d824a52 100644
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
index 7903e2ddde..b4836da6b2 100644
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
index b8bb25a1ea..40f459b786 100644
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



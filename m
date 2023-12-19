Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C54C819086
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWn-0001mY-Rw; Tue, 19 Dec 2023 14:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWl-0001k5-4L
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWj-0001lK-23
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c3fe6c08fso56500835e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013190; x=1703617990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F3jDm6hsuPn369Wfm7LfYD3ZrqbNS5l6yUoiu2wnKtg=;
 b=ORXSRtICHeMcAZA+QFJd47mFqT0mF/ElJBSUq1tt7IvcRVphjewYCmWgudwVFL5Nen
 Q4/GSZdBsvEX7cDyN2qaI6P8tn2WWsXj7EJwF3+UDCIRn27KVblZl2tBD8PslA0dJGXy
 8NE9KN4qqWZqY1hctAbBtIpqx4p7xAHoqwM1TufplDrF2CP7JwWpPeriTQ+fpdOf+D2R
 gttyeLaKK2s0DWjktCBiUbuQPBc5X2cYHUkE2fjlYpa3syGEQxjpP8npC9/USlDRK6Se
 CA65XKljL8xFNsiNuM3NVjgGA3AS1JFxkveVyvF7/txoQnaSo7dBMFk3Gv8GJ/61AkAW
 RmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013190; x=1703617990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3jDm6hsuPn369Wfm7LfYD3ZrqbNS5l6yUoiu2wnKtg=;
 b=s7bWSB1pVVbc2XrDPNO2yYkE+hBlcvMFjdqkHgwy18itaiVuV4SnA/jX8uUW9v+Qo3
 vFC5I70NSqNb6kc9TYj8ZQvULBFN/v7pXF9wSk/SIgx1Av2K097jBKYb7W421GdMUycd
 lFkke42sttNhptqJLIs8gCWedF1IN1EcVIbIR8rXq7TrmGKem/PTPm/1zbjDiVaFbGVk
 2q43BTAXJqH5vxeCLnJKJ0+4IKbK5rT2ILKtBBmNh99yQLk4/W8jP4THeiqNYNK/Da18
 6n0nm3zk7WinT2ketda6nLFfsbouG6O3W0mdMhKuYDShLbMJQ5QGQX+nyAkOLJqjsBFi
 BlrQ==
X-Gm-Message-State: AOJu0YxiU8HPxAr2OaDXE9xcy0Hy2ELMY73Y86PeuDjPUzk5G4EJ+2b9
 xRYcVJxwvdoKQknzpGfj+U2cyjRyaXIsFgdayqg=
X-Google-Smtp-Source: AGHT+IGDqMgdXc3M+uIw8511sqYOy8r0wMPutaNm+Iy8KzcULfpBbfuk0X+vV/YOSIXavIIGeNa31w==
X-Received: by 2002:a05:600c:2802:b0:40b:5e59:99b6 with SMTP id
 m2-20020a05600c280200b0040b5e5999b6mr6808312wmb.214.1703013190477; 
 Tue, 19 Dec 2023 11:13:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/43] target/arm: kvm64: remove a redundant
 KVM_CAP_SET_GUEST_DEBUG probe
Date: Tue, 19 Dec 2023 19:12:26 +0000
Message-Id: <20231219191307.2895919-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Chao Du <duchao@eswincomputing.com>

The KVM_CAP_SET_GUEST_DEBUG is probed during kvm_init().
gdbserver will fail to start if the CAP is not supported.
So no need to make another probe here, like other targets.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231025070726.22689-1-duchao@eswincomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3c175c93a7a..b8bb25a1eaa 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -32,13 +32,9 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 
-static bool have_guest_debug;
 
 void kvm_arm_init_debug(KVMState *s)
 {
-    have_guest_debug = kvm_check_extension(s,
-                                           KVM_CAP_SET_GUEST_DEBUG);
-
     max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
@@ -1141,33 +1137,23 @@ static const uint32_t brk_insn = 0xd4200000;
 
 int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
-    if (have_guest_debug) {
-        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
-            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
-            return -EINVAL;
-        }
-        return 0;
-    } else {
-        error_report("guest debug not supported on this kernel");
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
         return -EINVAL;
     }
+    return 0;
 }
 
 int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
     static uint32_t brk;
 
-    if (have_guest_debug) {
-        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
-            brk != brk_insn ||
-            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
-            return -EINVAL;
-        }
-        return 0;
-    } else {
-        error_report("guest debug not supported on this kernel");
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
+        brk != brk_insn ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
         return -EINVAL;
     }
+    return 0;
 }
 
 /* See v8 ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
-- 
2.34.1



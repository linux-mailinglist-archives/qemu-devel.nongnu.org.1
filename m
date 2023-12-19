Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8532819071
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:15:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX8-000220-I0; Tue, 19 Dec 2023 14:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001zc-3g
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001sN-Fk
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:31 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c236624edso54041375e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013207; x=1703618007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3OdKUaJzJak2eJQTHO6VMVDhLUVUEOXkAdntoItIO00=;
 b=mqgwWU7d3m47kwVFn1TJ7XRihgcdPXFNv7xbqPHPItrSHnMhtWKjI68y7UWyNft6Xs
 ku+yuzwZbTo04qiOG0oa3irf0VE1gJnppLQOjI2HQrpLOKCE2c6oilFpq8lAiZpypzRg
 PadlId9hNDMTd1Whh/YelqmJB5aqf9JJCqtnAMkjiWrMipZVXBXb1iQWZJHT9kC7VU1E
 Tuk8mv5eYuj6eNh/GCKeAQhd4/RnlY39/uVATX3kC6NBdE69KItD6ieNrPSv9vOkFPtR
 Oh1A9/6BRV3TA8rlb0AZDl1iKPjglSVkyHEVavMjVUvPEQPOWeBG+hmehvV6aJW0Z1Mt
 HXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013207; x=1703618007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OdKUaJzJak2eJQTHO6VMVDhLUVUEOXkAdntoItIO00=;
 b=JARoYOrOvt8h6FfodYY1+Mj6p17Rgv/ZrCGiseA6mZalzubo0ab6ja4i6jVSnxi7US
 PwigF/cLkuyOSTsK7xuWw1gbnhBaTdzw2L4DRwFqBs5f1n9Od+d4ATwR8NlscAUNlIhr
 MIeipSzvdFJN6q3yeL6RdhFDtCd9MdAdqynVU51ATTB/5GmhuoCPxrmHZnwt8vR+1XwC
 cmJ3F8IzR91xcMyVFPjOOtPooahVgv+Zp78abAO8R6/OC9IgqQwxN6twvxdCZZ4gSKkd
 8g56LmRgfgLFjx/v+fk3AiCtldkxWu+YADUvadiNEQ2SgUmZlkm31NFVRJImHrRuMN0u
 5Jog==
X-Gm-Message-State: AOJu0YxLmp1rhtnxWWiwim/HP+eMFviCYQ+hPDsZlWh9HnE70+eGFFWF
 QKuyK+Ctb2ZJd7uIXaw6gcP4gKL40i/l5gM1r40=
X-Google-Smtp-Source: AGHT+IGnnspE7Dph81DxXwA12I+VBrjv+juHPva6t3s/1nxF+yihD4nh6hhzEkO+sbcWzWUmcHutpQ==
X-Received: by 2002:a05:600c:a43:b0:40d:28ce:bb9e with SMTP id
 c3-20020a05600c0a4300b0040d28cebb9emr765800wmq.58.1703013207172; 
 Tue, 19 Dec 2023 11:13:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/43] target/arm/kvm: Have kvm_arm_hw_debug_active take a
 ARMCPU argument
Date: Tue, 19 Dec 2023 19:13:01 +0000
Message-Id: <20231219191307.2895919-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231123183518.64569-17-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6794dc8ad61..c5a31838437 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1453,11 +1453,11 @@ int kvm_arch_process_async_events(CPUState *cs)
 
 /**
  * kvm_arm_hw_debug_active:
- * @cs: CPU State
+ * @cpu: ARMCPU
  *
  * Return: TRUE if any hardware breakpoints in use.
  */
-static bool kvm_arm_hw_debug_active(CPUState *cs)
+static bool kvm_arm_hw_debug_active(ARMCPU *cpu)
 {
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
@@ -1491,7 +1491,7 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
     if (kvm_sw_breakpoints_active(cs)) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
     }
-    if (kvm_arm_hw_debug_active(cs)) {
+    if (kvm_arm_hw_debug_active(ARM_CPU(cs))) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW;
         kvm_arm_copy_hw_debug_data(&dbg->arch);
     }
-- 
2.34.1



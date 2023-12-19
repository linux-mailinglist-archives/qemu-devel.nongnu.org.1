Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E88190A3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWv-0001ve-Uq; Tue, 19 Dec 2023 14:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWs-0001sx-35
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWp-0001oG-MS
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c580ba223so61798725e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013198; x=1703617998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ak4CxhUk6h6TwjSSh7FmGz1AnjJa6mERKfsGXTlTv5I=;
 b=iU+Oe0L0YTfviGJej6mIaV3BOcQ+AfabeQf621bU6Qc6Px8izwf/H18YdN3vlrNBm6
 z7eJfzmKYDHtYlPQaAaWpkARMwS5sLtRFT7iURpGaXwMkyGJcr2CaAbre05rj9lDh/9a
 0LgqWR52huOm+nH8JDLuYLgEdpXfs8hrfqeLSN7tKgzw2RzfBbqvFV0+enjhF9aunl6F
 Spfh22bvSyK4t+oHb8haE20SpIJKGRsOLfBx6EmnPlpFz+hIkw7+nDl6ImuHhEZf2ZO6
 uMZ2ZpUIqQO3ibReaQipd3ViZQ33jFzrkULLWwx9lmjsPO1DaFNbc7JXV7gjNRrfGFAJ
 9+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013198; x=1703617998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak4CxhUk6h6TwjSSh7FmGz1AnjJa6mERKfsGXTlTv5I=;
 b=Wxd+3ZcSV8DEWd8MJT6fXe5HRxqSHr6djmE1Eeqid8w/GiGnPxB4sPZqj17hfb1OQo
 +z6lv/kLQvVoiZc618RTcOIflitLgvaqeqy2Q6sTXdmyNtWpdrBHQYbxXl3+3m5gbxFt
 oQSzd/AUm8hMBkx5CYXdAFhW7d0xohB/KyAs5v/X6pO6gcQcYxj/DnP0HX7lLvUccx/y
 pfNL7E2P7O7It0V3hijEVOSaozauzrE6jkQFo60L2UI1sjw1yP4cbC33ijzc3jenoUZP
 qsu6jmPYx/K72DhL4sb+bUnVabF0csN3ekfh6ovq5ZeDegc3oSMwzFwxEMRXMh+SyFPb
 6Ycg==
X-Gm-Message-State: AOJu0Yyp504XNOyaNwFg1rM1YzYqKqj5w+LKw+4u8ToF7PpAG++lFNMr
 cUyNqiJ59HuE4Q9uQ31RVylsg2UKWuBZQ8kMrm0=
X-Google-Smtp-Source: AGHT+IFmHy3p7qwNlY0O4aKm/sjXp2uxScOWuHVBYJjCmw/ukrmTSPWZ5QskBFzguwQJU0oKqelXxw==
X-Received: by 2002:a05:600c:450e:b0:40c:3508:b409 with SMTP id
 t14-20020a05600c450e00b0040c3508b409mr10051256wmo.111.1703013198419; 
 Tue, 19 Dec 2023 11:13:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/43] target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
Date: Tue, 19 Dec 2023 19:12:43 +0000
Message-Id: <20231219191307.2895919-20-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 20 --------------------
 target/arm/kvm.c     | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 1ec2476de7b..b4339d49d11 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -98,26 +98,6 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-/**
- * kvm_get_vcpu_events:
- * @cpu: ARMCPU
- *
- * Get VCPU related state from kvm.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_get_vcpu_events(ARMCPU *cpu);
-
-/**
- * kvm_put_vcpu_events:
- * @cpu: ARMCPU
- *
- * Put VCPU related state to kvm.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_put_vcpu_events(ARMCPU *cpu);
-
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4a5553864a0..b8923fe1776 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1090,7 +1090,15 @@ static void kvm_arm_put_virtual_time(CPUState *cs)
     cpu->kvm_vtime_dirty = false;
 }
 
-int kvm_put_vcpu_events(ARMCPU *cpu)
+/**
+ * kvm_put_vcpu_events:
+ * @cpu: ARMCPU
+ *
+ * Put VCPU related state to kvm.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_put_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     struct kvm_vcpu_events events;
@@ -1119,7 +1127,15 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
     return ret;
 }
 
-int kvm_get_vcpu_events(ARMCPU *cpu)
+/**
+ * kvm_get_vcpu_events:
+ * @cpu: ARMCPU
+ *
+ * Get VCPU related state from kvm.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_get_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     struct kvm_vcpu_events events;
-- 
2.34.1



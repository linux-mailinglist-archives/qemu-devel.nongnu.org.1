Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F03EA791769
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8ws-0003v8-IK; Mon, 04 Sep 2023 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wi-0002sR-2D
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:49 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wc-0004sh-6r
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:47 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso219547166b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831478; x=1694436278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c18azMn+jtI1YAn3dB0AGJOCqMNVzX0REantB+5g0DU=;
 b=WlkJXLjDr5p81463F//uUUFzTs4M3arxxHO3pd0X7GwKzvVMD4KAs/HnnrqHH9CKnl
 hZ96fLDTUuzcWAggBeM8QdCRAT18r1mkHgiKDITDMGv3wgoKS3DC7d5qfKsbTw9Oe7Pb
 XYleYjG3CudJ9aU+1h0xdBtz7ya1ZqSb1/01zyRdSWfZcQu1kc0dhei2zfdINxEAmGnx
 vOM6p7Is+nJ1h/8c83AZtF9N3BZqbh19qsxMqn4PmHe6s4g9psg2tGvGQ5Q2ZkMKqab1
 tRDsnOv4yaDzZPgDFjRUGFybk9o6HiJ9h19xHdHV+5tEFwde751i5w82b0/liA7sJl53
 nolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831478; x=1694436278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c18azMn+jtI1YAn3dB0AGJOCqMNVzX0REantB+5g0DU=;
 b=gd+JXPHhHuqyqQegIRpH23sOIJNaNcAuMObZzKVH4V4MvlLOYe6zUDvpAGZ0c/IJUL
 3IceZWcX+w4Pcpr9JEBiTDa3Lx6AVrc51k4L2NKVvvXAO21h2RzKDMJsYYOpSs9bja4m
 6u+alArqNZy1m8xEuZZRa/alFgYG24y5OD0FqMb1hWw1QTpmeGQ23WvZT8Cq08UTbqIC
 NpVQO2IGlQL8u4B5QAQnuYo5UN1RxofSwEKwczPPLR5rXMgw71YHLqz9L1f0ENBfOhR7
 70JDLUwLn8h/wshHy/bfNzuIDuN1VJs/7K4foCnhzyfOHsyC0dy663ITdYXltwFZPaE1
 hVfQ==
X-Gm-Message-State: AOJu0YxKVPLwM+rbS4Q63slFggnAfN48ZeYP68i3ZHIcEGoYHdEe3BDK
 k1BIoDDGHnXl289INoVnPCq94I3vvneNMdVTQWo=
X-Google-Smtp-Source: AGHT+IGkBWzlSRGBOELBpUf+dLc0WEpvu9JCETivRhredxbliVAZerUGcF4mTiM1Pqigg7YcHDOtcQ==
X-Received: by 2002:a17:906:5a6e:b0:9a2:24f9:fabe with SMTP id
 my46-20020a1709065a6e00b009a224f9fabemr6871711ejc.66.1693831478762; 
 Mon, 04 Sep 2023 05:44:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 hb26-20020a170906b89a00b0098cf565d98asm6058630ejb.22.2023.09.04.05.44.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 12/13] sysemu/kvm: Restrict kvm_has_pit_state2() to x86 targets
Date: Mon,  4 Sep 2023 14:43:23 +0200
Message-ID: <20230904124325.79040-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

kvm_has_pit_state2() is only defined for x86 targets (in
target/i386/kvm/kvm.c). Its declaration is pointless on
all other targets. Have it return a boolean.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h       | 1 -
 target/i386/kvm/kvm_i386.h | 1 +
 hw/i386/kvm/i8254.c        | 1 +
 target/i386/kvm/kvm.c      | 4 ++--
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 4326b53f90..147967422f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -221,7 +221,6 @@ int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
-int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 int kvm_has_intx_set_mask(void);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index d4a1239c68..76e8f952e5 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,7 @@
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
+bool kvm_has_pit_state2(void);
 
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 6a7383d877..a649b2b7ca 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -34,6 +34,7 @@
 #include "hw/timer/i8254_internal.h"
 #include "hw/qdev-properties-system.h"
 #include "sysemu/kvm.h"
+#include "target/i386/kvm/kvm_i386.h"
 #include "qom/object.h"
 
 #define KVM_PIT_REINJECT_BIT 0
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 639a242ad8..e5cd7cc806 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -154,9 +154,9 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
 static RateLimit bus_lock_ratelimit_ctrl;
 static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
-int kvm_has_pit_state2(void)
+bool kvm_has_pit_state2(void)
 {
-    return has_pit_state2;
+    return !!has_pit_state2;
 }
 
 bool kvm_has_smm(void)
-- 
2.41.0



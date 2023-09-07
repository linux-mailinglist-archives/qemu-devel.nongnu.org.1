Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1196579729A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeh-0006rP-7b; Thu, 07 Sep 2023 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe7-0004fG-0d
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe3-0007Xp-IT
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIIvR3K4rXWSNaWNDTeRXv+dkuqfOIauPPV/2IMVpP4=;
 b=B3bEX4E25DJR+mVmTEjY5RIryD/vZLJkSDX2hNqzk14n+eMVdmAHRLAoIsljEAYytGijEU
 rW2S8FCbVF21yY5ZyNyEbkvE8VH9H/uwE8DLYug4vgHL0Ewn4beC4lCTKzAT8vrcFRsSRW
 lGyXjYSk6mrK+j7TVDe57y3d1G0FSmU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-m1YurfUkOiiPL3wqtNeroA-1; Thu, 07 Sep 2023 09:01:58 -0400
X-MC-Unique: m1YurfUkOiiPL3wqtNeroA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so6681815e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091716; x=1694696516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIIvR3K4rXWSNaWNDTeRXv+dkuqfOIauPPV/2IMVpP4=;
 b=TLgH7T1FlvfOAwVMdD8SsCtpbLHnR8obyUuodQNzytEx6NWTV1zt524GO3tpm4qcNH
 NVWU1Cl/Kw3q4DXh80Pg9R+5voHxUyOX4qZGLqNwwU/2uA2+J8rQLfyyWu9F+Uuvxy4K
 nRUVXDTCLfq+IQLmCaL9VSX2RuMH1Q3f2617l/ppcMXiG6rutVeOvzgr9o1Vyua29NoO
 yPWSq51b3J5J9Ot5BtZIKlZiyRjoM+s94Yv0DdgVZVVLxX4mclweDnQC6oqKvh6xZJNs
 JMzfpobKh+xEewFXjU9Rs2xNcz9/nOr+8Ro9IcuU98MjLfGyWsKSD4pypCYYzzAm6r4J
 qlYw==
X-Gm-Message-State: AOJu0YwBwFuHXXB0yUwOx6OGG+Ht59nksMfrAl3xRKjwjdNBS+t4O2lD
 XxlQ2F+eRJC7UD1CoegX4f8b/yHmw8O/QoLAO6qOLR42yAyxsODi+vHfMGBuLcHwJ3Db9J2x5D/
 DzrsCop6JewP23RodPyc/IdZ07aEgiVdGYo19pF1+TbOIKfbtqf7Mrirc/svlFkHfbY6Jk+F0ZW
 8=
X-Received: by 2002:a05:600c:249:b0:400:6bee:f4fe with SMTP id
 9-20020a05600c024900b004006beef4femr4610441wmj.21.1694091716273; 
 Thu, 07 Sep 2023 06:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElZ43KvTRb+B5vJWThxxqrOJW05UO+FdfFniiWolMYa512bFUTThm2jPTKys6X4mmj+TuM/w==
X-Received: by 2002:a05:600c:249:b0:400:6bee:f4fe with SMTP id
 9-20020a05600c024900b004006beef4femr4610429wmj.21.1694091715951; 
 Thu, 07 Sep 2023 06:01:55 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a7bc44c000000b003fe61c33df5sm2457667wmi.3.2023.09.07.06.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 48/51] sysemu/kvm: Restrict kvm_has_pit_state2() to x86 targets
Date: Thu,  7 Sep 2023 14:59:57 +0200
Message-ID: <20230907130004.500601-49-pbonzini@redhat.com>
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

kvm_has_pit_state2() is only defined for x86 targets (in
target/i386/kvm/kvm.c). Its declaration is pointless on
all other targets. Have it return a boolean.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-13-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/i8254.c        | 1 +
 include/sysemu/kvm.h       | 1 -
 target/i386/kvm/kvm.c      | 4 ++--
 target/i386/kvm/kvm_i386.h | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 6a7383d8774..a649b2b7caf 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -34,6 +34,7 @@
 #include "hw/timer/i8254_internal.h"
 #include "hw/qdev-properties-system.h"
 #include "sysemu/kvm.h"
+#include "target/i386/kvm/kvm_i386.h"
 #include "qom/object.h"
 
 #define KVM_PIT_REINJECT_BIT 0
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 4326b53f90f..147967422f4 100644
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
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 639a242ad8c..e5cd7cc8061 100644
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
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index d4a1239c68e..76e8f952e5f 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -33,6 +33,7 @@
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
+bool kvm_has_pit_state2(void);
 
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
-- 
2.41.0



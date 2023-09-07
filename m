Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498E79728A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEed-0006DK-Tq; Thu, 07 Sep 2023 09:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe1-0004aJ-RF
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdy-0007Wg-98
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmixq+DPUWzXn9es08YKOqzSkEEgLhEbQB5clQHVKAY=;
 b=P+IRII4GqWJGK97BuyQWXPwjPabJwLE8Cjn/OIi7fL0colZs+fb8sFU8AsaS1Zilcapbdf
 Wpe12GOLGuJegYWo6rWcYV2uBnjslOU6Ecznw1Eq9naMhOGX6l/XnGyXE5ToHH1paWxiCm
 hllDyW9HeGc2xs/GDiI46n3KTD1f7aQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-iOdTimzhNO2_CqfpCe2X7A-1; Thu, 07 Sep 2023 09:01:55 -0400
X-MC-Unique: iOdTimzhNO2_CqfpCe2X7A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2be51691dd5so10224331fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091712; x=1694696512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmixq+DPUWzXn9es08YKOqzSkEEgLhEbQB5clQHVKAY=;
 b=b2BdpqbPrK3vZ9Cgcsp8C+rFji7gXjZR8XZ8zOpGB2iFJppDerHKIXWFIg6UA7SWIJ
 o4MhYNJ7r5b5ecS90wCzoE+UV7pV96pne6hsioSNlprF+tpa5RTR2czE2uYxFGKitn9v
 BDCvbKF+TgiunNtPcGYVPC1GrXZf0MZZcEE3EGYmvX5AEmDT8vh9JpK0Juz3scSS1QBf
 EhZUumiZuawNK9LdqrmtDXLf0s6ak5wJpHszgVXjU5tiAuuwZ+VOTvfcSfpmlX9YrcLu
 +Wg3YtQ6uulEwP3xh14wDXzD7MI1ZgyZ/KfKeN4CziBJCPjEYAYfj+9TgMfCh2wngwUS
 H3hQ==
X-Gm-Message-State: AOJu0YxXd3le0Yj1szb5NDoPSnFaMDX2904dROEm7es1GGSCK8LN+9Sd
 S22UCUDWemHMjhjLUjJGcG60WIP535ugtBotvlaj3O4nTUDu8eFWXzrK5vT4XKK4vA8FSOPFBYe
 oTRBcucPQxYOYkKcI+1EQHcGjhXYazxlsvoK7HnIY/ZL5Tk6owrtc7YrOgQ2BJlMrU+rBRURAVz
 4=
X-Received: by 2002:a2e:300e:0:b0:2ba:18e5:1064 with SMTP id
 w14-20020a2e300e000000b002ba18e51064mr4128676ljw.14.1694091712368; 
 Thu, 07 Sep 2023 06:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxiEh7n2u3oqq7II17cEomHS9MIIv2eBGbWsUy8DMxvhmEQw8IkqzDZ+j7sTAp33XT1/y0fA==
X-Received: by 2002:a2e:300e:0:b0:2ba:18e5:1064 with SMTP id
 w14-20020a2e300e000000b002ba18e51064mr4128656ljw.14.1694091711913; 
 Thu, 07 Sep 2023 06:01:51 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a05600c20cb00b003fc080acf68sm2455738wmm.34.2023.09.07.06.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/51] sysemu/kvm: Restrict kvm_arch_get_supported_cpuid/msr()
 to x86 targets
Date: Thu,  7 Sep 2023 14:59:55 +0200
Message-ID: <20230907130004.500601-47-pbonzini@redhat.com>
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

kvm_arch_get_supported_cpuid() / kvm_arch_get_supported_msr_feature()
are only defined for x86 targets (in target/i386/kvm/kvm.c). Their
declarations are pointless on other targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-11-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h       | 5 -----
 target/i386/kvm/kvm_i386.h | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ebdca410527..a578961a5e4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -464,11 +464,6 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
         kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
     })
 
-uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
-                                      uint32_t index, int reg);
-uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
-
-
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index ff309bad25f..b78e2feb498 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -40,6 +40,9 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
+uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
+                                      uint32_t index, int reg);
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 void kvm_set_max_apic_id(uint32_t max_apic_id);
 void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
-- 
2.41.0



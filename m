Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25866791783
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wr-0003kf-C9; Mon, 04 Sep 2023 08:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wS-0002Y9-VJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:36 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wP-0004ks-4H
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:31 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bcc4347d2dso20034271fa.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831467; x=1694436267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9c1++OFXiKHirX3uQNfDd/RXZK+lEL70eHdHIGvdol4=;
 b=fWk/Zq3ceQ7UglWsyYHnFamB0IOzavOkRrA4EjYZGAHdfTPMrV7c9E4sDCqPH/+HWI
 M3cu+rqvJ4zrVI7Oiwu8ho8g9L8KlJhXSqNSicL+ooarZ+bGE/UoKYJ+wrVFegscKE6I
 6gk6/+FzHoqjZakkgi/yWhtUKHy7zj5035b4Js21fQBkXZdb2cpWIyx8I4YtJW2ROjA2
 Ic55XjrlPML0gTzqavSGxFDNHi37d8b+WVnD2XwlvRYJhrM7YS4h7YNdSspBeP73EBWN
 pGWpT2+i9UJnxqHBR+lsodFOh7ns4pzbhdMCCOmLvoag/ELIEl5PUEsTtb1hHrjYKq/4
 sr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831467; x=1694436267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9c1++OFXiKHirX3uQNfDd/RXZK+lEL70eHdHIGvdol4=;
 b=Ap1VDdxCwjAcAbJzVwksu1wRDndEtaRw7SEFNcW0fggNMIk8itraMgQ7b8MCpxczwK
 VpZWE4JvvaEAnswY21covSlxtx+XumcvMoKDbHO9znWq53eivf9C2Uj/0Iv5mk5umIwC
 MakJPu7a4sn0Th5Z/TFmQva674V97w1BBIPgbYo1NSHFF/LqQE34ZQVEKptqdqnm/oI5
 RKDnJkYCIvr2vcvGku53xPAXC0m4WOtovxWax+0w7phHLeUMBDd3xNRaMlRWK8iV4QSr
 ZmCTZ/zLadXhRTnZElCV5WKR90PzzQ90vLP/tVLa2WEUFj04U2Un2F+Dk00C5I4dwHdt
 3gLg==
X-Gm-Message-State: AOJu0Yyhbn1skzyRVMA+I3BDgpQhE714IwBR3ZVQkhV9YxNGaMchIFQ1
 PcG6TQ5MRr0lTJIyMVXqOYtrzrcrC7lHll0YqjM=
X-Google-Smtp-Source: AGHT+IEWA9agBIka4/UEdzmAwtfRA+imBetPWuYVWeGSiJIg5JmAaXx74MtNWsYTkyhrhZ9vNtQo1Q==
X-Received: by 2002:a2e:908a:0:b0:2bc:fce1:54d3 with SMTP id
 l10-20020a2e908a000000b002bcfce154d3mr7414408ljg.41.1693831467132; 
 Mon, 04 Sep 2023 05:44:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a1709067f8f00b009934855d8f1sm6127181ejr.34.2023.09.04.05.44.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/13] sysemu/kvm: Restrict kvm_arch_get_supported_cpuid/msr()
 to x86 targets
Date: Mon,  4 Sep 2023 14:43:21 +0200
Message-ID: <20230904124325.79040-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

kvm_arch_get_supported_cpuid() / kvm_arch_get_supported_msr_feature()
are only defined for x86 targets (in target/i386/kvm/kvm.c). Their
declarations are pointless on other targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h       | 5 -----
 target/i386/kvm/kvm_i386.h | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ebdca41052..a578961a5e 100644
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
index ff309bad25..b78e2feb49 100644
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



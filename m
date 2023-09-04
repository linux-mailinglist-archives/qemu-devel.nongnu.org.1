Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75997791768
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wo-0003IW-Mt; Mon, 04 Sep 2023 08:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wM-0002Ui-NC
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:34 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wJ-0004kN-GI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:25 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bbbda48904so22935531fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831461; x=1694436261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfDnH2zi19spDXT1YZEdk2e2zvrpSHkYzKDFanumPPE=;
 b=OFetcV02ajE+PqlKu5fqrE509BbUwXTdtoYOnacoN56eVwIUD8S9s/eAzrY+iwiYkE
 j/MLAyUjbv9KoKG9HAyA5Cnh6EimPxQJVuHvp/g69foed4PfuRYzfBTNHrr0DEkiUy/I
 6VaJH1sL747WCUNBjzHcJU9iqApHFI3PHqRxCRN65+11KR/WAmgdEMyaO7q/fNoZvNLi
 sNAAZjNfA10HzA0hpUgTT/pQnkdYWo/rtZN2nbupMG4DRQB5pgEtyRPCxH5gdJLA7VvS
 UcJaMlTLSZyzBX/7R9lSAQ9El5fS1Ntu0kXH0BuCd5lMNSIxZ+Gc38PYyAKiONduYAIk
 zN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831461; x=1694436261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfDnH2zi19spDXT1YZEdk2e2zvrpSHkYzKDFanumPPE=;
 b=J4pYeDN9hgR3ct6tpmEBMG0Hj7KusIWtsP4ASm+gcnOHuK5y3j9e5e1hV06Rw7PSaN
 Ah8Hdu3fJTjDS+CF6X+efWQlvhtZ12ZG5m9Ug8nqmBiTkk3KdO0Yr2hDR9YwDC0/j5Gt
 EuGEL5lErkPNshR5D/B+PnOCmMQhIMzq0Moh2h3V8rI8a9panOluymp7CCDnQb2I6M4G
 WcLepNDkyT5xFpWi4BajUfBvfzXSw8WM0lNEQ3Kcn/HW73FUfY0wTjmMy5c/loo5x/q0
 nKNbadkp+HpcugrA3m06JOPNen7tuNxvjRqpn9vyqtbmbJApC/uWRC/hF2hxmUXVvuET
 wuww==
X-Gm-Message-State: AOJu0YzMOZhQYYfdLXniYUNE0go+RRqYiMGWwQxpQwmh7pmF1eL8zfQ8
 oQCiAO6S2v2w9pUcUYWDT++epzEwRq+pMZe/06U=
X-Google-Smtp-Source: AGHT+IE976/wb9043fTOX1jLNvYiAsS+SMGWMVP8cKCaRkt7WlpkXdAiG5q4d7+oUS7QvOusWuayLw==
X-Received: by 2002:a2e:a176:0:b0:2bc:c466:60e9 with SMTP id
 u22-20020a2ea176000000b002bcc46660e9mr6704259ljl.49.1693831461543; 
 Mon, 04 Sep 2023 05:44:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 gu18-20020a170906f29200b0098f99048053sm6215400ejb.148.2023.09.04.05.44.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/13] target/i386: Restrict declarations specific to
 CONFIG_KVM
Date: Mon,  4 Sep 2023 14:43:20 +0200
Message-ID: <20230904124325.79040-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

Keep the function accessed by target/i386/ and hw/i386/
exposed, restrict the ones accessed by target/i386/kvm/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm_i386.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 470627b750..ff309bad25 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -31,30 +31,35 @@
 #endif  /* CONFIG_KVM */
 
 bool kvm_has_smm(void);
-bool kvm_has_adjust_clock(void);
-bool kvm_has_adjust_clock_stable(void);
-bool kvm_has_exception_payload(void);
-void kvm_synchronize_all_tsc(void);
+bool kvm_enable_x2apic(void);
+bool kvm_hv_vpindex_settable(void);
+
+bool kvm_enable_sgx_provisioning(KVMState *s);
+bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
+
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 
+void kvm_set_max_apic_id(uint32_t max_apic_id);
+void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
+
+#ifdef CONFIG_KVM
+
+bool kvm_has_adjust_clock(void);
+bool kvm_has_adjust_clock_stable(void);
+bool kvm_has_exception_payload(void);
+void kvm_synchronize_all_tsc(void);
+
 void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
-bool kvm_enable_x2apic(void);
 bool kvm_has_x2apic_api(void);
 bool kvm_has_waitpkg(void);
 
-bool kvm_hv_vpindex_settable(void);
-bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
-
 uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
 
-bool kvm_enable_sgx_provisioning(KVMState *s);
-void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
-
 typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
 typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
 typedef struct kvm_msr_handlers {
@@ -66,6 +71,6 @@ typedef struct kvm_msr_handlers {
 bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr);
 
-void kvm_set_max_apic_id(uint32_t max_apic_id);
+#endif /* CONFIG_KVM */
 
 #endif
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5827972A2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:10:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEek-0007G5-E8; Thu, 07 Sep 2023 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdy-0004X7-EP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdv-0007W6-Bh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpvS7kXL3QPxpjC9VxkOF+3EPpNlxl8dKSrXGx/rLrM=;
 b=gEmbZPkIxcWWUEe0TlbkPC6B9jRl9kGD+sT5fgRSe2RpIyewi0qyFcjEO67sKtz/WqDUcu
 BR6rnH6++DS4FfsEiKLQmQmuPzlCKm657W+w8T2TXlcCzvfDkwrPc85rq92mOS64I70XfW
 +/cH8BrP/67Q+Key7T3LU44rNCS345c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-W3AORoUBNraZhigSKtqqXw-1; Thu, 07 Sep 2023 09:01:52 -0400
X-MC-Unique: W3AORoUBNraZhigSKtqqXw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso8835735e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091710; x=1694696510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpvS7kXL3QPxpjC9VxkOF+3EPpNlxl8dKSrXGx/rLrM=;
 b=cs+usAVTvyDLcX8XSUaM992Loc7M9aS5UGGfzEItfB3YNLeMbSKIW7SdsDCix2+YKG
 LISNMAPUfwQ76cxtFL06iS7wqgRNVRVFPgCUm/I4gTqjgvBaII4vAW6akoHKbIpsMudT
 8xYWJSf4HCOb7LDRm9h7Xo+duI80F+gsVTHDL9wUpTCXXaxWJY0MuPmRrryp0dajgjlt
 HYZgJLluDk7Qbz0dNZ9iuDhiaa3txgBMQCuxUReYaERfJg7i/UEDFoltCeoxqIt52Ntb
 Y7djwiGLv1Of+l/oitLfTnmPpb63idPVfzqY5QEyeLHnwHuKI8LnJPE6hiASJa3Hw4b+
 r3cg==
X-Gm-Message-State: AOJu0YxcgjFLNLff6RvKwOhK/7gsyKB4jJqjt0r70Bpj45Nj0SUMg/0J
 uFk5ZehbqzpPLRfzo2DFayFekzQFEpcRh8BWBc/56OzOnOSGYOfs1dn5j0R4//0vfGsn/CIAkHR
 TfRdbYPf/najtr0ip5Vlmp6AGO/UJhri9IQT4C0oEqgBdE+vMww8oLNBqy0DJnnoKXCjqmSW3Ln
 M=
X-Received: by 2002:a05:600c:1d1c:b0:401:bd94:f45b with SMTP id
 l28-20020a05600c1d1c00b00401bd94f45bmr2127646wms.4.1694091710487; 
 Thu, 07 Sep 2023 06:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6s9uUOr/hwHUE1ZEkt/xj/9GDweoKQoR3gvPkQx78YCjDb6pMbj4sMJ/FxPw2vw+jFc3kCQ==
X-Received: by 2002:a05:600c:1d1c:b0:401:bd94:f45b with SMTP id
 l28-20020a05600c1d1c00b00401bd94f45bmr2127578wms.4.1694091709283; 
 Thu, 07 Sep 2023 06:01:49 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c025100b00402c0a8a084sm2501217wmj.17.2023.09.07.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/51] target/i386: Restrict declarations specific to CONFIG_KVM
Date: Thu,  7 Sep 2023 14:59:54 +0200
Message-ID: <20230907130004.500601-46-pbonzini@redhat.com>
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

Keep the function accessed by target/i386/ and hw/i386/
exposed, restrict the ones accessed by target/i386/kvm/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-10-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 470627b7504..ff309bad25f 100644
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A77D788E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnIW-0002GK-8s; Wed, 25 Oct 2023 19:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIK-0002AE-Mi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnII-0005L2-SS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfQ/cMpbpaCvSibIc0j/d7DzhI6+GW3SWKL1MBnpcn8=;
 b=GoXgy8y1hFJWSMJZJ9wk9REFZVbV9/35JhsCciZ6fQvRnQDVIeiutbA7noq+5Q6eBthKI6
 PZGPDrWsRasIIK/+AWbKLbhOoi5RTfw8O4oMCpazSULsRFSXG8FlNZ5gltT96Cj/gJLHNb
 xWQHjlo8g/3HvncXN8CEajlcyP76eDk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-hQ4uadL_OFmx-uX9xKh5Ig-1; Wed, 25 Oct 2023 19:28:01 -0400
X-MC-Unique: hQ4uadL_OFmx-uX9xKh5Ig-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778b5354c7bso45736985a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276479; x=1698881279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfQ/cMpbpaCvSibIc0j/d7DzhI6+GW3SWKL1MBnpcn8=;
 b=Pmi/W98GExmyaohdj7MDWCAen1hB2FzSNkzMLYU0VqzrTTOMa4EpLSRX6Hy2wRq+9f
 pIInKhbl1Z/X2UbMBZO1+yLFPHRQs17yQ8S7/+NortTKFSLFcbHKULHwOpzJ1CyLzDsa
 TWSJPBuWMlccAoDKtfUikb89GcJWFPfwiix5J3t4sgTrYVX4Zm7m9e2aYMUiqe30Gta8
 PKM+BwCduFw/GFFmQuejSzeV2hImxfhCyl8sVSLm0BkMJ0/Gs3Onxeo01w6fw5Qin1+v
 PHYDYiNQwgwjEdBwmrsej52EmCcS6Sh3Ew4P95ClhFkQQRduC1llDWZppKaUeBzP5MPV
 qn+g==
X-Gm-Message-State: AOJu0YyViXsoIzgnVopj4V5FSNnP8YyQiG4/a0N0NyNJZD+A3kSGqxj2
 DnoWgnRXjpaPf4dJFci/58abKm3QawOEtpqURvgt0IZ3xxKBz2NmgKj20g2UpuMn9G2T9ukYkqX
 4Ar4pULw4vwJMxMXqBqfIKlPjoiJaVCl/wMdNbWK+JFuP4/goKN7Z8l7Y5Dr5UzflE3yhU1xWvt
 8=
X-Received: by 2002:a05:620a:1328:b0:774:2113:743a with SMTP id
 p8-20020a05620a132800b007742113743amr17368085qkj.19.1698276479343; 
 Wed, 25 Oct 2023 16:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9r6hWQ+sSJRAi94Vk6s8R6f+5n1VI5XnfQb0UPuyLeE2DkVSjVpfk0lCI48IE2JtrFUt+QA==
X-Received: by 2002:a05:620a:1328:b0:774:2113:743a with SMTP id
 p8-20020a05620a132800b007742113743amr17368077qkj.19.1698276478984; 
 Wed, 25 Oct 2023 16:27:58 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a05620a215400b007756d233fbdsm2949347qkm.37.2023.10.25.16.27.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/24] kvm: i386: require KVM_CAP_MCE
Date: Thu, 26 Oct 2023 01:27:14 +0200
Message-ID: <20231025232718.89428-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This was introduced in KVM in Linux 2.6.34, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4a244174a0f..42574c2df89 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -97,6 +97,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(XSAVE),
     KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
+    KVM_CAP_INFO(MCE),
     KVM_CAP_LAST_INFO
 };
 
@@ -582,14 +583,8 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
                                      int *max_banks)
 {
-    int r;
-
-    r = kvm_check_extension(s, KVM_CAP_MCE);
-    if (r > 0) {
-        *max_banks = r;
-        return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
-    }
-    return -ENOSYS;
+    *max_banks = kvm_check_extension(s, KVM_CAP_MCE);
+    return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
 }
 
 static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
@@ -2116,8 +2111,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
-           (CPUID_MCE | CPUID_MCA)
-        && kvm_check_extension(cs->kvm_state, KVM_CAP_MCE) > 0) {
+           (CPUID_MCE | CPUID_MCA)) {
         uint64_t mcg_cap, unsupported_caps;
         int banks;
         int ret;
-- 
2.41.0



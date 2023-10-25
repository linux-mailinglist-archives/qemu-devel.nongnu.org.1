Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BBF7D7888
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnIM-00028x-0a; Wed, 25 Oct 2023 19:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIF-00026F-3H
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnID-0005Jp-7H
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eo1OoCHjtMPg9CFeTq8xoeHrClNrtF9bywrJHkhtQM=;
 b=QdVw0lQw5+vYnyZvV6egfMXrM4CbehceRMCUaWfoZHZKQWoJoG5D9XL6ky1sTtFRYF24b5
 iAmar8UF3TGcMJqztBOReman33nWKdgcV1bdzSzme1I4bre3UU3DAjGVWUjp9C0RydNY3y
 SV02Yc6dGjIq4w76IxoxQIiOI6U8ELU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-qHrR1N6pMqWW52cDqrL4pw-1; Wed, 25 Oct 2023 19:28:01 -0400
X-MC-Unique: qHrR1N6pMqWW52cDqrL4pw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d062708b0so4117006d6.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276481; x=1698881281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2eo1OoCHjtMPg9CFeTq8xoeHrClNrtF9bywrJHkhtQM=;
 b=OggK5bcJmKhUcUypCfkyzz7/GoPNXC51wpeTl/U9Dm5lwW5U2eM3LG8X1c+aQM4enw
 lNq+x3SdV5wb2dkvzoQfmsQu5JxzhZnmGKFEAYYCqWg9ssNGIL98camk9qS0aYvCPwmU
 eMlI4xcD3TvSa24LmZcU6BWMFZcHv7DI3kLd7FNZXj1dqKHZV3ccIw3EHFHmnIy92N2a
 +bA2Xo3C6Qqzifn73rQHFLwgJb3mwntaytqqRAYbakh02+YGPYMJ2XpGCCcbKEdJyH3U
 P8DWpsrGtEiFBqvZJ8koF6XtlKj5KnZF7oNqswiK8LjXOFiBeBjpLJlq49zGrPcqGSpx
 k1EQ==
X-Gm-Message-State: AOJu0Yz+s+XcTPDNbjiQyKgNR0IcwrKYR/JEHPCOqW4At7p7ontqV9Tp
 Bzhh2NcbwIUGJOOItL5UjhXQ4pg9AGibTXrw4PzHc6fUPxJOl/cv80IoRYGYNRJlWB61lRm+tGk
 lSan6K1yDnpcUDVL6I6IQ16aBz0fuJu9R/KtBO31n5/g1zZFp++zflmBsS0e2oQJ+xF2sAQXgRj
 c=
X-Received: by 2002:a05:6214:d66:b0:66d:1e25:9774 with SMTP id
 6-20020a0562140d6600b0066d1e259774mr18460992qvs.61.1698276480844; 
 Wed, 25 Oct 2023 16:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnqpPgLiioEsnFaLlWiG6g6d9zK1UfYHFZ1NWUucaLXQmqLGcd9wb+k34hc8+jrLVeGwkyjA==
X-Received: by 2002:a05:6214:d66:b0:66d:1e25:9774 with SMTP id
 6-20020a0562140d6600b0066d1e259774mr18460976qvs.61.1698276480465; 
 Wed, 25 Oct 2023 16:28:00 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 s8-20020ad44388000000b0066d11743b3esm4744860qvr.34.2023.10.25.16.27.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:28:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/24] kvm: i386: require KVM_CAP_ADJUST_CLOCK
Date: Thu, 26 Oct 2023 01:27:15 +0200
Message-ID: <20231025232718.89428-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This was introduced in KVM in Linux 2.6.33, we can require it
unconditionally.  KVM_CLOCK_TSC_STABLE was only added in Linux 4.9,
for now do not require it (though it would allow the removal of some
pretty yucky code).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c        | 4 ----
 target/i386/kvm/kvm.c      | 6 +-----
 target/i386/kvm/kvm_i386.h | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index f25977d3f68..e756b0aa43f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -333,10 +333,6 @@ void kvmclock_create(bool create_always)
     X86CPU *cpu = X86_CPU(first_cpu);
 
     assert(kvm_enabled());
-    if (!kvm_has_adjust_clock()) {
-        return;
-    }
-
     if (create_always ||
         cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
                                        (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 42574c2df89..d4bf327fa6f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -98,6 +98,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(VCPU_EVENTS),
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_INFO(MCE),
+    KVM_CAP_INFO(ADJUST_CLOCK),
     KVM_CAP_LAST_INFO
 };
 
@@ -177,11 +178,6 @@ bool kvm_has_adjust_clock_stable(void)
     return (ret & KVM_CLOCK_TSC_STABLE);
 }
 
-bool kvm_has_adjust_clock(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
-}
-
 bool kvm_has_exception_payload(void)
 {
     return has_exception_payload;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 55d4e68c342..7e60ea4f23f 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -50,7 +50,6 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
 
 #ifdef CONFIG_KVM
 
-bool kvm_has_adjust_clock(void);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
-- 
2.41.0



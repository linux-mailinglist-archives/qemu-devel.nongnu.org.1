Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0557CD6A0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1ud-0000vV-LW; Wed, 18 Oct 2023 04:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ub-0000mc-MS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ua-0003bs-0y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7xyo+qk2Hmn+FRqA7cbZGYx0K1TdHtmSr+gpBySNFg=;
 b=MAFSS++J9NN9Md5h3mAPIg2gAcs6QQdteNkyykJhnNtxdc8prwXvjJFyAsjZCkdCgSx7gy
 8crgRz8EkmooOGK/uBguP0S67EHA1KMmaEbkoMufTNplehejM6oKR4pg1TjpgjSpSaF8AU
 5VtqDPv7j8uY0tezzylbL4x0G7v484o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-rh0GtM8hPvur8a2u3Qbiyw-1; Wed, 18 Oct 2023 04:28:04 -0400
X-MC-Unique: rh0GtM8hPvur8a2u3Qbiyw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso1609221e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617682; x=1698222482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7xyo+qk2Hmn+FRqA7cbZGYx0K1TdHtmSr+gpBySNFg=;
 b=gJY3xmqSAz6ECtay0jiFosgAJHEUtAb262IDRr69v+2HpL3K231I9LyOq7dyjdh9WH
 xloFOfp0ADjGXhN/NGXbpZL3keyKVdC00sfSN/8+QJmlKjHx66B1AUgNTm5KzQhPqSFM
 liNi4EKeiXG3p04onPcQt9pPgp0Bvutcnsf8NBBsViWfHmY0d8mzBNmo41BgS6SwU0y5
 5qMRQJBuvTvtyCC16qMnms8eBwIlnOyo9vk5SynMbC/nVEF/5TfwxDWiej0wkKIRGlPq
 jiyPZRaa8qX4IOJV6n3w8J2BZFVu38qUP4l3jBOuO9zbiaEWPd+qucFavanTU61/L5T9
 YhiQ==
X-Gm-Message-State: AOJu0Yx95Y51uxebrE1RxV+BSnop371FrI+zKPGdjzaA48vFRMLbCqWc
 qiexyE1ng5MlSh7DGsrj2XAIOcppCVcovKu/pwXcu1NBoUKpCPq9ZuBC0Un2yUgblz2thbDDoBR
 DsANtiKEZKE5CnmRU7ppXw8HrOBKB+CTd6mmm6vi9o6/djhDwcHQO6ZxG8eguLBYwPLXtTYofR3
 8=
X-Received: by 2002:a19:f80f:0:b0:507:ab5b:7b6c with SMTP id
 a15-20020a19f80f000000b00507ab5b7b6cmr3263263lff.36.1697617681913; 
 Wed, 18 Oct 2023 01:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFutWX2mcIlN1/kMR5cE028bo6W7nR2my1fGLRY6y1nrSKGTRqR37ZrhKhr+YjXGIWiQLwfSw==
X-Received: by 2002:a19:f80f:0:b0:507:ab5b:7b6c with SMTP id
 a15-20020a19f80f000000b00507ab5b7b6cmr3263247lff.36.1697617681442; 
 Wed, 18 Oct 2023 01:28:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 x90-20020a50bae3000000b005342fa19070sm2434257ede.89.2023.10.18.01.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 04/32] target/i386/cpu: Fix CPUID_HT exposure
Date: Wed, 18 Oct 2023 10:27:24 +0200
Message-ID: <20231018082752.322306-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

When explicitly booting a multiple vcpus vm with "-cpu +ht", it gets
warning of

  warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]

Make CPUID_HT as supported unconditionally can resolve the warning.
However it introduces another issue that it also expose CPUID_HT to
guest when "-cpu host/max" with only 1 vcpu. To fix this, need mark
CPUID_HT as the no_autoenable_flags.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20231010060539.210258-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c     | 1 +
 target/i386/kvm/kvm.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3aab05ddadc..bdca901dfaa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -778,6 +778,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {.eax = 1, .reg = R_EDX, },
         .tcg_features = TCG_FEATURES,
+        .no_autoenable_flags = CPUID_HT,
     },
     [FEAT_1_ECX] = {
         .type = CPUID_FEATURE_WORD,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f6c7f7e2686..ab72bcdfad1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -373,6 +373,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     if (function == 1 && reg == R_EDX) {
         /* KVM before 2.6.30 misreports the following features */
         ret |= CPUID_MTRR | CPUID_PAT | CPUID_MCE | CPUID_MCA;
+        /* KVM never reports CPUID_HT but QEMU can support when vcpus > 1 */
+        ret |= CPUID_HT;
     } else if (function == 1 && reg == R_ECX) {
         /* We can set the hypervisor flag, even if KVM does not return it on
          * GET_SUPPORTED_CPUID
-- 
2.41.0



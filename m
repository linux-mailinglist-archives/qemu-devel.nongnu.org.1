Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2F9A09A91
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 19:53:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK51-00070z-SS; Fri, 10 Jan 2025 13:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK36-0001xI-TH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK34-0001Ft-CS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZwSEYQVpte/NSCKZ3yifhKY5nLmZ34Bel3Y7xhbE78=;
 b=QjQoyXJfCgm5/WA0BkY74Ou0bBpLNECQDU8Ep6aZfxqkK3fYlSBX2gQQizUxjvdnQNkKps
 KN5VuZ70uR61kAfpzlWQ8bACVhbmNk0bvCmj2NeAdzMVzXKBWMlqn5ZclZiYgnkKwBuumq
 nwqOIRQA+9Cd7Xl7Y2XRuOYQHU/6lpg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-f_ot_YczOhifiXb24KF2_w-1; Fri, 10 Jan 2025 13:47:56 -0500
X-MC-Unique: f_ot_YczOhifiXb24KF2_w-1
X-Mimecast-MFC-AGG-ID: f_ot_YczOhifiXb24KF2_w
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d09962822bso2304073a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534874; x=1737139674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZwSEYQVpte/NSCKZ3yifhKY5nLmZ34Bel3Y7xhbE78=;
 b=WVxzWUor6ygtLvjcrMWBO/kjDH9aFJqcKmVkNF7t8oOcKxV0IAoeAOdIGjHo/HqI4v
 8qZOYCK6iPQ5Z20ejYd4Y71UZrS0E7Jzi70hY8Jb/vKQSe0fcNS2OLkvPUIZYBWNW9Sc
 Ry3T9Jip73sDeNMGndbqgvvgzEWrXB0r76ZH7hVy7AF2aiYZEGVrzP9LGaBpis/zp2g7
 KDu+nK7mj2BaaRo0FHA89nHiyGRx52Bwsr6ZO/mPzKC+FXWctd1oceejSe4lREo0dkjr
 jdqbtsA8JZz6VDxTfS6+RO8cnkVS3MmGy4stOk954oPsxCl5SyRGKjQ4fHzk5vaPOp7e
 Bcjg==
X-Gm-Message-State: AOJu0YytlI9GUGIJF6clCqV08w01JahqO1BNFP6nngc3pJcUtXUNoJzc
 8EypHUBCKJ4LqH06E2/W6Y+TMMP0Ce9KoxYwKC8SYAdiVSs0PwcDe6DpS9hWk4C+Dq8a9cLtjYc
 eqwVxfMXK8YRe27Nz1z0T6WKseLWLfhCQEphd2JCH8pfLsVcyvUEXZDX/DWsdiWzM4l7ezTur67
 KKrjT137KLCXTOKDbVCgtxzrb7vjtse+sGK9FE8Fg=
X-Gm-Gg: ASbGnctWw6aj2qUsIQS3yMdGXoQ/aCw1mRBmX3374bbf1qaEADFcqQoyHK6coeClBl/
 Z8XNd/cUkm7ihrHr7F0Fw3+2r5iOr+Z4+pBKadSfzdHBBGklEtsqFH6KcS51DVjuid0WEawaAWE
 DqCNl4oKxBsdC5hCtxroF500hR1qtxzq4Mzjmqku9ZDsx84pro6XNIDJ2zL2IenGpkuiGlsAXy9
 fXsFvLBZNL6sEOfqE9Hq6koqvS0PEgmQ64R5ieyNJKZeakgw7DktZpNcD8=
X-Received: by 2002:a05:6402:274c:b0:5d3:e766:6143 with SMTP id
 4fb4d7f45d1cf-5d972e7247cmr11355882a12.30.1736534873883; 
 Fri, 10 Jan 2025 10:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZOB2XuhTyTVWuqOQ3YoS5HysxqigKzBLiM1JgK9WKbLfI8QQCsKAIf/hy1tU7KyfhsB8QIA==
X-Received: by 2002:a05:6402:274c:b0:5d3:e766:6143 with SMTP id
 4fb4d7f45d1cf-5d972e7247cmr11355854a12.30.1736534873292; 
 Fri, 10 Jan 2025 10:47:53 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c3333sm1981068a12.47.2025.01.10.10.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 38/38] i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
 env->features[FEAT_8000_0001_ECX]
Date: Fri, 10 Jan 2025 19:46:19 +0100
Message-ID: <20250110184620.408302-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The correct usage is tracking and maintaining features in env->features[]
instead of manually set it in cpu_x86_cpuid().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-11-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3f0821c15f2..1b9c11022c4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6953,17 +6953,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
 
-        /* The Linux kernel checks for the CMPLegacy bit and
-         * discards multiple thread information if it is set.
-         * So don't set it here for Intel to make Linux guests happy.
-         */
-        if (threads_per_pkg > 1) {
-            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
-                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
-                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
-                *ecx |= 1 << 1;    /* CmpLegacy bit */
-            }
-        }
         if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
@@ -7530,6 +7519,15 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     if (x86_threads_per_pkg(&env->topo_info) > 1) {
         env->features[FEAT_1_EDX] |= CPUID_HT;
+
+        /*
+         * The Linux kernel checks for the CMPLegacy bit and
+         * discards multiple thread information if it is set.
+         * So don't set it here for Intel to make Linux guests happy.
+         */
+        if (!IS_INTEL_CPU(env)) {
+            env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_CMP_LEG;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
-- 
2.47.1



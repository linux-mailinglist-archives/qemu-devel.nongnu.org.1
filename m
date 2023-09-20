Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D087A88AA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 17:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qizKo-0003YG-5W; Wed, 20 Sep 2023 11:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qizKj-0003Xn-T4
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qizKh-0006f6-Ez
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695224502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ImKsrOm22l0Cjly0XJLu90aEyOOxO+NlelGomc6l0Dg=;
 b=KaT4bsQD3sTKYuJmW/crhdGFDwwGt200a8YOVmFA6EmXtsgJSywzCOE5pahER0uc6l37Xd
 DsdWA8d/alhSzyElBGHO9igcR4WRcD7XpFkaPnOcJVi/2P8RCpftGBNXmW0YQKuGTHut/O
 Latqx8igPnw9pWUuisWwXGnLs+3X9Lw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-QhocAhsZNcKafrdWpoGe3w-1; Wed, 20 Sep 2023 11:41:40 -0400
X-MC-Unique: QhocAhsZNcKafrdWpoGe3w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31ff9e40977so3416562f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 08:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695224499; x=1695829299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImKsrOm22l0Cjly0XJLu90aEyOOxO+NlelGomc6l0Dg=;
 b=EFIRQzZeIDnTkTY2Exwrtj8wfZ7cq4/T79hfjqo6f+J7O54sTOY/ZGznKXMLQam8yG
 N+GqV+G15FYYdtmRlRR3PNSdUtX5NqUSK3YRa2zjOXjbAGg58iUG4HV1g6Yg8vqC2971
 39l113CE258HTSgon3s7Z9+b+kXK+NL45UAM1f0Kv3wp5XmKbKsvUFkiFb9pPM6IQHf3
 luC3joitwsVXSYdJF8XBMU8/Tfgs0On5tL4peF/AzEs8afOcQSchJU9RZ8R7MEDX+1VL
 FEq6Wi6P8jIASmaZGRbZkSxJVfBogL48d4huL2U97qdDvEHDeE+FpHJzV+OBbUWjmDJR
 CzEQ==
X-Gm-Message-State: AOJu0YxWC2ev1p8S4PnjwuxBckmEiLZOx8kYe4UVm+HcuSh1SrEVGOK8
 r2K5uxWD3ja7fnerADqzZYCGOyNDtd3Ko5pzW6WM9yapWOWre7SMK6boh8NAteI23d2f2BC4Exu
 mL+BcnXDBqFnzE1Z7Dj531fztSGFNBAi18FGgbi/doBmzQ6/o+1irNLI9q+Cd1JFHTjrd0eoOp7
 c=
X-Received: by 2002:a5d:5005:0:b0:31f:e883:2ffc with SMTP id
 e5-20020a5d5005000000b0031fe8832ffcmr2602400wrt.43.1695224498762; 
 Wed, 20 Sep 2023 08:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+hIQwZg6rjGQC9/oHztGu14w5u5oP4TJQPmR7PyjgHhUGFDJkJh/RAB9KXPqzPSTI77wr/w==
X-Received: by 2002:a5d:5005:0:b0:31f:e883:2ffc with SMTP id
 e5-20020a5d5005000000b0031fe8832ffcmr2602384wrt.43.1695224498340; 
 Wed, 20 Sep 2023 08:41:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a056000100c00b0031ae2a7adb5sm18728557wrx.85.2023.09.20.08.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 08:41:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: weijiang.yang@intel.com
Subject: [PATCH] target/i386: enumerate bit 56 of MSR_IA32_VMX_BASIC
Date: Wed, 20 Sep 2023 17:41:36 +0200
Message-ID: <20230920154136.33171-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

On parts that enumerate IA32_VMX_BASIC MSR bit as 1, any exception vector
can be delivered with or without an error code if the other consistency
checks are satisfied.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6e52c7be1e1..8f334dbbcc2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1347,6 +1347,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             [54] = "vmx-ins-outs",
             [55] = "vmx-true-ctls",
+            [56] = "vmx-any-errcode",
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index eab610e5cd5..2e09c588f0b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1039,6 +1039,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
 #define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
 #define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
+#define MSR_VMX_BASIC_ANY_ERRCODE                    (1ULL << 56)
 
 #define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
 #define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
-- 
2.41.0



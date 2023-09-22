Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB57AAE14
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVo-0004it-UW; Fri, 22 Sep 2023 05:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVd-0004i1-ID
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVa-0003Lj-Dp
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyyUffVCCI6wnmLrjN9LYL/D6+d/aBzAyTI/qFrludo=;
 b=ft/El+MepboU/c1Z2G07niji0RyrcDpUT+Jsj8WUZ7L0qmPI9tbaqveQ3uUBS3mUd8agji
 lLd0vTtwGAPvMJHKnTD0bxW6dU1mJdsZk/amPPc6qXz0V0OmXSseibb8RecktrLvERmw08
 r1BXs3g3vJ/thN3kZFeVTWS+AnfVKX0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-Vdmq72LaNruJv-n8MoPOSw-1; Fri, 22 Sep 2023 05:31:31 -0400
X-MC-Unique: Vdmq72LaNruJv-n8MoPOSw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-321544abeeeso1346586f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375090; x=1695979890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyyUffVCCI6wnmLrjN9LYL/D6+d/aBzAyTI/qFrludo=;
 b=BRAlwzvH4TShdg37PQPpzZS6cn42fSX7sHwD3wrJc7GnbTUE+kjhcRhSPM8E8bSLrG
 97KQVyWWC3rJokpDkdUqnZuYicYAhaFYktqUxoSRUelYY2ZGuXlvUaYITBO9rAhZVwVu
 gj0r7ZPyij3YPN+larZjH1yF0WQARAwcx+abneh6D5u0/6NybZPTDZTX49F5Ru8zdgp/
 2E776PC7P/3jmrobFU4CJXidWVPPD80AKp/l9ixUO9+2U92MgN5UHjKQLQH3KvKrnvm1
 OcBokvUrIdPEqvWVdBATmih/80/NZtm8D/bziceV6kNV9x6TY2ziS7yOnkl14v3/WxG9
 Z29w==
X-Gm-Message-State: AOJu0YzwP0sVKjzdT2WJBaZdexzV0be8Xor5UySAUH6q67ov/Y1rfvPK
 bX0Wqsj6UCsSAT3EQnUMMaJ3xXy1FPbIZXCpSnpfsn0jhn8TmyMthZTYIcc/8AzUBwtlfwfnpQu
 QuUvy8/RV0hfDQQ2bg54nIWOSq7EMGZA879Y3WPn29oH8Zmq11P6T1raYNcVORe1nYyw3p/bNL+
 8=
X-Received: by 2002:adf:e88f:0:b0:31f:fe07:fdde with SMTP id
 d15-20020adfe88f000000b0031ffe07fddemr6996509wrm.12.1695375089816; 
 Fri, 22 Sep 2023 02:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvNFr39a1dF7umOtIeOR25lV/ObTKpQQrTZXVrMqHG7VRwBvOH3zhJjhzDHAqvz7abhAf/+Q==
X-Received: by 2002:adf:e88f:0:b0:31f:fe07:fdde with SMTP id
 d15-20020adfe88f000000b0031ffe07fddemr6996494wrm.12.1695375089435; 
 Fri, 22 Sep 2023 02:31:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g10-20020adffc8a000000b003176c6e87b1sm3978072wrr.81.2023.09.22.02.31.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] target/i386: enumerate bit 56 of MSR_IA32_VMX_BASIC
Date: Fri, 22 Sep 2023 11:31:14 +0200
Message-ID: <20230922093126.264016-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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
 scripts/kvm/vmxcap | 1 +
 target/i386/cpu.c  | 1 +
 target/i386/cpu.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index ce27f5e635a..3fb4d5b3425 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -115,6 +115,7 @@ controls = [
             (50, 53): 'VMCS memory type',
             54: 'INS/OUTS instruction information',
             55: 'IA32_VMX_TRUE_*_CTLS support',
+            56: 'Skip checks on event error code',
             },
         msr = MSR_IA32_VMX_BASIC,
         ),
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2a20365e10..d48607b4e1e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1340,6 +1340,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             [54] = "vmx-ins-outs",
             [55] = "vmx-true-ctls",
+            [56] = "vmx-any-errcode",
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fbb05eace57..d1ffadd78be 100644
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



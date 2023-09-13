Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C198179E79E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOfu-0000j8-MV; Wed, 13 Sep 2023 08:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfb-0000bR-SY
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfV-0002XH-NJ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694606908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78V6AUCfEa5S4vTUncfdyPTfOlLBu9pITh1WEI4+Qq0=;
 b=IadwVw2J9bKH8Z3QuzUrRj2bKnU3ffoxn2vFiiWnBeKjAt/amRe11QuqfIbxUisMWhCf3D
 qsApySWe7oN0FBaKDwd1jM4czghYaTbgtKVgRVNoYHWSnXc0N6TXPAFj0RshCOGAmx3l/R
 UshpH+t3lWWQr2gEMb3FwmDyBgoX8Xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-dW6J3fjzPdy16G1A0StOfg-1; Wed, 13 Sep 2023 08:08:26 -0400
X-MC-Unique: dW6J3fjzPdy16G1A0StOfg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401ea9bf934so52567315e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694606905; x=1695211705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78V6AUCfEa5S4vTUncfdyPTfOlLBu9pITh1WEI4+Qq0=;
 b=LZwz5a4frrnmuXNbProy7NyKolXLI7FyWXDDpFWh19mCiFR4sn91I82QPhu1OqGEhZ
 gJX74VEMvDo8YY8rVGvcmCpcGRr6Za03wdo1GKVEB7TPFAjhBgBuGYDFPBlzkB0YTMA4
 UIeDSetf2GtccTkkRx/SowrUhQJVcFeTMq8UTFhucUW0yEa0eZRdpmOsLPXYRMj4Zy5g
 yWfYOFYI9FQUhPrlgrON8cLi2YmxdJoLyvwV8R7SyBafZXy37RBbEtgwgglJzkOreAjK
 wK/ToGcGLs33VcalFs1H4mVkAbHvDcV8I+A3uw/UcdBTZI3XHUrCKFyw9Q+ZxKBmerL2
 d16A==
X-Gm-Message-State: AOJu0Yw2pS8PUCJGnNWkKKQOk6S4dC75ie+lCOhhTCO6+9xC2cXJ4TEc
 XvR7AZiZjbGWJHhetfBIB0CxymeevU2OkDd4T9j+XlCNXZp7U99x6tPtDNUM4BNy6NCdkq1KxGd
 dGLYftSB4YkalfVq3CMyqaTNt1R3dxxK+3E/c5x/K51BujlAcP2SCf9jea1aUzJhhQFP9Ru7hHF
 U=
X-Received: by 2002:a05:600c:108b:b0:3fe:207c:1aea with SMTP id
 e11-20020a05600c108b00b003fe207c1aeamr1755401wmd.23.1694606905374; 
 Wed, 13 Sep 2023 05:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwCGrEOTImettvIlPU9IRVxwfDqYc2yWj9Hr/HJ3zQUya1OQEr582obamOymFCNfaieSGxdA==
X-Received: by 2002:a05:600c:108b:b0:3fe:207c:1aea with SMTP id
 e11-20020a05600c108b00b003fe207c1aeamr1755386wmd.23.1694606905019; 
 Wed, 13 Sep 2023 05:08:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a1c7c0e000000b003fe2b081661sm1911669wmc.30.2023.09.13.05.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 05:08:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/4] target/i386: Check kvm_hyperv_expand_features() return
 value
Date: Wed, 13 Sep 2023 14:08:18 +0200
Message-ID: <20230913120820.969262-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913120820.969262-1-pbonzini@redhat.com>
References: <20230913120820.969262-1-pbonzini@redhat.com>
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

In case more code is added after the kvm_hyperv_expand_features()
call, check its return value (since it can fail).

Fixes: 071ce4b03b ("i386: expand Hyper-V features during CPU feature expansion time")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230913093009.83520-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d0..bd6a932d088 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7121,8 +7121,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
 
-    if (kvm_enabled()) {
-        kvm_hyperv_expand_features(cpu, errp);
+    if (kvm_enabled() && !kvm_hyperv_expand_features(cpu, errp)) {
+        return;
     }
 }
 
-- 
2.41.0



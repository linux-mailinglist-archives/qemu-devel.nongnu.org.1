Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D47C73B8A3
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfL-0004Xe-2x; Fri, 23 Jun 2023 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfJ-0004X7-4l
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfH-0005ad-7i
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6LzM46kJa48T3+aRvGvtOXkekp7mWniYMCf+e1S9DU=;
 b=J2ENcutYTuGd6MUDeamokl8fWk+Z/IVj07el26UmNCQ8bhr9VnrWLkJFG/1ICArQw4qcyN
 eKNT94znS96UWACcQzQPr60BGaxdrhHpNAgEHl9WhPjaKqoeHKGquouQ+xJ0GOoDSrqpTi
 WZ1eQ3my8gqeaPOcAcoXaGiU2FxK2lk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-9Vs4n8WwPTOOOrvzC8-ukg-1; Fri, 23 Jun 2023 09:17:24 -0400
X-MC-Unique: 9Vs4n8WwPTOOOrvzC8-ukg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b475f626b6so5637011fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526242; x=1690118242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6LzM46kJa48T3+aRvGvtOXkekp7mWniYMCf+e1S9DU=;
 b=AohP7M5yFAYHybSV35kethr6AWKYWu1ov1G+PQ3bKGyE0lIgWTo5WruB3gK+1DhDg8
 eWHhKop8tZOmGzTGYHDzWKIwHvjK/HCR20F09rYmBO2/u8ALd8jU8CAkNg6173+5KItT
 cKiaKnBvJII7784NtrWuD2fh2Q4uekdDPwfAdpzBQtnD1aHE0VRqHjSmNvZ5CNurUrpy
 CrSvIeheTNeqK9WjSLdkUNZzrwPbuRusCu2bs9sGHD9wHqev+dWAq+pxjhuewAa38asF
 6ivUuBfpslrRpDjtSfM1gtbXBAjTYCWUtisj8WG221duib6021u2crWBg0fP6y6BUanf
 OOSw==
X-Gm-Message-State: AC+VfDyrDWsylpcQC178E/04US+hzWqdLvZB9V7pEsjnVmu9oSCGZp1P
 PmQMXMFMXr9urgeeFjxjIuMbcBxqNdLzYTL0tgduaQ6smvUhSLByfxytk5rzkXLN4t2YP8cLozi
 FLj4WWO3yuEgLELNMbSNYxctut2yrTSy86mrIlhU6CUc1D2KlCJcwCBKcZRmcBbHkiO6XjTONrI
 s=
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9297 with SMTP id
 n9-20020a2e7209000000b002b45a0b9297mr15765340ljc.29.1687526242076; 
 Fri, 23 Jun 2023 06:17:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QmfMqCrn4RQ6ExsTXdygv0M8DYoZoSCbzfZuNKW0PsMB0Do4i2qA2/Fr23Qch5GbjyZbHHA==
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9297 with SMTP id
 n9-20020a2e7209000000b002b45a0b9297mr15765322ljc.29.1687526241719; 
 Fri, 23 Jun 2023 06:17:21 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a170906c21700b0098296b1fdd0sm6057342ejz.133.2023.06.23.06.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 05/11] target/i386: TCG supports XSAVEERPTR
Date: Fri, 23 Jun 2023 15:17:05 +0200
Message-ID: <20230623131711.96775-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

XSAVEERPTR is actually a fix for an errata; TCG does not have the issue.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fc4246223d4..bce0cb73e85 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -678,6 +678,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 
+#define TCG_8000_0008_EBX  CPUID_8000_0008_EBX_XSAVEERPTR
+
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
@@ -939,7 +941,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amd-psfd", NULL, NULL, NULL,
         },
         .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
-        .tcg_features = 0,
+        .tcg_features = TCG_8000_0008_EBX,
         .unmigratable_flags = 0,
     },
     [FEAT_8000_0021_EAX] = {
-- 
2.41.0



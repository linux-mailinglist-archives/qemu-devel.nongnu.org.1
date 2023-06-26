Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B008773DD29
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBu-0003GI-J4; Mon, 26 Jun 2023 07:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBj-00034c-Nq
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBc-0000lu-FS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b437COmzgCSpqdY33D96rpKkD+pKvcOW0IPyRHH0SKk=;
 b=Rv8LzlK0CgBbvI2ZoNbx5tiLB+IPc33pirywbH9YSEfDe/YskzU5Y7WP67r0M+YlnYSRHl
 S4GCygoAdS4CuUle3iOMLcKxTSHSns6oEUJO2pdqhWj5FB3Nts61hYA60Z+WxPzfLTPEAa
 Z0cYH9xpxKFGpQkdc41kn0O2NyzBahU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-EFrO9KTmO0iioZe0SJv_1w-1; Mon, 26 Jun 2023 07:15:09 -0400
X-MC-Unique: EFrO9KTmO0iioZe0SJv_1w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa06fc72f2so18769775e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778108; x=1690370108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b437COmzgCSpqdY33D96rpKkD+pKvcOW0IPyRHH0SKk=;
 b=MhEIn4nakDKJN0NV5TiZFvpciHGk60rmfsFAsHKomURm9YbqzHR9i7z4JSa5nPmYiM
 hAm+VYd3yEedl4Q1FmCmFCgwaQK+TvDLddV3cQorCGHfP/oQ1J7FJU3MYV5cKhPHb+h6
 D9fbSCBS8Pt+44gKpxDYQM5Dtahha5haQz/RzIXcXN9EVAlvRyu/TdX+OHcs7MpEEY93
 lSyxiVvKWG7D99y38v+opxA/lEDEYRgiEo3XgkLkgBp5MDuJlJVqrnjzV3vJu+bmxcly
 BGf88dTC96HM8mSM6e0Vfs6DvnN5+0OOK8mdTZ4MXW9HJy9aRFlsXgdARuBsdIVm1KIb
 gIxg==
X-Gm-Message-State: AC+VfDyjdQWNC3WuGMtKoVIcewoPtuocR9iEkggjtYmIBLxWdpIaud+/
 ospi5uZ+bHjx/dxU+z0gNyRMrG2FmGSiVh1fFcVXmw+cwo4j1NpM3xSXnHBjFNgvG3AUlG5D4V1
 qpvniCTlO+WMf6xDdzLMPEuMkxO+Tk7qhf27N+m7OwHqUX6hxHPAoMEwY0mKhTjwVH5DcnrSLAI
 w=
X-Received: by 2002:a05:600c:c4:b0:3fa:71db:56ff with SMTP id
 u4-20020a05600c00c400b003fa71db56ffmr9017535wmm.40.1687778108016; 
 Mon, 26 Jun 2023 04:15:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yb6EpsfdBS24XqYW7GXkefikbnfx8HQaKYqV5fYYPCgVz84GMt7VCueXpfNxteefoCbJY7A==
X-Received: by 2002:a05:600c:c4:b0:3fa:71db:56ff with SMTP id
 u4-20020a05600c00c400b003fa71db56ffmr9017522wmm.40.1687778107765; 
 Mon, 26 Jun 2023 04:15:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a1c7414000000b003fa973e6612sm2334412wmc.44.2023.06.26.04.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/18] target/i386: AMD only supports SYSENTER/SYSEXIT in
 32-bit mode
Date: Mon, 26 Jun 2023 13:14:41 +0200
Message-ID: <20230626111445.163573-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ed4016f554b..a20b5af71e7 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5669,9 +5669,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         s->base.is_jmp = DISAS_NORETURN;
         break;
     case 0x134: /* sysenter */
-        /* For Intel SYSENTER is valid on 64-bit */
-        if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
+        /* For AMD SYSENTER is not valid in long mode */
+        if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
+        }
         if (!PE(s)) {
             gen_exception_gpf(s);
         } else {
@@ -5680,9 +5681,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x135: /* sysexit */
-        /* For Intel SYSEXIT is valid on 64-bit */
-        if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
+        /* For AMD SYSEXIT is not valid in long mode */
+        if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
+        }
         if (!PE(s)) {
             gen_exception_gpf(s);
         } else {
-- 
2.41.0



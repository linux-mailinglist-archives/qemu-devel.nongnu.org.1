Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D773B8A8
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:19:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfO-0004Yx-31; Fri, 23 Jun 2023 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfL-0004Y4-U4
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfK-0005bl-Fc
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iajl0SbAzN6Vf70G/F/Se072OB8g0wD2P1jeIUlYfpA=;
 b=bL1mOBtkGo2OzBmnZ8x692Z2Ixf6KvLmthsMjIysPrGU7cjgih22bUaySEGipI0el6KZoR
 Ba2ihhR5IHS3KJUlNLs3pcVPSs9buWrGTCfuG/oOEDCnXYD+Dn7kxd11HNbmOxpidJsbbX
 Q3Tlrb+O6/V/GYf+Y1GlgStldr+Fu0U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kUZtbC6eOLCr8ej8iktDwg-1; Fri, 23 Jun 2023 09:17:28 -0400
X-MC-Unique: kUZtbC6eOLCr8ej8iktDwg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b45bf52675so6502991fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526247; x=1690118247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iajl0SbAzN6Vf70G/F/Se072OB8g0wD2P1jeIUlYfpA=;
 b=jKV4laIOrfkkw8J+nvr13uXtMH4tCPXdz5zDfZXIiIuJIK+SQdIZbw8O1iD+Ij9O5l
 SzcE8UI70UqZ0+o6oAyhU1lo1a7gRBW5zaT5h5V/zU/xcHiY5Y19J2WpImkSCGRrzfo9
 sPKoV4YFoPGfH++JbF30djLQGbLfHTt9gUA4XCH0VJ1V4qrEnV5tPk8dq5qQdrN8HLfN
 8O3gjDyTi1lcfKcftuoCeJmsRXye9O02/YIN/WZMy5Ma4cYQH4kHJsDGPxc2Q5Pf9Yj7
 u9aE6HALs5CiOnDMoIfBl4t6U0IpV63z+irSgHGvSy4zunvHVHFQasOhYVdbC9F8MDGj
 y4/w==
X-Gm-Message-State: AC+VfDwmkoZgqKRmgkf9kv2wUHvmZ7Oj9jGrfL8bAvxdCpZaJa+pyC1/
 V2s72xCRqf8cJGJq5+G1uRY/TQXbPP+wWGzTBw/ra9ZF0qbev0P52P9Z0u5I75gDY9r5r+C9ff8
 jXVEO79DzZVM3RI8FfPqjNyDT8EnCEVkxQkOgMlBh9dym1E7aYMClza3501diNOHfKR/px5+QaL
 k=
X-Received: by 2002:a2e:a175:0:b0:2b1:fdcc:14fb with SMTP id
 u21-20020a2ea175000000b002b1fdcc14fbmr15335144ljl.43.1687526246819; 
 Fri, 23 Jun 2023 06:17:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66OMDxerQCH9QSVhgp3wwTGdp0oJXw5TPNjLHqLO6va6SDFt1rWhe/KvzVL6JNFlo+yiObiA==
X-Received: by 2002:a2e:a175:0:b0:2b1:fdcc:14fb with SMTP id
 u21-20020a2ea175000000b002b1fdcc14fbmr15335127ljl.43.1687526246323; 
 Fri, 23 Jun 2023 06:17:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a1709064ccd00b00982a077599fsm5917638ejt.110.2023.06.23.06.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 08/11] target/i386: AMD only supports SYSENTER/SYSEXIT in
 32-bit mode
Date: Fri, 23 Jun 2023 15:17:08 +0200
Message-ID: <20230623131711.96775-9-pbonzini@redhat.com>
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



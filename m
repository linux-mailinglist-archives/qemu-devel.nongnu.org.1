Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4E7C8760
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrImY-0004tr-4A; Fri, 13 Oct 2023 10:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIlw-0001oh-O2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:04:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIle-0002gX-1E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:04:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so3849862a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205831; x=1697810631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4alAtOXM/H/5FX7cyO/SwuIUYprCQ9PCZpIdYP2vGY=;
 b=P0K0EOKBNNDBU7BITx4q5wgLWKMrIAEvxAY6zGwhsaQ/jB017LuJd1wxmWrbnoqh9U
 fXGvyu8CsFRE+0S3pZzBQl1YhvrqMAXZGFGSa6+o3y505AUBBHIouO8Pi62qQd4USFJn
 gYb4wMwd0Bu1dSdUrSQdC/GpJY6rO2XMcMz1jEAuealT4EDKUkMCXR305D0SZckqav6I
 X14Mlzqkl5a3Pbao9jh9Xi/93OD5fhXrM3Ax+ru2DqTmQ9UKLqCR/cJs+ZzgWhA4Q3yw
 xAtIo3eKFPzYKi6Ck6Aln0X+NetA7bLk0wKP295wZzpLDQWF9NaLVO3Z2qPVaPPfxDXx
 JJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205831; x=1697810631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4alAtOXM/H/5FX7cyO/SwuIUYprCQ9PCZpIdYP2vGY=;
 b=oIr463//03TE3N7xCq/WhG++go0PwWDiNXm6HNz2DR4KKcKOMWN9rHMjbfFbo3iYMF
 t00eEsc+bxZ700EQbqUd8j2xH8mjudfmTWNacBjNT2TkR6/t+TvmHPj8MmoFMChrE/ST
 JNbvyYk2/+33BYIvYti4QaVTFuOuMN/3AU+JiD60aS5JqV4vYT4lhIOsXVTy83+bbWDf
 uV+KaJ29fja8ivvUgI5q4WlRjSbdsgmtEgjIJbwCUCgxKBU8TpfcLcAy7db3xG3lu+D0
 ETYmCcpP6vfLlqRSCJk0tfKK42c16xuX4z3/lTlOsREZOrmqr0X4llHIawz8GqLUX7jP
 viTg==
X-Gm-Message-State: AOJu0YzWyr2AUb1gpiXNC+jrIM3SNd0715DyVjcUZ4keQ75NZwQWI9MO
 aninM6/CX44jlTycVV/XTjsAT4dDRna7B1bTQDE=
X-Google-Smtp-Source: AGHT+IERKCTNVWD0dJclVoyHnhGisvpmsV/d+FMKb6sYDuUfem0HyRDDDLrUvGmq/Ea0lVyeOnjJ1w==
X-Received: by 2002:a17:906:30cc:b0:9a1:c447:3c62 with SMTP id
 b12-20020a17090630cc00b009a1c4473c62mr23478118ejb.49.1697205831758; 
 Fri, 13 Oct 2023 07:03:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 gq7-20020a170906e24700b00993664a9987sm12476932ejb.103.2023.10.13.07.03.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:03:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yanan Wang <wangyanan55@huawei.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Marek Vasut <marex@denx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 16/16] target/sparc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Fri, 13 Oct 2023 16:01:15 +0200
Message-ID: <20231013140116.255-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013140116.255-1-philmd@linaro.org>
References: <20231013140116.255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

In few commits we are going to add more types, so replace
the type_register_static() to ease further reviews.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ba96ae225..1e66413e94 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -924,17 +924,21 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->tcg_ops = &sparc_tcg_ops;
 }
 
-static const TypeInfo sparc_cpu_type_info = {
-    .name = TYPE_SPARC_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(SPARCCPU),
-    .instance_align = __alignof(SPARCCPU),
-    .instance_init = sparc_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(SPARCCPUClass),
-    .class_init = sparc_cpu_class_init,
+static const TypeInfo sparc_cpu_types[] = {
+    {
+        .name           = TYPE_SPARC_CPU,
+        .parent         = TYPE_CPU,
+        .instance_size  = sizeof(SPARCCPU),
+        .instance_align = __alignof(SPARCCPU),
+        .instance_init  = sparc_cpu_initfn,
+        .abstract       = true,
+        .class_size     = sizeof(SPARCCPUClass),
+        .class_init     = sparc_cpu_class_init,
+    }
 };
 
+DEFINE_TYPES(sparc_cpu_types)
+
 static void sparc_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     SPARCCPUClass *scc = SPARC_CPU_CLASS(oc);
@@ -959,7 +963,6 @@ static void sparc_cpu_register_types(void)
 {
     int i;
 
-    type_register_static(&sparc_cpu_type_info);
     for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
         sparc_register_cpudef_type(&sparc_defs[i]);
     }
-- 
2.41.0



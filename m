Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B17BF76E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq95s-0004ma-HM; Tue, 10 Oct 2023 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq950-0001T9-Fo
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:31:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq94x-0008Im-Jx
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:31:06 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso972571766b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696930261; x=1697535061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9ac00GoAEt719cFFz9dDP5blE56OLyiS+6SiHpN8FY=;
 b=VeZUhIXa7yITGBMlRC2CGpsswo4w8gObX6ZDxgI6G1p1kmiDdIKZjdtoo/7OaUgjMr
 ZocoIgpgOw9JKxGVtVPx5JNYgx9Jb7hdwG+vzk4Jp8OwjhBl0jgBSfUTtRULfaS8a579
 u7o20Zz+Lc6+M5ydNQcvRHKDyxAasRHivRBUs+m6DkGavdzW9ND7XRS949kitVILuao2
 74/vtNsBUcoEL0lQnSQG6A9J/MQ3Aq2aR83qex8YQMsLlJgmgErTLYMOb64bdFuIyvmW
 sFOBi6ag5SmdRwh7ELHg9cf2448lN8gKJNzKKuCP623bK9YbJLe219Uy2nh1CF/jWMJy
 f2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696930261; x=1697535061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9ac00GoAEt719cFFz9dDP5blE56OLyiS+6SiHpN8FY=;
 b=UFpyAr4IJncKdjEUxJQaL87pACqdUJT6HHEe48VQw7+RGjxx4+Wy38G/TcX6eqOMuV
 cwSHNLp6wkJndfHBP30MRwvSvOmXZVBG8guGFXvdDBgGFtTzB87JbxSnGnksOSbMO2Ey
 LKUodp/DfISemmsJDKllrg4I7yRPK8FGrnw3Cr/uJz7UsmNJ+UwsfpIohe0++EX/6LkL
 dA5QwgFdmchu4h5li+hcDSr7sWxmtdlZch7OPiNPWG1n3GPCDBe6/7NcKeVUSqdtCN/c
 LjemIJOANCNFZRubcZlm791DKxL9wyombvgwcBgnosCa2ZD3ivU409M+ZlA6d5ZYvKqt
 f1pg==
X-Gm-Message-State: AOJu0YxAWb5v05evffDSBpG9U0m47otDMatfPIm6ZRLM+x13uaSNAS52
 YbBojKtaNn714v5AOypLbi9aLoSSkJ/3X04weoy8rg==
X-Google-Smtp-Source: AGHT+IHCEKFzifEYk0go6tXBA7Cg5kiurnTUEAsAtaXFlNuV7rl2Z6uHR9cY1ztH9AsYMzy4JhfLmg==
X-Received: by 2002:a17:906:74db:b0:9ad:e0e0:d6ab with SMTP id
 z27-20020a17090674db00b009ade0e0d6abmr17089848ejl.12.1696930261008; 
 Tue, 10 Oct 2023 02:31:01 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 n12-20020a170906378c00b0099d45ed589csm8100822ejc.125.2023.10.10.02.30.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 02:31:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org
Subject: [PATCH 14/18] target/sparc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Tue, 10 Oct 2023 11:28:56 +0200
Message-ID: <20231010092901.99189-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010092901.99189-1-philmd@linaro.org>
References: <20231010092901.99189-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



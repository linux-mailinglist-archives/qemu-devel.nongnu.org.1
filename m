Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF37BF76A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq95q-0004h6-1n; Tue, 10 Oct 2023 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq95P-0003MF-Ap
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:31:31 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq95M-0008TA-7p
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:31:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b29186e20aso923858066b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696930285; x=1697535085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgsiCqJEVbd0iph25Vp3iyBl0HVLbk20nUnsucfnJsA=;
 b=OSI5iTqsDif8f7TBP68R+kfCKES76Vt3BQHHuYZzh3VoJ5BD8brfUcAV3DpteobBvq
 5Bgej7edzuURO1d204wLB57qc79Y6GlYSY6L4Lcv/3Yeq7i9MCyPNz3b9jmnsTM0+pQB
 XljpPgXESuWE7WKjJT+RdSnSdWiIUhbrkyS1uOdYp+TlcSxRjePtOdjHXML73sTa7pMq
 WAm2LcCSEv8TjLYWq5/MRvxlWZxY54gTt63kpSD7I96GrgKHfXjWsT5F0HpKZD/uezxq
 DnBncb0RdEjC4UZ22ZH9Ee3Dt440e5me7vsvUmhQYkP/p6tbLBeA39bdSEosQ3RP5kJ+
 7UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696930285; x=1697535085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgsiCqJEVbd0iph25Vp3iyBl0HVLbk20nUnsucfnJsA=;
 b=OPf11p3ot/e51E4omEmFx/QfLU61aKqJI7XtpvvpEpDwM141b4Ah2WhmG+EjOThRa+
 YPegGbfrZjH9AcMbA2IWuWn27w0Xn/Ipsf0e+mwbSPr7lulrANo/1anVyL8FO7a42g23
 ogKseUPsVLieOMzwUjjaWV+FqemAJBTmUwslG/wQ+k7fBGCJEWMPZDZ7VZFcJP6ySuDh
 Vd/LUI7pQIpZ/9Izt+QzKS7uvIN0Pdzxr/F1VM1J5TP4Esf0xQ076I5ZGUiD6wYneXBH
 21/ZpY7M6iG/NVNrhVXUseX9cRV69ZWNUkch3K24EbjMzJST57jorPFHPC7DIQ/1uyEj
 m+7A==
X-Gm-Message-State: AOJu0YzBtFTCbc8qdc4Z0ROYbxDSiE+NyEakBcvSRuB1iAu505HeF234
 To+ZOWh3SO87aGcHzoxe8d7tn/XVK3so7Djlb9ZPwA==
X-Google-Smtp-Source: AGHT+IEXpjZVU56vEKy3GfKoaWZ7nqZXZb6YT1jP60i2kfKRVil3wfqjKGL4iQtSkJmsNpUfOSqjQQ==
X-Received: by 2002:a17:906:538f:b0:99e:f3b:2f78 with SMTP id
 g15-20020a170906538f00b0099e0f3b2f78mr17049450ejo.67.1696930285483; 
 Tue, 10 Oct 2023 02:31:25 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 fi10-20020a170906da0a00b009ad8796a6aesm8106883ejb.56.2023.10.10.02.31.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 02:31:25 -0700 (PDT)
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
Subject: [PATCH 17/18] target/mips: Make MIPS_CPU common to new MIPS32_CPU /
 MIPS64_CPU types
Date: Tue, 10 Oct 2023 11:28:59 +0200
Message-ID: <20231010092901.99189-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010092901.99189-1-philmd@linaro.org>
References: <20231010092901.99189-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

"target/foo/cpu-qom.h" can not use any target specific definitions.

Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
on the mips(32)/mips64 build type. This doesn't scale in a
heterogeneous context where we need to access both types concurrently.

In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
both inheriting a common TYPE_MIPS_CPU base type.

Keep the current CPU types registered in mips_register_cpudef_type()
as 32 or 64-bit, but instead of depending on the binary built being
targeting 32/64-bit, check whether the CPU is 64-bit by looking at
the CPU_MIPS64 bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-qom.h | 13 ++++++-------
 target/mips/cpu.h     |  3 +++
 target/mips/cpu.c     | 11 ++++++++++-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index 9c98ca1956..1a71509b5e 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU MIPS CPU
+ * QEMU MIPS CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -23,13 +23,12 @@
 #include "hw/core/cpu.h"
 #include "qom/object.h"
 
-#ifdef TARGET_MIPS64
-#define TYPE_MIPS_CPU "mips64-cpu"
-#else
-#define TYPE_MIPS_CPU "mips-cpu"
-#endif
+#define TYPE_MIPS_CPU   "mips-cpu"
+#define TYPE_MIPS32_CPU "mips32-cpu"
+#define TYPE_MIPS64_CPU "mips64-cpu"
 
-OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
+OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
+OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
 
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6b026e6bcf..3b6d0a7a8a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -10,6 +10,9 @@
 #include "hw/clock.h"
 #include "mips-defs.h"
 
+/* Abstract QOM MIPS CPU, not exposed to other targets */
+OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 83ee54f766..f43300dd5e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -605,6 +605,14 @@ static const TypeInfo mips_cpu_types[] = {
         .abstract       = true,
         .class_size     = sizeof(MIPSCPUClass),
         .class_init     = mips_cpu_class_init,
+    }, {
+        .name           = TYPE_MIPS32_CPU,
+        .parent         = TYPE_MIPS_CPU,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_MIPS64_CPU,
+        .parent         = TYPE_MIPS_CPU,
+        .abstract       = true,
     }
 };
 
@@ -621,7 +629,8 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
     char *typename = mips_cpu_type_name(def->name);
     TypeInfo ti = {
         .name = typename,
-        .parent = TYPE_MIPS_CPU,
+        .parent = def->insn_flags & CPU_MIPS64
+                  ? TYPE_MIPS64_CPU : TYPE_MIPS32_CPU,
         .class_init = mips_cpu_cpudef_class_init,
         .class_data = (void *)def,
     };
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D827C875E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:05:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIlv-0001LA-VB; Fri, 13 Oct 2023 10:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIkY-0007q1-17
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:02:55 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIkT-0002Nc-N4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:02:44 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so349245666b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205758; x=1697810558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ve1lLlxnRHTflzhTJxO7OlNBTIrjeeFG/SBbqRg4BJs=;
 b=RcLyMrjUizWvmglUmZAfF1Fa5qPDVBiIW83KMphzoOrGtYanM/UNkklxIg06zRTIQz
 Sxb12JzB7PuulC3GDmhJS2Pc1FgDVJkN0yAo0W5H9nTs5Vs7584P63bwGew7LDRbQBhX
 t3fuUxNUbygLuy7Ca8ibODXfICM6ulQlyjgB+4GusOOAz8bkpahQ92l8KXjMv+4c41EW
 4cGleA0ahTOCCZPrdBQ2pSR6ARpu6OJu1Ie48HTs20KpJcZBFRIA986yE5UyG74NIIzW
 oMrAXl6K488X7mmuKGA/pVA7SUAJMw0Ri9RTz5M0uklnqy++M2nWWdjTmjd5WxfaY+nV
 jncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205758; x=1697810558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ve1lLlxnRHTflzhTJxO7OlNBTIrjeeFG/SBbqRg4BJs=;
 b=Kfee1shxiEHlhHb7OWxi3VKaUHQMkAZDsrEuoSt8fB1xb1Wq6qbtFDIAPGUmKv9RK+
 yzCd/JHbLVAyhomcRqCKHjvR2/PgcPT7CxzQZPVGByypkDa/gdxgRP3sapwRfl4uKyuR
 WW7A1PnL0USOve4zFzEhP9ThTGWeLnFddT7AbqqlUXuLSwIM3zPxhyIOK0A/cfqfzPGt
 lIWELxc8opisuTuRcfIHSvfY9hudUAIp1fgoR2ntJveAgrFZeuM0SZ53PQEgEssmdrIR
 IRPE9yZcDledjPbmetHgFrhuSOwpZAVaqzvXaSRo91inXfilabVclP9jZzy4PNpxZlHH
 Zv/w==
X-Gm-Message-State: AOJu0Yy3VHEshaFGEp6Rb/eR6jTJw3H18bxNCd56AMfnDJov5FZW/XrE
 aEoMInMTw88dqqBILNQPo4fp+C4cBVePonKbzPw=
X-Google-Smtp-Source: AGHT+IHWONbfnoPyiRyGIQvfR8K+ccfv9PXbi5HxUaJAghxanGW3/XwOZ1qOOwb8JiQbWCMBf92Dwg==
X-Received: by 2002:a17:906:1097:b0:9ad:7890:b4c0 with SMTP id
 u23-20020a170906109700b009ad7890b4c0mr21446662eju.56.1697205758763; 
 Fri, 13 Oct 2023 07:02:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a17090611d700b00991e2b5a27dsm12479889eja.37.2023.10.13.07.02.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:02:38 -0700 (PDT)
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
Subject: [PATCH v2 08/16] target/loongarch: Declare QOM definitions in
 'cpu-qom.h'
Date: Fri, 13 Oct 2023 16:01:07 +0200
Message-ID: <20231013140116.255-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013140116.255-1-philmd@linaro.org>
References: <20231013140116.255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

"target/foo/cpu.h" contains the target specific declarations.

A heterogeneous setup need to access target agnostic declarations
(at least the QOM ones, to instantiate the objects).

Our convention is to add such target agnostic QOM declarations in
the "target/foo/cpu-qom.h" header.

Extract QOM definitions from "cpu.h" to "cpu-qom.h".

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu-qom.h | 24 ++++++++++++++++++++++++
 target/loongarch/cpu.h     | 10 +---------
 2 files changed, 25 insertions(+), 9 deletions(-)
 create mode 100644 target/loongarch/cpu-qom.h

diff --git a/target/loongarch/cpu-qom.h b/target/loongarch/cpu-qom.h
new file mode 100644
index 0000000000..82c86d146d
--- /dev/null
+++ b/target/loongarch/cpu-qom.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch CPU QOM header (target agnostic)
+ *
+ * Copyright (c) 2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef LOONGARCH_CPU_QOM_H
+#define LOONGARCH_CPU_QOM_H
+
+#include "hw/core/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_LOONGARCH_CPU "loongarch-cpu"
+#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
+#define TYPE_LOONGARCH64_CPU "loongarch64-cpu"
+
+OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
+                        LOONGARCH_CPU)
+
+#define LOONGARCH_CPU_TYPE_SUFFIX "-" TYPE_LOONGARCH_CPU
+#define LOONGARCH_CPU_TYPE_NAME(model) model LOONGARCH_CPU_TYPE_SUFFIX
+
+#endif
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 2b8b828114..2b759aba5e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -17,6 +17,7 @@
 #include "exec/memory.h"
 #endif
 #include "cpu-csr.h"
+#include "cpu-qom.h"
 
 #define IOCSRF_TEMP             0
 #define IOCSRF_NODECNT          1
@@ -381,13 +382,6 @@ struct ArchCPU {
     const char *dtb_compatible;
 };
 
-#define TYPE_LOONGARCH_CPU "loongarch-cpu"
-#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
-#define TYPE_LOONGARCH64_CPU "loongarch64-cpu"
-
-OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
-                        LOONGARCH_CPU)
-
 /**
  * LoongArchCPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -478,8 +472,6 @@ void loongarch_cpu_list(void);
 
 #include "exec/cpu-all.h"
 
-#define LOONGARCH_CPU_TYPE_SUFFIX "-" TYPE_LOONGARCH_CPU
-#define LOONGARCH_CPU_TYPE_NAME(model) model LOONGARCH_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
 #endif /* LOONGARCH_CPU_H */
-- 
2.41.0



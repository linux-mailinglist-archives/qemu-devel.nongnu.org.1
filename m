Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46027E1F92
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:09:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxQJ-0000TD-Ts; Mon, 06 Nov 2023 06:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQA-0000HC-C2
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQ6-0004FT-4p
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so2595387f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268724; x=1699873524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXuP88BtphoINz4Bov6u/pkpdXdezQqYli4OVAIpAZI=;
 b=E6sFIdPbRUgtedzhm31+W27IgBnLNqA870oNNPo7xpe2Epet+mWfdOg0Ozzfm/AeGZ
 8xnBNQQUHMZ0cSAZMIhp9Os5+jL8+vdnSJ0LRguG3tiBnrZrVq+0EmA1LoCyGMwqO4td
 1n7+ukVgLh2RSJSh/G2c9AP1R5Lh6wRtkz9J+s0NP7U0afk3lyn4S6/cZUY/s+OeBWIX
 9M6KLaCjTloEWlurqMztSiXJDvD9Xo9Vzt/1aGG9WB5U+IzJVItIAKMWL8Lyuwsoa0ck
 vicMop8uV3SNmsW69MgTWUsjRWwjFPBkfeoAPK+W9W7s6JagXP0yclD9bpQ9juGR1Amy
 6JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268724; x=1699873524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXuP88BtphoINz4Bov6u/pkpdXdezQqYli4OVAIpAZI=;
 b=sCHXVt2NI9LRnFNwixHR4MMb+5KCmm7fvqntL/4NjcrOYhCSHp3/z2YQldpxJU4JVp
 pGSu3uEc2lmftRBA3eIDjh5o6rY/hHYYOiR3hNOIVLaBH6HXBxtGwHuijQxU8CGRwnYq
 sJSsgVWsTr3KSdsflDvngqWB8F59KzomwRDxPfn8ovwZh5njOWrsp3QBnXoJvpjN612m
 efnAEYhDFGyU0csFIIDCEbbpPNHL2XDJWsIMe86dXExW8SiVae+OkOlKW4W+8y5bqkP4
 jfldlPUdKCZlIhjHslO34O6CAHAT92T9veg+TM5EKqKx+efehV9ekT7uMB/CthUezGLC
 Jl7g==
X-Gm-Message-State: AOJu0Yw7MoM7BBwbquWoq2bOCoY/EE/H/oZlS65VPN3dWh/dZxzsYB1E
 9qdyOQ9kzK99UZ8KoMwtfKW4Iw0zlfTZiwxvg+o=
X-Google-Smtp-Source: AGHT+IHaBHUQklVP9Pu5QT4vT7r66jTjw7Yf4RVyFH1CKsmkdCj1+2Bfzei9MwaofGzJpViR1lgQOw==
X-Received: by 2002:adf:e6c4:0:b0:32f:adaf:be86 with SMTP id
 y4-20020adfe6c4000000b0032fadafbe86mr8820884wrm.16.1699268724027; 
 Mon, 06 Nov 2023 03:05:24 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a5d5686000000b0032f7eaa6e43sm9161653wrv.79.2023.11.06.03.05.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:05:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/60] target/loongarch: Declare QOM definitions in 'cpu-qom.h'
Date: Mon,  6 Nov 2023 12:02:47 +0100
Message-ID: <20231106110336.358-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Add a comment clarifying that in the header.

Extract QOM definitions from "cpu.h" to "cpu-qom.h".

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-9-philmd@linaro.org>
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
index 8f0e9f0182..c8839f4cff 100644
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



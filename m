Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9877E1FAE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:10:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxQY-00011W-Ra; Mon, 06 Nov 2023 06:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQN-0000rB-3R
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:44 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQJ-0004IO-HD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:42 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so57407011fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268737; x=1699873537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nk4cWXrgP2wfdX8K07cLqFbkIit3uK5saNqg4nYpY5E=;
 b=RDUdqWboVD3quZSQuqcQzcpO6jciqNidy2pQK4F7zh6i78tgblRZPS3TgtVac+HWCt
 +5cBvsFrAT9xcPcJdpWdftDh08ezimBXywqnFMp8x72BPslMhbBjr7zC+pELhw3GyTZJ
 zF3Boh04xWn8HFVZopN9fPdPisDqmSD5q1Xsz4SXIAb+aZJE+VdI0o8+uzvuSSxJy2eK
 mDh4Uv3R3xsqOOF5M8DFKB5yTRsHyxr/GzZ+GQjxPKrwAfbKXYRkn8XM5o52cL73KEcR
 Tc0LdXJx/VK7llu6T+MfxIY0kcoQNRt/70pkYtJFknPO4WjpJO5k++5LikFZMIcAGilQ
 Y0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268737; x=1699873537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nk4cWXrgP2wfdX8K07cLqFbkIit3uK5saNqg4nYpY5E=;
 b=ZjYDH/sx7dj+pXsD2gqCJrcY1fqu992crnExfYT6jX/2m6GCChvH3MvKa8neQpPZar
 LExtgMl1XBsKa1q4jcUDPU83yGO9M/2vlT5OQF9QgzvkxfeJU/6DVzznHF8JMYert1XV
 pQ8hxxlOclCBFFoH3zCnr6J/QV83BN6yq9TQQ0tIxzMc1rO7nFm+km65dmUHOt6et0I+
 BbycTTY0GJmqYqpY58FgCnzUK1vvl8V3pqQUCCcgq0nnV8QgizGN5b0SRcwYI+7UyoKK
 f/p9Q+j80KUSA6ML8wsYGFjjOHIywZvWjGvNOnDF/yq7gyWkPikk6glV5WF78dEBTzCq
 xWTg==
X-Gm-Message-State: AOJu0Yza0adiSAHRcs6NSsg0V74yXQAgb4o+r14//xFbYLDNcsk/KGiE
 jn7SO9DwBTlVLK5BjDHtwWY1SjBCCSm1sqmkweI=
X-Google-Smtp-Source: AGHT+IHKiC1CxF8T0vSr2BLcywa6c3PPTVgxII/mK+f6zwidK7EflGt0iUFCbELVhD20Vx3Mom76tg==
X-Received: by 2002:a2e:9cc6:0:b0:2c5:1bd3:5657 with SMTP id
 g6-20020a2e9cc6000000b002c51bd35657mr22787612ljj.15.1699268737741; 
 Mon, 06 Nov 2023 03:05:37 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a05600c4fcd00b0040588d85b3asm11817685wmq.15.2023.11.06.03.05.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:05:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PULL 17/60] target/openrisc: Declare QOM definitions in 'cpu-qom.h'
Date: Mon,  6 Nov 2023 12:02:49 +0100
Message-ID: <20231106110336.358-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-11-philmd@linaro.org>
---
 target/openrisc/cpu-qom.h | 22 ++++++++++++++++++++++
 target/openrisc/cpu.h     | 10 +---------
 2 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100644 target/openrisc/cpu-qom.h

diff --git a/target/openrisc/cpu-qom.h b/target/openrisc/cpu-qom.h
new file mode 100644
index 0000000000..1ba9fb0a4c
--- /dev/null
+++ b/target/openrisc/cpu-qom.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU OpenRISC CPU QOM header (target agnostic)
+ *
+ * Copyright (c) 2011-2012 Jia Liu <proljc@gmail.com>
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef QEMU_OPENRISC_CPU_QOM_H
+#define QEMU_OPENRISC_CPU_QOM_H
+
+#include "hw/core/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_OPENRISC_CPU "or1k-cpu"
+
+OBJECT_DECLARE_CPU_TYPE(OpenRISCCPU, OpenRISCCPUClass, OPENRISC_CPU)
+
+#define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
+#define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
+
+#endif
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 29cda7279c..dedeb89f8e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -20,17 +20,12 @@
 #ifndef OPENRISC_CPU_H
 #define OPENRISC_CPU_H
 
+#include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
-#include "hw/core/cpu.h"
-#include "qom/object.h"
 
 #define TCG_GUEST_DEFAULT_MO (0)
 
-#define TYPE_OPENRISC_CPU "or1k-cpu"
-
-OBJECT_DECLARE_CPU_TYPE(OpenRISCCPU, OpenRISCCPUClass, OPENRISC_CPU)
-
 /**
  * OpenRISCCPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -304,7 +299,6 @@ struct ArchCPU {
     CPUOpenRISCState env;
 };
 
-
 void cpu_openrisc_list(void);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
@@ -339,8 +333,6 @@ void cpu_openrisc_count_start(OpenRISCCPU *cpu);
 void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 #endif
 
-#define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
-#define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
 #include "exec/cpu-all.h"
-- 
2.41.0



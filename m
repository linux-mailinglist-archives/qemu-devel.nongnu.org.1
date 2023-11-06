Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF27E1F94
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:09:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxQJ-0000W1-Un; Mon, 06 Nov 2023 06:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQB-0000HN-7C
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPz-0004D6-8D
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:30 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32f9268bf8cso2602456f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268717; x=1699873517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vep8ejgClIB/0OUtyRO014f5iK14K4Tf/g8eVxuuhkY=;
 b=YQg8L2P0it4YSIoMv9sBPS3ZoO+DpcMyo6+SIY16dLD8EvJhcnw+LZJb3fZN+ESqdt
 XCXejmVRDVSe/pLrvF5JshqDB0ZLACWA4xTZ3EBU9H3uwhBbCRRdsaTyELT41wPFIA0g
 h3wM+8l+BBWvRl2Hh7DCJV2/cRdSoZnM2x4/LzQxjTzuk07JkE89e6iE5eozA/k2oEwH
 nYjeelWBiQT2an5HdtsnoyiS/xxuIHUxtTXAEn813cEcLzCwRdWcwGeIWuwKbDyu89mL
 sv37S/+cMk6QGv09fBT/KYHHhcExlBc6PBaU0eWFz5xITe+q1Wyc1OuViGQms700iyuS
 ce7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268717; x=1699873517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vep8ejgClIB/0OUtyRO014f5iK14K4Tf/g8eVxuuhkY=;
 b=oS/IBCDeipZac/raA7pypfKZnNPFdBBRadsjXklBG/yFkJ0W5wE0PGJbpAOshofHgz
 /7bZnzuLbW2d2VXL2gIBBzkj3v9e3bc+ULgmmOFWLcaPqCdRPG9gWbJvc7uVbxFljjTT
 jPIY282X8uk12dJzJzMZakjR5pH3AgQ/HjSH8OM1dN4ABJkcdQLXGiE/hA5IhRZ6OSAK
 fQsTgBq9PLi7OhvJ+Bo4yxM1tQ0rv5ussCxMdtbCAiCHf2S8jaRj+jUSNQayM2nJ6Ee9
 DlT2liTi3DiM3Yu6y+zmrPa1PJLw3vQC+XZLnc1c6SVp7e6a8KtiVqGrus1YbD+k2qdK
 VMJw==
X-Gm-Message-State: AOJu0Yw62UWsdlNDiriOuEDedA5XXiJJmOWWBk+3zp813B5ePH7Iwgfm
 UOoAZYixaxYm5NpaozuBiaP4+VghpcHSB2Vr/cE=
X-Google-Smtp-Source: AGHT+IFGvT0btHnF3YPkzx9cmFeVj8iEZzjdIY/tcCq/l6fv1iFj5XC77e6JGhJHntN6X+4R9AYh8Q==
X-Received: by 2002:a05:6000:186c:b0:32f:7a65:da64 with SMTP id
 d12-20020a056000186c00b0032f7a65da64mr24414146wri.65.1699268717450; 
 Mon, 06 Nov 2023 03:05:17 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 l9-20020adfe589000000b0032f7d7ec4adsm9108143wrm.92.2023.11.06.03.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:05:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>
Subject: [PULL 14/60] target/hexagon: Declare QOM definitions in 'cpu-qom.h'
Date: Mon,  6 Nov 2023 12:02:46 +0100
Message-ID: <20231106110336.358-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Brian Cain <bcain@quicinc.com>
Message-Id: <20231013140116.255-8-philmd@linaro.org>
---
 target/hexagon/cpu-qom.h | 28 ++++++++++++++++++++++++++++
 target/hexagon/cpu.h     | 15 +--------------
 2 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 target/hexagon/cpu-qom.h

diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
new file mode 100644
index 0000000000..f02df7ee6f
--- /dev/null
+++ b/target/hexagon/cpu-qom.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU Hexagon CPU QOM header (target agnostic)
+ *
+ * Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_HEXAGON_CPU_QOM_H
+#define QEMU_HEXAGON_CPU_QOM_H
+
+#include "hw/core/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_HEXAGON_CPU "hexagon-cpu"
+
+#define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
+#define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
+
+#define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
+#define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
+#define TYPE_HEXAGON_CPU_V69 HEXAGON_CPU_TYPE_NAME("v69")
+#define TYPE_HEXAGON_CPU_V71 HEXAGON_CPU_TYPE_NAME("v71")
+#define TYPE_HEXAGON_CPU_V73 HEXAGON_CPU_TYPE_NAME("v73")
+
+OBJECT_DECLARE_CPU_TYPE(HexagonCPU, HexagonCPUClass, HEXAGON_CPU)
+
+#endif
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 035ac4fb6d..7d16083c6a 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -20,11 +20,10 @@
 
 #include "fpu/softfloat-types.h"
 
+#include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
-#include "qom/object.h"
-#include "hw/core/cpu.h"
 #include "hw/registerfields.h"
 
 #define NUM_PREGS 4
@@ -36,18 +35,8 @@
 #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
 #define VSTORES_MAX 2
 
-#define TYPE_HEXAGON_CPU "hexagon-cpu"
-
-#define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
-#define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 
-#define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
-#define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
-#define TYPE_HEXAGON_CPU_V69 HEXAGON_CPU_TYPE_NAME("v69")
-#define TYPE_HEXAGON_CPU_V71 HEXAGON_CPU_TYPE_NAME("v71")
-#define TYPE_HEXAGON_CPU_V73 HEXAGON_CPU_TYPE_NAME("v73")
-
 void hexagon_cpu_list(void);
 #define cpu_list hexagon_cpu_list
 
@@ -127,8 +116,6 @@ typedef struct CPUArchState {
     VTCMStoreLog vtcm_log;
 } CPUHexagonState;
 
-OBJECT_DECLARE_CPU_TYPE(HexagonCPU, HexagonCPUClass, HEXAGON_CPU)
-
 typedef struct HexagonCPUClass {
     CPUClass parent_class;
 
-- 
2.41.0



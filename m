Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681847F4F93
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:32:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s12-0004Hh-Db; Wed, 22 Nov 2023 13:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0S-0004Bx-Ki
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0O-0004bE-LM
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:23 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-332d2b6a84cso22484f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677878; x=1701282678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emiroLvN4ZFzV0iGKy2RcqyAnliELrYGvZjH5AAzbJU=;
 b=FVlhk34mZEB+d8qCug9cHm0r/g+slR0rjpcJfHCwmMbnRVv9PfwQcj25atXSH/k8FF
 BfJkJqpPfuGkyx6I1l0mzDI9lS/J5N/DjTegYz9W/3D7s2JbE8sHErliZs/QE/z6v4zM
 psZM1IwKbWXKK55xK0rPMSXW1a2yU0fvTtmJ+28vYwAwfa+o9kF4m6RYCmZVXI/sQywc
 XCJCjAW+i3EQZNePDfS5bLrW2DqlN/KVFpv+ZFarWshOa4tphjZop6KRJnpmU+mSbCmi
 JFv3j3kuCQUHiRD2kA9yMypZuPL8cj7IjuOLdUAvyScluvYBZOJi0BmnfwVxkAvrxNPf
 i7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677878; x=1701282678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emiroLvN4ZFzV0iGKy2RcqyAnliELrYGvZjH5AAzbJU=;
 b=toagxF3J2pNB59O9XlpkOHuF8QvanPp0a21Zqp8qVDFyxOPdZOA6MiFJ5jWTLKLHLD
 AVyuNaRKP01BZfMpiKK8jkWARDvxQmusDeWv4+fyYjEJELiO3TFwf7C6RvqYFEBWBn1I
 gQuwXCoTSDd7VEUztV8vC/jfbYPOG5cikjPnXnnAj9zV8r6YHZIsN/GLyDDhcL5ExGr2
 7yzHwEzjyId1NxP6oI/8RzqZ2SV/JL0vBewU/Rw6KDlpYEjMDq13eF/kFGIx01iNVJJa
 Og+4+Zua3ii4KSVihcIVcxbXJd3zZoutp9rt/q+MclwIDD9lwuojYHG+zfoPOOaTlodR
 cvVg==
X-Gm-Message-State: AOJu0YzeGx9KiLR2DN6zVhiECs4vqCV6Fv4QGHMgLt7h9tgpAhuSRJRP
 sjKS+8hMczO5uV5K0IIi1EZUSP7nW2lOSuJDbt4=
X-Google-Smtp-Source: AGHT+IFNMJbi2etXsf890GglUiuNpOGjNqWpIB4o2PtsfSGyJ5b4d+uqJysxjW5ginkWipADtZqyPw==
X-Received: by 2002:adf:cc82:0:b0:331:6976:c8c7 with SMTP id
 p2-20020adfcc82000000b003316976c8c7mr2198011wrj.38.1700677877918; 
 Wed, 22 Nov 2023 10:31:17 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 t3-20020a5d6903000000b0032da49e18fasm66146wru.23.2023.11.22.10.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-9.0 05/11] target/arm: Move GTIMER definitions to
 'cpu-defs.h'
Date: Wed, 22 Nov 2023 19:30:41 +0100
Message-ID: <20231122183048.17150-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To allow GTIMER_* definitions to be used by non-ARM specific
hardware models, move them to a new target agnostic "cpu-defs.h"
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-defs.h | 19 +++++++++++++++++++
 target/arm/cpu.h      |  8 +-------
 hw/arm/bcm2836.c      |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 target/arm/cpu-defs.h

diff --git a/target/arm/cpu-defs.h b/target/arm/cpu-defs.h
new file mode 100644
index 0000000000..1ad76aff14
--- /dev/null
+++ b/target/arm/cpu-defs.h
@@ -0,0 +1,19 @@
+/*
+ * ARM "target agnostic" CPU definitions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ARM_CPU_DEFS_H
+#define ARM_CPU_DEFS_H
+
+#define GTIMER_PHYS     0
+#define GTIMER_VIRT     1
+#define GTIMER_HYP      2
+#define GTIMER_SEC      3
+#define GTIMER_HYPVIRT  4
+#define NUM_GTIMERS     5
+
+#endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 124d829742..8107e4d446 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -24,6 +24,7 @@
 #include "qemu/cpu-float.h"
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
+#include "target/arm/cpu-defs.h"
 #include "exec/cpu-defs.h"
 #include "qapi/qapi-types-common.h"
 
@@ -154,13 +155,6 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-#define GTIMER_PHYS     0
-#define GTIMER_VIRT     1
-#define GTIMER_HYP      2
-#define GTIMER_SEC      3
-#define GTIMER_HYPVIRT  4
-#define NUM_GTIMERS     5
-
 #define VTCR_NSW (1u << 29)
 #define VTCR_NSA (1u << 30)
 #define VSTCR_SW VTCR_NSW
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 166dc896c0..6986b71cb4 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -15,6 +15,7 @@
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
+#include "target/arm/cpu-defs.h"
 
 struct BCM283XClass {
     /*< private >*/
-- 
2.41.0



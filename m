Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A366962411
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Aug 2024 11:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMV-00020i-8Y; Wed, 28 Aug 2024 05:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMM-0001vd-R0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:04 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMJ-0001nk-97
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7148912a1ebso1995089b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838776; x=1725443576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFvdTr8ItVOjTzK94rYNt0BNQVSxcF+DNvHDFPsSwO0=;
 b=dVDDhgjUPOWayHSa03rvAVcPseBIQB7KYhoRsxIsL7y0XmDOvPlFKxOEfE8teGR8DF
 8ifpwdBznLjFzSVszrRQ4fxC05kr0ZBDFSORieGcO24LUCjqn7qWz8iN4rpuo+qhi6hH
 dIh/6aa26uisotXGiXNF8N1ZqQB/1tPsLgMp2zkbBudVL3bOlKam7uvJ3YSNJ4phOSPz
 spqYms/eMtg6cZOdnk0fpx5g9n1FOuYYDzsG2o49zReZRhfU8HftxgK0NylkQPwm1mFc
 N2XnLKeV3sMJeUtPgvqLSWx/7tv0/tdF+MlsL9tbYepdSDU7TEuPSPdMlImpvGf+ML4e
 ZFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838776; x=1725443576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFvdTr8ItVOjTzK94rYNt0BNQVSxcF+DNvHDFPsSwO0=;
 b=Ote3I9lclI6W7SUo/6pwpUbIfyO52Lb7YPWVeinHV/nO0jhkaqvSJov0FkurGne+tn
 VErFwDHFzsKcE+KbipWtMK407CPN5+ISLAWzcvSjhD3aLMXWycsZylRhUCTNHUdFRzCm
 lpjCsFYPX4YdlPzIsmR9KJHY+jsnycDmElrt8CoqAKHens+6oZ+MlpcmivwD5eXqZvQN
 g4gW83MKyLX20UI5gtjtZsXyOLlbZk8flaglr8gvsYOqQaEzP4zrosS/tTigWBL9ORfk
 ALAvyqTzXCsHXZcW9m+tDcs+AjdIAxHPUfkHDRX8nWEzbjrtHneJ+dGkJk1roaye0amk
 LHAA==
X-Gm-Message-State: AOJu0YxQHImoSxg2jfZl66jhDFmFjZ2X474pjlJ1ADu8qEAlKfFqLBl1
 /s+ILLQsrETOCz1V/72s6D2bkqySJJvNlVMWJ2UnUtXdOWTBQYFqzSV0MlJA
X-Google-Smtp-Source: AGHT+IHaEhCfXVcHUIE0CKEsGvpB4sBt5EkRPs8D/AUi7ZOKtswjyGsu4CINsETScm3hYeldvFD6jg==
X-Received: by 2002:a05:6a00:84f:b0:714:2a0f:29e8 with SMTP id
 d2e1a72fcca58-715d10be868mr1650514b3a.10.1724838775922; 
 Wed, 28 Aug 2024 02:52:55 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:52:55 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 01/17] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Wed, 28 Aug 2024 19:52:27 +1000
Message-Id: <20240828095243.90491-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Mark Corbin <mark@dibsco.co.uk>

Added the initial implementation for RISC-V CPU initialization and main
loop. This includes setting up the general-purpose registers and
program counter based on the provided target architecture definitions.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_cpu.h | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.h

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
new file mode 100644
index 0000000000..e17c910ae9
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -0,0 +1,39 @@
+/*
+ *  RISC-V CPU init and loop
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_CPU_H
+#define TARGET_ARCH_CPU_H
+
+#include "target_arch.h"
+
+#define TARGET_DEFAULT_CPU_MODEL "max"
+
+static inline void target_cpu_init(CPURISCVState *env,
+        struct target_pt_regs *regs)
+{
+    int i;
+
+    for (i = 1; i < 32; i++) {
+        env->gpr[i] = regs->regs[i];
+    }
+
+    env->pc = regs->sepc;
+}
+
+#endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1



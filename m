Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D547174D1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D44-0007L6-8d; Wed, 31 May 2023 00:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3n-0006rc-VD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:45 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3j-0006AL-IZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:41 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-75afeacb5e4so619894485a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505818; x=1688097818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FMynriKgHY7/a7Zeekt4jsXQMXu8INdJVu2wztuImV0=;
 b=b+FVgTIvy9k3CoLgJ5zGTG3QFzNfEHoo3cKdyiWRQqkNvI8I9GYb5wMd37JePoXETn
 S6ETjXrI2zDexxJqgz1L7bBbvuJ8N+xDQYRpgXjshP2r5A17KYODyvtO45R1/Uf5MiUZ
 ruw2vceP84lnOoZPu9BJHBhynYHfz/1hmBUpRTTY+Q5giHbwDi5ComLozHSD2Dkm5bGa
 gFG6kTz7C0gczvSo+6nEzmaGEvexNY2z7vzC/dFRPvGYXHwzxaeiWQpfhafh2pHwhFnA
 UIlM/3GkvcCzVQdG/HMCt5wKkw8XXVFwf8GzrIPGhhrtEvziRFB2eRiV788lcOHcBgrv
 zZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505818; x=1688097818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMynriKgHY7/a7Zeekt4jsXQMXu8INdJVu2wztuImV0=;
 b=gpPW24junAGwnODtfayt+eN2Max4TAMse5QD2t6Zy6dGRnwyA/cD1+UlUqM7gF8B57
 +uam1ktekUzHD7a2atHZfyN+ktEeBtTQMh8geo6NxbLweOFb1L+HOgZJK+LpPt1sTamm
 gzeyd5mBWuAkMhvF1JVKdjRGrbFiydwAQAIHgWsnssiVebH/tbg2ICWYzBl4rLYG+Cle
 720n7i5u6tuZN0o1CRVnhj0iwA1jz2rGIaMSldF+6X96Hx5luxNxzIW2fYBddTFegPD2
 lX4SLTrhji5s53hGphAXDUxYZZpAF+EU8m6br/7Afx5OI18Lygf3Pn8yddlcZvyQ/D8Q
 4sIw==
X-Gm-Message-State: AC+VfDzewgjcurNrlRJrcSIZhfBvV95zYh+/Xqq0ArkG8oiuvIx5zr/H
 h6UBfGJveg92m9fJ39u+1FE0HEwnmWgfkdkdHAY=
X-Google-Smtp-Source: ACHHUZ7eJv1ahn4M39y1FKVrQ3pZWeglEe4fepyEa1cZHTj3A/NxttdjexmILojOC7mm5BaM9bmpCw==
X-Received: by 2002:a37:6885:0:b0:75b:23a1:360b with SMTP id
 d127-20020a376885000000b0075b23a1360bmr4501961qkc.28.1685505818313; 
 Tue, 30 May 2023 21:03:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/48] *: Add missing includes of tcg/debug-assert.h
Date: Tue, 30 May 2023 21:02:51 -0700
Message-Id: <20230531040330.8950-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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

This had been pulled in from tcg/tcg.h, via exec/cpu_ldst.h,
via exec/exec-all.h, but the include of tcg.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c      | 1 +
 target/rx/cpu.c       | 1 +
 target/rx/op_helper.c | 1 +
 target/tricore/cpu.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a24c23c247..8f741f258c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "disas/dis-asm.h"
+#include "tcg/debug-assert.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 67452e310c..157e57da0f 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
+#include "tcg/debug-assert.h"
 
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index acce650185..dc0092ca99 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "fpu/softfloat.h"
+#include "tcg/debug-assert.h"
 
 static inline G_NORETURN
 void raise_exception(CPURXState *env, int index,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index d0a9272961..7fa113fed2 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/error-report.h"
+#include "tcg/debug-assert.h"
 
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
-- 
2.34.1



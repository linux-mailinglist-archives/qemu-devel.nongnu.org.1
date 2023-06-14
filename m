Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3572FE00
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PLT-0005q8-BO; Wed, 14 Jun 2023 08:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q9PLR-0005oc-7t; Wed, 14 Jun 2023 08:11:25 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q9PLP-0004WD-JW; Wed, 14 Jun 2023 08:11:24 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f62cf9755eso8332176e87.1; 
 Wed, 14 Jun 2023 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686744681; x=1689336681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TcpuyNo7Cj05QxClzlMTZ9fXRZkmmq8aHpB9ZFFXheo=;
 b=RJ52bJ90toDQXXwyzrh9atFfl/gRDgl8IbsqG1kZFny7tNtIvQhIx980BbVBFMaXxb
 CfV2l8QYSDZFMit3RF/TCJaHlDQQQwbA6YYwqSytkIt+NRTheJeX/Brs4FqFK7X0wtjO
 BLC00o8S/u2XOgHgFMOXsk1kRnGsGbd80/JFXNOu1fAFcUYpecZrr23ZsYfAK9VwYGhj
 iZzyPf1NlwzG9aNlqadyHknB3sc+5yvGqTX7zApS4RvmMGKKwLuEwEuQF3Qj4fSKxL86
 dSFROr1+iLCUdQCkiWfxQ09XiWJrHi4/M58AYVQHfx2nR+YXQ4iyM5hlH08Z3LM6IgDr
 0oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686744681; x=1689336681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TcpuyNo7Cj05QxClzlMTZ9fXRZkmmq8aHpB9ZFFXheo=;
 b=Bz9oG7R52uehBmWiAJzbuVlUipQI2/lNmtzMaVrkg6m8upJ7iQMr6AG1oWOmC9FxDI
 +F6zH0It12o1bKfkBB7umYBHZbNMfKAYeFUhxgkN62Nhv90H1JB3mU1zeH6bG6P/Dw7J
 ycXB2kkonHNCuJzynw6FhbCtf2Pv1rU0ixQYCrScHGaUcrAavG1RmtlCRbpbtC9hZ2KX
 VPQXOC/KXJ+RxLGyVGL79xcEJNcJODqlUGcYncyjJWrhqA0Q/nV12UStiAsJHVc9XXMU
 Wtyfcx4GMaMTNLCVxgPNKY9mbibuzXNdrEp1RJlZtAqx02deLihVsxVK7FLHpu+nly84
 DcOA==
X-Gm-Message-State: AC+VfDwZjEcVUrULu6F0FJVOdA9fXEyNe9YIFl4gzdmygFbyn1JarSoA
 Ss/qJbZ6IpXriU/4BAz5v6Y=
X-Google-Smtp-Source: ACHHUZ7GO84e6JB9dBeo+QAT/FDl33GKDC03xc0UVJnwW6VAYC4ZVZzZIBMdiCdjSWr9QmFAElusOw==
X-Received: by 2002:a2e:b0e2:0:b0:2b1:a8bb:99ab with SMTP id
 h2-20020a2eb0e2000000b002b1a8bb99abmr6310911ljl.19.1686744681245; 
 Wed, 14 Jun 2023 05:11:21 -0700 (PDT)
Received: from fedora.local.lan (aamiens-551-1-4-122.w92-131.abo.wanadoo.fr.
 [92.131.75.122]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c224b00b003f8126bcf34sm12918570wmm.48.2023.06.14.05.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 05:11:20 -0700 (PDT)
From: Lucas Dietrich <ld.adecy@gmail.com>
To: philmd@linaro.org
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org,
 Lucas Dietrich <ld.adecy@gmail.com>
Subject: [PATCH] Fix handling of AVR interrupts above 33.
Date: Wed, 14 Jun 2023 16:07:49 +0200
Message-Id: <20230614140748.3584-1-ld.adecy@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=ld.adecy@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit addresses a bug in the AVR interrupt handling code.
The modification involves replacing the usage of the ctz32 function
with ctz64 to ensure proper handling of interrupts above 33 in the AVR
target.

Previously, timers 3, 4, and 5 interrupts were not functioning correctly
because most of their interrupt vectors are numbered above 33.

Signed-off-by: Lucas Dietrich <ld.adecy@gmail.com>
---
 target/avr/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 2bad242a66..e6e7d51487 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -52,7 +52,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         if (cpu_interrupts_enabled(env) && env->intsrc != 0) {
-            int index = ctz32(env->intsrc);
+            int index = ctz64(env->intsrc);
             cs->exception_index = EXCP_INT(index);
             avr_cpu_do_interrupt(cs);
 
@@ -79,7 +79,7 @@ void avr_cpu_do_interrupt(CPUState *cs)
     if (cs->exception_index == EXCP_RESET) {
         vector = 0;
     } else if (env->intsrc != 0) {
-        vector = ctz32(env->intsrc) + 1;
+        vector = ctz64(env->intsrc) + 1;
     }
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
-- 
2.40.1



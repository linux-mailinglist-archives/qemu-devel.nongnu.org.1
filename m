Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F32117804C8
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:38:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJB-0003GA-S4; Thu, 17 Aug 2023 23:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJ9-00033Z-D7
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJ7-00064Q-5B
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so1148825b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329872; x=1692934672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gp/kxAcFG041fuCB7eSCneQ328svw2ciA3ODd6siWoU=;
 b=CB3Zd7XiCZPUa9cfX5MIrERKntVTDPlXfzhlrw3DD384Ne486U76HN2/ICgNDUaPBg
 kat+vkX77bbb7pibsrjhqnSD4aOnX3dprzHuQQwlu2/QXl/6M0xJLmlqsjZPbsURgxlq
 1mu7iMPY5TG7nN7YdalxOyfJIRIkGR3mQ2rqTYdv2KwIHOxxtE9pJbhrgbv8OpbAhGIx
 sr8Hff1Aq6Qtqknju7D5mbiHdMumpeHlK+NXQy2QcUFEamcqpQ3Y+EoByca/cZjSWByD
 SbwUF905YfFJ2tBU9sQtdzdsNXuAstyslHJAk49537oQMotWn3MYYl9M3iTAfmbIfpv/
 vkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329872; x=1692934672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gp/kxAcFG041fuCB7eSCneQ328svw2ciA3ODd6siWoU=;
 b=bqK2+BxpmOv4jFaWoWbTLchLwWH0XD22mUX0JAT1A1U5amDJlifJy/yQ1MBAExBvqv
 SDnboA0Wd57qcn+vq/ZNtQvEwEjFL3Xudx/qOqVXK2WhVlGsOmEmf6u+n2L89yQMKleh
 yaRz4yD1n23qDaCHroRhqiC3sbZrmz4Fxvg+J6pYDwypf1eB61/RduO1g05cHDSqWCNS
 5eVqm8RLDo7b4+0nI2b0J+SxzVO1uoGTsB1pEH6t69kKOpxvhxPtSH4RLg7Qq3AqQbo9
 6dZp355ijUYUDYqVlPghvCyoWE1UQd104XS5YDQYrgNC/yIJHwg9RzaYUHY2D9g2ZoHg
 a+vQ==
X-Gm-Message-State: AOJu0YzHsTSRrPO7QlW13MKuGFVcq1z90heunGD4zjzQMCK82GVhEB/X
 48ErJPFVrOHs1xS5XkOVzDW0DA==
X-Google-Smtp-Source: AGHT+IE9jOBNcA9rOpHutz5RSCndyrwhakRzbJiNH6sQwIGKL51XiY+yEQNwtLn2oIl71lezIovewg==
X-Received: by 2002:a05:6a20:1594:b0:134:73f6:5832 with SMTP id
 h20-20020a056a20159400b0013473f65832mr1780255pzj.16.1692329872018; 
 Thu, 17 Aug 2023 20:37:52 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH RESEND v5 18/26] target/arm: Remove references to gdb_has_xml
Date: Fri, 18 Aug 2023 12:36:37 +0900
Message-ID: <20230818033648.8326-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/gdbstub.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index dbc396a88b..4cccaa42e0 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -45,21 +45,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         /* Core integer register.  */
         return gdb_get_reg32(mem_buf, env->regs[n]);
     }
-    if (n < 24) {
-        /* FPA registers.  */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return gdb_get_zeroes(mem_buf, 12);
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register.  */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return gdb_get_reg32(mem_buf, 0);
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             return gdb_get_reg32(mem_buf, xpsr_read(env));
@@ -99,21 +85,7 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->regs[n] = tmp;
         return 4;
     }
-    if (n < 24) { /* 16-23 */
-        /* FPA registers (ignored).  */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return 12;
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register (ignored).  */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return 4;
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             /*
-- 
2.41.0



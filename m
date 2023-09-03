Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C628790ACC
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 06:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcem6-0002HE-Ie; Sun, 03 Sep 2023 00:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelw-0002DS-Br
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelt-0006yb-7O
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so7491945ad.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693715496; x=1694320296;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imQ9qzdcJDtD/a1jypCsLu37Mc6AwMqkJVAfloEAGmU=;
 b=ZOaqrIgYfOjAUpmEYR1gPQ6qKUahRgpXYvqaRVD8DfDjXIhbCLYS1FFLzR48cIp+oC
 H2JLDVkys11YHcx7tQbtlgA+IAGsC939pHnLd/+e20HQ/yIJvBzqt+J1VxrRAbM+MMqu
 v3dzO6Wn8A4yXPdBAzQxEO5pm37F/4FrDXnVLA1K++4pT2F51V8+1/NBPUDkaAEfWY6c
 G71cg2r6nYLqCTJORV342pGFKlFc9HmEciV0+SfrHu/VEV9iSumKpF8pMxqlUKdYbg18
 tzDDtxrfX8ERqx/3lrjBOh61fWe7zdZcmGOAVya5/O0mDp3BbzwC3ceWNOK2Vs9IOslo
 STsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693715496; x=1694320296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imQ9qzdcJDtD/a1jypCsLu37Mc6AwMqkJVAfloEAGmU=;
 b=LLJ7S2yKxwxZ/0xKNYpd98HTm6aI7cEOjYHGz79gk7kuMPlwjtAWGxzL5CiQmr2NkW
 LgCajPnTeHLbcqYSmeGkqa9PoFfwTUtO1YAxtkuytkvkwF/ld1MFdpvkR18+nnWfp0O/
 YQqq2jw+OCSq5hu9SVavkjuo5W0G6RVXnfYZFRRKeAUf9AJ0hkh/H/xF1EjfjhFaqyJX
 kN/P5u2bLNlpXGWMnd97+rQa2MGusSJlndw61GxQk1ssBZCS8ndEusIJT37k3lJOd/x4
 SuSqEe8OVD1aAmbLXLW/au0IycVlA7BRaxxb6b0sYGmhcZ6bDKI7jA0XkDkZQouLrpWP
 hIdA==
X-Gm-Message-State: AOJu0YxQvGTWjceVW9zgpCfRK0+v8Wwu/BAnuJutGeojL9a6u+my12Uy
 NGAKYD7ZtyQ1vN9ChEpTu3K7BCa5G7i4B5qKcHQ=
X-Google-Smtp-Source: AGHT+IGMbfp+G5QcVXO4jcvTYCcJ830aRAKEId2e0w6AbOvdHewaqNTukLG+W6rYVP9xPtXB7o9eTQ==
X-Received: by 2002:a17:902:ec84:b0:1bf:7aeb:c488 with SMTP id
 x4-20020a170902ec8400b001bf7aebc488mr9373299plg.29.1693715495898; 
 Sat, 02 Sep 2023 21:31:35 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm5295792plb.146.2023.09.02.21.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 21:31:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 6/8] target/arm: Remove references to gdb_has_xml
Date: Sun,  3 Sep 2023 13:30:16 +0900
Message-ID: <20230903043030.20708-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903043030.20708-1-akihiko.odaki@daynix.com>
References: <20230903043030.20708-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/gdbstub.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index f421c5d041..b7ace24bfc 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -46,21 +46,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
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
@@ -100,21 +86,7 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
2.42.0



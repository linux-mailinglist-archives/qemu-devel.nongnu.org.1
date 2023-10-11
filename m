Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE77C5078
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgm-0008D2-8u; Wed, 11 Oct 2023 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgj-0008At-PG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgh-0007fB-3b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-406650da82bso61643145e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021012; x=1697625812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPaasftMrVbbA875970yr+KsXKzf7HZNoY4yrQwF8Og=;
 b=Ay3YH6wvFeInz/4JZVMAYNkuLzH6bzNgOd+eBH9rmyPGqoJGhVjp9jXsEMJUwBUmW8
 LKJm0Se4cY96r3YrHeDRZ4uWnf3nzBjNhbN9yBbgutjdqoozCoi/JsFoUwrbDU0dHr6A
 iYaPM+WWNutqLdebVQCAUWSMcCKUwZNJksssGfbFlNQo6AaRXUeuryrOvUQ0VwE0cIHq
 S2Pfde4D0tUDzeGANEpCtE0tStmkT/PwWbilDEE00f5pHbS2wmaJnFITFGsP8HthR9UW
 NLQPgG8s438ELw6S1foamXnCpR5xj2pNmFk4l7CL3gJvlAYDOwAZkzv7ga3vexmWt2ZT
 /n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021012; x=1697625812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPaasftMrVbbA875970yr+KsXKzf7HZNoY4yrQwF8Og=;
 b=wG5KPtv0z471zAdeCfZVlOnExIxvKQLcdLg2U0k/Tjl1mlFxZ5Cr5caZa17tHsZ/dD
 y+FheStELMBJIr1ojIzK4/aYlFwGdPmG/it5lUTgp9oZocoDIv2mYTfBV6+BkwttbnhV
 asHme11OtCAC2KngahlFCoRAqQb0NSMirobXMeYE08jcaCkgdWXvbpJLNV/NwLkg/wi+
 JJeXv7qkV4oWmjqPnk2SNie1juMQ22MYTUCEC+8KurPwlWuQrzfjcjiODDzpIFz52wYl
 6fD2z/6jHDDcnI5GaZtLSTn4Z+ruNjnNZQO5TLR5E7SC0RUP3wqbfmxXfdSYS1bC+nX/
 W8rw==
X-Gm-Message-State: AOJu0Yxvy6KbDuHXwwgSTqKNe0k6nReQohs/FnBLsAPX4t9a3p5C5c6z
 kYlv3csMkie3radBHWOlBybf1Q==
X-Google-Smtp-Source: AGHT+IFzEy64ewUPAUmpiwMh+dXI7S8AwXRB27XR7BJ3qE1cN9uymFBLg2mD/Cvo/6DAnLak0uhZpQ==
X-Received: by 2002:a1c:ed02:0:b0:401:38dc:891c with SMTP id
 l2-20020a1ced02000000b0040138dc891cmr17641553wmh.5.1697021012597; 
 Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a1c7405000000b004064e3b94afsm18852827wmc.4.2023.10.11.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:31 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAFFC1FFC8;
 Wed, 11 Oct 2023 11:33:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 16/25] target/arm: Remove references to gdb_has_xml
Date: Wed, 11 Oct 2023 11:33:20 +0100
Message-Id: <20231011103329.670525-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230912224107.29669-10-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-17-alex.bennee@linaro.org>

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8fc8351df7..b7ace24bfc 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -46,21 +46,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         /* Core integer register.  */
         return gdb_get_reg32(mem_buf, env->regs[n]);
     }
-    if (n < 24) {
-        /* FPA registers.  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return gdb_get_zeroes(mem_buf, 12);
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register.  */
-        if (gdb_has_xml()) {
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
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 12;
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register (ignored).  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 4;
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             /*
-- 
2.39.2



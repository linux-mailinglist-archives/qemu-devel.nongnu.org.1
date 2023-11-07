Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737E7E41C0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N01-0004Ed-Sw; Tue, 07 Nov 2023 09:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzs-0004Cr-SJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:04 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzp-0007YF-Gj
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32deb2809daso3403279f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367038; x=1699971838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKa4ph+IbACrmLp/l7KUj2enSm3dMfUXc05KWX4jlJA=;
 b=KevyJCliE4PnLVzDXFLJ/yNUU6KBLmNzK19OACMFRlH1hWCXzMBIZdZxUZxu8fcEbl
 a4e2frxF/7gUBVI4AL13aQnJ3SRdFfyhcll7Br9XqsOvHTMkSZPNmTMyTegWch4I1ve8
 6MBTSXvVw4kwsXwu2cRttjrD2s57FqPN0w7G1pegNq9+LMjO1aPX+Wl/lOjbY10KE5t9
 +ELsJ/RzkQeJrIOa0WyZreMuqzgQ6jSUafXyMKd1IiCYbeupfdxT57D8mS/Sokb+Tfzm
 f9va9TClpL5D1SJoQVL2Ik56FPvAUGhQB6qDOMlrsxAo3jAZOLB3v00UhX48DRrnbAHu
 5w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367038; x=1699971838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKa4ph+IbACrmLp/l7KUj2enSm3dMfUXc05KWX4jlJA=;
 b=OZDWAh9lH4B59vDG/XTTsgndryAhO9FMTAkdiWBSm12aZHW08feT4sFJNDCIe2582V
 3fnj7beab7M0RyxisFk5gCWpJ21ULwm5Elx1xbOqPILZFWp5nd+u0TNiyZSRqm7Vfv4C
 K8w/UWjwBm90rvICdtdJDzVbWOOrXtx2YGN77XoaJ5ujzdfWLlDslxjMZDqgqKR+zXx6
 OV7tArWeHdelG67NinVl42/0YYj2+bLi/gxmWvuZ4K6A+rjwm16lPc+BsY7XoFjhrWFu
 2ETz2sRc4wexJ/xRnCNCaf/k1wO7W9HUu6j3I6+Wim3sZWiz0tTx49eAdOcu5Ba7EYTb
 eVzw==
X-Gm-Message-State: AOJu0YyftLqFR3xkOhIb9f3KjIU5mtxjKUGI22FgBjfJ3AwK3bpcyoiA
 LIEjhmjvVjArTcBAP4W8OwymaA==
X-Google-Smtp-Source: AGHT+IE7qYprY1z7qR1PiFwugXJZRofeFzSTVcJ17QkUYqJaL+LpOmdwsuWR6+a8uX6wVcuIsQuL1g==
X-Received: by 2002:a5d:47c7:0:b0:32f:932b:e02f with SMTP id
 o7-20020a5d47c7000000b0032f932be02fmr19117539wrc.55.1699367038435; 
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h6-20020adfe986000000b003200c918c81sm2457299wrm.112.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F344365759;
 Tue,  7 Nov 2023 14:23:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 04/23] target/arm: hide all versions of DBGD[RS]AR from gdbstub
Date: Tue,  7 Nov 2023 14:23:35 +0000
Message-Id: <20231107142354.3151266-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

This avoids two duplicates being presented to gdbstub. As the
registers are RAZ anyway it is unlikely their value would be of use to
someone using gdbstub anyway.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-5-alex.bennee@linaro.org>

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 79a3659c0c..cbfba532f5 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -937,14 +937,14 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
      */
     { .name = "DBGDRAR", .cp = 14, .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL0_R, .accessfn = access_tdra,
-      .type = ARM_CP_CONST, .resetvalue = 0 },
+      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     { .name = "MDRAR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
       .access = PL1_R, .accessfn = access_tdra,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "DBGDSAR", .cp = 14, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL0_R, .accessfn = access_tdra,
-      .type = ARM_CP_CONST, .resetvalue = 0 },
+      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     /* Monitor debug system control register; the 32-bit alias is DBGDSCRext. */
     { .name = "MDSCR_EL1", .state = ARM_CP_STATE_BOTH,
       .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
@@ -1065,9 +1065,11 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
 static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
     /* 64 bit access versions of the (dummy) debug registers */
     { .name = "DBGDRAR", .cp = 14, .crm = 1, .opc1 = 0,
-      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
+      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT | ARM_CP_NO_GDB,
+      .resetvalue = 0 },
     { .name = "DBGDSAR", .cp = 14, .crm = 2, .opc1 = 0,
-      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
+      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT | ARM_CP_NO_GDB,
+      .resetvalue = 0 },
 };
 
 static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.39.2



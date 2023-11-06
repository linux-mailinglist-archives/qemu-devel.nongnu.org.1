Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF247E2C62
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:53:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04hC-0006E3-TF; Mon, 06 Nov 2023 13:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h9-0006A8-8Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:31 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gv-0000xH-4o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:30 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507cee17b00so6163711e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296675; x=1699901475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhApO9Ay6WkoDHQaLzRIOYtnAoxR05P4kp/hfwO/YNE=;
 b=hrnQfoD34u/csHZiPLQ3JbqSd7sZu6G+wxUH9dUBmVVjE26qnrn+nP5+eUTVUSbTFX
 /WEvXum9pa5lmHA4l8UKHoZ4L/msFmUywAQZV0TtLeFsFrELal60jpYYwlnAq5+xMeBX
 fKCg5i9KvzI65rJ1MU5OA9LZr3oeP0NU0jLkT8GrF4BGJA0ZlhkUANH3W5rskLq7JhKj
 1nqlUFMU/LU6T+hfTHrPC5djh/CDX+vkl6lRImz5nzdmOLee6sXOi3VYHg8+/hwE6YhC
 xG6DHM0WmNBgMVliCchgSZFcIojiXabPzKx9+SjdX/p2u1gHR0bZLN5+0ZFDEQVuKmGm
 3R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296675; x=1699901475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhApO9Ay6WkoDHQaLzRIOYtnAoxR05P4kp/hfwO/YNE=;
 b=DChB1M45WXsG51DXNjl56R8ELGzLJSx6DeWyMD5J9pBQE26KtMTPshmwywRqK8XIQ/
 nDpE48N8WP/RhEJF1vQ2wM2as9vT6IyI9lVnYvtfQ5/mp3iFTUw7kHFPRAoYEdt4qvcX
 GewEjaHOAStKffGhSNLDluwj2bs4g69jZ1uV1/xHur4ojL7mJ3uS7Mo/vOsTQHXBfsSr
 XP/CTEB4OR1j+S92yWcTvq9d5cBswck1dbhh4JwnLBqCKCuy1yBIZft8LfM4v/alnkUH
 sa7ZCPwkzyrwx70HUQsmhTIdLKo+Uiqg4PcgxGP/V7GHQRA09nsV/0W2Xvi46JPgabrA
 OLcw==
X-Gm-Message-State: AOJu0Yz/FmnmKNyogjmhixC8MQL8r2n1oETA7dHVy4lXscyHBkAvE6Hr
 sYgyFP6Vb6jU/eT0i+vN6D5MCQ==
X-Google-Smtp-Source: AGHT+IFferl/m3ntvivL3nECOQrneQWjFFcDEK+j7HRzQDtYHoFWSctR9SfGs6QB6mQulGvb2QBjGA==
X-Received: by 2002:ac2:5634:0:b0:507:aaab:528c with SMTP id
 b20-20020ac25634000000b00507aaab528cmr21547700lff.69.1699296675383; 
 Mon, 06 Nov 2023 10:51:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c1c9900b004067e905f44sm13340971wms.9.2023.11.06.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D242B6573E;
 Mon,  6 Nov 2023 18:51:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/22] target/arm: hide all versions of DBGD[RS]AR from gdbstub
Date: Mon,  6 Nov 2023 18:50:54 +0000
Message-Id: <20231106185112.2755262-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-5-alex.bennee@linaro.org>
---
 target/arm/debug_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 79a3659c0c..dc783adba5 100644
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
@@ -1065,9 +1065,9 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
 static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
     /* 64 bit access versions of the (dummy) debug registers */
     { .name = "DBGDRAR", .cp = 14, .crm = 1, .opc1 = 0,
-      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
+      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT | ARM_CP_NO_GDB, .resetvalue = 0 },
     { .name = "DBGDSAR", .cp = 14, .crm = 2, .opc1 = 0,
-      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
+      .access = PL0_R, .type = ARM_CP_CONST | ARM_CP_64BIT | ARM_CP_NO_GDB, .resetvalue = 0 },
 };
 
 static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.39.2



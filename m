Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5D07E2C65
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:53:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04h7-00066g-Mw; Mon, 06 Nov 2023 13:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h1-0005v0-56
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:23 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gy-0000xz-7a
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:22 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507c5249d55so6299778e87.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296677; x=1699901477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pitDltH9Qlw0pV6jb2flwtg/jHXkAlmdYF0xczgfric=;
 b=sKU07PzNCzY/IFAPsfClFZo+uXJp1G+G6HctQu/ZzXVeY5FysbmlQFw8r84Lh2Pd1+
 DSU3f5pJNxyJ7ncfYy10tNCLT2NHmdWgQzBhlqasYuN7XBa3PvGpwvFLylz7JXKofLVO
 ZQqUnw7ciN3orCLKctdUXpyh3BfPjP8nSB84A3EdUzZDF/O5RFEjKk5N1lOEJWF7+qdi
 s9tyCB4GJSVLqCIN+J/8pkBUvit740YMxIaPG/Bv+GIEaVkfPZA4ZSoCB2r01lKCBzVq
 QZH5FHxF2FF7thViRY1XDjnomQsRliSUCoSuAn330pcv2xWiFnKbV7HyYlHaNKlDgigP
 5gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296677; x=1699901477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pitDltH9Qlw0pV6jb2flwtg/jHXkAlmdYF0xczgfric=;
 b=CH53rgqyaxj6RzSLQIsSShH/nj0gahUz92WTpg31YrLb9lSOzrR+9G8BpIMk1Gaixh
 zso7YDhyphzBBeYk2rMZe8hM83fOYQpJj7WyS7mOAjNx1pGjJxBBDIhbUfVRgwLd2gYC
 1sBYzhHdREwUt4Z3rGQJv4ltMbNqgoMhfadlACEluknHKrPTFupw4Y97R9m9AMnoOcog
 9aN4cl/ALoo8e/XhO0cBUexggxYH86Vlvekx/ww02indzVJn1E9iJ8aUukUONQjUEFXi
 v3SVqW2CI9C3U9g3W/O+PR+vIJMk7GfWrj3szJKa9en+qsXSKJv9KRid/R86G/6J9vkb
 dBQg==
X-Gm-Message-State: AOJu0YzBGMMZ8kP+1HPJbS4bBMaagaaCsnAMhJNmDBLe4mKS/V3VoByh
 f6hZOBChFBZbirKlMYOhMCHtvw==
X-Google-Smtp-Source: AGHT+IH0I3bj91VULb1n1+Ir7Zqqpfpl27F/ELlsXQ/UvfBrn/gmBNRk72FD0lcKgGVJ8rXTLNStKA==
X-Received: by 2002:a19:e043:0:b0:508:136d:ab0c with SMTP id
 g3-20020a19e043000000b00508136dab0cmr18493505lfj.30.1699296677441; 
 Mon, 06 Nov 2023 10:51:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a10-20020a5d53ca000000b00326dd5486dcsm291434wrw.107.2023.11.06.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E5E1C6574F;
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
Subject: [PATCH 05/22] target/arm: hide aliased MIDR from gdbstub
Date: Mon,  6 Nov 2023 18:50:55 +0000
Message-Id: <20231106185112.2755262-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

This is just a constant alias register with the same value as the
"other" MIDR so it serves no purpose being presented to gdbstub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-6-alex.bennee@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 104f9378b4..a681bcba62 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8993,7 +8993,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
         };
         ARMCPRegInfo id_v8_midr_alias_cp_reginfo = {
-            .name = "MIDR", .type = ARM_CP_ALIAS | ARM_CP_CONST,
+            .name = "MIDR", .type = ARM_CP_ALIAS | ARM_CP_CONST | ARM_CP_NO_GDB,
             .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 4,
             .access = PL1_R, .resetvalue = cpu->midr
         };
-- 
2.39.2



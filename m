Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A87E2C5F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:53:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04gz-0005rE-1H; Mon, 06 Nov 2023 13:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gx-0005qG-2N
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:19 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gv-0000xO-B9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:18 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c5087d19a6so65368271fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296676; x=1699901476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paT+/TLeQzoSncT973yZvwKaP9Wy9ZCe68IEGURzE5I=;
 b=A1EJWLhRhKJxDkFn+62HelxYF5xwyu7Fzwnmq2zp6KKZ96a/M2sa/75eSSBE/wyoDA
 ++SXNHvZ+ZtSTckunYor9xmQ995DitnU5D4vxZq3Iw+OFBoiec3GX1v85XsS/qfcH4FP
 bXwU02wHR8KlG/jfk6rgoAgAOQADn+8kX1uV9m4b1sM8LNmZcAM9dMSjRhwMwk3hMQqX
 JLYEeykfLAgCSU+y4yjmmnkjIai6ysF+xZ8Oh6X7+4YqWQHt227v8ecp232akvn81gjm
 8bDV0fuia8wN5AYgNsbO+8NkxAD3VlzDfLRA1s/51kq/Id0pZeZsc0l0okze4ir+4e3p
 2gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296676; x=1699901476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paT+/TLeQzoSncT973yZvwKaP9Wy9ZCe68IEGURzE5I=;
 b=eiFlSPaVvplpuawUtOxdWv2+2Lj+sRqVG1ECpYx0dFq0EOBn8JFDXAYQipcyPwWiHf
 A979RMO3zwXk4y0CaHd1PMjPPcpYAeXo94VpKOtq0ii+ApQZSxrlKDizOwMAifbURGFH
 Le19XiIMTDp3cCGda2OncT5p++8T5/Rn04N23ZbZf73xFPqW0UugN8VczhNjUS1gVsfk
 cuWdrgdyND2quGJbTqUiTteGdX4fLHIUN+F4+0IWSi2IVCMuMV3Y1rvZIqL28P/8JnmN
 frnxiWW3ANEimcv1shUsS098jZWU943lU1QwzZNLRHRpjWiv51o1Rqo6z1T+0p7BlS+K
 Id1g==
X-Gm-Message-State: AOJu0Yyn+9FIvtSmrSGk8u4Z0Nc93NIOurWvg04fW3hUdT7YBsRJs5hb
 EJeKEnluC6FsGm0s/z6v0gc4Ow==
X-Google-Smtp-Source: AGHT+IH/fICKXCEPVpGF4YNsay/Xu1Msx3dNZAykGzyRKduQ0OF9/phBhBNyMQoYZ22/28rRFPesvA==
X-Received: by 2002:a2e:5012:0:b0:2c5:16d0:69ab with SMTP id
 e18-20020a2e5012000000b002c516d069abmr24843616ljb.44.1699296675606; 
 Mon, 06 Nov 2023 10:51:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg13-20020a05600c3c8d00b0040644e699a0sm13185234wmb.45.2023.11.06.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB6806570A;
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
Subject: [PATCH 03/22] target/arm: hide the 32bit version of PAR from gdbstub
Date: Mon,  6 Nov 2023 18:50:53 +0000
Message-Id: <20231106185112.2755262-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

This is a slightly hacky way to avoid duplicate PAR's in the system
register XML we send to gdb which causes an alias. However the other
alternative would be to post process ARMCPRegInfo once all registers
have been defined looking for textual duplicates. And that seems like
overkill.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-4-alex.bennee@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5dc0d20a84..104f9378b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3727,7 +3727,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
       .access = PL1_RW, .resetvalue = 0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
                              offsetoflow32(CPUARMState, cp15.par_ns) },
-      .writefn = par_write },
+      .writefn = par_write, .type = ARM_CP_NO_GDB },
 #ifndef CONFIG_USER_ONLY
     /* This underdecoding is safe because the reginfo is NO_RAW. */
     { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
-- 
2.39.2



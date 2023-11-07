Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D851E7E41E6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:35:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N9i-0003gh-VM; Tue, 07 Nov 2023 09:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9T-0003UR-K3
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:02 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9O-0001Rj-6J
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:33:56 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso40363645e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367615; x=1699972415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66Yo0o+2uncS4aFgFuePxGz49R/v9IcSCTHQts+bNnM=;
 b=a+EPJHaa7NxLR4x/UKi17a+FzjjN8iwtb+IeGs+lP+r3w/ZSgT6wcFanIIf7M/g+tG
 n3ui1mzBeHF9jMgFUxXt1eEQBXLyceX/V9iq1psZbknP/FL/G+Jqr1BmByaylFT6U4jo
 WkcYKgCIr9zwuKJC1RovpTndoTQejQYpH6M6u0GlmS5L6mZEits8VBQoiELhH0w7ZArt
 QsB1TeWGkN55NtEZY4ORBcxZBFkdAGUUL/tMmmaqdkN/Vzli6x0wWPZ9FT6fjfH4rLZ1
 bd8YlrvLhXqEIebc9pII4x+h/E5Wh7ozcuW9ZKBm5osFLv3hRMXN1TDlp6KaLksMf4gh
 Fpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367615; x=1699972415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66Yo0o+2uncS4aFgFuePxGz49R/v9IcSCTHQts+bNnM=;
 b=vvHEQ3yPc2HDBnonfMyaw4GsNSPmih8bebL9/pBCVtzq1y/VYD+j2oWBnzmO10pJaL
 eiLQwaBN1C2oMjxAqizF48eBT8SCIvY/VKWnMKke1W9XfpvrjoPGCm9QYJJocqHSBM41
 sHBstZDGKNE7+LXvDjauj7ymWd5+iU7HOGIGkyuxv3BXZIwm1BFFPO7PjOmyd1PAI8kQ
 0jdFlWUul1plosxsINkuVIE4YHVi/MQB57IcECEhZjJU40/atNUpJAoBRGtopmk1o3Dz
 /g8qtjnDjdoYwW0eL2KKUHhLOpFw3vAwtN7c7SbPbnKkcltq0JD8RrdQPs5tupguVad0
 9nkg==
X-Gm-Message-State: AOJu0Yzcz1iUYfooZDt0qkfQhRhbhZjL9foJBOYErARPfOQduy6hm73F
 rQ9crb7Cpz+bmroSaPG3VvLFgIRoGnDeQm15ZLypaw==
X-Google-Smtp-Source: AGHT+IE94ut5xSB/CfTNuTVVhnIgtBeOGGdkZYLukqHE/d8jAJr32hpVcFcNAu/aHqrufTnM2YVJEg==
X-Received: by 2002:a05:600c:3547:b0:401:b1c6:97dc with SMTP id
 i7-20020a05600c354700b00401b1c697dcmr2465268wmq.23.1699367615013; 
 Tue, 07 Nov 2023 06:33:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00405c7591b09sm16090135wmq.35.2023.11.07.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:33:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A22996576D;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/23] Revert "tests/tcg/nios2: Re-enable linux-user tests"
Date: Tue,  7 Nov 2023 14:23:54 +0000
Message-Id: <20231107142354.3151266-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

nios2 signal tests are broken again:

  retry.py -n 10 -c -- ./qemu-nios2 ./tests/tcg/nios2-linux-user/signals
  Results summary:
  0: 8 times (80.00%), avg time 2.254 (0.00 varience/0.00 deviation)
  -11: 2 times (20.00%), avg time 0.253 (0.00 varience/0.00 deviation)
  Ran command 10 times, 8 passes

This wasn't picked up by CI as we don't have a docker container that
can build QEMU with the nios2 compiler. I don't have time to bisect
the breakage and the target is orphaned anyway so take the easy route
and revert it.

This reverts commit 20e7524ff9f0cab4c9a0306014d6f3d7b467ae1e.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-23-alex.bennee@linaro.org>

diff --git a/tests/tcg/nios2/Makefile.target b/tests/tcg/nios2/Makefile.target
new file mode 100644
index 0000000000..b38e2352b7
--- /dev/null
+++ b/tests/tcg/nios2/Makefile.target
@@ -0,0 +1,11 @@
+# nios2 specific test tweaks
+
+# Currently nios2 signal handling is broken
+run-signals: signals
+	$(call skip-test, $<, "BROKEN")
+run-plugin-signals-with-%:
+	$(call skip-test, $<, "BROKEN")
+run-linux-test: linux-test
+	$(call skip-test, $<, "BROKEN")
+run-plugin-linux-test-with-%:
+	$(call skip-test, $<, "BROKEN")
-- 
2.39.2



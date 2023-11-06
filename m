Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595C7E2C8D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:01:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o7-0002vT-L6; Mon, 06 Nov 2023 13:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04o5-0002v3-Mt
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:41 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nx-0002Q1-9O
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:41 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c50d1b9f22so64515001fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297111; x=1699901911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fAkKRt+1wt+onAFA8XwPfIt8ZimYX8PK1f+OKUAUp8=;
 b=MnHy+Jd3ObGC8cBsu0KD6xwgdRlOoBu6Bf3DWTHY7mtondRudmXXmfmp2zHK0F3rp1
 bncI0Nf5U+tI8QZTrXl5zp2tD+6Zp0npsCzg49ix1UZUrXyGwyfwDpBDgvlFnwnyz8j/
 qDC6uBQGVtXUaEVf2tYhKACHml55OtVnTS4xQUVrF/KP1rALPZJm+d1UmzKdHO8f+IrP
 f/3+chjXJqja8Zo5SXUdpKJLPmhDxQufapu/zzLcOD75XOYTCTBdL3EzksTqBOiO9fhc
 HMhfoDwmH7JkEiYhEXyV6/B826QjFykVxKuD+ambO5HeHyqYXHL9+4MZf/fMDnkFudfK
 PEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297111; x=1699901911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fAkKRt+1wt+onAFA8XwPfIt8ZimYX8PK1f+OKUAUp8=;
 b=RUFjbRe1uugidvPA3xEXhdvY4vaEq88xgY0/sgwCtQMPhodW3tzDQG3VhtvxA99Uh5
 vNSVETY62qUS9zxsxS5b5NFuwUUenmimRNHwSh24i3Qt4pCbizvU19419GUiQ4jOsXH4
 ck0QDKqtRJsWqIUe1dNlp+D2PvnCwOGlBHQiWjnePWqDnjdfBfMS+EWLyW/WZ+qDwnqU
 NIr8nFAXyFkCmJeIVo5tV/bmI5eaJi4oUg8RA8CexX1MzZ9khkNMvWLe1rhwR5wF9e/U
 7bs17SYYwvtOE1YB1HsnFGtYLfi8aYYclgVWtoR5y23uYUwdp691xpnfnlTCzNU9up4x
 JV6A==
X-Gm-Message-State: AOJu0Yz1RcLu5rE1VyHQd+Mtz+LXFHoS03bCXnLyFH0Bgm8sr26ZakzF
 NpnDBFGZUrH0yzXMgE+SB1hwYA==
X-Google-Smtp-Source: AGHT+IET4wgMT1NBuVedNfnzbA5aYyqMU5TnYluJAT4baiXwtcp4UJs1qAKHUFs2nGeQpgW0Bkgyew==
X-Received: by 2002:a2e:3307:0:b0:2c6:ef64:3164 with SMTP id
 d7-20020a2e3307000000b002c6ef643164mr10533761ljc.17.1699297111446; 
 Mon, 06 Nov 2023 10:58:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m13-20020a5d4a0d000000b00327b5ca093dsm300326wrq.117.2023.11.06.10.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DCEC65766;
 Mon,  6 Nov 2023 18:51:14 +0000 (GMT)
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
Subject: [PATCH 22/22] Revert "tests/tcg/nios2: Re-enable linux-user tests"
Date: Mon,  6 Nov 2023 18:51:12 +0000
Message-Id: <20231106185112.2755262-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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
can build QEMU with the nios2 compiler. I don't have to bisect the
breakage and the target is orphaned anyway so take the easy route and
revert it.

This reverts commit 20e7524ff9f0cab4c9a0306014d6f3d7b467ae1e.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/nios2/Makefile.target | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 tests/tcg/nios2/Makefile.target

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



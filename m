Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B7D7A09DC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgogH-0002Ds-93; Thu, 14 Sep 2023 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofw-0001Xd-JP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofl-00087Z-Vd
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40475103519so5597325e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706865; x=1695311665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0F+tBp/Zccy2uJ7FpGjMy0R3Pa8Sdc/jZphp2CrwY2k=;
 b=CrN02Blq2X8Je6vjXY4CsC/0YKmG/IHWJ67JMUt//G5wMR5yE4EsF7yOHkKRHy9jL1
 P8asV5T/ut3SlyEZkYwXS70vrXs9sueDOcc8cuWcVj/x1LAIMhwtJekMUaYFnu3q5CIf
 Rc2SOJR5WyydOsE5+2ZgjKrUSpfrhui9sA6mYh9WkEDw8lHVLdfXjqQochYHoCWWdXK/
 xe6wfkuTTHu+K72IV1uvWX83wnj0b1YdU6evJUhzr7AYdDUQAvzBhYePYfzgbrfWBLd7
 gD8RYZbE3DtAmYVFmpzXxZxPrtgA05joheUXC46W1AFwByeOHMvti6Rd0+/TYQgxO1FF
 337g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706865; x=1695311665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0F+tBp/Zccy2uJ7FpGjMy0R3Pa8Sdc/jZphp2CrwY2k=;
 b=p01SoPDB7zSRIwnBoOFu23j3mWkcmwjR6OhifnR0b6PH2JIfJKpISp5wDSrnhqkqpk
 XiIQsZgSnauR0J38JPeBqBuHi/czVuVHEdeHh8ybtd38VSiO3Qj3fNsMoEPNl2J/69Eq
 hDwiCPJCIkkaRRfk1lZhPN4vb+zPFl4kelRrieN0VKpA0dkV1TMe3SRRJjvZeSI5ZCkT
 tDlvrZTJGP2MmYf7TBzYW6NGbMVFlf932XGtEW0Js4xMKLltstPx0hk3ZAlrNd1q5VXu
 aRtsTG1vy7eyMznAwc+vaMSEmTx6mmrl+QaDwQoPD8NY//ImN4QrA15XuJrwqWm7d5+d
 BmFQ==
X-Gm-Message-State: AOJu0Yzy9FqXd8/PW2RPSGFgRpp7Vs98xXHL6IzVxDq/0XjMcmMgXek/
 HdaI3cCIof/p6o0dAB5jyuDA0pLjPXHCBQzEJrY=
X-Google-Smtp-Source: AGHT+IEbbka9N/h+hjyxJLQaCyCXqBrTDLLeu0GA+rnQ/79cJIBdJ6m0RjH4oY0ENjgcm8YWDNzc6Q==
X-Received: by 2002:a7b:c01a:0:b0:402:f07c:4b48 with SMTP id
 c26-20020a7bc01a000000b00402f07c4b48mr4887453wmb.28.1694706865312; 
 Thu, 14 Sep 2023 08:54:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a7bc4cd000000b003fc02e8ea68sm5199620wmk.13.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE6AF1FFBF;
 Thu, 14 Sep 2023 16:54:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/9] microbit: add missing qtest_quit() call
Date: Thu, 14 Sep 2023 16:54:17 +0100
Message-Id: <20230914155422.426639-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Without this call, the QEMU process is being left running which on
FreeBSD 13.2 at least, makes meson think the test is still running,
and thus execution of "make check" continues forever.

This fixes the regression introduced in:

  commit a9c9bbee855877293683012942d3485d50f286af
  Author: Chris Laplante <chris@laplante.io>
  Date:   Tue Aug 22 17:31:02 2023 +0100

    qtest: microbit-test: add tests for nRF51 DETECT

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1882
Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230912184130.3056054-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/microbit-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 2abcad8e31..72190d38f7 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -434,6 +434,8 @@ static void test_nrf51_gpio_detect(void)
     g_assert_true(qtest_get_irq(qts, 0));
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 3, 0);
     g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
 }
 
 static void timer_task(QTestState *qts, hwaddr task)
-- 
2.39.2



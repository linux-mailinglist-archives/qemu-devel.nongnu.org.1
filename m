Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB427A2204
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARU-0003MY-Nx; Fri, 15 Sep 2023 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARG-0003C5-5h
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARD-000298-14
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-404c023ef5eso2658775e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790533; x=1695395333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q10Bjf5twhWJo+XU63cogYzeT8gsJVx5jFBjBqDS8Tg=;
 b=gJdn8rWIsk+flH72+FR1NVOK7DrEwHP2D6SwsCHV4W0M/RiNS1ZUqmt3UNo3zg3tkc
 ZfC7/hXXi+8L/ZCdw4T/6oox9Map0gwgaVK1cj9Wvfq04mLKw8jIX7tZkENtotfBsUM+
 l0dCU0YCdaYLMhPMweBJWuAjP1+6BgQQIe+AXSrJWdltrVfwf4FpYWJ2/MKQSYCeKZJb
 +F3s9qlv/dELmbE9Oibp2ZjaaCfbflghipsgL/aQWoFfw81pd0PGOqY5VhhNpniDmO1E
 BKYGiRM/F/vPxXSXFjrNrnSQxiuHARzsCymoya13QMRgfP07OEs3+3M2aIw4pud6hlqh
 ZJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790533; x=1695395333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q10Bjf5twhWJo+XU63cogYzeT8gsJVx5jFBjBqDS8Tg=;
 b=wwhYlo8SBNerhnstl8vh6P/Y8MLMUx5A1qOVA6wGfAvENvKFPvjzm789U6oqJh8jI/
 9uHrgybQdhu12CacaMIc2p9DvxCfdxOb/jVLjF19ehnEfeOrSQtJCMElx8pJkEZcPByp
 pGnJORG098brd6XX6PF20bZJhplYEMM3pxIV0h29aByhKaXl34NeDWgLME0Ci1cJGFKy
 B+2RN0rVW2suDA2WuhFHPyhOxIrmwUmmW0qpHQine8MwL5JWX24tScgZBnTshtt9ncGy
 nWjAwjETwnM3/HAUH2Hk056LbHEcO4yQrXzk8qhtl5+1OqFJKzVkN7MSEo771lw5OsSK
 L6Aw==
X-Gm-Message-State: AOJu0YyuUfjOcIr9amtQuzn2agz95P72772GYsDsd91HynjwZxt4tVEm
 0CZODWWYyYNqdrjFsXn9O46d3w==
X-Google-Smtp-Source: AGHT+IGbk91fvqVjNwaW0Ba7QdaIJjAWwpG7/uS5m0RT9yg3K4YsiPhqZJkFcbsnChLQLsez76daIg==
X-Received: by 2002:a5d:61cc:0:b0:317:5de3:86fb with SMTP id
 q12-20020a5d61cc000000b003175de386fbmr1589727wrv.10.1694790533208; 
 Fri, 15 Sep 2023 08:08:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 ba13-20020a0560001c0d00b0031ddf6cc89csm1940914wrb.98.2023.09.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6067C1FFBF;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:NRF51)
Subject: [PULL 4/9] microbit: add missing qtest_quit() call
Date: Fri, 15 Sep 2023 16:08:44 +0100
Message-Id: <20230915150849.595896-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20230914155422.426639-5-alex.bennee@linaro.org>

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



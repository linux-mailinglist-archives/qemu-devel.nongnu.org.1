Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC5B7085E8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgN2-0007em-GB; Thu, 18 May 2023 12:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMq-0007Yr-Oj
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMo-0006OB-0j
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so15098505e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426835; x=1687018835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUHrMn9cHBXK2gE6B1hvICEMAHPwsKhO8NPg/jbojk0=;
 b=s/xYoGYQLNBKdPs/URM7DgxnbxBSBHILWBSzglW2qySsRm1uhDh1Q2PPIV0dmz8yvw
 ErfVDbV6f7sdM7UPp6HX4BeXz490hJbAmEsXMVXjkswuYC10IDdB9NSO7P/SvHvDclP5
 vJ1cy39cBWWpfrCivpS7qt0jcySp8p7YukOmzRNBWH9lg7f9OA6CYGoJ3lEjUy0PjfFT
 73gmXoHyaVih0NVFM83Jl0E7U/mkjxEURqq+93xHzGpYsafxDk+8bDR/waGcNbXClevo
 9fgK7LKfnVS8rR4LGua/GzzsIx53W2OqqR3DDGIWIVSiGSDUQbS1fyrPrUhzwMJOVahl
 A/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426835; x=1687018835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUHrMn9cHBXK2gE6B1hvICEMAHPwsKhO8NPg/jbojk0=;
 b=ZOixQjZah9vz9d28BbbLTDNjQHgcNd+jQF4q59QHmRmyZRn/HsDq6z2Q3hGzAxeZO2
 8qRkYReW3oLd5J6Fine1mPrIhnItFeCiP4eir4bSuelIvwZnoDUi9hXrdXSQouqiY37F
 Uwo1dRIAm9cFI54H84b2xr8mXwD8Fc5IZxLUkI/n3xbQskKhItTQ6b53Rl6iNrc3wz8J
 dFrWj6gG8/Kjc2dpx5QlzPHw1WXUK0CSzVWn+ggJGpBwUuRrmVeOCCrFg11TgKeE3+T6
 D9cZ+leyQOBAZg2bngn3p3rTPY8CFoFfU9Pchg5vRK9qwHEFs2iY3Vo0Gphmobk0ynEG
 IbrQ==
X-Gm-Message-State: AC+VfDzpJs7JpL0uiFwdTvQlqVHnptTZGyV7JBAyHJ3MZlRrdzeX7C+k
 p3HP/mKuIRUAFxgtrVB+0wDkUg==
X-Google-Smtp-Source: ACHHUZ7T8IW+mrriobVTIhLRLxfJLDcKXLN8MGL0PfLg82NwLWtQqMKZt55iAUfAfgnHXCH6/u5nbw==
X-Received: by 2002:a05:6000:181:b0:306:2c16:8359 with SMTP id
 p1-20020a056000018100b003062c168359mr1979126wrx.39.1684426835417; 
 Thu, 18 May 2023 09:20:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l6-20020adffe86000000b0030785b864f1sm2584903wrr.65.2023.05.18.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74FBC1FFBD;
 Thu, 18 May 2023 17:20:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 2/8] gitlab: ensure coverage job also publishes meson log
Date: Thu, 18 May 2023 17:20:28 +0100
Message-Id: <20230518162034.1277885-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The coverage job wants to publish a coverage report on success, but the
tests might fail and in that case we need the meson logs for debugging.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230503145535.91325-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 0bb5cd56f9..b6390e3562 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -462,9 +462,12 @@ gcov:
   coverage: /^\s*lines:\s*\d+.\d+\%/
   artifacts:
     name: ${CI_JOB_NAME}-${CI_COMMIT_REF_NAME}-${CI_COMMIT_SHA}
-    when: on_success
+    when: always
     expire_in: 2 days
+    paths:
+      - build/meson-logs/testlog.txt
     reports:
+      junit: build/meson-logs/testlog.junit.xml
       coverage_report:
         coverage_format: cobertura
         path: build/coverage.xml
-- 
2.39.2



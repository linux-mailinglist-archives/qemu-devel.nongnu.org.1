Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B929745DC2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrC-0007cj-1i; Mon, 03 Jul 2023 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0007TF-T0
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqx-0005fY-Cf
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so41328885e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391869; x=1690983869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeRzCQ4EwzWGsNcRrOpl+FoUKZGHEnv7AIluzaFf2u8=;
 b=ja6l46h4I0BtyGmPnCZI0Pj04UYb1Nxlcc+ZF7EcYM5e3UVcyC9xjaVe4FTmIxSnEB
 PDBe3lNANAJB88Mi3pYSuAThDZRo0/dcqZlUM6zs1nOAX7X144jPL0B8jFK/wo7uHf9l
 VYZNaCCqyPT7vmm264vZqOf1nOQEEusYMqOW8T2Xrae0vfeZ6vsbII2Hoi33R1tQXKro
 0sJIOI8q3YIWErH/b6TDP0U3U9uFWlbXpymTJs7hM73+SPgTQaB5OjeuY2FGmZ79e+mm
 t15DOaNIli+w468l9l/5Z5kNwjimkgHPBQEAdWe+r+VIgzcj2vD8ASX3vPAGYZXtTcVh
 bP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391869; x=1690983869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeRzCQ4EwzWGsNcRrOpl+FoUKZGHEnv7AIluzaFf2u8=;
 b=GBv84tndcQYhM3Wof+EpAkprZkfMaI6cnEevbTxXBbEkJRHeRC/AHSgghwR8SBaJda
 nkfNux1cRzXQsNVsM8trcAmiEPFt9N2llBD8mTbwBvfWjGN2E41iHQp4xWDlMJesg6Kk
 5xTh1mnj55AZTWa7CqdNn+oSjzHYbg27dsn1O1EFg0nPcoEWqYyrmcRHH5q/SqnqmrJo
 qKi90wmC0yIWzYXrwztyOvLJ8NcXC06ibcCocCS0S6MkfM7DYS2SUrh5LmakqkeFk6aC
 cAFoVaIObKXRASnsCgmC/4dOLPK62FCYBRD0NcehINwkjdTSUL8cTyjulOXLSPH0Fg+t
 0+Rg==
X-Gm-Message-State: AC+VfDzkYw9UObo/5KhWwcKGANHG6FnDOwI9vN6P06qOLWzwY3LLNgLm
 o4LOctAz9a6E0beSoA7ywhQ6dfX0+jxjl1oDhaU=
X-Google-Smtp-Source: ACHHUZ7gxkPgQNR3XVBeWoJh6ro2f/6hsgABnKy4PO0qLgCuSbDzN/fbvrg0iuSs/M+vHAVBpyJxSg==
X-Received: by 2002:a7b:cb9a:0:b0:3fa:9590:a365 with SMTP id
 m26-20020a7bcb9a000000b003fa9590a365mr7488184wmi.17.1688391868917; 
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003fba2734f1esm18185573wmc.1.2023.07.03.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A24A1FFBD;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/38] gitlab: ensure coverage job also publishes meson log
Date: Mon,  3 Jul 2023 14:43:51 +0100
Message-Id: <20230703134427.1389440-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230503145535.91325-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 24bba061cd..a8fd9a0c1f 100644
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



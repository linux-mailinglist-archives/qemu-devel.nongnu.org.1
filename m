Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08007DACD8
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77i-0007PH-Fl; Sun, 29 Oct 2023 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77g-0007OZ-Qk
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77d-00054i-Gw
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32dbbf3c782so2783914f8f.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591035; x=1699195835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wT9HXqD5wVLOCdDU/D1HUAOIlUJzgFM70IP8pqAvtPQ=;
 b=Sbl00RA7b+nQJOH7bM4nO6FrZz2h1+wlhH4/ABczteg0JHu4xPPg4mqn7/7MBmgJv0
 lwzATeOiJWJgoYwPLfwIiSpKo9NNd+ejGl4yH8a+cjn0Tj2sI3m+Z1uT78j59XSIS1E9
 XHDEWU7/nxsrFet+Vp64AnYtraPWU5cwLpf8Su/wwrh87I4o14fO3exa3IxKwCcsIeib
 MhnipbJLjwhFqX+hDq/KeY2bRuSoFtjnTTN9G87PHsqCjDJJ7sYzkCg1/m2apiPWWIpC
 JaLsTETio4Lx8VKN18LVK47sJUo0InNykvUKp6hG9ZZKKNRXApdtPhKgZaK1+fAVs2mR
 VGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591035; x=1699195835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT9HXqD5wVLOCdDU/D1HUAOIlUJzgFM70IP8pqAvtPQ=;
 b=c6UeD9FmB9um936lk8WZsr+M17sf41lcTuoHllRrV6ByTbbJAPtnIPB3RtNX3LRUqX
 z3A8FMECs5bH3Rx3tdxfAcutK0JO09y7fmAu0WHQY0fmy22+klWrpTqs7qCGWUUCJYoG
 WzhPtn0ly01eX3Pzgu85AjFlDevBZCAUYa/n3ro4nIfw3PdJCaABkR024Cj7tySn++f/
 tgl8Q1/HCAIZyi6L0Mq6/LGi4rFm5GdNYrNWHTN5I0VkWmAPrUrshNwx2aRIchIVaHc4
 jFsN8sGI8wmDW/kaQL3+CR2U9Y+pjt4KChl42Bg0Cbj9L5OLwqQt2EEK8C94mEEGeG53
 uQWQ==
X-Gm-Message-State: AOJu0YywNteg2V2EnKaPjqKoykijbA61Q5h9pM6PJrqPEsYjx/tq0k65
 2CZl+zYFgRQd0UGAlS3mzrCurA==
X-Google-Smtp-Source: AGHT+IEKGCBZmHx/x5F8FAgfxFq/4xQ7dXlBBzQlritq5qVdI2XIzcJEuupIn8JyqATsAgjtkflXlw==
X-Received: by 2002:a05:6000:1864:b0:32f:7d8a:d751 with SMTP id
 d4-20020a056000186400b0032f7d8ad751mr4344192wri.18.1698591035260; 
 Sun, 29 Oct 2023 07:50:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0032da49e18fasm6185006wrn.23.2023.10.29.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6EA405F7A4;
 Sun, 29 Oct 2023 14:50:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 04/19] gitlab: clean-up build-soft-softmmu job
Date: Sun, 29 Oct 2023 14:50:18 +0000
Message-Id: <20231029145033.592566-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Having dropped alpha we also now drop xtensa as we don't have the
compiler in this image. It's not all doom and gloom though as a number
of other targets have gained softmmu TCG tests so we can add them. We
will take care of the other targets with their own containers in
future commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index bb24e052f6..5e9cbf9385 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -290,7 +290,9 @@ build-user-hexagon:
     CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
     MAKE_CHECK_ARGS: check-tcg
 
-# Only build the softmmu targets we have check-tcg tests for
+# Build the softmmu targets we have check-tcg tests and compilers in
+# our omnibus all-test-cross container. Those targets that haven't got
+# Debian cross compiler support need to use special containers.
 build-some-softmmu:
   extends: .native_build_job_template
   needs:
@@ -298,7 +300,9 @@ build-some-softmmu:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
-    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu
+    TARGETS: arm-softmmu aarch64-softmmu i386-softmmu riscv64-softmmu
+      s390x-softmmu x86_64-softmmu
+    MAKE_CHECK_ARGS: check-tcg
     MAKE_CHECK_ARGS: check-tcg
 
 # We build tricore in a very minimal tricore only container
-- 
2.39.2



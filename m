Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 967D1745DA8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrD-0007gu-B6; Mon, 03 Jul 2023 09:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr7-0007X8-6g
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0005hz-Vp
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so36801995e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391874; x=1690983874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E90hciyt1UffWPwONrp14kWIyQMFUouofO9E1/IMQIY=;
 b=nbAKNb/najijPAg6S4CwVHdw2yTxys9bBEMFq9hZ4B5p2kcotL4aMH7kdi+QzA4s/L
 /5tn7fcv1hkuNevkvGLOD2eb88Ffo4rvEf2YkqqOTGQ3yERxj2sf9CiSn/GVvtrUAKl4
 QvGJkqUONAapAS+gIq6Gom0yHclLbOv3GSwuOmC2KK/z+zykkP943fEjZL2q1JAciY7c
 7nufQVAYaqoJePNeo9+nlXxJX7izHDCSww638iU1ecYnap64VTWVqJwg5LH4RXCCBcxb
 yLGQsIUK7HHHf7zEr8tP7tr1jITB8n3d5rJsD78tXpDozkAUwnO57iPGuH4/hU9errTc
 oDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391874; x=1690983874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E90hciyt1UffWPwONrp14kWIyQMFUouofO9E1/IMQIY=;
 b=TynKdTjpNKk+JrCGEovAnLEtp9Jjb4JACqc0P+Xt7qn4zAK7QT4C7zBXyf1HdqB0M2
 9sZ4rkS/kUtLp8r+PLg1hYMi8/b5AnrsepF0Slpa8g2MEFxUHNjnFh/ysByNditMiRhk
 HzuAe/E4taL7+RB30IYcBqgEfw/PHIvC063Nvby/w7BPWgcrRQSnHNfg0azxq077LWHy
 i4W3z4rwHQNg53PqAda7qKP9xNK/59zZF/WUB/m7bd8r+9tQIa63gBvk8Pn8MT7vkL9J
 pX40P3y865mdd8fMpRc0R3Gf34z8twIhypM265VNA2kM/+kHurYRrM2cDhSKYHXPPLBY
 KHVA==
X-Gm-Message-State: AC+VfDxuldOw8Quq3mOn2DZQJp5qlUbRaNVIHs0r3+5oY82poWJHr/9G
 1Y9JI8rEaG3mlstrsZPmyWz3K+F5BOkfuSrJRuE=
X-Google-Smtp-Source: ACHHUZ4KMn1pRSUQY/yOATnKes0sYMA2WFdkOReRT0oUptOWGTGK6HTrucUkmeTNxz1pMyk/IWJPEg==
X-Received: by 2002:a5d:51c3:0:b0:30f:bb2f:705 with SMTP id
 n3-20020a5d51c3000000b0030fbb2f0705mr14114027wrv.22.1688391874139; 
 Mon, 03 Jul 2023 06:44:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a7bc3d8000000b003fba94c9e18sm17097011wmj.4.2023.07.03.06.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5CA51FFBC;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/38] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Date: Mon,  3 Jul 2023 14:43:59 +0100
Message-Id: <20230703134427.1389440-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

This is yet another make target you usually run in the top level of
the source directory.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-11-alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 804a5681e0..5d48dfac18 100644
--- a/Makefile
+++ b/Makefile
@@ -28,7 +28,7 @@ quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
 
 UNCHECKED_GOALS := TAGS gtags cscope ctags dist \
     help check-help print-% \
-    docker docker-% vm-help vm-test vm-build-%
+    docker docker-% lcitool-refresh vm-help vm-test vm-build-%
 
 all:
 .PHONY: all clean distclean recurse-all dist msi FORCE
-- 
2.39.2



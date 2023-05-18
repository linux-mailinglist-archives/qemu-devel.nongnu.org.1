Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DDB7085ED
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgN0-0007dt-Nm; Thu, 18 May 2023 12:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMq-0007Yu-Qa
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMo-0006OZ-MN
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f42d937d61so21650905e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426836; x=1687018836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WUqhetdgE59J23w7OMYoxJNBVAN+y7zryiCeyC7VBI=;
 b=Qau3oOcjErE/jFx+eo+rc5cuzF3WT7T8Df+bZQMtDy/Q3Q95S+POVsea/xwygBkx7+
 EfcrVXiS4ZYrNhkbSYVwjJGZChFmOEqmaACJGH/+2EJM2Qcgvehr4C2JTQ4/jCj4WpRZ
 j6Qfm293ITNKu+67scqBsbXLh2RJYcmpzYiXuEy7abCP6ip7ZepJ33ityp6mEjF+3pba
 xJ7ZymEkENc9R8yjonEF0aMHjJia1/NIPuhe12mg3GEXD29rzia9tgq5W9utrtBDVz1I
 c0gUYsNdPuuXAVXWB0AGT4wZWNIT/XZ6FbXh3gYdlNkDAKUhQxTFNX0fCCQvGoxcngb/
 6S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426836; x=1687018836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WUqhetdgE59J23w7OMYoxJNBVAN+y7zryiCeyC7VBI=;
 b=kEGCAYl2YOTHuAtumKCfEEnpQEceLeWttG9IcWyo3cLrCqgzl5H8sGsAoimRlLPUoN
 cpuuDXKZnG16RsUMq9Gyc9fxla3hTpoN3H7fyhK8LO9iAvN2OJNIHeAwo83r8JpWpJx3
 f8uHMrGWOcTUuuJ5vj58n+2DUZKitvsE3Y4TkqNtvr2zlQy13D18lnyN8+HKejkLRXO/
 T4XPJVig0N6YwvTt6vYjNmKhhAfOhMSEVQJ5hXjE04pD7eFBvjaiAQ7GBLPReUcItdUZ
 6eDRAw0goUXEvaxw48UvJuB3JTKkvLXmHLyhl90sRkCrT+EOUyvIjgyKAKjGBDVogo3G
 e9gg==
X-Gm-Message-State: AC+VfDygSKL1PGW8x6D5RljIuZKIHauH7Ra+pYSPvenzw0dfx/vOZHk9
 3pnaX0RtEVTB46LG7WnKnCbE1Ee+pepa8BHkdG0Nyg==
X-Google-Smtp-Source: ACHHUZ6osZgSqE8MF0AwbM/1x6NmhaAqX1XmmVm1Wr94PE5xf9DLLevWDPE89YQov5ahW+Fd8XcOMQ==
X-Received: by 2002:a7b:c012:0:b0:3f3:468d:d017 with SMTP id
 c18-20020a7bc012000000b003f3468dd017mr2055206wmb.6.1684426836713; 
 Thu, 18 May 2023 09:20:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a7bc404000000b003f4e3ed98ffsm2469032wmi.35.2023.05.18.09.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCCA31FFC0;
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
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 5/8] tests/tcg: add mechanism to handle plugin arguments
Date: Thu, 18 May 2023 17:20:31 +0100
Message-Id: <20230518162034.1277885-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
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

We recently missed a regression that should have been picked up by
check-tcg. This was because the libmem plugin is effectively a NOP if
the user doesn't specify the type to use.

Rather than changing the default behaviour add an additional expansion
so we can take this into account in future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/Makefile.target | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 72876cc84e..2462c26000 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -169,13 +169,17 @@ extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
 
 RUN_TESTS+=$(EXTRA_RUNS)
 
+# Some plugins need additional arguments above the default to fully
+# exercise things. We can define them on a per-test basis here.
+run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true$(COMMA)callback=true
+
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
 
 run-plugin-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
+		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
 else
@@ -189,7 +193,7 @@ run-plugin-%:
 	$(call run-test, $@, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
-	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
+	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
 endif
-- 
2.39.2



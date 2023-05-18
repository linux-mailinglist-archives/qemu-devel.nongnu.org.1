Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EA87084D7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfXY-0001Cc-Ii; Thu, 18 May 2023 11:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzfXW-0001CJ-IF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:27:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzfXU-0003wf-PK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:27:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f4ec041fc3so13863345e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684423655; x=1687015655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GFzwhGKzsH6ESQx03OZTxPi8kAZtQoM+LD4DVTxCe+Y=;
 b=oq4Q8e1yaXOULJ+slHkGVGQIlGjAuagiNGJIObVXw2n2EAzBo8gmnqKPTFFrDVXfJZ
 JmB/OWnU/B+47qgtJi8nFhHeH2AfsPibyBt2j522U4hVGe7rSzdu2S3Ke4FHmZHxQzv3
 hWvFlEMmsS4kUr/iiX+nfZsbIycrIXMy4K+zlX95phbQuPtJVO2uMKQTFH6J0Cqe4ZI5
 Hzuh4OrAoyYpYq/AtRjXjgWX26xC88ElOwbzLayDUlf0bIg/WVr3rHjViccxLduR1jgT
 tYCiQilp7v50MF6NpoujB0VRYjykQUO5xrDRWIWulcGo7Gwqv6Bjdtdmzxl/9/bfFUK8
 oAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684423655; x=1687015655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFzwhGKzsH6ESQx03OZTxPi8kAZtQoM+LD4DVTxCe+Y=;
 b=VX3ZYz8nqI1Yw7s50+/shQ52e8AHJYMtjKAJohpagXRe+yQLadMDCuNXgkjA+MYTRA
 cf/r1VMU/wNwu5icuhouijW/ppr818vFmvw/ZcPfoGVCyoMlMsMKJqNyBHY38W2u2ReV
 wrHYEfqZjFl2CsW4LMYxQCu2EoqZbAmdEYyaUCn8L6I6bRKKw9Yc5AOKonjgKRUT6wXa
 Q2madnc0omcou7suXzGttdeF05AIal+lmdW8q9A0IGJw5tCi7E2KKsHpHoBdlDWw049g
 3sUy5kfXMVj5rr9RWtrl5bAFOP+UuOYfL+Nasaqsa+/NGuGTv/deJczLcs4br412cEKt
 me4g==
X-Gm-Message-State: AC+VfDymHWTBCPN2gB7vEmn0hVeLMBRe+po4q+ZCoyWltYF92L86KKt8
 M139sEuJN05xLl2UuGKmmRLrUw==
X-Google-Smtp-Source: ACHHUZ49POjeg6l5YhgAHvp8ZPTNz42+WziNZxoP6uw45Fv4WfJWdnVPDf7PQvyVDpKIRp8PyRkoQQ==
X-Received: by 2002:a1c:7c08:0:b0:3f4:2cc3:2623 with SMTP id
 x8-20020a1c7c08000000b003f42cc32623mr1759348wmc.22.1684423654666; 
 Thu, 18 May 2023 08:27:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d6ac8000000b003079ed1f0a0sm2478763wrw.44.2023.05.18.08.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:27:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7CEC61FFBB;
 Thu, 18 May 2023 16:27:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] tests/tcg: add mechanism to handle plugin arguments
Date: Thu, 18 May 2023 16:27:29 +0100
Message-Id: <20230518152729.1247541-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
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



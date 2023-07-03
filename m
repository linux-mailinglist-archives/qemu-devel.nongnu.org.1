Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10055745DCB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrK-0007op-Nd; Mon, 03 Jul 2023 09:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0007TI-Rz
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqy-0005fs-FP
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc587febfso36426075e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391870; x=1690983870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rotzDBtOd6/iqr5ugUGgrWbU+6kRG33xvmLRtv1TB5Y=;
 b=vnskl0aU8h7iL6Oiy4Zz/JK0brbW7saE/DoTj48FhYRW5vRKFltFoFv/a42nqEwzzx
 prYTXxShK1//JuAYXBUsDRXLUI/HUe1wIHtK9LoRoWvBOcClSC6zAPixodRQ4NGvijUx
 44RR7ShP5cAmm5BcCoOhuxrcw8CD0l+c6+oALiWZ0ZRYU7nrDQmgMGtC7TpmmUSvXmlP
 TAoxXL81AvoAwskq9ZWGam7l5kkHYkZRqNrj2bBkQc8hhOlftdwJsJEhQ9WWvVujy305
 wFXa5MQyeRM3hyQqwwBMiRIfANto8ECODqMSyxn0Qf5hHX+B9nWfjKSHdvSqd1K6ogVI
 xulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391870; x=1690983870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rotzDBtOd6/iqr5ugUGgrWbU+6kRG33xvmLRtv1TB5Y=;
 b=iBPl+7akeYSXlTrnKMFUZNWRFFXMwTeXl9+dl9ce3tdbJKrEg/cgJeEYME+FmrhR9j
 5TBIbTHVlDeOSsthcCH0dttvjkipI+6zTPvn/UHDMFC24V/1gvuLWJl4CN6DuaaqkPiy
 ZkJPVAoNryGOTOWe0IXMjC/MWs63FU4kpC0Di3Ed2HK7V61TbQ3VjCee9CcqXubZ+jN3
 ZOBofb6KPR1k/ekypIUrwsUGNecjyqzTj1IjbeL+vz2eSByrmh9Ll2TFCTeSLiFoGBYN
 5+bFR2GVpPqbIMw3aTcJ8pGjLEJx+K8Ci2PGiw2YipPv7s+3ZHiThvVwCcbS6Uyx72qT
 fa2A==
X-Gm-Message-State: AC+VfDyd28lSl/Xxf5Hr1M9g/4/GVSQ4m3VnksRMTWWTT0xamGRQmkx2
 g/U6rZrMtfDutM0QdiUpWiatXo5n+mKrfHnX8LM=
X-Google-Smtp-Source: ACHHUZ6hfZ4okCTkSqbkim9gFgc2T4XUsyX84nTYgbi7jvalbFCu6zVhtXO3QKlpWjGTGqnvcM74aw==
X-Received: by 2002:a1c:7c05:0:b0:3f8:f6fe:26bf with SMTP id
 x5-20020a1c7c05000000b003f8f6fe26bfmr7669929wmc.12.1688391870424; 
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f9b24cf881sm29850195wma.16.2023.07.03.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 607251FFC0;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/38] tests/tcg: add mechanism to handle plugin arguments
Date: Mon,  3 Jul 2023 14:43:54 +0100
Message-Id: <20230703134427.1389440-6-alex.bennee@linaro.org>
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

We recently missed a regression that should have been picked up by
check-tcg. This was because the libmem plugin is effectively a NOP if
the user doesn't specify the type to use.

Rather than changing the default behaviour add an additional expansion
so we can take this into account in future.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-6-alex.bennee@linaro.org>

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



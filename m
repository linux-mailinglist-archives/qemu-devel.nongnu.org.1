Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE57441C9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIU3-0008LX-Gd; Fri, 30 Jun 2023 14:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITv-0008Hh-ND
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITs-0006yb-AD
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so13910035e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148267; x=1690740267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9YIwoz2syzBIvgIfb1KrTiedkOwekCcwMFZMGMcvn4=;
 b=lqbvm6pqNewUj6RaKfZVi7dE9g8W3q0ZBjF95DMcrcjTNDFusfskvIHAZLOvVzetEw
 dKryrBXBWXPB5kHTZeo/D8UtNTR/yhRFHw20GiEapa3TeDKxxSWfPkWphjuVsU2EBuX+
 LwTOBmhYa3FRqRbsuECPn3H5VxN1DeCLEhTt1NlrkiUFW6x4kJB04DX9NEwA4FknAovm
 uhsSUF4gBoYM/sh7DpPQltOBDnoVWZopWMJyYEqw5fZJl1r0Go9z9wmOsdWsaauUbDI5
 LXJ2xJqQDtgBuAKAzVPWabmUsuGKBnsRF7sHa/dmhZuM8Nabvem72ZAQToQWOmecIjJ5
 vARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148267; x=1690740267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9YIwoz2syzBIvgIfb1KrTiedkOwekCcwMFZMGMcvn4=;
 b=XoGufJtdV6WS0+pehRuZW0fJkUnD5hE7aNFS1sjYAfTAk3Qalu8QiYVgIfwJ6g9lHZ
 uuRsruOHfN+dgEGt1RFKY+11+F5KiqEuQA82Vxz3DnBt84v6AzI4FYhpNrPhwAM6pa/V
 k5orxHotPOyElHrCda7zOY5I8J9vs9ZQUj6Jkncu6TFtTDu8JaMbeKoWIMVSXYZX9Oin
 MdcNx221OGXPdtzgrgylsispU/ad2MBOs+0HZ6dvXmpuShLp8sq13MIMGSKsYgravjRm
 jzNRI/7QDCCO7oUlxJCUUbaXIZ62x0QB5Pg7QwIZEuR7t9LvYJBx3z+vTGcJ830k+MRV
 Awww==
X-Gm-Message-State: AC+VfDynxmX7Ios09OXR4R7P7qDzg+u4cc6NnDGCpO8rmzIFkGbimK4X
 XXEVK0eRg3FAnQe+dEhoN3g9Ow==
X-Google-Smtp-Source: ACHHUZ4Hv6dE9IXzFdfHJkLDDU4npJFG5lmGseD7i4Jt2EG/TO8hSDpd6Jis7rkNt2ge0mDLg6Qh1Q==
X-Received: by 2002:a05:600c:218f:b0:3fb:5dad:1392 with SMTP id
 e15-20020a05600c218f00b003fb5dad1392mr2327208wme.17.1688148266903; 
 Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0ac100b003fba6a0c881sm10400961wmr.43.2023.06.30.11.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 748461FFC0;
 Fri, 30 Jun 2023 19:04:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 05/38] tests/tcg: add mechanism to handle plugin arguments
Date: Fri, 30 Jun 2023 19:03:50 +0100
Message-Id: <20230630180423.558337-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
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

Message-Id: <20230623122100.1640995-6-alex.bennee@linaro.org>
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



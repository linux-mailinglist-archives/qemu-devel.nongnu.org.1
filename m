Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD7F73B723
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoV-0006an-1C; Fri, 23 Jun 2023 08:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003kZ-Q1
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmi-0003gr-Ma
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso620325f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522863; x=1690114863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WUqhetdgE59J23w7OMYoxJNBVAN+y7zryiCeyC7VBI=;
 b=D73HOrWIhu2fC33oVmavdY6FdQfU+/K8O3x/sgrLpX75NeP8frQHts37plDdIVkd2r
 g2clhRovLNOt+yEWxGzMRc3O1sPT500lBJkcDbJmQ1RZkHgEC9GFYvdzhD3oKuo/efiT
 jZpDc87AlSwVEofLyIi40DYx1ZcJJKmNRX/ZFGWhb3iJ9kOPvckhl7E4+c7dxK2pp8Uz
 UexrErdhQvBOJm479WjTZOm1by+n+SQqnak5E0aDOnO0F8sqC61Z2aCSOmweBp/pWMQC
 phR91XCZODHtrImQ47Va3OdBiLPgQK51+N1PhC3lwSMQEA//nqkZahNSzq1RMCzXFPB8
 YzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522863; x=1690114863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WUqhetdgE59J23w7OMYoxJNBVAN+y7zryiCeyC7VBI=;
 b=bUnj1Dwba6QTL2CbCnxcn5xv74dzcwMHflsiXGhwN5Vc1lv2cOcevU1QxzW6sNObqb
 5ws5ldkdAxL5O1Smk7u5WuQWAPZEj2Z3kHzcB3ttrqW5EBALmzbnAptqVbfruj08G5ci
 CwZEhITzySGefF1XKmbfKhiGUKysBsS2VpYufnDBSAUJ14fxQXJsiwG0YRMyDUDcW7I6
 NyOx+ubcf1Ndjg3hoWFdzdYLo3Rj4ki5GIxZpgPl/XB9wNcGDPxRLL7pjOz7Dr+uRBdE
 DObHceECskBijgv/T/UwlpwLS5Spls2ROcKCrNMVd8NUA7EcswBAK2t42hBcOqEVEWln
 ORKQ==
X-Gm-Message-State: AC+VfDxMnWV4CYZy1WFitIU3oFrQrbcpI5kfSV+uG4W+9nkgRoMFTh1h
 5+DntTnkZrYYu2DjMvULsj4VSw==
X-Google-Smtp-Source: ACHHUZ78wHOFRDgFd8pur0oNNt9l2nIYhQ3p8/6zemG411mN/dWtSXsk60knAJha9XDMF8r9jgF4VQ==
X-Received: by 2002:adf:f244:0:b0:309:4999:7549 with SMTP id
 b4-20020adff244000000b0030949997549mr16063793wrp.46.1687522863349; 
 Fri, 23 Jun 2023 05:21:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y16-20020adfd090000000b003110dc7f408sm9389685wrh.41.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A50E1FFC0;
 Fri, 23 Jun 2023 13:21:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 05/26] tests/tcg: add mechanism to handle plugin arguments
Date: Fri, 23 Jun 2023 13:20:39 +0100
Message-Id: <20230623122100.1640995-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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



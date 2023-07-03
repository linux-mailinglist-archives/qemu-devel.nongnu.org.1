Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9A745DBA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrM-0007uA-OW; Mon, 03 Jul 2023 09:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr7-0007YA-JC
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0005hX-Vz
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so40243765e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391873; x=1690983873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbXOS2UafnQ3pS56dbbQl+HPmW3sM7cKkRCi6U8OV2M=;
 b=adr95iLMKKSXYwgVKi3Tu1zYHHlTiX2HfTGOdZlyPiqKiI+xbjMt2J55ND3JVMrY9c
 f/6/2YljddLM3guqoRamKcMBu22JCxC02UKpc3PfNoxEttRM1C28M/wcYbZtAN3xkA3A
 sy3l37WrG9qoCoS7t7af6PZLhisSnVzgQ8tWmwveVqwSCYWFfZroEZBZzG7V2sw3PGwB
 J4Xt10JVjp8yiAJrfFH8F2b0qPhwLD5gGXfZQvKj9k9tfhu4QQqbYhi/+aHq+7FkOnEY
 7bTD0mTnSwCm3JoZIOCZik5N8Xutl0PE9r9iE+rpWJ4e+AduUcFDzcv54i8vyuKxYGuz
 Cslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391873; x=1690983873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbXOS2UafnQ3pS56dbbQl+HPmW3sM7cKkRCi6U8OV2M=;
 b=mCYG0fsx67NPmzEPXtHOilyeyB8kC+7Zju8yS1BOhrMqflPWtk3HZeyccP1D2il7XJ
 qhyEEhBq0ci5cB76flbkK8wUJbIILwkHY43IoLsitgeYI3iHyNdFonXTVfpaO5WNPmos
 AfcVo2XjSm4T88UcJCXvEf+QOhy8eGIBMQXnEqN8ud4jRB3l6GzBqvQeU4oH4tRa1tfH
 aviytzHsDOSJMJbt8+6w65gSutU1K95otqiP2QPTuZDabj4YPdIwBtlM4hALIQ95Xt8X
 y9uS5D2avkpqFSscrR1psgZdrvCfXJ7DeFYWcPSxRDusfcxplb6EhxIy/Xwr5ptZIasZ
 kVTw==
X-Gm-Message-State: ABy/qLYvD9hw65tqwy98+g71AKuKHdCfGtYOeylXWGLupNqKDOY/iZwh
 7Pw4ATjrRnJmqtb3o6cmykkBgg==
X-Google-Smtp-Source: APBJJlFL61SyA6lixMr08cLZ4x7P0x9BtM6zI8bjNFiuR9qCyyaRkJ5n66yquZ+lvCuAWR8UZ/rEOA==
X-Received: by 2002:a5d:66c2:0:b0:313:ef08:c83b with SMTP id
 k2-20020a5d66c2000000b00313ef08c83bmr9300524wrw.56.1688391873007; 
 Mon, 03 Jul 2023 06:44:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a5d460e000000b0031433760a92sm4044732wrq.115.2023.07.03.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F2B6C1FFC4;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 11/38] tests/lcitool: update to latest version
Date: Mon,  3 Jul 2023 14:44:00 +0100
Message-Id: <20230703134427.1389440-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
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

We need this for the riscv64 and gcc-native mappings. As the older
alpine release has been dropped from the mappings we also need to bump
the version of alpine we use.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-12-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 0097637dca..43370f7b36 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-316 qemu
+#  $ lcitool dockerfile --layers all alpine-318 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.16
+FROM docker.io/library/alpine:3.18
 
 RUN apk update && \
     apk upgrade && \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index c8971e90ac..b0f44f929a 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9
+Subproject commit b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index f1570b54df..5d36a62b10 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -115,7 +115,7 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-316")
+    generate_dockerfile("alpine", "alpine-318")
     generate_dockerfile("centos8", "centos-stream-8")
     generate_dockerfile("debian-amd64", "debian-11",
                         trailer="".join(debian11_extras))
-- 
2.39.2



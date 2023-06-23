Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4E73B709
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfnk-00046m-HO; Fri, 23 Jun 2023 08:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfms-0003m1-RG
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003hB-Am
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so7364545e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522864; x=1690114864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IO8FBVf+cxDpmWwXUlU1UGAlcwL+PYrJLsP60QqSPVQ=;
 b=WIXk0hjU9d/HOhhwzcatybuWLPn6Vdye655bSjnK0J7RA/oGvMwn7pJmY0RTxzSMVk
 jsemR+3oVSe5f3/EslT/ARZlSbpT6G+E9Sx8fivR/3ayzIwMKSW79IRWZ8Az6uc/NTjK
 BoeDRg3zgm+c+pYcIe5viiAq4pnh5AEZ3UbrpdfR/RcZG9au6RRRkBqXGnUk9u/AB2aS
 r1ZEz6SkBJnj792q0UvrWot+wU+DqGs4og3n949Zf0SLY5X5g3ZYNBICRTS7rUGPk9QC
 vw6Pqqn4j3Kv39gr0ZY5/culLHMC/bnpZMRtrWaRscahc3sr5EqhfnGl/IKUTjVfKxbU
 lCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522864; x=1690114864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IO8FBVf+cxDpmWwXUlU1UGAlcwL+PYrJLsP60QqSPVQ=;
 b=ZXU1i7XPeBoe45ICT5sLrZEqWcSvhX8r1voSzKKY2GmpNuki5z+YLYryi9kOiDaZxb
 XSnNNs4A21jPvs/gL3vbocYBBMkT8mjD2Z18gCkwTvRu1OSrw8ZEZpdztGs1M2oViq+H
 Kto+/+ux7ZsoI/TcRn8cOrTUkMhAzsNHwGYOBCdbpzhuiBDGTxezkdhAQptk4WrQYIPR
 4AGqRhGYtbxy95c798cIaENxhqlty5Rkee175gg8DDKH9o+qUWsGue5FdXbyjaoWWGBl
 2KXmmHHE7D99gA/4qrRfKmza6rzc4NKUghA0qaYfI4wKSqHjvF/kfZfMRY6Jkag2pvsD
 f65A==
X-Gm-Message-State: AC+VfDw4Q9s0k6wReGce9jpAzgqMg3vQRp7THdZQn0pl4m04dRxkqrh0
 hXEUVaBorkBpP9f49zij7tNoRQ==
X-Google-Smtp-Source: ACHHUZ4cW9zbCUktJYnZALr6fnpgZu4vAdJu9wdM1hdMpPkOxay7jBgWknRyTGl/HdZaZRODev045w==
X-Received: by 2002:a7b:c391:0:b0:3f9:b3f5:b8f with SMTP id
 s17-20020a7bc391000000b003f9b3f50b8fmr9975932wmj.34.1687522864118; 
 Fri, 23 Jun 2023 05:21:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d6850000000b003047ae72b14sm9483364wrw.82.2023.06.23.05.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC4801FFC5;
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
Subject: [PATCH 12/26] tests/lcitool: update to latest version
Date: Fri, 23 Jun 2023 13:20:46 +0100
Message-Id: <20230623122100.1640995-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/alpine.docker | 4 ++--
 tests/lcitool/libvirt-ci               | 2 +-
 tests/lcitool/refresh                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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



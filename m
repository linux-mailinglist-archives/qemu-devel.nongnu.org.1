Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E05740078
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGQ-0008Op-AL; Tue, 27 Jun 2023 12:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGM-0008A1-66
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGH-0005nK-7m
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:53 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so3641326e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882187; x=1690474187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DudiICXjsv3m9urKUi2tH2RtAEiqXNFzr67H4vIREuA=;
 b=WyyjRv+3t88vSdGYUsjDeCty4FtdbMzwro9rPT+TXqjh+/CoajKMQDpzPuk7vGaraD
 k6OfoOJXwKwphz1VUc8oogthA4Q64L+19b/0bGTCRMsSHlIZcqTEb0jNr9fJxY85qxi+
 HTQRFmBM2pHK13RQpsvDJy0f8EDZOe4sAwd8yqMU9Ap+JhKYsXEHZKWGMvSIx8x5xatx
 hG0w1ArW2whI74CwkDkFt6a2z+oX+uAuaz5XA+1Khk2yHozbnY2AC4LvwdzcQgKsq0lr
 XRb9oclZppRMCQU2mXwQ56ZQs133wfAM3XmHn+LIX2xaw9IITP0Me67p146X3w41rphS
 5Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882187; x=1690474187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DudiICXjsv3m9urKUi2tH2RtAEiqXNFzr67H4vIREuA=;
 b=iV7MNgSmmY/kaFLucczb7Uiz/0E2XPn025aH5McY/rjiO8Fqfb0WYoCE1/z/grO66z
 fRi/WrHY8jAHKtDF+KaJJUHNr7ZBq+EmvSfmFQu0FK/DcL5uomdEoVzNCXG9qENLIc4U
 N8cLR0JBITIX+xgGwfzmIGpWI2dUQf9olfUqnMPI4AobfFazxmT3AWuqF94XZmJKwrfz
 iTMSxGH0swVYo8Istrhh9V9PUIFnU1G0fsVcBgwVD+5eRw8kCw2Nzrtfu9jk6GzEY2pf
 mthEuFLecosnl+obay/yD/J5m1kBTCWHPrG4l3md9Z4n382DAdJwaIzxFrsVJBOGjFzh
 SOjw==
X-Gm-Message-State: AC+VfDzojh/mTJ771niOvJqOqCJhCysaBpnFscslGSb41VIBsXSW4gJ1
 h+ILc3YJ0hbajj05L6vb5aHQaQ==
X-Google-Smtp-Source: ACHHUZ5wELTkw/hzWvdKpDNEpRRQHCm0UZVRrU+RUicOaQ5Fvo7km2BAv5Ps9nvsF70rjKki+EPDgQ==
X-Received: by 2002:a05:6512:3e2a:b0:4fb:889c:c53d with SMTP id
 i42-20020a0565123e2a00b004fb889cc53dmr1624376lfv.10.1687882187113; 
 Tue, 27 Jun 2023 09:09:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 hn10-20020a05600ca38a00b003fba586100fsm2240688wmb.6.2023.06.27.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C0D31FFC6;
 Tue, 27 Jun 2023 17:09:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: [PATCH v3 12/36] tests/lcitool: Bump fedora container versions
Date: Tue, 27 Jun 2023 17:09:19 +0100
Message-Id: <20230627160943.2956928-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

From: Erik Skultety <eskultet@redhat.com>

Fedora 37 -> 38

Signed-off-by: Erik Skultety <eskultet@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230623122100.1640995-14-alex.bennee@linaro.org>
Message-Id: <c9b00e573a7a80fc6ce5c68595382f5c916a9195.1685528076.git.eskultet@redhat.com>
[AJB: Dropped alpine (in prev commit), reflow commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora-win32-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora.docker             | 4 ++--
 tests/lcitool/refresh                              | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index dc72ae9cc9..a0a3cd9e5b 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw32 fedora-37 qemu
+#  $ lcitool dockerfile --layers all --cross mingw32 fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:37
+FROM registry.fedoraproject.org/fedora:38
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 7eb4a5dba2..b6c1a6a339 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw64 fedora-37 qemu
+#  $ lcitool dockerfile --layers all --cross mingw64 fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:37
+FROM registry.fedoraproject.org/fedora:38
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 3a69eefdda..8a35a17617 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-37 qemu
+#  $ lcitool dockerfile --layers all fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:37
+FROM registry.fedoraproject.org/fedora:38
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 5d36a62b10..5e06fb2cf5 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -119,7 +119,7 @@ try:
     generate_dockerfile("centos8", "centos-stream-8")
     generate_dockerfile("debian-amd64", "debian-11",
                         trailer="".join(debian11_extras))
-    generate_dockerfile("fedora", "fedora-37")
+    generate_dockerfile("fedora", "fedora-38")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2004", "ubuntu-2004")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
@@ -169,12 +169,12 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win32-cross", "fedora-37",
+    generate_dockerfile("fedora-win32-cross", "fedora-38",
                         cross="mingw32",
                         trailer=cross_build("i686-w64-mingw32-",
                                             "i386-softmmu"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-37",
+    generate_dockerfile("fedora-win64-cross", "fedora-38",
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
                                             "x86_64-softmmu"))
-- 
2.39.2



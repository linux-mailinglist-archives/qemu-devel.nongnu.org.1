Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A273B70A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfo7-00053k-8A; Fri, 23 Jun 2023 08:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmu-0003o4-Mb
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:18 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003j5-9t
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:13 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f8775126d3so661170e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522868; x=1690114868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l1lsbfw4bSxGd90NtaE4vKULowZxXwBNTWJjDPGTPM=;
 b=ekLeF5oGLpKM2Cz3D9AFjWzNEhFXiU+9ZJUSBMvZf2PMexzazQPM7gwWOSMGYuPDUU
 LHIoFKNtHOcQhmVGCnlRihRyxDEwTasBbqYJoHOJ6fvyMKkJl3u0qC1fdtQ+0/1CieVR
 T6b+JZOmmM3cP5nPATZ+eXwO77aANn9ZEXzdxbt0qzGH/femc0djX1WwAV79rMxppw79
 /PAq/nKBEl8P5kviRHpWv6wHMjWK4EvolGC9Mq8HgIob1RLv54fzkfoFNdzAX3B3rhei
 N7eCp02MDwK4hmxGooZn+KRCLzpH4glC/pkWia3sCuA4+MV0veqhpqNQuZafMCmugbuO
 MeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522868; x=1690114868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1l1lsbfw4bSxGd90NtaE4vKULowZxXwBNTWJjDPGTPM=;
 b=bEP3GpY4W0w105F+EDofn5bZQk+D2b/WJISn2h7IA1ZeJEamsKCcPAV7Ycc+M3FnF5
 ft4/wpLItugvgeXkc4FouYQS7xYELo3b/6JlQ5quKSCNgoE+zj62fSUW3k9STN91sECe
 K6A4Vi6iryfizuTGY/02Z3TgxNhJjj4Sr08uLShQjiXOpjlI7XUHCVOYEtoUAJRG5Mz9
 eyQDc6a/9JCYnJ6wiuj56BTXjBVqTW8gQn/ibIGws0eh/Mv5wNM5LPclg0GprVMNHZ1W
 d7WbNGLZzVqKSdx2QWrZOhDCSRuydJXEpyCieEJUxe5RJYpW5HKIVpNWZA8FfsFir+5j
 JlyA==
X-Gm-Message-State: AC+VfDxEfYyb6qyt5iMcUU5qBPr2KgrgzCISVXidpyTG6dLJrsj3cjgz
 CCyoBjHRSPvfz0odKsijv/5oiw==
X-Google-Smtp-Source: ACHHUZ7OyHZHif2QH18Hzb4GdKOJQSOSeCj2YuJNw0UCThi2ZZmqDL4g4QwBPPvVVmqYuUZIOoZnFg==
X-Received: by 2002:a19:710f:0:b0:4f7:3ee8:eede with SMTP id
 m15-20020a19710f000000b004f73ee8eedemr14211775lfc.61.1687522867875; 
 Fri, 23 Jun 2023 05:21:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c221400b003f8f8fc3c32sm2187755wml.31.2023.06.23.05.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2EC0B1FFBE;
 Fri, 23 Jun 2023 13:21:02 +0100 (BST)
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
Subject: [PATCH 14/26] tests/lcitool: add an explicit gcc-native package
Date: Fri, 23 Jun 2023 13:20:48 +0100
Message-Id: <20230623122100.1640995-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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

We need a native compiler to build the hexagon codegen tools. In our
current images we already have a gcc as a side effect of a broken
dependency between gcovr and lcov but this will be fixed when we move
to bookworm. See
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987818 for details.

Update the packages while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora-win32-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 11 files changed, 11 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 40a2b6acc4..016c2321f1 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index c99300bbfa..3c114efa11 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 5db5c78b31..dfbd47db89 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index ae6600b25f..4e0084e896 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index daa2d48e36..88adf333e9 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 5af04e2054..256e8b5dfe 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 1eeba7fcab..4d19cd2bd7 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 52e89a6dab..642bbde3d1 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       exuberant-ctags \
                       findutils \
                       flex \
+                      gcc \
                       gcovr \
                       gettext \
                       git \
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index a0a3cd9e5b..e3dfd68bed 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -29,6 +29,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                diffutils \
                findutils \
                flex \
+               gcc \
                gcovr \
                git \
                glib2-devel \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index b6c1a6a339..0e15c9643a 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -29,6 +29,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                diffutils \
                findutils \
                flex \
+               gcc \
                gcovr \
                git \
                glib2-devel \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 566db8313b..21fd3d2cf9 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -24,6 +24,7 @@ packages:
  - fuse3
  - g++
  - gcc
+ - gcc-native
  - gcovr
  - gettext
  - glib2
-- 
2.39.2



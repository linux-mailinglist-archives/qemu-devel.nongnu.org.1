Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D36AB704B5B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:01:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQ6-0002Na-9u; Tue, 16 May 2023 07:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPH-0001bg-Ja
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP7-00087A-6G
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gagIyj+ohvBxTGckPPYIFm5V3ZHBPriTT/5noq/lqAw=;
 b=cyVmgYaZnjScvNPwjWATdEypSkGhXIGOHOF9Bs9Yqe+0HQCxQzGvwPzWsV7AeY/WED9N9u
 4ke9m3AbGmwDfys5hdHJuuPNnKrl4ApgYt5Edgpa6KSBVdoPGIPUN/8xgUTvjG7fAL4YAe
 qxGJn+nQq9jZde+XU5JYDMUXU6Ej8bs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-mLorABw4N3WE1EOFZcjqJQ-1; Tue, 16 May 2023 06:59:24 -0400
X-MC-Unique: mLorABw4N3WE1EOFZcjqJQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 718188037A8;
 Tue, 16 May 2023 10:59:24 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 919BB492B01;
 Tue, 16 May 2023 10:59:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 12/27] tests/docker: add python3-venv dependency
Date: Tue, 16 May 2023 12:58:53 +0200
Message-Id: <20230516105908.527838-12-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: John Snow <jsnow@redhat.com>

Several debian-based tests need the python3-venv dependency as a
consequence of Debian debundling the "ensurepip" module normally
included with Python.

As mkvenv.py stands as of this commit, Debian requires EITHER:

(A) setuptools and pip, or
(B) ensurepip

mkvenv is a few seconds faster if you have setuptools and pip, so
developers should prefer the first requirement. For the purposes of CI,
the time-save is a wash; it's only a matter of who is responsible for
installing pip and when; the timing is about the same.

Arbitrarily, I chose adding ensurepip to the test configuration because
it is normally part of the Python stdlib, and always having it allows us
a more consistent cross-platform environment.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230511035435.734312-12-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-hexagon-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-tricore-cross.docker  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 981e9bdc7b0e..f9f401544a05 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -57,7 +57,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         gcc-sh4-linux-gnu \
         libc6-dev-sh4-cross \
         gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross
+        libc6-dev-sparc64-cross \
+        python3-venv
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index b99d99f94365..c2cfb6a5d0fa 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -20,7 +20,8 @@ RUN apt-get update && \
         bison \
         flex \
         git \
-        ninja-build && \
+        ninja-build \
+        python3-venv && \
 # Install QEMU build deps for use in CI
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt build-dep -yy --arch-only qemu
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 803afb957345..081404e01410 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -28,7 +28,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata apt install -yy \
     libglib2.0-dev \
     ninja-build \
     pkg-config \
-    python3
+    python3 \
+    python3-venv
 
 # Add ports and riscv64 architecture
 RUN echo "deb http://ftp.ports.debian.org/debian-ports/ sid main" >> /etc/apt/sources.list
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index cfd2faf9a803..269bfa8d4230 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -33,7 +33,8 @@ RUN apt update && \
        pkgconf \
        python3-pip \
        python3-setuptools \
-       python3-wheel
+       python3-wheel \
+       python3-venv
 
 RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/tricore-toolchain-9.40/tricore-toolchain-9.4.0.tar.gz \
     | tar -xzC /usr/local/
-- 
2.40.1




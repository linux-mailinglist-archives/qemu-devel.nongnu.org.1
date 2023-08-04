Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E6476FF3D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 13:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRsi3-0005QG-4o; Fri, 04 Aug 2023 07:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRsi0-0005Pd-TZ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 07:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRshy-00089J-Gv
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691147461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0D2HbqXKb3z+5woKGOEZXNqs0NHqMwUXIv9h/c8xDw=;
 b=dqvNxWlaTP5WjLSpfHmdErz/gc11W5gff5XoYIKmYRNqw1RBNsS0I9my204iXsIAnP39+v
 GFwH3mlZPz7nUYwtFdySHgDpKoFijKNnXrwmGqH9saKczZm06i3Fje2RFYUPCq8r1CjTE7
 W1GroMRG7myrGOaQvTWFgZYdIhN3GKg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-LEiMNGBQPVmeXSIJaiTCrg-1; Fri, 04 Aug 2023 07:10:58 -0400
X-MC-Unique: LEiMNGBQPVmeXSIJaiTCrg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A34380392B;
 Fri,  4 Aug 2023 11:10:58 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7A4E492CA6;
 Fri,  4 Aug 2023 11:10:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/1] gitlab: enable ccache for many build jobs
Date: Fri,  4 Aug 2023 12:10:54 +0100
Message-ID: <20230804111054.281802-2-berrange@redhat.com>
In-Reply-To: <20230804111054.281802-1-berrange@redhat.com>
References: <20230804111054.281802-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The `ccache` tool can be very effective at reducing compilation times
when re-running pipelines with only minor changes each time. For example
a fresh 'build-system-fedora' job will typically take 20 minutes on the
gitlab.com shared runners. With ccache this is reduced to as little as
6 minutes.

Normally meson would auto-detect existance of ccache in $PATH and use
it automatically, but the way we wrap meson from configure breaks this,
as we're passing in an config file with explicitly set compiler paths.
Thus we need to add $CCACHE_WRAPPERSPATH to the front of $PATH. For
unknown reasons if doing this in msys though, gcc becomes unable to
invoke 'cc1' when run from meson. For msys we thus set CC='ccache gcc'
before invoking 'configure' instead.

A second problem with msys is that cache misses are incredibly
expensive, so enabling ccache massively slows down the build when
the cache isn't well populated. This is suspected to be a result of
the cost of spawning processes under the msys architecture. To deal
with this we set CCACHE_DEPEND=1 which enables ccache's 'depend_only'
strategy. This avoids extra spawning of the pre-processor during
cache misses, with the downside that is it less likely ccache will
find a cache hit after semantically benign compiler flag changes.
This is the lesser of two evils, as otherwise we can't use ccache
at all under msys and remain inside the job time limit.

If people are finding ccache to hurt their pipelines, it can be
disabled by setting the 'CCACHE_DISABLE=1' env variable against
their gitlab fork CI settings.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml           | 11 ++++++++
 .gitlab-ci.d/crossbuild-template.yml          | 26 +++++++++++++++++++
 .gitlab-ci.d/windows.yml                      | 13 ++++++++--
 docs/devel/ci-jobs.rst.inc                    |  7 +++++
 .../dockerfiles/debian-hexagon-cross.docker   |  9 ++++++-
 5 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index f3e39b7eb1..4fbfeb6667 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -2,11 +2,21 @@
   extends: .base_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  cache:
+    paths:
+      - ccache
+    key: "$CI_JOB_NAME"
+    when: always
   before_script:
     - JOBS=$(expr $(nproc) + 1)
   script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="500M"
+    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
     - mkdir build
     - cd build
+    - ccache --zero-stats
     - ../configure --enable-werror --disable-docs --enable-fdt=system
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
@@ -20,6 +30,7 @@
       then
         make -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - ccache --show-stats
 
 # We jump some hoops in common_test_job_template to avoid
 # rebuilding all the object files we skip in the artifacts
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index d97611053b..3e5f4d9cd8 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -2,10 +2,20 @@
   extends: .base_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  cache:
+    paths:
+      - ccache
+    key: "$CI_JOB_NAME"
+    when: always
   timeout: 80m
   script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="500M"
+    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
     - mkdir build
     - cd build
+    - ccache --zero-stats
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
         --target-list-exclude="arm-softmmu cris-softmmu
@@ -18,6 +28,7 @@
       version="$(git describe --match v[0-9]* 2>/dev/null || git rev-parse --short HEAD)";
       mv -v qemu-setup*.exe qemu-setup-${version}.exe;
       fi
+    - ccache --show-stats
 
 # Job to cross-build specific accelerators.
 #
@@ -29,7 +40,15 @@
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 30m
+  cache:
+    paths:
+      - ccache/
+    key: "$CI_JOB_NAME"
   script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="500M"
+    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
     - mkdir build
     - cd build
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
@@ -40,7 +59,14 @@
   extends: .base_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  cache:
+    paths:
+      - ccache/
+    key: "$CI_JOB_NAME"
   script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="500M"
     - mkdir build
     - cd build
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index cd7622a761..12a987cd71 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -5,13 +5,14 @@
   - windows
   - windows-1809
   cache:
-    key: "${CI_JOB_NAME}-cache"
+    key: "$CI_JOB_NAME"
     paths:
       - msys64/var/cache
+      - ccache
     when: always
   needs: []
   stage: build
-  timeout: 80m
+  timeout: 100m
   variables:
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
@@ -72,6 +73,7 @@
       bison diffutils flex
       git grep make sed
       $MINGW_TARGET-capstone
+      $MINGW_TARGET-ccache
       $MINGW_TARGET-curl
       $MINGW_TARGET-cyrus-sasl
       $MINGW_TARGET-dtc
@@ -101,11 +103,18 @@
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
+  - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
+  - $env:CCACHE_DIR = "$env:CCACHE_BASEDIR/ccache"
+  - $env:CCACHE_MAXSIZE = "500M"
+  - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
+  - $env:CC = "ccache gcc"
   - mkdir build
   - cd build
+  - ..\msys64\usr\bin\bash -lc "ccache --zero-stats"
   - ..\msys64\usr\bin\bash -lc "../configure --enable-fdt=system $CONFIGURE_ARGS"
   - ..\msys64\usr\bin\bash -lc "make"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
+  - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
   - Write-Output "Finished build at $(Get-Date -Format u)"
 
 msys2-64bit:
diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index 3f6802d51e..4c39cdb2d9 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -188,3 +188,10 @@ If you've got access to a CentOS Stream 8 x86_64 host that can be
 used as a gitlab-CI runner, you can set this variable to enable the
 tests that require this kind of host. The runner should be tagged with
 both "centos_stream_8" and "x86_64".
+
+CCACHE_DISABLE
+~~~~~~~~~~~~~~
+The jobs are configured to use "ccache" by default since this typically
+reduces compilation time, at the cost of increased storage. If the
+use of "ccache" is suspected to be hurting the overall job execution
+time, setting the "CCACHE_DISABLE=1" env variable to disable it.
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index c2cfb6a5d0..578269766c 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -15,6 +15,7 @@ RUN apt-get update && \
 # Install common build utilities
     apt-get install -y --no-install-recommends \
         curl \
+        ccache \
         xz-utils \
         ca-certificates \
         bison \
@@ -24,13 +25,19 @@ RUN apt-get update && \
         python3-venv && \
 # Install QEMU build deps for use in CI
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy --arch-only qemu
+    apt build-dep -yy --arch-only qemu && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 
 ENV TOOLCHAIN_INSTALL /opt
 ENV TOOLCHAIN_RELEASE 16.0.0
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
 ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/v${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 
 RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
 ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
-- 
2.41.0



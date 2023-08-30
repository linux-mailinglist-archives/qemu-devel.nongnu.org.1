Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4940B78D6BB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaI-0001BF-BC; Wed, 30 Aug 2023 10:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaE-00019B-0O
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaA-0000jH-7P
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401d67434daso19356305e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407249; x=1694012049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KwLHI/E94Q26mI+rQkt5YQi8gKeSm5LiWqohZsEnUk=;
 b=Klhxh32atk0WUQpqDJ1B/ZVCP0/0YgcKjlVHmHCsOLwXIEVrR3Vm/j8vZvSk8/48Bc
 LBum1jkeag2alKroT7Fnu1JHQq+7JZAm7s+G2zzaJCrfK1d1YnH7AHcjswWV4zKmFLeF
 LORIHarKujVATleqYtbYHjm+kJZ94a2e0G8FcFNZDVK9puPfRWUd6Mpc5cLzfd3DI/1r
 ErfdTX8jWllOusNE0fG+Y+KPl89FiUCoHX36kd+GmCQR9Ciqia9Z6KCb38EHOqmgZfcc
 hbKMAXK9T+39EwgPEwhFM4DGia6erwIrH+WjWtybMR3R4ciIxSEOi+T2977o7DIPgLi9
 Na1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407249; x=1694012049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KwLHI/E94Q26mI+rQkt5YQi8gKeSm5LiWqohZsEnUk=;
 b=eEg/wiMMoPGC2lBi8SfcnngZr9tWJlaNtLb5tyOZW+bgM6z3cFGWt7qe45LFT1X+Jg
 LZCEPYhn1R/TwgZ0FLsCop9kZPzaSgAoR6ys0lEAfWTCMTYDyrGzm9xfR+NU9FkjfqTd
 +eFJZu0Guky6dLdbUSbP2qZflKlQnKfnDkl7IPiZ8LhAjpzWf13MNxZ5TPe0BPDv8AWm
 Cre3Z+hJfdcRwD1q62EWHh5YcONaPjwNr+J2EdD66Uq4xLrUdc6rzeYc6kRDzsVpL4U2
 BSiK5MuSy+xQWrhgxpsxnRmeQBICQcWRUNjLk3RfjdUdQrQUU5XTrMsvCyjbQTEs5aFS
 6DVQ==
X-Gm-Message-State: AOJu0Yx4hmTt4Ptx2J/m6yY09f8DBCHrbUrZtiQv4/sPlL9T81pfwfKp
 DaemUXt16rAG5qvnwqmmlJDjkWipX989aOq7kpo=
X-Google-Smtp-Source: AGHT+IHGtc8eDAO1fFXKqLCXPMt6CmJEaOOF/6ASSylHO21VsBYJRQW9ol0t0IIoxhJuE/Ktcw92mg==
X-Received: by 2002:a5d:4845:0:b0:319:666e:b466 with SMTP id
 n5-20020a5d4845000000b00319666eb466mr2042696wrs.42.1693407248574; 
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c10-20020adfef4a000000b0031773e3cf46sm16855458wrp.61.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC3961FFBC;
 Wed, 30 Aug 2023 15:54:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PULL 01/12] gitlab: enable ccache for many build jobs
Date: Wed, 30 Aug 2023 15:53:56 +0100
Message-Id: <20230830145407.3064249-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230804111054.281802-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-2-alex.bennee@linaro.org>

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
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 153fc7cfb3..7c38d7c9e4 100644
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
@@ -27,7 +28,12 @@ RUN apt-get update && \
         python3-wheel && \
 # Install QEMU build deps for use in CI
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy --arch-only qemu
+    apt build-dep -yy --arch-only qemu && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 RUN /usr/bin/pip3 install tomli
 
@@ -35,6 +41,7 @@ ENV TOOLCHAIN_INSTALL /opt
 ENV TOOLCHAIN_RELEASE 16.0.0
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
 ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/v${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 
 RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
 ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
-- 
2.39.2



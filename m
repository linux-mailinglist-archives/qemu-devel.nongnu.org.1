Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F678C977
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nk-0004xX-8e; Tue, 29 Aug 2023 12:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NT-0004mc-Ch
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NL-0004My-Qk
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso43074655e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325729; x=1693930529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usp5SVkYHvuBXbAycyRbEhDIRIcV18Phf6H25qHm2hA=;
 b=OPjuIq+lhacqGmPEEuRb4KKwIJLkWdWDU75MDpFI19c38aMl9YMeWS7aDrZRFNMYPy
 cOvuiP22HyY//7/UPdBWIkjsFzBg0O7+4uOlsdGiUSZKsFTbRyLJ2gLEp4R9UNpVCGRR
 fEt241fdzGQ2RSebqevQuiQ+r8mCLNi1xfTnd/uxJ2vPJRLR9AV1MN85jogH/mNfRsOx
 gSt5UmvFhTq7KOKiuCRJ6X/EXDGnI3uqhhjZA/mwtOmItZPRn2BEwS7vL4rHjWX6Ow3J
 WKJGO8KM5HYGCKUJUITBB2R/8fWNPw/D/NYMljM+tQEn4GalJLZbJ7uLHy7iV15MWsnw
 6WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325729; x=1693930529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usp5SVkYHvuBXbAycyRbEhDIRIcV18Phf6H25qHm2hA=;
 b=N20aOznsA2ddFe4NOLPUrPZz7B84sbjEeLPHhEVuRjJnR74mR7guxvQMpwY9ix2uxw
 7sIRx7DlyhsmZDj2yQlYOwZ+jPiV+oMUjROgfbqPeRtWTTfFgRWSJE0EkfkSPuBFLd8n
 HRS4qTYefYIHEZD0Iq4GLcQ7BVPcEyETOB+y83Yjjei86cCaqmb+cwoWrAyzyrMyem7z
 iEiUPhhEwWOTyrRqQNoS90xmonAcAL5CoPLBaiQDdcd4JjpWv9k+ayL6qUqQa8IS30wi
 kM8l9eHGBhvc/T/Wcdw+6gIST2e7a31KI4tSAuCnACwclzFd6I0jPMdJmdtHAIljJXE5
 s4uA==
X-Gm-Message-State: AOJu0YxQRkSzgCbbW2JDu5d/I0Bs4+iHKTlcWOQvSJIaH9SG+7WuCP83
 oUOkk6oqkpYGWKuZWeMgVu8FwA==
X-Google-Smtp-Source: AGHT+IEkUkZX/ga0o3b/yW/6xW089nfvi0JZ/xrxpVq8jlDGn8hGDWV0naaaDGJEvB30xX+1eJyJMA==
X-Received: by 2002:a5d:4f8d:0:b0:319:520b:2228 with SMTP id
 d13-20020a5d4f8d000000b00319520b2228mr21352389wru.27.1693325729234; 
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p24-20020a1c7418000000b003fef60005b5sm14230907wmc.9.2023.08.29.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D00D1FFBC;
 Tue, 29 Aug 2023 17:15:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 01/12] gitlab: enable ccache for many build jobs
Date: Tue, 29 Aug 2023 17:15:17 +0100
Message-Id: <20230829161528.2707696-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-Id: <20230824163910.1737079-2-alex.bennee@linaro.org>
Message-Id: <20230804111054.281802-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/ci-jobs.rst.inc                    |  7 +++++
 .gitlab-ci.d/buildtest-template.yml           | 11 ++++++++
 .gitlab-ci.d/crossbuild-template.yml          | 26 +++++++++++++++++++
 .gitlab-ci.d/windows.yml                      | 13 ++++++++--
 .../dockerfiles/debian-hexagon-cross.docker   |  9 ++++++-
 5 files changed, 63 insertions(+), 3 deletions(-)

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



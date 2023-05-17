Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9A706A40
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHco-0005dg-Ih; Wed, 17 May 2023 09:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzHcP-0005bK-UT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzHcL-0008F8-SP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684331700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMOlrwNzm+GSzcvWy1f34B0rA4vW8/T94j/5OPXHceg=;
 b=PrnJhgF42j1DTxa5mAgEnT9seclDiPd+j2nM45CKQDB4bdMAMpw/bGjB0EsJaZ9KOhy3by
 g0pSH2M8erMTcxPIX23zfkNZENljlLfbUZ2HIIT9YlTMPCpoaf0+ZhTiZSR7TYcP22T4+M
 JK/ss17J8J69nmyFpB6vtiGzmh2C23g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-IUb32ZAXOE-yZgas1tpaxQ-1; Wed, 17 May 2023 09:54:55 -0400
X-MC-Unique: IUb32ZAXOE-yZgas1tpaxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 185AB3C1485C;
 Wed, 17 May 2023 13:54:55 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83AD0492C3F;
 Wed, 17 May 2023 13:54:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/5] gitlab: centralize the container tag name
Date: Wed, 17 May 2023 14:54:44 +0100
Message-Id: <20230517135448.262483-2-berrange@redhat.com>
In-Reply-To: <20230517135448.262483-1-berrange@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

We use a fixed container tag of 'latest' so that contributors' forks
don't end up with an ever growing number of containers as they work
on throwaway feature branches.

This fixed tag causes problems running CI upstream in stable staging
branches, however, because the stable staging branch will publish old
container content that clashes with that needed by primary staging
branch. This makes it impossible to reliably run CI pipelines in
parallel in upstream for different staging branches.

This introduces $QEMU_CI_CONTAINER_TAG global variable as a way to
change which tag container publishing uses. Initially it can be set
by contributors as a git push option if they want to override the
default use of 'latest' eg

  git push gitlab <branch> -o ci.variable=QEMU_CONTAINER_TAG=fish

this is useful if contributors need to run pipelines for different
branches concurrently in their forks.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml                | 6 ++++++
 .gitlab-ci.d/buildtest-template.yml  | 4 ++--
 .gitlab-ci.d/buildtest.yml           | 4 ++--
 .gitlab-ci.d/container-template.yml  | 3 ++-
 .gitlab-ci.d/crossbuild-template.yml | 6 +++---
 .gitlab-ci.d/static_checks.yml       | 4 ++--
 docs/devel/ci-jobs.rst.inc           | 5 +++++
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 2fbb58d2a3..fba9d31cc6 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -1,4 +1,10 @@
 
+variables:
+  # On stable branches this needs changing. Should also be
+  # overridden per pipeline if running pipelines concurrently
+  # for different branches in contributor forks.
+  QEMU_CI_CONTAINER_TAG: latest
+
 # The order of rules defined here is critically important.
 # They are evaluated in order and first match wins.
 #
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index a6cfe9be97..094ae485b8 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -1,7 +1,7 @@
 .native_build_job_template:
   extends: .base_job_template
   stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   before_script:
     - JOBS=$(expr $(nproc) + 1)
   script:
@@ -44,7 +44,7 @@
 .common_test_job_template:
   extends: .base_job_template
   stage: test
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
     - scripts/git-submodule.sh update
         $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index bb3650a51c..35867dfe77 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -532,7 +532,7 @@ build-without-defaults:
 build-libvhost-user:
   extends: .base_job_template
   stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/fedora:latest
+  image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
   needs:
     job: amd64-fedora-container
   script:
@@ -572,7 +572,7 @@ build-tools-and-docs-debian:
 # of what topic branch they're currently using
 pages:
   extends: .base_job_template
-  image: $CI_REGISTRY_IMAGE/qemu/debian-amd64:latest
+  image: $CI_REGISTRY_IMAGE/qemu/debian-amd64:$QEMU_CI_CONTAINER_TAG
   stage: test
   needs:
     - job: build-tools-and-docs-debian
diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 519b8a9482..83c693c807 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -5,7 +5,8 @@
   services:
     - docker:dind
   before_script:
-    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
+    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:$QEMU_CI_CONTAINER_TAG"
+    # Always ':latest' because we always use upstream as a common cache source
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     - apk add python3
     - docker info
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 4f93b9e4e5..6efb0d2a54 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -1,7 +1,7 @@
 .cross_system_build_job:
   extends: .base_job_template
   stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 80m
   script:
     - mkdir build
@@ -27,7 +27,7 @@
 .cross_accel_build_job:
   extends: .base_job_template
   stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 30m
   script:
     - mkdir build
@@ -39,7 +39,7 @@
 .cross_user_build_job:
   extends: .base_job_template
   stage: build
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
     - mkdir build
     - cd build
diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index b4cbdbce2a..ad9f426a52 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -26,7 +26,7 @@ check-dco:
 check-python-minreqs:
   extends: .base_job_template
   stage: test
-  image: $CI_REGISTRY_IMAGE/qemu/python:latest
+  image: $CI_REGISTRY_IMAGE/qemu/python:$QEMU_CI_CONTAINER_TAG
   script:
     - make -C python check-minreqs
   variables:
@@ -37,7 +37,7 @@ check-python-minreqs:
 check-python-tox:
   extends: .base_job_template
   stage: test
-  image: $CI_REGISTRY_IMAGE/qemu/python:latest
+  image: $CI_REGISTRY_IMAGE/qemu/python:$QEMU_CI_CONTAINER_TAG
   script:
     - make -C python check-tox
   variables:
diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index 1f28fec0d0..f72537853b 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -70,6 +70,11 @@ in a handful of namespaces
    repository CI settings, or as git push variables, to influence
    which jobs get run in a pipeline
 
+ * QEMU_CI_CONTAINER_TAG - the tag used to publish containers
+   in stage 1, for use by build jobs in stage 2. Defaults to
+   'latest', but if running pipelines for different branches
+   concurrently, it should be overridden per pipeline.
+
  * nnn - other misc variables not falling into the above
    categories, or using different names for historical reasons
    and not yet converted.
-- 
2.40.1



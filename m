Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE69BA70AFB
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 21:06:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txASO-0000UH-4O; Tue, 25 Mar 2025 16:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txAS7-0000SQ-MG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txAS5-0002es-Nb
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JZJtIHhM3XNf/12cMKk60fBKC2TI3sJ8bnZj33aWRw=;
 b=LLl0NFLqszI8lnEYmb1rG+S2dzgBBSdjQwx0oaLkTkBI8Nt5R9qZt1rQzUwa/akhytFaTf
 oYjOKpjFL4epRmCzxmM5F/FVYm7kol3V9fuYazVaue0G1XI2+XlIQyTUBLRld37/8qy2QH
 OdibHHe4q3yzvNPIT2tbVwWAO5ZTb8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-_jRb22iUOYaF6sxX7iFvHg-1; Tue,
 25 Mar 2025 16:00:39 -0400
X-MC-Unique: _jRb22iUOYaF6sxX7iFvHg-1
X-Mimecast-MFC-AGG-ID: _jRb22iUOYaF6sxX7iFvHg_1742932838
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70B0119560B1; Tue, 25 Mar 2025 20:00:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2DE8180176A; Tue, 25 Mar 2025 20:00:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/15] gitlab-ci: Remove the avocado tests from the CI
 pipelines
Date: Tue, 25 Mar 2025 21:00:09 +0100
Message-ID: <20250325200026.344006-2-thuth@redhat.com>
In-Reply-To: <20250325200026.344006-1-thuth@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We are going to move the remaining Avocado tests step by step
into the functional test framework. Unfortunately, Avocado fails
with an error if it cannot determine a test to run, so disable
the tests here now to avoid failures in the Gitlab-CI during the
next steps.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 11 ----------
 .gitlab-ci.d/buildtest.yml          | 33 +++++++++++------------------
 2 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 39da7698b09..13fa4f4a4fc 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -95,7 +95,6 @@
   cache:
     key: "${CI_JOB_NAME}-cache"
     paths:
-      - ${CI_PROJECT_DIR}/avocado-cache
       - ${CI_PROJECT_DIR}/functional-cache
     policy: pull-push
   artifacts:
@@ -109,16 +108,6 @@
     reports:
       junit: build/tests/results/latest/results.xml
   before_script:
-    - mkdir -p ~/.config/avocado
-    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
-    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado-cache']"
-           >> ~/.config/avocado/avocado.conf
-    - echo -e '[job.output.testlogs]\nstatuses = ["FAIL", "INTERRUPT"]'
-           >> ~/.config/avocado/avocado.conf
-    - if [ -d ${CI_PROJECT_DIR}/avocado-cache ]; then
-        du -chs ${CI_PROJECT_DIR}/*-cache ;
-      fi
-    - export AVOCADO_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
   after_script:
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 00f4bfcd9f3..431bc07d8fb 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -29,8 +29,7 @@ functional-system-alpine:
       artifacts: true
   variables:
     IMAGE: alpine
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:avr arch:loongarch64 arch:mips64 arch:mipsel
+    MAKE_CHECK_ARGS: check-functional
 
 build-system-ubuntu:
   extends:
@@ -60,8 +59,7 @@ functional-system-ubuntu:
       artifacts: true
   variables:
     IMAGE: ubuntu2204
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:alpha arch:microblazeel arch:mips64el
+    MAKE_CHECK_ARGS: check-functional
 
 build-system-debian:
   extends:
@@ -92,8 +90,7 @@ functional-system-debian:
       artifacts: true
   variables:
     IMAGE: debian
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc arch:xtensa
+    MAKE_CHECK_ARGS: check-functional
 
 crash-test-debian:
   extends: .native_test_job_template
@@ -155,9 +152,7 @@ functional-system-fedora:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:microblaze arch:mips arch:xtensa arch:m68k
-      arch:riscv32 arch:ppc arch:sparc64
+    MAKE_CHECK_ARGS: check-functional
 
 crash-test-fedora:
   extends: .native_test_job_template
@@ -278,9 +273,7 @@ functional-system-centos:
       artifacts: true
   variables:
     IMAGE: centos9
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
-      arch:sh4
+    MAKE_CHECK_ARGS: check-functional
 
 build-system-opensuse:
   extends:
@@ -309,8 +302,7 @@ functional-system-opensuse:
       artifacts: true
   variables:
     IMAGE: opensuse-leap
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:s390x arch:x86_64 arch:aarch64
+    MAKE_CHECK_ARGS: check-functional
 
 #
 # Flaky tests. We don't run these by default and they are allow fail
@@ -338,10 +330,9 @@ functional-system-flaky:
   allow_failure: true
   variables:
     IMAGE: debian
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
     QEMU_JOB_OPTIONAL: 1
     QEMU_TEST_FLAKY_TESTS: 1
-    AVOCADO_TAGS: flaky
 
 # This jobs explicitly disable TCG (--disable-tcg), KVM is detected by
 # the configure script. The container doesn't contain Xen headers so
@@ -482,8 +473,8 @@ clang-user:
 # Since slirp callbacks are used in QEMU Timers, we cannot use libslirp with
 # CFI builds, and thus have to disable it here.
 #
-# Split in three sets of build/check/avocado to limit the execution time of each
-# job
+# Split in three sets of build/check/functional to limit the execution time
+# of each job
 build-cfi-aarch64:
   extends:
     - .native_build_job_template
@@ -520,7 +511,7 @@ functional-cfi-aarch64:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
 
 build-cfi-ppc64-s390x:
   extends:
@@ -558,7 +549,7 @@ functional-cfi-ppc64-s390x:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
 
 build-cfi-x86_64:
   extends:
@@ -592,7 +583,7 @@ functional-cfi-x86_64:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
 
 tsan-build:
   extends: .native_build_job_template
-- 
2.49.0



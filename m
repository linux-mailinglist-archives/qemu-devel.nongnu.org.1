Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B2706A43
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHcX-0005bS-6G; Wed, 17 May 2023 09:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzHcN-0005b4-EB
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzHcK-0008F2-OK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684331700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBPyQstf8/5garXCywqErl3VJr+Z3fdvh1rv6M4Bon0=;
 b=OHJu83GCXtVLgo0+YkKYFqSOWZ+zXRRDVxR8t6HGt7i5S7VUZLLYAFfhXcjhvp+6o9oAAW
 a7zQapmhvx7r7ADeW+YMBjn3pwAv7r/0OPNcdA/aRA43J9qdI4xVoALrR5Fu/rglNQsocc
 3+kBTn29sXgQKVgwazb4sbSy0/ad/sE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-Wij1aH__O0ar63ZYPE237g-1; Wed, 17 May 2023 09:54:57 -0400
X-MC-Unique: Wij1aH__O0ar63ZYPE237g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 898FC3C14851;
 Wed, 17 May 2023 13:54:56 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64069492C3F;
 Wed, 17 May 2023 13:54:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/5] gitlab: allow overriding name of the upstream repository
Date: Wed, 17 May 2023 14:54:45 +0100
Message-Id: <20230517135448.262483-3-berrange@redhat.com>
In-Reply-To: <20230517135448.262483-1-berrange@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The CI rules have special logic for what happens in upstream. To enable
contributors who modify CI rules to test this logic, however, they need
to be able to override which repo is considered upstream. This
introduces the 'QEMU_CI_UPSTREAM' variable

  git push gitlab <branch> -o ci.variable=QEMU_CI_UPSTREAM=berrange

to make it look as if my namespace is the actual upstream. Namespace in
this context refers to the path fragement in gitlab URLs that is above
the repository. Typically this will be the contributor's gitlab login
name.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml      | 19 ++++++++++++-------
 docs/devel/ci-jobs.rst.inc |  6 ++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index fba9d31cc6..a1d734267a 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -5,6 +5,11 @@ variables:
   # for different branches in contributor forks.
   QEMU_CI_CONTAINER_TAG: latest
 
+  # For purposes of CI rules, upstream is the gitlab.com/qemu-project
+  # namespace. When testing CI, it might be usefult to override this
+  # to point to a fork repo
+  QEMU_CI_UPSTREAM: qemu-project
+
 # The order of rules defined here is critically important.
 # They are evaluated in order and first match wins.
 #
@@ -30,23 +35,23 @@ variables:
       when: never
 
     # Publishing jobs should only run on the default branch in upstream
-    - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
+    - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
       when: never
 
     # Non-publishing jobs should only run on staging branches in upstream
-    - if: '$QEMU_JOB_PUBLISH != "1" && $CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH !~ /staging/'
+    - if: '$QEMU_JOB_PUBLISH != "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH !~ /staging/'
       when: never
 
     # Jobs only intended for forks should always be skipped on upstream
-    - if: '$QEMU_JOB_ONLY_FORKS == "1" && $CI_PROJECT_NAMESPACE == "qemu-project"'
+    - if: '$QEMU_JOB_ONLY_FORKS == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
       when: never
 
     # Forks don't get pipelines unless QEMU_CI=1 or QEMU_CI=2 is set
-    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
+    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: never
 
     # Avocado jobs don't run in forks unless $QEMU_CI_AVOCADO_TESTING is set
-    - if: '$QEMU_JOB_AVOCADO && $QEMU_CI_AVOCADO_TESTING != "1" && $CI_PROJECT_NAMESPACE != "qemu-project"'
+    - if: '$QEMU_JOB_AVOCADO && $QEMU_CI_AVOCADO_TESTING != "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: never
 
 
@@ -66,7 +71,7 @@ variables:
       allow_failure: true
 
     # Avocado jobs can be manually start in forks if $QEMU_CI_AVOCADO_TESTING is unset
-    - if: '$QEMU_JOB_AVOCADO && $CI_PROJECT_NAMESPACE != "qemu-project"'
+    - if: '$QEMU_JOB_AVOCADO && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: manual
       allow_failure: true
 
@@ -78,7 +83,7 @@ variables:
 
     # Forks pipeline jobs don't start automatically unless
     # QEMU_CI=2 is set
-    - if: '$QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
+    - if: '$QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: manual
 
     # Jobs can run if any jobs they depend on were successful
diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index f72537853b..f9ef14f2eb 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -75,6 +75,12 @@ in a handful of namespaces
    'latest', but if running pipelines for different branches
    concurrently, it should be overridden per pipeline.
 
+ * QEMU_CI_UPSTREAM - gitlab namespace that is considerd to be
+   the 'upstream'. This defaults to 'qemu-project'. Contributors
+   may choose to override this if they are modifying rules in
+   base.yml and need to validate how they will operate when in
+   an upstream context, as opposed to their fork context.
+
  * nnn - other misc variables not falling into the above
    categories, or using different names for historical reasons
    and not yet converted.
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A273D958
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhN9-0004N6-IR; Mon, 26 Jun 2023 04:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMt-00047E-8I
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMo-0000tk-KX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687767272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17LEbanjgPchbJJDLleWcEVa3CiMHha3jzV0dkguvS4=;
 b=JQ3KbgSdSJ0qPGoutMuWyIydweMm/pWiWfk0/3OVcaWYY9zwx0kf/Dz3IjyIGu3/ElSQvD
 CrPOHtWWMET3w6UJAAqbQ7pXHrLOv8k5rxRT6XUH8SM6yIuHducZnZCTHrsiNFg1+uPFRK
 QoC+ZdlHY7g/5TbjLOKAZyjDkw2sK3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-jQvxm_OKMCiExM5LsjR0TA-1; Mon, 26 Jun 2023 04:14:29 -0400
X-MC-Unique: jQvxm_OKMCiExM5LsjR0TA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 071E08CC206;
 Mon, 26 Jun 2023 08:14:29 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4B0A492B01;
 Mon, 26 Jun 2023 08:14:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/9] gitlab: stable staging branches publish containers in a
 separate tag
Date: Mon, 26 Jun 2023 10:14:10 +0200
Message-Id: <20230626081415.64615-5-thuth@redhat.com>
In-Reply-To: <20230626081415.64615-1-thuth@redhat.com>
References: <20230626081415.64615-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

If the stable staging branches publish containers under the 'latest' tag
they will clash with containers published on the primary staging branch,
as well  as with each other. This introduces logic that overrides the
container tag when jobs run against the stable staging branches.

The CI_COMMIT_REF_SLUG variable we use expands to the git branch name,
but with most special characters removed, such that it is valid as a
docker tag name. eg 'staging-8.0' will get a slug of 'staging-8-0'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230608164018.2520330-4-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/base.yml | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index a1d734267a..f379c182a7 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -1,7 +1,7 @@
 
 variables:
-  # On stable branches this needs changing. Should also be
-  # overridden per pipeline if running pipelines concurrently
+  # On stable branches this is changed by later rules. Should also
+  # be overridden per pipeline if running pipelines concurrently
   # for different branches in contributor forks.
   QEMU_CI_CONTAINER_TAG: latest
 
@@ -16,6 +16,9 @@ variables:
 # Thus we group them into a number of stages, ordered from
 # most restrictive to least restrictive
 #
+# For pipelines running for stable "staging-X.Y" branches
+# we must override QEMU_CI_CONTAINER_TAG
+#
 .base_job_template:
   variables:
     # Each script line from will be in a collapsible section in the job output
@@ -61,11 +64,23 @@ variables:
     #############################################################
 
     # Optional jobs should not be run unless manually triggered
+    - if: '$QEMU_JOB_OPTIONAL && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
+      when: manual
+      allow_failure: true
+      variables:
+        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
+
     - if: '$QEMU_JOB_OPTIONAL'
       when: manual
       allow_failure: true
 
     # Skipped jobs should not be run unless manually triggered
+    - if: '$QEMU_JOB_SKIPPED && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
+      when: manual
+      allow_failure: true
+      variables:
+        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
+
     - if: '$QEMU_JOB_SKIPPED'
       when: manual
       allow_failure: true
@@ -87,4 +102,9 @@ variables:
       when: manual
 
     # Jobs can run if any jobs they depend on were successful
+    - if: '$QEMU_JOB_SKIPPED && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
+      when: on_success
+      variables:
+        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
+
     - when: on_success
-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA69728587
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Igs-0001Rb-KY; Thu, 08 Jun 2023 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7Ign-0001Q7-Iw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7Igl-0002Hx-OZ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686242443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNh9Bsy/U8pDSehacCxOvzNTyJnbzMe0TaTickLvs3s=;
 b=JieAiWb89U3/AAPacHzExEZjW4+yu/phnJxSCQyPsptJZxzViGZDR0kaNWKYx+qh+qafxL
 JO6p0NL+tQnoZ+mN5x6c9AnJxCUtM7piSP0qA0giXy5YASJHsd51su0Pv1bpdHzU2BP5Ad
 V8ACgNnCGluShs/Glx2BnbpCafQ8Pyw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-iERYJawoPD6ml7KSdOOXmQ-1; Thu, 08 Jun 2023 12:40:39 -0400
X-MC-Unique: iERYJawoPD6ml7KSdOOXmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8881938184E2;
 Thu,  8 Jun 2023 16:40:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 927E52166B25;
 Thu,  8 Jun 2023 16:40:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 5/5] gitlab: support disabling job auto-run in upstream
Date: Thu,  8 Jun 2023 17:40:18 +0100
Message-Id: <20230608164018.2520330-6-berrange@redhat.com>
In-Reply-To: <20230608164018.2520330-1-berrange@redhat.com>
References: <20230608164018.2520330-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In forks QEMU_CI=1 can be used to create a pipeline but not auto-run any
jobs. In upstream jobs always auto-run, which is equiv of QEMU_CI=2.

This supports setting QEMU_CI=1 in upstream, to disable job auto-run.
This can be used to preserve CI minutes if repushing a branch to staging
with a specific fix that only needs testing in limited scenarios.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 999149852e..188a770799 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -109,6 +109,16 @@ variables:
     - if: '$QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: manual
 
+    # Upstream pipeline jobs start automatically unless told not to
+    # by setting QEMU_CI=1
+    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
+      when: manual
+      variables:
+        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
+
+    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
+      when: manual
+
     # Jobs can run if any jobs they depend on were successful
     - if: '$QEMU_JOB_SKIPPED && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
       when: on_success
-- 
2.40.1



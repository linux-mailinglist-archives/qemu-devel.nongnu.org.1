Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8272858F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:42:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Igq-0001Qs-Uj; Thu, 08 Jun 2023 12:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7Ign-0001Pq-Di
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7Igk-0002F5-Ud
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686242441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NR8tDnFAeuKljmi4+RsPGDIapTwUldEJSmlSO/Jn8A0=;
 b=hs0Mapi5rFnHaEyhSOgVm/EYaiYJms7ZpavtXtfff3ej6ZzrdtOCB7ryuLxY0i3s8dA2Lz
 pxEeCinwdQgPOj3BOvKRj86xK3V8E7pzxkb1+WB5Kke2zPUN7LdzXU0+9rO+jfgWj+Dbi4
 inWHj1aDHUWMwvvtGgAQv03I9CXyLa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-A1fZ3L8WNc2SqNx8yjeAeQ-1; Thu, 08 Jun 2023 12:40:36 -0400
X-MC-Unique: A1fZ3L8WNc2SqNx8yjeAeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0B2C185A78B;
 Thu,  8 Jun 2023 16:40:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A3F52166B25;
 Thu,  8 Jun 2023 16:40:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 4/5] gitlab: avoid extra pipelines for tags and stable
 branches
Date: Thu,  8 Jun 2023 17:40:17 +0100
Message-Id: <20230608164018.2520330-5-berrange@redhat.com>
In-Reply-To: <20230608164018.2520330-1-berrange@redhat.com>
References: <20230608164018.2520330-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

In upstream context we only run pipelines on staging branches, and
limited publishing jobs on the default branch.

We don't want to run pipelines on stable branches, or tags, because
the content will have already been tested on a staging branch before
getting pushed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index f379c182a7..999149852e 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -33,6 +33,14 @@ variables:
     # want jobs to run
     #############################################################
 
+    # Never run jobs upstream on stable branch, staging branch jobs already ran
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^stable-/'
+      when: never
+
+    # Never run jobs upstream on tags, staging branch jobs already ran
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_TAG'
+      when: never
+
     # Cirrus jobs can't run unless the creds / target repo are set
     - if: '$QEMU_JOB_CIRRUS && ($CIRRUS_GITHUB_REPO == null || $CIRRUS_API_TOKEN == null)'
       when: never
-- 
2.40.1



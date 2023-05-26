Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A842712475
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UY8-0003IN-DD; Fri, 26 May 2023 06:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UY5-0003HU-Jp
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UXz-0002UE-Do
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIbvnBUs0q5GLkLe1tIpp4fk0Dqu4qdHc7TMEK9CNS8=;
 b=B1URxhmTAyn1fINozleihgjmmSTU2cOsBRnLmNlIZJ/f/OWXbM1naYsxraviT/5yF+LSXE
 TEABnKQ6qoK+HTChjwIx/hSoup4PndyLe9Iom4n3SXFB33lFYpxyxZo8Iq3VrYLz9N9wxT
 cnSp9G/GTx/RcZ6CflF7Rwon+UBaXoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-_SyYJPBqNC6wsxxemblsVw-1; Fri, 26 May 2023 06:19:45 -0400
X-MC-Unique: _SyYJPBqNC6wsxxemblsVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E40A85A5B5;
 Fri, 26 May 2023 10:19:45 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E653040C6CCF;
 Fri, 26 May 2023 10:19:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/5] gitlab: avoid extra pipelines for tags and stable
 branches
Date: Fri, 26 May 2023 11:19:33 +0100
Message-Id: <20230526101934.935969-5-berrange@redhat.com>
In-Reply-To: <20230526101934.935969-1-berrange@redhat.com>
References: <20230526101934.935969-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



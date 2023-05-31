Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A477718443
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MTx-00026l-0L; Wed, 31 May 2023 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4MTu-00026P-Fo
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4MTs-0007NR-63
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685542034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YDRTt3QA395WCblD2uVJc4hRFAaDqkrnfRfZ8FVmcSA=;
 b=Iyf3jEFLYYk+JWT2xHGPGw+F1Eo+Q2HAcDX1QuxamDnoZnbINEKqbu3srBqz6sVHOgr+ll
 fMX9N8GBwaEGru6DWZsZyUcFeQx4Fo0KjeShIfDZBXh9v/jTomhgNhCXCSU5UJA9QpoKOo
 nziOwlbXnBQU7uMAzlckHx/Gy9joMfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-Hn-CEy-sPQijrwmFQgUg2w-1; Wed, 31 May 2023 10:07:05 -0400
X-MC-Unique: Hn-CEy-sPQijrwmFQgUg2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3E35811E7F;
 Wed, 31 May 2023 14:06:56 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 780372029F6D;
 Wed, 31 May 2023 14:06:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Camilla Conte <cconte@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: switch from 'stable' to 'latest' docker container tags
Date: Wed, 31 May 2023 15:06:54 +0100
Message-Id: <20230531140654.1141145-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

The 'stable' and 'stable-dind' tags are not documented as supported
tags at:

  https://hub.docker.com/_/docker

Looking at their content they reflect docker 19.x.x release series,
were last built in Dec 2020, and have 3 critical and 20 high rated
CVEs unfixed. This obsolete status is attested by this commit:

  https://github.com/docker-library/docker/commit/606c63960a4845af7077721eb3900c706f5d0c5e

The 'stable-dind' tag in particular appears buggy as it is unable to
resolve DNS for Fedora repos:

  - Curl error (6): Couldn't resolve host name for https://mirrors.fedoraproject.org/metalink?repo=fedora-37&arch=x86_64&countme=1 [getaddrinfo() thread failed to start]

We used the 'stable' tag previously at the recommendation of GitLab
docs, but those docs are wrong and pending a fix:

  https://gitlab.com/gitlab-org/gitlab/-/issues/409430

Fixes: 5f63a67adb58478974b91f5e5c2b1222b5c7f2cc
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 4 ++--
 .gitlab-ci.d/opensbi.yml            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 9ac4a0ee25..8c1370b8f0 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -1,9 +1,9 @@
 .container_job_template:
   extends: .base_job_template
-  image: docker:stable
+  image: docker:latest
   stage: containers
   services:
-    - docker:stable-dind
+    - docker:dind
   before_script:
     - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 2e9d51764e..b4d7eef688 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -42,9 +42,9 @@
 docker-opensbi:
   extends: .opensbi_job_rules
   stage: containers
-  image: docker:stable
+  image: docker:latest
   services:
-    - docker:stable-dind
+    - docker:dind
   variables:
     GIT_DEPTH: 3
     IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
-- 
2.40.1



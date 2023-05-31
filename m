Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 360137185BD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NRj-00014J-K7; Wed, 31 May 2023 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRZ-0000tB-M8
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRX-0004Dd-Hg
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTaWo4gLPbMdtV/vSjQMW6kRyuL7BB1+PhhPoxdkGmA=;
 b=FTmhx9HnE3bticER4GaNpsLpqqXliU7GuiWE3mxbkTeiKK4FX9FJLVC80ytB5O0fgwnGb6
 wgQ3IL4cud8T5hYNkoeCsUSvfQF51vRE5Xm1Df/B/UA2SvSw7XItFBt8GMW5TEvEqfhpBN
 ci46X/oo4ZfBaYXJ1YuSA0G+Tz2uVC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-iZWkD89FPVuMa0apaOhm8A-1; Wed, 31 May 2023 11:08:51 -0400
X-MC-Unique: iZWkD89FPVuMa0apaOhm8A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so26136975e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545729; x=1688137729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTaWo4gLPbMdtV/vSjQMW6kRyuL7BB1+PhhPoxdkGmA=;
 b=DwZkvZNFX+bdexLEdlZawggC8SeZ5igP7FF3i+jdpIZkK/NBc64RDr5ld2s1oF9HNQ
 FWuy5DdRHX2D217UxJU5UgPocJbfEs5gIlGWTeWbhZqrnNTOHFVZXQx5e+JKbrth+IeR
 tufn2iQjJzYZZ+MAybkJ3dOkxCJHRWolFw0peokNTFKjWE0s/edA7lBwNGoS0zhYai89
 ZqI6ZbWX4Hy8mS6uMTvf7e8LEGl9NehFebLcFhUF/ur5R16javGnCI8V0Nw+y1Era0+t
 gytfaMuDx4Gx45M8ZRtj7QGcJk1vzlsndNYJBfP02T221axUtQifbNqZ1DlXMkM43dPv
 piBw==
X-Gm-Message-State: AC+VfDwgEge82np8P5owYa7IuiUu3VdR33TPZcDTfWvBNjga9uW2y8gu
 AZ/CJDngS2rew8fh1p2wVFYF9o/a1pOuGt0x8ZzTXH62m1wZBpY16EbpC0FOLKykQDetslKO/yF
 rlA75vaBmJOMDT9fHFXbT9EP3DT2LeWjZRqkZzDF2X4a8gMTKcrjK4zIVPmeEqeNDL3pfr/dk
X-Received: by 2002:a05:6000:4c:b0:306:2aa0:ce81 with SMTP id
 k12-20020a056000004c00b003062aa0ce81mr4909643wrx.30.1685545729559; 
 Wed, 31 May 2023 08:08:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WhjUZ5zN5Gtmwt30KP+osdwk8UDJqKm/GuBD2o5izinC3zkH6wejHyyj8KIcAQWrH8uq/SA==
X-Received: by 2002:a05:6000:4c:b0:306:2aa0:ce81 with SMTP id
 k12-20020a056000004c00b003062aa0ce81mr4909628wrx.30.1685545729303; 
 Wed, 31 May 2023 08:08:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adff40f000000b00307972e46fasm7090499wro.107.2023.05.31.08.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:08:49 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org,
 Camilla Conte <cconte@redhat.com>
Subject: [PATCH 4/5] gitlab-ci: Use container template for opensbi
Date: Wed, 31 May 2023 16:08:23 +0100
Message-Id: <20230531150824.32349-5-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531150824.32349-1-cconte@redhat.com>
References: <20230531150824.32349-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
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

Use the same template for all the jobs in the "container" stage.

Changes the URL of the "opensbi-cross-build" images by
using the same URL pattern as the other images.

Removes pushing the image to the additional CI_COMMIT_SHA tag.
It seems unnecessary.

Example of the old URLs:
- registry.gitlab.com/qemu-project/qemu:00a0bdc...
- registry.gitlab.com/qemu-project/qemu:opensbi-cross-build

Example of the new URL:
- registry.gitlab.com/qemu-project/qemu/qemu/opensbi-cross-build

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/opensbi.yml | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index d0221632f6..bb90c56bcf 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -1,3 +1,6 @@
+include:
+  - local: '/.gitlab-ci.d/container-template.yml'
+
 # All jobs needing docker-opensbi must use the same rules it uses.
 .opensbi_job_rules:
   rules:
@@ -40,24 +43,14 @@
       when: on_success
 
 docker-opensbi:
+  extends: .container_job_template
   rules:
     - !reference [.opensbi_job_rules, rules]
-  stage: containers
-  image: docker:stable
-  services:
-    - docker:stable-dind
   variables:
     GIT_DEPTH: 3
-    IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
-  before_script:
-    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
-    - until docker info; do sleep 1; done
-  script:
-    - docker pull $IMAGE_TAG || true
-    - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-                                           --tag $IMAGE_TAG .gitlab-ci.d/opensbi
-    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-    - docker push $IMAGE_TAG
+    NAME: opensbi-cross-build
+    DOCKERFILE: "$CI_PROJECT_DIR/.gitlab-ci.d/opensbi/Dockerfile"
+    BUILD_CONTEXT: "$CI_PROJECT_DIR/.gitlab-ci.d/opensbi"
 
 build-opensbi:
   rules:
@@ -72,7 +65,7 @@ build-opensbi:
       - opensbi32-generic-stderr.log
       - opensbi64-generic-stdout.log
       - opensbi64-generic-stderr.log
-  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
+  image: $CI_REGISTRY_IMAGE/qemu/opensbi-cross-build:latest
   variables:
     GIT_DEPTH: 3
   script: # Clone the required submodules and build OpenSBI
-- 
2.40.1



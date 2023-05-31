Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB217185C0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NRm-00015w-0Q; Wed, 31 May 2023 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRZ-0000t9-M7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRW-0004DY-W8
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVuzBMnkfJNSJsyI+pl3jmQ0YmPp+bKGi9FVckju4oA=;
 b=d2DuxI/qOFjm4z0LFJW9indHGbilMHPdVMBKm2NkJQlK2u2oa7O9VSvc+yIL5gRj3uq7yi
 lKZWVjq7D1Lvnmdq9aHgPNe3KiUAYnB3QnvZnNbc3jitcag1BKc3rSbEPEQNP5lBChc6Eg
 UC1cJy27lOC5igBk+/GIaa8D3pphCnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-4hWFgmunMbqnAPYmzvTbpA-1; Wed, 31 May 2023 11:08:52 -0400
X-MC-Unique: 4hWFgmunMbqnAPYmzvTbpA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso27295085e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545730; x=1688137730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVuzBMnkfJNSJsyI+pl3jmQ0YmPp+bKGi9FVckju4oA=;
 b=FaTi5OC/oePLkYobEblITY+3CVMxUYMIGTkaY5mtY5EInK3CpC8ia7OTcsaXLjOE9i
 hu3g96L31LRway9IRq5fycGT2AAs9X4DhA3sQhvYGsPIk4ENC6RAyv0DBYv80i23IajJ
 rTXMXF733ZWb6Ir1KrloM89V+MflNbrkWHH+YivagYkUgJ1EwZZguiV8lD+KTKcg44Li
 O3c0EcD8r5EoKO5vFiJaxionM6ETsntDrzjVM+dNQqfjF51WqjnkerW9W5Xt4alonQWO
 UJIh+T7QC/ppqUG7YRQZbHIuExIpjTo3rUHIeIc6LmJ0XKQOullGYkTK9u00wKIFlzEA
 bmOw==
X-Gm-Message-State: AC+VfDztSl3VrXgZ5LJUjh6MsZdnm2kvsu4qHKXLxxnoV8yqHpDDCqHr
 0JGPMH1tCgeGZ5IFG9S3P6fs/NArnnsJ046r5VUx+DUJyZdYsXovGZH6fDytLCQs0FYtX2oyEb/
 Na1xDx3iPp8vBUCmhWhUPWEWsCgIid3E2Z8nmmxUF8GQrMCJf6kL71lkIUcC4oDxkpb30qq5S
X-Received: by 2002:a05:600c:2294:b0:3f1:8c5f:dfc5 with SMTP id
 20-20020a05600c229400b003f18c5fdfc5mr4169904wmf.39.1685545730349; 
 Wed, 31 May 2023 08:08:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bb9T0iYTICI52GbprKZ1zhoeDrwixgrhlyH23QDZgMArn1bjcufLnLm20NYxZHWzAT7hbDA==
X-Received: by 2002:a05:600c:2294:b0:3f1:8c5f:dfc5 with SMTP id
 20-20020a05600c229400b003f18c5fdfc5mr4169891wmf.39.1685545730178; 
 Wed, 31 May 2023 08:08:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adff40f000000b00307972e46fasm7090499wro.107.2023.05.31.08.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:08:49 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org,
 Camilla Conte <cconte@redhat.com>
Subject: [PATCH 5/5] gitlab-ci: Replace Docker with Kaniko
Date: Wed, 31 May 2023 16:08:24 +0100
Message-Id: <20230531150824.32349-6-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531150824.32349-1-cconte@redhat.com>
References: <20230531150824.32349-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Previous attempt by Alex Bennée, for the records:
https://lore.kernel.org/qemu-devel/20230330101141.30199-12-alex.bennee@linaro.org/

Does not enable caching, as suggested in a previous review:
https://lore.kernel.org/qemu-devel/ZCVpMDLPJcdnkAJz@redhat.com/

Does not specify a context since no Dockerfile is using COPY or ADD instructions.

Does not enable reproducible builds as
that results in builds failing with an out of memory error.
See issue "Using --reproducible loads entire image into memory":
https://github.com/GoogleContainerTools/kaniko/issues/862

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/container-template.yml           | 25 +++++--------------
 .gitlab-ci.d/opensbi.yml                      |  1 -
 .../ci/gitlab-kubernetes-runners/values.yaml  | 12 ---------
 3 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index d146d1d197..0e93f5f13e 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -1,27 +1,14 @@
 .container_job_template:
   extends: .base_job_template
   stage: containers
-  image: docker:stable
-  services:
-    - docker:stable-dind
+  image:
+    name: gcr.io/kaniko-project/executor:debug
+    entrypoint: [""]
   variables:
     TAG: "$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
-    COMMON_TAG: "$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     DOCKERFILE: "$CI_PROJECT_DIR/tests/docker/dockerfiles/$NAME.docker"
-    BUILD_CONTEXT: "$CI_PROJECT_DIR"
-  before_script:
-    - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
-    - until docker info; do sleep 1; done
   script:
     - echo "TAG:$TAG"
-    - echo "COMMON_TAG:$COMMON_TAG"
-    - >
-      docker build
-      --tag "$TAG"
-      --cache-from "$TAG"
-      --cache-from "$COMMON_TAG"
-      --build-arg BUILDKIT_INLINE_CACHE=1
-      -f "$DOCKERFILE" "$BUILD_CONTEXT"
-    - docker push "$TAG"
-  after_script:
-    - docker logout
+    - /kaniko/executor
+      --dockerfile "$DOCKERFILE"
+      --destination "$TAG"
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index bb90c56bcf..e531ce2728 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -50,7 +50,6 @@ docker-opensbi:
     GIT_DEPTH: 3
     NAME: opensbi-cross-build
     DOCKERFILE: "$CI_PROJECT_DIR/.gitlab-ci.d/opensbi/Dockerfile"
-    BUILD_CONTEXT: "$CI_PROJECT_DIR/.gitlab-ci.d/opensbi"
 
 build-opensbi:
   rules:
diff --git a/scripts/ci/gitlab-kubernetes-runners/values.yaml b/scripts/ci/gitlab-kubernetes-runners/values.yaml
index 204a96a842..ed6c5894bc 100644
--- a/scripts/ci/gitlab-kubernetes-runners/values.yaml
+++ b/scripts/ci/gitlab-kubernetes-runners/values.yaml
@@ -4,27 +4,15 @@ rbac:
   create: true
 concurrent: 200
 runners:
-  privileged: true
   config: |
     [[runners]]
       limit = 100
-      environment = [
-        "DOCKER_HOST=tcp://docker:2376",
-        "DOCKER_TLS_CERTDIR=/certs",
-        "DOCKER_TLS_VERIFY=1",
-        "DOCKER_CERT_PATH=/certs/client"
-      ]
       [runners.kubernetes]
         poll_timeout = 1200
-        image = "ubuntu:20.04"
         cpu_request = "0.5"
         service_cpu_request = "0.5"
         helper_cpu_request = "0.25"
         cpu_request_overwrite_max_allowed = "7"
         memory_request_overwrite_max_allowed = "30Gi"
-      [[runners.kubernetes.volumes.empty_dir]]
-        name = "docker-certs"
-        mount_path = "/certs/client"
-        medium = "Memory"
       [runners.kubernetes.node_selector]
         agentpool = "jobs"
-- 
2.40.1



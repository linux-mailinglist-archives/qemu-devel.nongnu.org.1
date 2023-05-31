Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1B7185BC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NRb-0000xD-Rz; Wed, 31 May 2023 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRX-0000ri-Op
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRW-0004DM-4t
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBfSt4Me5C/XPY7LY682rlFuKztjSBtY5pm75ZUXSxM=;
 b=Bf5Fho7DYGqnR49ObLtCNnkKWMsjv7Ndt1238qU/tPkcjxAKGijXPwJVi4ebyx9kyyoE+N
 l2KrIDNEgaEKzzqvXcltnilKrgFZtFGzSjAdY+xXjSLPjKQCViagqFnLHAgTo/SoJcyoa0
 qFgC7Od8Lte2cDbsHHmKv/T5/tq/70A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-3SVYcAdXOVaSzUKm9BLrrA-1; Wed, 31 May 2023 11:08:50 -0400
X-MC-Unique: 3SVYcAdXOVaSzUKm9BLrrA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ab548ba06so7954029f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545728; x=1688137728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBfSt4Me5C/XPY7LY682rlFuKztjSBtY5pm75ZUXSxM=;
 b=FHjJqgv0Hp/OOt/DT6K8WWylfR4/+eBLDdcQ+41st3EBqEZMBsOGRjAn557I968Z3i
 j7mtjlXk2SeqxiUELKp8V93MPkBxkgVAFbtAClgabJMA7MpA8+GWb+eUb40NNGN99ljV
 M6y6hWkv0Hjq1v0HW9bFOXca3nSgSmtJD3xBvgCXWW3AqEyCra3/mffjFinISBNDc4lx
 hPDKMXzkOFETnThvMBLsnjvrE8Z4Z6MmV/VlTU+sJl3r+MbTZ+yeojC1eBijEGraucrn
 0ukL94RojAVRd6Cp3o+bC9LeJD17MlamOOuXBUQsUxmawTDuqnrcbZLtHObByLEpFe+m
 zhSg==
X-Gm-Message-State: AC+VfDx/C8XCBmtCuUEP+BsU8n8kmdY8IrbKDCZIHLLORS+V7IyAzXpF
 DgE33+KtYas/Jg0x862qgxCHAFwVrl3GzPCmsK+OxwuPAaZcPoHjvjgfXTqZv76uXQr8KUOHR1o
 CHyML6BC5PBvxQaIUlgrZr6y8EL39NzeSpEi/niiJhjfkGeE7MZ5owuDPTlsfXbmLzkc3NfI6
X-Received: by 2002:a5d:474b:0:b0:306:4031:63c5 with SMTP id
 o11-20020a5d474b000000b00306403163c5mr4640419wrs.51.1685545728718; 
 Wed, 31 May 2023 08:08:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66QlsAqhDlleChZ4z4P2K3hAWGyvhj29ECEsZbU4FAeghqZvbcSmc+WcoleWozS4MBdA9gmg==
X-Received: by 2002:a5d:474b:0:b0:306:4031:63c5 with SMTP id
 o11-20020a5d474b000000b00306403163c5mr4640391wrs.51.1685545728393; 
 Wed, 31 May 2023 08:08:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adff40f000000b00307972e46fasm7090499wro.107.2023.05.31.08.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:08:48 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org,
 Camilla Conte <cconte@redhat.com>
Subject: [PATCH 3/5] gitlab-ci: Move variables outside script
Date: Wed, 31 May 2023 16:08:22 +0100
Message-Id: <20230531150824.32349-4-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531150824.32349-1-cconte@redhat.com>
References: <20230531150824.32349-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
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

Also split long line for clarity.

Docs:
https://docs.gitlab.com/ee/ci/variables/#use-cicd-variables-in-other-variables
Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index fd7deb1c29..d146d1d197 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -1,20 +1,27 @@
 .container_job_template:
   extends: .base_job_template
-  image: docker:stable
   stage: containers
+  image: docker:stable
   services:
     - docker:stable-dind
+  variables:
+    TAG: "$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
+    COMMON_TAG: "$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
+    DOCKERFILE: "$CI_PROJECT_DIR/tests/docker/dockerfiles/$NAME.docker"
+    BUILD_CONTEXT: "$CI_PROJECT_DIR"
   before_script:
-    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
-    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
     - until docker info; do sleep 1; done
   script:
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
-    - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
+    - >
+      docker build
+      --tag "$TAG"
+      --cache-from "$TAG"
+      --cache-from "$COMMON_TAG"
       --build-arg BUILDKIT_INLINE_CACHE=1
-      -f "tests/docker/dockerfiles/$NAME.docker" "."
+      -f "$DOCKERFILE" "$BUILD_CONTEXT"
     - docker push "$TAG"
   after_script:
     - docker logout
-- 
2.40.1



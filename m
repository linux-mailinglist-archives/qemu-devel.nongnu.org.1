Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651C70C48E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19Yw-0003YH-9K; Mon, 22 May 2023 13:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Yn-0003X5-2R
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Yk-0004AT-3U
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTYIXXmimrTIlllTqeWRNB2BffiFgHW9NJl6I5KnpN0=;
 b=ifdQmkS2lL5bNUsAMUodUwvYMW6Aofs7Y3T5pPZh+R3zN+6s5D1OqENqYv4EtO6tTbmVNu
 i8dLXOKytm0nq+r6Zje/zVRUIGE1EW7TmTiJAD7nSZWOAsX3nwOdlm9bq1Bv1selfhhBah
 IDHUbHpieR1GAQPMQ7x31LN8VZDyeM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Wkb6raTJPCOlwrOyzAAUiQ-1; Mon, 22 May 2023 13:43:00 -0400
X-MC-Unique: Wkb6raTJPCOlwrOyzAAUiQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso7076705e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 10:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684777378; x=1687369378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTYIXXmimrTIlllTqeWRNB2BffiFgHW9NJl6I5KnpN0=;
 b=SbZzZ5vy5YgUaLXLEQCR0N1OhybK/765sCWB9G3If0tUEl2g7Kwt6WwJhjxG8Q3Pjn
 RIcxkyDpszoDksCiwd9mQv7BC67bYfQteiej3vCOuL6hxpQFJTzQj38IR+P0LD0DCqo9
 vDcE7Py54EXivWzHl3Uw9BgZ6VbZkGKD4ZT6LFQOApDpImnU4p/nQa6oAuFxmvndlFL5
 mQ3uD6clgZdqYAmPUMZr84oOmrRYuwGg/CMKBR/G6jmtSiQ5RzMCpRKSSAyQL1NOAxz5
 0WRCC2UdTovE6ZcUEDDUFG9ydCVcnwRuI/4pX+sfiSJf0WH+39/G4DhqzhRq3E3ykQwL
 2Gwg==
X-Gm-Message-State: AC+VfDzLKePV7FCqzLXHAa6d+7waVFwzlvBl3GG5uY5C4apAQcQHqp+s
 pGCD/HOnyomsex/ZVJEeOmxWtYME62PHUOQZuMwpLn8maa7+kw7sJb2zX1f1K/OHAvV72Z5kYfv
 l4i7aqsy7RZj7pbDD+JR/8iJY/w+nBsPA7mp04BFG9XGHMWuGv7COXVnWCgQnIM0bx9dlRIkT
X-Received: by 2002:a05:600c:3549:b0:3f5:a54:9f97 with SMTP id
 i9-20020a05600c354900b003f50a549f97mr8557279wmq.0.1684777378782; 
 Mon, 22 May 2023 10:42:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4YAtConbzCWYFvHVIXVzFPCG5w1x28Xm16wiVMscpbHa6W/9aFHre2B2NDea06KmTuK0k+hQ==
X-Received: by 2002:a05:600c:3549:b0:3f5:a54:9f97 with SMTP id
 i9-20020a05600c354900b003f50a549f97mr8557264wmq.0.1684777378525; 
 Mon, 22 May 2023 10:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b003f3157988f8sm9030805wmc.26.2023.05.22.10.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 10:42:58 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, Camilla Conte <cconte@redhat.com>
Subject: [PATCH v2 3/5] Add loop over docker info
Date: Mon, 22 May 2023 18:41:52 +0100
Message-Id: <20230522174153.46801-4-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522174153.46801-1-cconte@redhat.com>
References: <20230522174153.46801-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
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

Wait for docker info to return successfuly to ensure that
the docker server (daemon) started.
This is needed for jobs running on Kubernetes.
See https://wiki.qemu.org/Testing/CI/KubernetesRunners.

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 2 +-
 .gitlab-ci.d/opensbi.yml            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 11569dd900..9ac4a0ee25 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -8,8 +8,8 @@
     - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     - apk add python3
-    - docker info
     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
+    - until docker info; do sleep 1; done
   script:
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 13070575b6..2e9d51764e 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -50,6 +50,7 @@ docker-opensbi:
     IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
   before_script:
     - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
+    - until docker info; do sleep 1; done
   script:
     - docker pull $IMAGE_TAG || true
     - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0E707A6C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:53:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzXUl-0004Of-Ox; Thu, 18 May 2023 02:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzXUj-0004OS-Iy
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzXUi-0003gY-3P
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684392730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MFvNX+ZKxUx752r9NGL2P1bYYI26cpGBiCk4f1VAu0E=;
 b=H6E3tG2q+5eZ9K9EjO9tELz+WXT1E6LnSdTJ9+a6Z+QgH79OpNfQ/ece1C0jS2h2tueapr
 R2Zc2OigdNh6spjQVN4zvlRrk+zr6We8xYlANV2+XRoczVfA3ZHqNkncU/VfQtxLOSBwQG
 pazXpkr1uSzVM84gn5dtzvwXFZA0om4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-ofAFZfNCP565iCQq90E3OQ-1; Thu, 18 May 2023 02:52:09 -0400
X-MC-Unique: ofAFZfNCP565iCQq90E3OQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9668a987fe7so136884566b.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684392728; x=1686984728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MFvNX+ZKxUx752r9NGL2P1bYYI26cpGBiCk4f1VAu0E=;
 b=BKxgHzjdDlF0b8P2fahEOQSAVs1o+fFCBTOE7hPua6TK1FOuYCt6gbBHf7x9t0YKwr
 QjgdUwuGLsKRjGcWaNCjTj4GP7ncPcsY6MaYeVBV5kBlfLJ0PZOELz/iS5DOXzaOxb8m
 A/574+Tr8byiwPgjkYH7ToQJJTMgY5A/YG79CwM+qnGZfkAVGZI5yg6P5jD9EtSgZiQe
 MyKzLOt1pFsONYSISNOzhUoTTKZ3n2robwj2CpaEWSmuyVgLhcT0BThjgpB6YTQulr2h
 oiTALdFMAD/YUod/PPa1jupvWDabbIeRHViJdhR+zUqO8MTpv+Jmg+cUu1ql73099Gdq
 0OMg==
X-Gm-Message-State: AC+VfDwayTaTugF5WtJb60hgPGxQneQI1FxAhPRyAg1pP4O37SM49Ka5
 efCJDo9ejRv1B1QQv8qfonO2xdPorX2ZHV6Pd+Tk9FD75hF3LucR1PV8R8oP6kd6qfsPQjmZUk2
 Shjcz8KvStJbprGA0Dk9+sVo/BPUbihSJYgyLk7epnlpWyHOVe14vrEyibDQA9lf+YRQ7nbnVPl
 w=
X-Received: by 2002:a17:907:7f03:b0:94e:4285:390c with SMTP id
 qf3-20020a1709077f0300b0094e4285390cmr5774407ejc.10.1684392727783; 
 Wed, 17 May 2023 23:52:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6u0JvWAaUHJJiqu3zQQ0eW59084zAJzsDDX4u1S+mIbp30knUshcNOVMeiqmj/a2bTlRqbqg==
X-Received: by 2002:a17:907:7f03:b0:94e:4285:390c with SMTP id
 qf3-20020a1709077f0300b0094e4285390cmr5774395ejc.10.1684392727352; 
 Wed, 17 May 2023 23:52:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 oy26-20020a170907105a00b009682b2b3d66sm541401ejb.197.2023.05.17.23.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 23:52:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] gitlab: custom-runners: preserve more artifacts for debugging
Date: Thu, 18 May 2023 08:52:06 +0200
Message-Id: <20230518065206.951902-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Since custom runners are not generally available, make it possible to
debug the differences between a successful and a failing build by
comparing the logs and the build.ninja rules.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/custom-runners.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 34a1e6f32735..8e5b9500f401 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -20,8 +20,10 @@ variables:
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
+    when: always
     paths:
-      - build/meson-logs/testlog.txt
+      - build/build.ninja
+      - build/meson-logs
     reports:
       junit: build/meson-logs/testlog.junit.xml
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00A7185BF
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NRl-0001CH-RD; Wed, 31 May 2023 11:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRa-00011M-Tu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRZ-0004E3-Ev
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8yX6wUKUNL3b0AwG+fZ1PjWIcb66Z5UX8v/bLKwjtQ=;
 b=AeVht15aS81FOVXBVzL2zXqb088VP6XqRmn5bYXHlh1qL7WeMMc1E4TBYz7rC1VsjhQK6g
 GmqFKhMP2gas1+bRqe08PWU07zk8YOWTiiYD0vSr6wzXpr8hkntZuNUaS4Z8gXEVpulMN8
 phcEc3NYvmqb20OXMwNKnRrrd1cJHMA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-fu5za5Z8NXSxwj0tjgyRjg-1; Wed, 31 May 2023 11:08:48 -0400
X-MC-Unique: fu5za5Z8NXSxwj0tjgyRjg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f6f58e269eso28814245e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545726; x=1688137726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8yX6wUKUNL3b0AwG+fZ1PjWIcb66Z5UX8v/bLKwjtQ=;
 b=PauiM6O0JiIjoRdinJHa1Yts825MiFymuXbw0kE1HV4bbfMrqjn2g8TPKu+cll7avP
 s+87V5NlKhBs1QJ9T6ZLqRbMVbR/VkXjZuqIughXXvBEaSl8Kuqn7ZBx5AoZdD/wAwEs
 yOH6QaltPHp2XPcOj4hbd06TrlIVrMjLGoSBpIADFa8N1OAdl/o29WhCBL3XRvcxXQ52
 B/yo1HIjWgut1mlomDjIQPoh4lkAi3K5myX1dxe8+SWmt2RexUR339Jjx0oO5MXUuCpj
 Nz93JBcXunEs8052UoHVEe70eG/R44qKzd858HJ0yehpagkYRSPEMcsg8jdCMhbTPmzq
 LpiQ==
X-Gm-Message-State: AC+VfDwgnQdTiZOFSrxGKpWsEHzYwtDfWk66MvwHwNd6rXWmi6HSN7sW
 hKWXvmBj8lPlCvvkOxSLys/K1697NDYCYT4xWPHhYf991p8HC/EHSh2qTs4rxyu/+vDHUgCDKUN
 IHY1ivA3flWDdnz2Brdd+tShXrKnpofUMgMT0REwk6RQZd4hd+HfaJ61JsOmqZ3lbomenfwXA
X-Received: by 2002:a7b:ce05:0:b0:3f6:3bb:5132 with SMTP id
 m5-20020a7bce05000000b003f603bb5132mr4803730wmc.24.1685545726793; 
 Wed, 31 May 2023 08:08:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YwAgbhImiWplJ22IUsC9T+hCc7vgFVrUBEHTxzUqH9tgu6DjKe/IJrMVhci56j+lJxKviIA==
X-Received: by 2002:a7b:ce05:0:b0:3f6:3bb:5132 with SMTP id
 m5-20020a7bce05000000b003f603bb5132mr4803709wmc.24.1685545726474; 
 Wed, 31 May 2023 08:08:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adff40f000000b00307972e46fasm7090499wro.107.2023.05.31.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:08:46 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org,
 Camilla Conte <cconte@redhat.com>
Subject: [PATCH 1/5] gitlab-ci: Remove unused Python package
Date: Wed, 31 May 2023 16:08:20 +0100
Message-Id: <20230531150824.32349-2-cconte@redhat.com>
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

Python should have been removed in this commit:
https://gitlab.com/qemu-project/qemu/-/commit/94b8b146df84ba472f461398d93fb9cdf0db8f94

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 9ac4a0ee25..fd7deb1c29 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -7,7 +7,6 @@
   before_script:
     - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
-    - apk add python3
     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
     - until docker info; do sleep 1; done
   script:
-- 
2.40.1



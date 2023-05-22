Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964470C48B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19Yv-0003X6-28; Mon, 22 May 2023 13:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Yk-0003Wr-9Y
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Yh-0004AL-KX
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9lpf4DJBf0TIKpy15n2M7nyjKZcr9QB+iScUFoDvFk=;
 b=NCh3YwZZsrEI1TGrnl4BBAniLk0oGCPkWlrNgWjWfhYyR0zjbj8mFtUfms8oRu18jcbUdV
 rKm2gxZDlA7srWz98YviUlbAdy2hvmd/ahZsSqWWibrKoUXr4sU2Q5iixQpry9od9Ni9cr
 KLkbJnM6R+hqLibVp91SmAn+tYfVSjc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-KbcKy7XaOY2yewfvFV2Vhg-1; Mon, 22 May 2023 13:42:57 -0400
X-MC-Unique: KbcKy7XaOY2yewfvFV2Vhg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f4dd7f13d0so24797445e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 10:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684777376; x=1687369376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9lpf4DJBf0TIKpy15n2M7nyjKZcr9QB+iScUFoDvFk=;
 b=dcBN2lSXTZS1sjCpIYkS5PNP87vvj+CX3g1r26mDOQBskBzHDjF857yp0mkkWqDhH9
 XVkCHOw5kmyOCqdC4+zukmAjE55dpWMTMFEIqWGtY7XqUUvEXR77ixfBpcgrQOb27EzR
 b4n6tCIzV4BghPMGWXNaUSPOul8/Poxu3nRl1cwyr43fNOt67aIg3C8Cg9j7Od6ZUcws
 NKzChObXSi0TB3WGwDl8mS4jx+clRL0yhAP9fVjK8sR9YTA0uEt3C+24Xzg2L61x2wT7
 rVDpvlqxMH8wUkIS+G2NZfPrp2esO5iT6S/2ZCpBHYJRls/JxGjzIKDtWialQYsLe9wa
 pshg==
X-Gm-Message-State: AC+VfDwYxKiCWHil44TvKMxNnG3jq3W+bjeQ32UedDKzMC9LBajZmQ/j
 cyRLSUsDwpAvG0ye+5aPDg3oZDMF2Q9XmceQ7nvzWq1lmcDTVrIecChtHW7WEuJj6HdWFt7flei
 rFINu1R2O6XM4p5+MI3ti15eoGa1k+vdSdI984dwr9e+GCBgnFYrMZOekLIPBcfwOs4Zd9j1A
X-Received: by 2002:a05:600c:2212:b0:3f0:a08e:811b with SMTP id
 z18-20020a05600c221200b003f0a08e811bmr8137592wml.13.1684777376141; 
 Mon, 22 May 2023 10:42:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MJkfLAijqaQCcYz7o0ajGBwLJDj5+H5rhpUUN2yWYF6be4+HQP6JT5iU5EUqecMKrHn8qOA==
X-Received: by 2002:a05:600c:2212:b0:3f0:a08e:811b with SMTP id
 z18-20020a05600c221200b003f0a08e811bmr8137582wml.13.1684777375854; 
 Mon, 22 May 2023 10:42:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b003f3157988f8sm9030805wmc.26.2023.05.22.10.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 10:42:55 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, Camilla Conte <cconte@redhat.com>
Subject: [PATCH v2 2/5] Use docker "stable" tag
Date: Mon, 22 May 2023 18:41:51 +0100
Message-Id: <20230522174153.46801-3-cconte@redhat.com>
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

Use the same tag in all jobs.

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 519b8a9482..11569dd900 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -3,7 +3,7 @@
   image: docker:stable
   stage: containers
   services:
-    - docker:dind
+    - docker:stable-dind
   before_script:
     - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
-- 
2.40.1



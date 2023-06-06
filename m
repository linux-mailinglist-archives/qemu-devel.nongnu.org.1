Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3572370E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 08:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgX-0004qp-Lt; Tue, 06 Jun 2023 01:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgV-0004ph-5B
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgT-00049t-Jy
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uQwwPtz4DspYHNqIHFxsjZmiGzLxYPAFBsB9XPFdB0=;
 b=KKWEnpIhwVpSvlrDDzcrKVJeSzDWc2OoQ1WDMQVnMBwJUXAGJ+2aBPcrQjrh1gwULy9qjV
 0Xp9EKJLXJ7lqfWzPlUpNa9U7f9Yv0LKf++DFnn11XCpnK35zIuEwBfKBfSTns5wcaTuWC
 fgIsxJyBMMFEdEHzZ9PqPdlPqC7XyTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-BzPKCGcIMn605upAgrnjfw-1; Tue, 06 Jun 2023 01:56:41 -0400
X-MC-Unique: BzPKCGcIMn605upAgrnjfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F2A9801182;
 Tue,  6 Jun 2023 05:56:41 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 523DD2166B25;
 Tue,  6 Jun 2023 05:56:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Camilla Conte <cconte@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/18] gitlab-ci: Remove unused Python package
Date: Tue,  6 Jun 2023 07:56:14 +0200
Message-Id: <20230606055621.523175-12-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Camilla Conte <cconte@redhat.com>

Python should have been removed in this commit:
https://gitlab.com/qemu-project/qemu/-/commit/94b8b146df84ba472f461398d93fb9cdf0db8f94

Signed-off-by: Camilla Conte <cconte@redhat.com>
Message-Id: <20230531150824.32349-2-cconte@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 8c1370b8f0..77aa839e9e 100644
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
2.31.1



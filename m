Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B582B391
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:02:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQv-0004ID-Jj; Thu, 11 Jan 2024 12:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQt-0004Fw-KS
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQr-0003wu-T3
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7bJLYPkgCLStrFZA04nKxsfUZ5MnQeev1D/E3CGlcc=;
 b=D/Fm8oaDWaSQKxKNQro9jHLdPIa1obSMlxl3BJx+qmzNewMtibXuTM9Ms8AfQ3BdEsblaj
 UKtL+pYIXpdmWGqxc7fXTBo1Fb5WCg2PDjIXVt+3+WjSdLAGh4Mlq81xddcBnynT0UX5dx
 ZzkwpN7Sw0Tc8qe/tUgcYlU8kVu6JIU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-ODzi9SDUPyeZyISryD1o7Q-1; Thu,
 11 Jan 2024 12:01:22 -0500
X-MC-Unique: ODzi9SDUPyeZyISryD1o7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA0E43816B60;
 Thu, 11 Jan 2024 17:01:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E409B51D5;
 Thu, 11 Jan 2024 17:01:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/17] .gitlab-ci.d/buildtest.yml: Work around htags bug when
 environment is large
Date: Thu, 11 Jan 2024 18:00:46 +0100
Message-ID: <20240111170047.909117-18-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Sometimes the CI "pages" job fails with a message like this from
htags:

$ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU sourcecode"
htags: Negative exec line limit = -371

This is due to a bug in hflags where if the environment is too large it
falls over:
https://lists.gnu.org/archive/html/bug-global/2024-01/msg00000.html

This happens to us because GitLab CI puts the commit message of the
commit under test into the CI_COMMIT_MESSAGE and/or CI_COMMIT_TAG_MESSAGE
environment variables, so the job will fail if the commit happens to
have a verbose commit message.

Work around the htags bug by unsetting these variables while running
htags.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2080
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240111125543.1573473-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfe737aca2..9b4df24e9a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -647,7 +647,10 @@ pages:
     - mkdir -p public
     # HTML-ised source tree
     - make gtags
-    - htags -anT --tree-view=filetree -m qemu_init
+    # We unset variables to work around a bug in some htags versions
+    # which causes it to fail when the environment is large
+    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
+        -anT --tree-view=filetree -m qemu_init
         -t "Welcome to the QEMU sourcecode"
     - mv HTML public/src
     # Project documentation
-- 
2.43.0



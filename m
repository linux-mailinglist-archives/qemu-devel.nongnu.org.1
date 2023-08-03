Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D948176E6DC
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWDK-0006OE-VT; Thu, 03 Aug 2023 07:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWDJ-0006N5-2G
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWDH-0007WD-DU
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691060990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0quHJ8zjcyew3h4WlIHQ5gzOvjQKo1QeWAdtjpfOdgI=;
 b=DwnPMGPJJyEGN3utzgZzrSQNih+59U0Paa7gPWD4CKPcvPSZIsHGx5gx8u9nxqLC2BTjJz
 66+EAEwizC3svC6TyNpMNpqZ7AH+HP27ci4ZSz1QZSskHXl2i0+lWCQvtvdFcbrE1H5/To
 dNPFGUzcNlFL0XzpDWU72+plEXfsNP8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-zIa0fyjVOS24nsfmZD6GhA-1; Thu, 03 Aug 2023 07:09:47 -0400
X-MC-Unique: zIa0fyjVOS24nsfmZD6GhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA1C3C10148;
 Thu,  3 Aug 2023 11:09:46 +0000 (UTC)
Received: from thuth.com (unknown [10.45.226.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12FD31121325;
 Thu,  3 Aug 2023 11:09:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 9/9] gitlab: disable FF_SCRIPT_SECTIONS on msys jobs
Date: Thu,  3 Aug 2023 13:09:32 +0200
Message-Id: <20230803110932.341091-10-thuth@redhat.com>
In-Reply-To: <20230803110932.341091-1-thuth@redhat.com>
References: <20230803110932.341091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The FF_SCRIPT_SECTIONS=1 variable should ordinarily cause output from
each line of the job script to be presented in a collapsible section
with execution time listed.

While it works on Linux shared runners, when used with Windows runners
with PowerShell, this option does not create any sections, and actually
causes echo'ing of commands to be disabled, making it even worse to
debug the jobs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230801130403.164060-9-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 552e3b751d..cd7622a761 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -12,6 +12,10 @@
   needs: []
   stage: build
   timeout: 80m
+  variables:
+    # This feature doesn't (currently) work with PowerShell, it stops
+    # the echo'ing of commands being run and doesn't show any timing
+    FF_SCRIPT_SECTIONS: 0
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
-- 
2.39.3



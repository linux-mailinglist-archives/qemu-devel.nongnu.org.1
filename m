Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE779D462
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4yC-0002qc-Mj; Tue, 12 Sep 2023 11:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg4y7-0002hi-IF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg4y1-0005FH-Sz
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694531177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x9ME1wS9F/tBKCl+xjMO9Ymv+/gB9CLakMW+nX1YGO0=;
 b=fJB4SfLvm1OvfSHgGkAk38/vVTE0CzAGtXmYN7vLFitQOiaw0mBpBOM5GMPTo/btJ3XI5l
 rjHB5kl+6fttPd/VHo4RyKOiUDktouO06dylcqgJ6yIw16vbg+Nj/sq7fvmIB3K8qJb2pC
 p4RwSiZuiv8KIjl0bkV8cKVoq4xWChI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-6JT75uI9OTyglb353DCHmQ-1; Tue, 12 Sep 2023 11:06:13 -0400
X-MC-Unique: 6JT75uI9OTyglb353DCHmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 555CE29DD9B6;
 Tue, 12 Sep 2023 15:06:13 +0000 (UTC)
Received: from localhost (unknown [10.39.193.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4FBE40C6EA8;
 Tue, 12 Sep 2023 15:06:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] gitlab: remove unreliable avocado CI jobs
Date: Tue, 12 Sep 2023 11:06:11 -0400
Message-ID: <20230912150611.70676-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The avocado-system-alpine, avocado-system-fedora, and
avocado-system-ubuntu jobs are unreliable. I identified them while
looking over CI failures from the past week:
https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
https://gitlab.com/qemu-project/qemu/-/jobs/5030428571

Thomas Huth suggest on IRC today that there may be a legitimate failure
in there:

  th_huth: f4bug, yes, seems like it does not start at all correctly on
  alpine anymore ... and it's broken since ~ 2 weeks already, so if nobody
  noticed this by now, this is worrying

It crept in because the jobs were already unreliable.

I don't know how to interpret the job output, so all I can do is to
propose removing these jobs. A useful CI job has two outcomes: pass or
fail. Timeouts and other in-between states are not useful because they
require constant triaging by someone who understands the details of the
tests and they can occur when run against pull requests that have
nothing to do with the area covered by the test.

Hopefully test owners will be able to identify the root causes and solve
them so that these jobs can stay. In their current state the jobs are
not useful since I cannot cannot tell whether job failures are real or
just intermittent when merging qemu.git pull requests.

If you are a test owner, please take a look.

It is likely that other avocado-system-* CI jobs have similar failures
from time to time, but I'll leave them as long as they are passing.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aee9101507..83ce448c4d 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -22,15 +22,6 @@ check-system-alpine:
     IMAGE: alpine
     MAKE_CHECK_ARGS: check-unit check-qtest
 
-avocado-system-alpine:
-  extends: .avocado_test_job_template
-  needs:
-    - job: build-system-alpine
-      artifacts: true
-  variables:
-    IMAGE: alpine
-    MAKE_CHECK_ARGS: check-avocado
-
 build-system-ubuntu:
   extends:
     - .native_build_job_template
@@ -53,15 +44,6 @@ check-system-ubuntu:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check
 
-avocado-system-ubuntu:
-  extends: .avocado_test_job_template
-  needs:
-    - job: build-system-ubuntu
-      artifacts: true
-  variables:
-    IMAGE: ubuntu2204
-    MAKE_CHECK_ARGS: check-avocado
-
 build-system-debian:
   extends:
     - .native_build_job_template
@@ -127,15 +109,6 @@ check-system-fedora:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-avocado-system-fedora:
-  extends: .avocado_test_job_template
-  needs:
-    - job: build-system-fedora
-      artifacts: true
-  variables:
-    IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado
-
 crash-test-fedora:
   extends: .native_test_job_template
   needs:
-- 
2.41.0



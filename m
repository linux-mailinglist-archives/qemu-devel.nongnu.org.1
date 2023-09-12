Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DF79D8D8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8Ke-0004Vx-0K; Tue, 12 Sep 2023 14:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg8KV-0004TM-Rw
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg8KT-0001Qd-F7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694544100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iSs2QBVfpISQpVZYsjcitJoFfqKja+Hxwecaxyub818=;
 b=b45+z+95Mszfj473T7Oz3+QzbDT1tgtrZWd/iGyCR/lbDSDOMaNw6nlRvdLbisclQGj6r5
 CweiPk96tR983LzgMtpbzhSn5Zrpi/ySgKMMR/i5UomsWriczgMU16BNskjo7RzcsTcxAR
 51FRBy9392G58R7XnrTmZ6RWO22N86A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-kTih-M9sNDKBb90aD0gAFg-1; Tue, 12 Sep 2023 14:41:39 -0400
X-MC-Unique: kTih-M9sNDKBb90aD0gAFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E40018945E5;
 Tue, 12 Sep 2023 18:41:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57C237B62;
 Tue, 12 Sep 2023 18:41:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] gitlab: make Cirrus CI timeout explicit
Date: Tue, 12 Sep 2023 19:41:29 +0100
Message-ID: <20230912184130.3056054-4-berrange@redhat.com>
In-Reply-To: <20230912184130.3056054-1-berrange@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On the GitLab side we're invoking the Cirrus CI job using the
cirrus-run tool which speaks to the Cirrus REST API. Cirrus
sometimes tasks 5-10 minutes to actually schedule the task,
and thus the execution time of 'cirrus-run' inside GitLab will
be slightly longer than the execution time of the Cirrus CI
task.

Setting the timeout in the GitLab CI job should thus be done
in relation to the timeout set for the Cirrus CI job. While
Cirrus CI defaults to 60 minutes, it is better to set this
explicitly, and make the relationship between the jobs
explicit

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus.yml       | 3 +++
 .gitlab-ci.d/cirrus/build.yml | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 41d64d6680..816d89cc2a 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -15,6 +15,9 @@
   stage: build
   image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master
   needs: []
+  # 20 mins larger than "timeout_in" in cirrus/build.yml
+  # as there's often a 5-10 minute delay before Cirrus CI
+  # actually starts the task
   timeout: 80m
   allow_failure: true
   script:
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index a9444902ec..29d55c4aa3 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -16,6 +16,8 @@ env:
   TEST_TARGETS: "@TEST_TARGETS@"
 
 build_task:
+  # A little shorter than GitLab timeout in ../cirrus.yml
+  timeout_in: 60m
   install_script:
     - @UPDATE_COMMAND@
     - @INSTALL_COMMAND@ @PKGS@
-- 
2.41.0



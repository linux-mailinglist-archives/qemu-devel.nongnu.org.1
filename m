Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF883FC8B
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 04:06:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHws-0004Cx-Af; Sun, 28 Jan 2024 22:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwp-00049Y-T6
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwo-0002cV-5R
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9E9ZiyB8lolyP1h8HTT4gHWB7P2p+lbkjksyMOxvG8=;
 b=S7oZenHb+iOT2j9rI11Jpr+RjKL8TJ0Be8RzfSFlh5DxbSp0ZLu2B690m9nBcBnxmQYCel
 oQ2I4WkmhE9Wz6k5VFOua0Dihh+o/GN9aCTPM4dmEG6XFQTcfPH+lDpHnGsb0u3arMPwAc
 yH81D7RqY9Z+UqKDoH+jTohylV16Qig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-5q5G6M94PzmVEF4qItCVuQ-1; Sun, 28 Jan 2024 22:04:31 -0500
X-MC-Unique: 5q5G6M94PzmVEF4qItCVuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80D8485A589;
 Mon, 29 Jan 2024 03:04:31 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C8521121306;
 Mon, 29 Jan 2024 03:04:28 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 06/14] ci: Add a migration compatibility test job
Date: Mon, 29 Jan 2024 11:03:57 +0800
Message-ID: <20240129030405.177100-7-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fabiano Rosas <farosas@suse.de>

The migration tests have support for being passed two QEMU binaries to
test migration compatibility.

Add a CI job that builds the lastest release of QEMU and another job
that uses that version plus an already present build of the current
version and run the migration tests with the two, both as source and
destination. I.e.:

 old QEMU (n-1) -> current QEMU (development tree)
 current QEMU (development tree) -> old QEMU (n-1)

The purpose of this CI job is to ensure the code we're about to merge
will not cause a migration compatibility problem when migrating the
next release (which will contain that code) to/from the previous
release.

The version of migration-test used will be the one matching the older
QEMU. That way we can avoid special-casing new tests that wouldn't be
compatible with the older QEMU.

Note: for user forks, the version tags need to be pushed to gitlab
otherwise it won't be able to checkout a different version.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240118164951.30350-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e1c7801598..f0b0edc634 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -167,6 +167,66 @@ build-system-centos:
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
 
+# Previous QEMU release. Used for cross-version migration tests.
+build-previous-qemu:
+  extends: .native_build_job_template
+  artifacts:
+    when: on_success
+    expire_in: 2 days
+    paths:
+      - build-previous
+    exclude:
+      - build-previous/**/*.p
+      - build-previous/**/*.a.p
+      - build-previous/**/*.fa.p
+      - build-previous/**/*.c.o
+      - build-previous/**/*.c.o.d
+      - build-previous/**/*.fa
+  needs:
+    job: amd64-opensuse-leap-container
+  variables:
+    IMAGE: opensuse-leap
+    TARGETS: x86_64-softmmu aarch64-softmmu
+  before_script:
+    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
+    - git checkout $QEMU_PREV_VERSION
+  after_script:
+    - mv build build-previous
+
+.migration-compat-common:
+  extends: .common_test_job_template
+  needs:
+    - job: build-previous-qemu
+    - job: build-system-opensuse
+  # The old QEMU could have bugs unrelated to migration that are
+  # already fixed in the current development branch, so this test
+  # might fail.
+  allow_failure: true
+  variables:
+    IMAGE: opensuse-leap
+    MAKE_CHECK_ARGS: check-build
+  script:
+    # Use the migration-tests from the older QEMU tree. This avoids
+    # testing an old QEMU against new features/tests that it is not
+    # compatible with.
+    - cd build-previous
+    # old to new
+    - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
+    # new to old
+    - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
+
+migration-compat-aarch64:
+  extends: .migration-compat-common
+  variables:
+    TARGET: aarch64
+
+migration-compat-x86_64:
+  extends: .migration-compat-common
+  variables:
+    TARGET: x86_64
+
 check-system-centos:
   extends: .native_test_job_template
   needs:
-- 
2.43.0



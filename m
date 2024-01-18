Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712D831DD7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVat-00037t-Vo; Thu, 18 Jan 2024 11:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQVam-00036E-Rj
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:50:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQVaj-0000To-H6
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:50:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3FE5521F04;
 Thu, 18 Jan 2024 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705596602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2JBt0/WlpCTdPl1eTsJA7poEMuw26v6B8Sz54F1+Gs=;
 b=I1uJrB44jj5+2JGfeewPuanwAplB7aVsThwZqU3xUaYCXICERIsxuy4jugwBCMyxre+3ta
 p2/vZSAOtNX1SukrWtrqG3vOABXZNOaPoou7yGNnDTMpEsdxXh0RKVIQm3Fi/oypqU4uEF
 +GYyQkIoAnr78d3/PQ1cWEdn00RVpao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705596602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2JBt0/WlpCTdPl1eTsJA7poEMuw26v6B8Sz54F1+Gs=;
 b=Ixl/Znju5EyfvdkueolFrD3kch8KatqtsdKP3Smyxse4A454XB/pmq0ZG9zYlfPvUe0udH
 WEiptfDrTeaquqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705596602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2JBt0/WlpCTdPl1eTsJA7poEMuw26v6B8Sz54F1+Gs=;
 b=I1uJrB44jj5+2JGfeewPuanwAplB7aVsThwZqU3xUaYCXICERIsxuy4jugwBCMyxre+3ta
 p2/vZSAOtNX1SukrWtrqG3vOABXZNOaPoou7yGNnDTMpEsdxXh0RKVIQm3Fi/oypqU4uEF
 +GYyQkIoAnr78d3/PQ1cWEdn00RVpao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705596602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2JBt0/WlpCTdPl1eTsJA7poEMuw26v6B8Sz54F1+Gs=;
 b=Ixl/Znju5EyfvdkueolFrD3kch8KatqtsdKP3Smyxse4A454XB/pmq0ZG9zYlfPvUe0udH
 WEiptfDrTeaquqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4266136F5;
 Thu, 18 Jan 2024 16:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eFAXKrdWqWUdSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jan 2024 16:49:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v4 2/3] ci: Add a migration compatibility test job
Date: Thu, 18 Jan 2024 13:49:50 -0300
Message-Id: <20240118164951.30350-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240118164951.30350-1-farosas@suse.de>
References: <20240118164951.30350-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
2.35.3



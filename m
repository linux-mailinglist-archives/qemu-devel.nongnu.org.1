Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 646CF824733
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:20:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRNL-00049n-1z; Thu, 04 Jan 2024 12:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLRNH-00048U-LG
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:19:20 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLRNF-0008ME-8x
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:19:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E7DA220C4;
 Thu,  4 Jan 2024 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704388753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXzhHM5Xsos+lZ8KeiisT11rEeM4li9bZ4VVFvCjCso=;
 b=iG5buSwWp6Fp7QGqkjidr8gHghu/KIBFpEeNSFoZpgg6dAC3cZCJhKAM63H2yas8yBaK/4
 9u2eNiDZdaY8v+zjkNK/E/2kJmI4Hynz5J1w39U1KO+QDzubrwVdUQtBqmzTv8D4+l5Z1a
 P94vLtEcPlDYDiAXlKZmQ9s7pFHNiH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704388753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXzhHM5Xsos+lZ8KeiisT11rEeM4li9bZ4VVFvCjCso=;
 b=szCprh7CB7f2wYkpr7unAVN6NFTJaPKkJ1FccUAT9+a6zsedljv44LE4yG8Cp6MRv3nF3G
 LmUtsXusfH6MHDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704388753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXzhHM5Xsos+lZ8KeiisT11rEeM4li9bZ4VVFvCjCso=;
 b=iG5buSwWp6Fp7QGqkjidr8gHghu/KIBFpEeNSFoZpgg6dAC3cZCJhKAM63H2yas8yBaK/4
 9u2eNiDZdaY8v+zjkNK/E/2kJmI4Hynz5J1w39U1KO+QDzubrwVdUQtBqmzTv8D4+l5Z1a
 P94vLtEcPlDYDiAXlKZmQ9s7pFHNiH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704388753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXzhHM5Xsos+lZ8KeiisT11rEeM4li9bZ4VVFvCjCso=;
 b=szCprh7CB7f2wYkpr7unAVN6NFTJaPKkJ1FccUAT9+a6zsedljv44LE4yG8Cp6MRv3nF3G
 LmUtsXusfH6MHDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2666413722;
 Thu,  4 Jan 2024 17:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WB2AN47olmUNbAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 17:19:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 4/4] ci: Add a migration compatibility test job
Date: Thu,  4 Jan 2024 14:18:57 -0300
Message-Id: <20240104171857.20108-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240104171857.20108-1-farosas@suse.de>
References: <20240104171857.20108-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.51
X-Rspamd-Queue-Id: 6E7DA220C4
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iG5buSwW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=szCprh7C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

I'm leaving the jobs as manual for now because using an older QEMU in
tests could hit bugs that were already fixed in the current
development tree and we need to handle those case-by-case.

Note: for user forks, the version tags need to be pushed to gitlab
otherwise it won't be able to checkout a different version.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91663946de..81163a3f6a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -167,6 +167,59 @@ build-system-centos:
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
 
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
+    QEMU_JOB_OPTIONAL: 1
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
+  allow_failure: true
+  variables:
+    QEMU_JOB_OPTIONAL: 1
+    IMAGE: opensuse-leap
+    MAKE_CHECK_ARGS: check-build
+  script:
+    - cd build
+    - QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
+    - QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
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



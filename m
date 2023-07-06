Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5874A4C9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:21:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVRv-0002PN-SH; Thu, 06 Jul 2023 16:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHVRu-0002PE-8N
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:19:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHVRs-0002Zn-Ke
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:19:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B1A722181;
 Thu,  6 Jul 2023 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688674771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RumLlNs+w1qS4o+NCwDx/mHZSkGsxPhQRzBYkTCKJLU=;
 b=izPByKgrZfPxKbqpc0xdD34pi6+nHUGaMPWSPkrwTCbOk5TF+X4u7xWE44ZtYhj4NxonAV
 nm6yWcyKvkzxZa6P8JNweVwdtpJQJr6EfYItUW+ZQgdfhEkxh6c38AU5H/kZKK1gZUFsZb
 Yl+0CkHqhCTLiOR+pQ8aKEOXtBBOIaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688674771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RumLlNs+w1qS4o+NCwDx/mHZSkGsxPhQRzBYkTCKJLU=;
 b=eluyXpb3HdKgh7erfJYWB2g3OPWj/tpmpMNi48Q+NjSTqjvpp+C2QA5eSROq7OxrvEYS28
 JfnbQLDMWxFV3PCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2FFE138EE;
 Thu,  6 Jul 2023 20:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G2KmJtEhp2S8GAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 20:19:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 0/6] migration: Test the new "file:" migration
Date: Thu,  6 Jul 2023 17:19:21 -0300
Message-Id: <20230706201927.15442-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Based-on:
[PATCH V4 0/2] migration file URI
https://lore.kernel.org/r/1688135108-316997-1-git-send-email-steven.sistare@oracle.com

Since v3:

- used FILE_TEST_FILENAME for the three tests

v3:
https://lore.kernel.org/r/20230630212902.19925-1-farosas@suse.de

v2:
https://lore.kernel.org/r/20230628165542.17214-1-farosas@suse.de

v1:
https://lore.kernel.org/r/20230626182210.8792-1-farosas@suse.de

Here's the test for the file: migration.

I hit an issue with the setting of migration status. If we call
query-migrate too soon after migrate-incoming, the query returns an
empty response because we're not setting the MIGRATION_STATUS_SETUP in
the incoming path. We just send the event, but never actually change
state.

Aside from the fix, there's some tidying up to avoid duplicating too
much code in the tests.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/912226554

Fabiano Rosas (6):
  tests/qtest: migration: Expose migrate_set_capability
  tests/qtest: migration: Add migrate_incoming_qmp helper
  tests/qtest: migration: Use migrate_incoming_qmp where appropriate
  migration: Set migration status early in incoming side
  tests/qtest: migration: Add support for negative testing of
    qmp_migrate
  tests/qtest: migration-test: Add tests for file-based migration

 migration/migration.c             |   7 +-
 tests/qtest/libqtest.c            |  33 +++++++
 tests/qtest/libqtest.h            |  28 ++++++
 tests/qtest/meson.build           |   1 +
 tests/qtest/migration-helpers.c   |  60 +++++++++++++
 tests/qtest/migration-helpers.h   |  10 +++
 tests/qtest/migration-test.c      | 138 +++++++++++++++++++++++++-----
 tests/qtest/virtio-net-failover.c |  77 ++---------------
 8 files changed, 261 insertions(+), 93 deletions(-)

-- 
2.35.3



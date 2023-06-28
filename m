Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A456C7416D6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYSr-0003Ue-Ln; Wed, 28 Jun 2023 12:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEYSO-0003RN-5j
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:55:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qEYSJ-0001lo-RZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:55:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 458251F8D6;
 Wed, 28 Jun 2023 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687971346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NZ3ZXC6sOMRtwElUR8qo5Lx5p67f+dpCH637YMTlFSI=;
 b=BMYGKwDJDCfo2FT/0nbtfLAgBoVSgjqKdQN+U4MWwLlBT9XwhCwqSjiWS2ML5gsEUB4a7n
 Zc8N8ooon/39eMNKtayNwHBkRnmqJs03JCeOQewvgYNuGQ31fahi5U+l44kssYvzRZaHad
 kfGoELRlMNNyvarHPOY/NWLLaEVU26U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687971346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NZ3ZXC6sOMRtwElUR8qo5Lx5p67f+dpCH637YMTlFSI=;
 b=NAg/hIxBjd5V5cWzWCInNtYx+jTP8pz7AjTBGZ8mLHqsucD5ZDGggiIV9az1ErKsysgMwA
 Ms/zsPUZZKN8fkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABCAA138EF;
 Wed, 28 Jun 2023 16:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PWgHHRBmnGRIZwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 28 Jun 2023 16:55:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] migration: Test the new "file:" migration
Date: Wed, 28 Jun 2023 13:55:36 -0300
Message-Id: <20230628165542.17214-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
[PATCH V3 0/2] migration file URI
https://lore.kernel.org/r/1687466251-310524-1-git-send-email-steven.sistare@oracle.com

Since v1:

- added the force-emit-setup-event property
- added verification that the skipped region is empty

CI run: https://gitlab.com/farosas/qemu/-/pipelines/914915941

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
  migration: Set migration status early in incoming side
  tests/qtest: migration: Expose migrate_set_capability
  tests/qtest: migration: Add migrate_incoming_qmp helper
  tests/qtest: migration: Use migrate_incoming_qmp where appropriate
  tests/qtest: migration: Add support for negative testing of
    qmp_migrate
  tests/qtest: migration-test: Add tests for file-based migration

 migration/migration.c             |  17 +++-
 migration/migration.h             |  11 +++
 migration/options.c               |  13 +++
 migration/options.h               |   1 +
 tests/qtest/libqtest.c            |  33 +++++++
 tests/qtest/libqtest.h            |  28 ++++++
 tests/qtest/meson.build           |   1 +
 tests/qtest/migration-helpers.c   |  61 +++++++++++++
 tests/qtest/migration-helpers.h   |  11 +++
 tests/qtest/migration-test.c      | 144 +++++++++++++++++++++++++-----
 tests/qtest/virtio-net-failover.c |  77 ++--------------
 11 files changed, 304 insertions(+), 93 deletions(-)

-- 
2.35.3



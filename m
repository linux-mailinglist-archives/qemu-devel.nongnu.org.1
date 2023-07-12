Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5B7510FB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfBu-0007hr-7o; Wed, 12 Jul 2023 15:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBl-0007ev-Id
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:07:49 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBj-000844-Ut
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:07:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B5F201FDCE;
 Wed, 12 Jul 2023 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689188866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zYpz9UKxw9jpDu/vQZSJPuLbp+myNx5U+LgN+Z/C4Gk=;
 b=yfHpF5u7Hl/w+gHRyN9lOtAVFmXO/d0/H+oyMRzw9BwDfZVHh9d5Dk3IaHkTbWzIineWbl
 ZQSG8Cf+01puqmUChBCmJdYr7SLFCnSNQ/RjOUY6/tYJFo93mGNd8xYQv9U3v6f6upSSt0
 V0zHscFQ5C+X0oou/zF+ewUond5YAZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689188866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zYpz9UKxw9jpDu/vQZSJPuLbp+myNx5U+LgN+Z/C4Gk=;
 b=dXkSxnJOKdI1E4tneFmZlDXd4ZL7tBUan4Easx6uTOkmLIC84qE4+Sae9P3daTA+8Brswf
 QiOmVyxkO9Tt5EBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30AD413336;
 Wed, 12 Jul 2023 19:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hO4POgD6rmROOgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 12 Jul 2023 19:07:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 0/6] migration: Test the new "file:" migration
Date: Wed, 12 Jul 2023 16:07:36 -0300
Message-Id: <20230712190742.22294-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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
[PATCH V4 0/2] migration file URI
https://lore.kernel.org/r/1688135108-316997-1-git-send-email-steven.sistare@oracle.com

Since v4:

- Implemented a separate version of test_precopy_common to be used
  with the file transport (patch 6).

v4:
https://lore.kernel.org/r/20230706201927.15442-1-farosas@suse.de

v3:
https://lore.kernel.org/r/20230630212902.19925-1-farosas@suse.de

v2:
https://lore.kernel.org/r/20230628165542.17214-1-farosas@suse.de

v1:
https://lore.kernel.org/r/20230626182210.8792-1-farosas@suse.de

Fabiano Rosas (6):
  tests/qtest: migration: Expose migrate_set_capability
  tests/qtest: migration: Add migrate_incoming_qmp helper
  tests/qtest: migration: Use migrate_incoming_qmp where appropriate
  migration: Set migration status early in incoming side
  tests/qtest: migration: Add support for negative testing of
    qmp_migrate
  tests/qtest: migration-test: Add tests for file-based migration

 migration/migration.c             |   7 +-
 tests/qtest/libqtest.c            |  33 ++++++
 tests/qtest/libqtest.h            |  28 +++++
 tests/qtest/meson.build           |   1 +
 tests/qtest/migration-helpers.c   |  60 ++++++++++
 tests/qtest/migration-helpers.h   |  10 ++
 tests/qtest/migration-test.c      | 185 ++++++++++++++++++++++++++----
 tests/qtest/virtio-net-failover.c |  77 ++-----------
 8 files changed, 308 insertions(+), 93 deletions(-)

-- 
2.35.3



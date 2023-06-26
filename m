Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105073E836
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:23:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDqr7-0000gF-18; Mon, 26 Jun 2023 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qDqqw-0000f0-R7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 14:22:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qDqqv-0006Cb-1J
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 14:22:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 461631F8AC;
 Mon, 26 Jun 2023 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687803734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IMOquzWhfMOBmjjxvhYgyDPUfKmAU6Xbl9TMTjjj7G4=;
 b=lLFQOk2/AHfUxxouskPwJHnj6OHO699bzKuRBMmxCnq/E8sSg4ArwbIBi6IcPfZFVILMaq
 /iqrgq/3VXBNrArd7CwQRSjmACX1ohqjx0UxRX61D1MzzrKhw2PjugiThgFP9VD10F4hF1
 b8OjKDqoRjO7gxZz85rHqQJMaWHXDJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687803734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IMOquzWhfMOBmjjxvhYgyDPUfKmAU6Xbl9TMTjjj7G4=;
 b=N/LaOJVe/yEv27Cj1/c87eHUO1kHd/aVfY0xFxu55K6wvmrxmT2HdZqw6Z4jIDjvAe6uOh
 t/zgPWx3FTcr8oDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2E1F13483;
 Mon, 26 Jun 2023 18:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /WmfHlTXmWTBcgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 26 Jun 2023 18:22:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] migration: Test the new "file:" migration
Date: Mon, 26 Jun 2023 15:22:04 -0300
Message-Id: <20230626182210.8792-1-farosas@suse.de>
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

Fabiano Rosas (5):
  migration: Set migration status early in incoming side
  tests/qtest: migration: Expose migrate_set_capability
  tests/qtest: migration: Add migrate_incoming_qmp helper
  tests/qtest: migration: Use migrate_incoming_qmp where appropriate
  tests/qtest: migration: Add support for negative testing of
    qmp_migrate

Nikolay Borisov (1):
  tests/qtest: migration-test: Add tests for file-based migration

 migration/migration.c             |  17 ++++-
 tests/qtest/libqtest.c            |  33 ++++++++++
 tests/qtest/libqtest.h            |  28 ++++++++
 tests/qtest/meson.build           |   1 +
 tests/qtest/migration-helpers.c   |  61 +++++++++++++++++
 tests/qtest/migration-helpers.h   |  11 ++++
 tests/qtest/migration-test.c      | 106 +++++++++++++++++++++++-------
 tests/qtest/virtio-net-failover.c |  77 +++-------------------
 8 files changed, 241 insertions(+), 93 deletions(-)

-- 
2.35.3



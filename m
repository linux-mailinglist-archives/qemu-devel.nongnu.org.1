Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4BAACBE38
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 03:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbe-0006PF-5u; Mon, 02 Jun 2025 21:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbb-0006Ot-03
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:19 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbZ-0001PH-7U
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 068B3218E7;
 Tue,  3 Jun 2025 01:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4XSAI2nYNWvVcLgkYck9f27/OA84YmqiEwgOJQa+e/k=;
 b=hYakX0AMIp1RC6mTNQ5Wtf0PvIrI1SxhVs6bG/Eu8wPrNz38BPRXXZCoFu1Ta7+9UHmTt2
 sw7pEPGjEpeoGlEUDJb67Kwr12leiPxU6U8CSkFz+Uk8xQEEBXE2q1RjBHFOJ5yqa2cJZ0
 PTjI9hoMfMlgb8q3JZnzcngqKFGHYqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4XSAI2nYNWvVcLgkYck9f27/OA84YmqiEwgOJQa+e/k=;
 b=MagC4yF2a6OEK5FYeRZaRyGv7NL1tU5tQsDaTOj3BXpLO13XSrLi53xs8zvfZRSNPC8JkR
 mU3uTOa7uybfseBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4XSAI2nYNWvVcLgkYck9f27/OA84YmqiEwgOJQa+e/k=;
 b=hYakX0AMIp1RC6mTNQ5Wtf0PvIrI1SxhVs6bG/Eu8wPrNz38BPRXXZCoFu1Ta7+9UHmTt2
 sw7pEPGjEpeoGlEUDJb67Kwr12leiPxU6U8CSkFz+Uk8xQEEBXE2q1RjBHFOJ5yqa2cJZ0
 PTjI9hoMfMlgb8q3JZnzcngqKFGHYqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4XSAI2nYNWvVcLgkYck9f27/OA84YmqiEwgOJQa+e/k=;
 b=MagC4yF2a6OEK5FYeRZaRyGv7NL1tU5tQsDaTOj3BXpLO13XSrLi53xs8zvfZRSNPC8JkR
 mU3uTOa7uybfseBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72ABD13700;
 Tue,  3 Jun 2025 01:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rDuvDAVSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/21] migration: Unify capabilities and parameters
Date: Mon,  2 Jun 2025 22:37:49 -0300
Message-Id: <20250603013810.4772-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Thanks for the reviews in the last round. Your feedback has allowed me
to reduce the complexity of the series and the code considerably.

Changes in this v2:

- Followed the suggestion to unify the TLS strings as StrOrNull. This
  allows the complete removal of the MigrateSetParameters
  type. Therefore, no need for playing tricks with base types.

- I figured out that block_bitmap_mapping was set as optional in
  qmp_query_migrate_parameters in error. Fixing that allows to
  simplify that function somewhat.

- The suggestion of not checking the has_* fields when setting the
  parameters also led to great simplification. Now there's no need to
  open-code the setting of every single parameter.

- Deprecated the capabilities commands.

- Removed some redundant documentation from migration.json. Now
  there's only 1 (one) place where migration parameters need to be
  documented.

The series:
- passes CI: https://gitlab.com/farosas/qemu/-/pipelines/1849885920
- passes the migration tests in the ASAN build.
- passes the migration compat tests against each of the 3 last QEMU versions.
- passes the iotest 300 (related to block_bitmap_mapping).

v1:
https://lore.kernel.org/r/20250411191443.22565-1-farosas@suse.de

Fabiano Rosas (21):
  migration: Normalize tls arguments
  migration: Remove MigrateSetParameters
  qapi/migration: Don't document MigrationParameter
  migration: Run a post update routine after setting parameters
  migration: Add a flag to track block-bitmap-mapping input
  migration: Remove checks for s->parameters has_* fields
  migration: Set block_bitmap_mapping unconditionally in
    query-migrate-parameters
  migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE
  migration: Extract code to mark all parameters as present
  migration: Use QAPI_CLONE_MEMBERS in query_migrate_parameters
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  migration: Use visitors in migrate_params_test_apply
  migration: Cleanup hmp_info_migrate_parameters
  migration: Add capabilities into MigrationParameters
  qapi/migration: Mark that query/set-migrate-parameters support
    capabilities
  migration: Remove s->capabilities
  qapi/migration: Deprecate capabilities commands
  migration: Allow migrate commands to provide the migration config
  libqtest: Add a function to check whether a QMP command supports a
    feature
  tests/qtest/migration: Add a test for config passing

 docs/about/deprecated.rst          |   12 +
 migration/migration-hmp-cmds.c     |  484 ++++++++----
 migration/migration.c              |   50 +-
 migration/migration.h              |    9 +-
 migration/options.c                | 1090 +++++++++++++---------------
 migration/options.h                |   29 +-
 migration/page_cache.c             |    6 +-
 migration/ram.c                    |    5 +-
 migration/savevm.c                 |    8 +-
 migration/tls.c                    |    2 +-
 qapi/migration.json                |  573 ++++++---------
 qapi/pragma.json                   |    3 +-
 system/vl.c                        |    3 +-
 tests/qtest/libqtest.c             |   42 ++
 tests/qtest/libqtest.h             |   12 +
 tests/qtest/migration/framework.h  |    2 +
 tests/qtest/migration/misc-tests.c |   39 +
 17 files changed, 1243 insertions(+), 1126 deletions(-)

-- 
2.35.3



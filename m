Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B0AEE7D7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Jun 2025 22:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKf9-0002WU-6S; Mon, 30 Jun 2025 15:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKf0-0002W3-Dd
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:26 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKey-0007S6-HE
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3E81F388;
 Mon, 30 Jun 2025 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sj/A8epu8nMZbsb3NzBG0GAVw9jdoDcGAdjIuu/8Tss=;
 b=ZlWqMC1LJtqvx81w+/cGBZqPWk2FKy90BlP/K9HMrRJyqypdno48YBMhyIv40DzbkH6Oew
 rhe2lODybQ+OEwyHSn4DXw+xENjGEnW6mUbuB41u/25YUEg2mgTBeAEAnDBcDWZ6zg0fZo
 wn7B1/GsDESY5PmQPdZCC22mui3MaV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sj/A8epu8nMZbsb3NzBG0GAVw9jdoDcGAdjIuu/8Tss=;
 b=8FHps/mg/jeSY6p9JlPCL8xyk0FrYtaD35BcEgxF/fklvSm6L4964betzevm1xLL3+RcFQ
 nlKoK0OSBVkWgcCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sj/A8epu8nMZbsb3NzBG0GAVw9jdoDcGAdjIuu/8Tss=;
 b=ZlWqMC1LJtqvx81w+/cGBZqPWk2FKy90BlP/K9HMrRJyqypdno48YBMhyIv40DzbkH6Oew
 rhe2lODybQ+OEwyHSn4DXw+xENjGEnW6mUbuB41u/25YUEg2mgTBeAEAnDBcDWZ6zg0fZo
 wn7B1/GsDESY5PmQPdZCC22mui3MaV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sj/A8epu8nMZbsb3NzBG0GAVw9jdoDcGAdjIuu/8Tss=;
 b=8FHps/mg/jeSY6p9JlPCL8xyk0FrYtaD35BcEgxF/fklvSm6L4964betzevm1xLL3+RcFQ
 nlKoK0OSBVkWgcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 881481399F;
 Mon, 30 Jun 2025 19:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Nj2EZTsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 00/24] migration: Unify capabilities and parameters
Date: Mon, 30 Jun 2025 16:58:49 -0300
Message-Id: <20250630195913.28033-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Merge migration capabilities and parameters in MigrationState and
deprecate migration capabilities QMP commands.

v2:

- TLS options:
  - Normalize to "abc"|"" during parameter handling.
  - Normalize to "abc"|NULL when exposing to rest of migration
    code.

- Reverted block_bitmap_mapping to truly optional in
  query-migrate-parameters. It's an API break to make it
  non-optional. Fortunately it doesn't get in the way of the rest of
  the series.

- Haven't made s->parameters a pointer. It breaks qdev properties,
  which need to use offsetof.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1898505234

v1:
https://lore.kernel.org/r/20250603013810.4772-1-farosas@suse.de

RFC:
https://lore.kernel.org/r/20250411191443.22565-1-farosas@suse.de

Fabiano Rosas (24):
  migration: Fix leak of block_bitmap_mapping
  migration: Add a qdev property for StrOrNull
  migration: Normalize tls arguments
  migration: Remove MigrateSetParameters
  qapi/migration: Don't document MigrationParameter
  migration: Run a post update routine after setting parameters
  migration: Add a flag to track block-bitmap-mapping input
  migration: Remove checks for s->parameters has_* fields
  migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE
  migration: Extract code to mark all parameters as present
  migration: Use QAPI_CLONE_MEMBERS in query_migrate_parameters
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  migration: Use visitors in migrate_params_test_apply
  migration: Cleanup hmp_info_migrate_parameters
  migration: Add capabilities into MigrationParameters
  migration: Remove s->capabilities
  qapi/migration: Deprecate capabilities commands
  migration: Store the initial values used for s->parameters
  migration: Allow migrate commands to provide the migration config
  tests/qtest/migration: Take reference when passing %p to qtest_qmp
  tests/qtest/migration: Adapt the capabilities helper to take a config
  tests/qtest/migration: Adapt convergence routines to config
  tests/qtest/migration: Pass the migration config to file tests

 docs/about/deprecated.rst             |   12 +
 migration/migration-hmp-cmds.c        |  490 ++++++++---
 migration/migration.c                 |   49 +-
 migration/migration.h                 |   14 +-
 migration/options.c                   | 1154 ++++++++++++-------------
 migration/options.h                   |   30 +-
 migration/page_cache.c                |    6 +-
 migration/ram.c                       |    5 +-
 migration/savevm.c                    |    8 +-
 migration/tls.c                       |    2 +-
 qapi/migration.json                   |  558 ++++--------
 qapi/pragma.json                      |    1 +
 system/vl.c                           |    3 +-
 tests/qtest/migration/file-tests.c    |   68 +-
 tests/qtest/migration/framework.c     |   50 +-
 tests/qtest/migration/framework.h     |    1 +
 tests/qtest/migration/migration-qmp.c |   30 +-
 tests/qtest/migration/migration-qmp.h |    4 +-
 tests/qtest/migration/misc-tests.c    |    4 +-
 tests/qtest/migration/precopy-tests.c |   23 +-
 20 files changed, 1315 insertions(+), 1197 deletions(-)

-- 
2.35.3



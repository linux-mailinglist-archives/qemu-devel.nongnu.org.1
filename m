Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EE823B6B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFP9-0000AA-9s; Wed, 03 Jan 2024 23:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFP7-00009x-7k
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFP5-0006Wq-C5
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3STyDinUTvGIEQvgFrC+VOyUJUv9ABeLdR89aNy1zYs=;
 b=FqiFLEgOJRP9RbXGt1nEZswAJHFD75DTrg+PbVqYNei+WBy9Vm5t9mKb61ZxU8czWccR/t
 tjfJ7cBo+qmLkbR3PofAklVHOZdYJ8pYW9WuWYyUdqnjPH1gYLdIai++AywHLkSO1P8et/
 ucWAiV6tUwXGig/EqdsUz/NmMwfMi80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-_ofupzBSMgmIrGSPthkGog-1; Wed, 03 Jan 2024 23:32:20 -0500
X-MC-Unique: _ofupzBSMgmIrGSPthkGog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED5CA836F88;
 Thu,  4 Jan 2024 04:32:19 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87EEFC15A0C;
 Thu,  4 Jan 2024 04:32:15 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 00/26] Migration 20240104 patches
Date: Thu,  4 Jan 2024 12:31:45 +0800
Message-ID: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit 7425b6277f12e82952cede1f531bfc689bf77fb1:

  Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-12-27 05:15:32 -0500)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240104-pull-request

for you to fetch changes up to b12635ff08ab2e5a6a955c6866ef4525fb3deb5d:

  migration: fix coverity migrate_mode finding (2024-01-04 09:52:42 +0800)

----------------------------------------------------------------
migration 1st pull for 9.0

- We lost Juan and Leo in the maintainers file
- Steven's suspend state fix
- Steven's fix for coverity on migrate_mode
- Avihai's migration cleanup series

----------------------------------------------------------------

Avihai Horon (11):
  migration: Remove migrate_max_downtime() declaration
  migration: Remove nulling of hostname in migrate_init()
  migration: Refactor migration_incoming_setup()
  migration: Remove errp parameter in migration_fd_process_incoming()
  migration/multifd: Fix error message in multifd_recv_initial_packet()
  migration/multifd: Simplify multifd_channel_connect() if else
    statement
  migration/multifd: Fix leaking of Error in TLS error flow
  migration/multifd: Remove error_setg() in
    migration_ioc_process_incoming()
  migration: Fix migration_channel_read_peek() error path
  migration: Remove unnecessary usage of local Error
  migration/multifd: Remove unnecessary usage of local Error

Juan Quintela (1):
  MAINTAINERS: Leaving Migration

Leonardo Bras (1):
  MAINTAINERS: Remove myself as reviewer from Live Migration

Steve Sistare (13):
  cpus: vm_was_suspended
  cpus: stop vm in suspended runstate
  cpus: check running not RUN_STATE_RUNNING
  cpus: vm_resume
  migration: propagate suspended runstate
  migration: preserve suspended runstate
  migration: preserve suspended for snapshot
  migration: preserve suspended for bg_migration
  tests/qtest: migration events
  tests/qtest: option to suspend during migration
  tests/qtest: precopy migration with suspend
  tests/qtest: postcopy migration with suspend
  migration: fix coverity migrate_mode finding

 MAINTAINERS                          |   5 -
 qapi/misc.json                       |  11 +-
 qapi/run-state.json                  |   6 +-
 include/migration/snapshot.h         |   7 ++
 include/sysemu/runstate.h            |  20 +++
 migration/migration.h                |   4 +-
 tests/migration/i386/a-b-bootblock.h |  26 ++--
 tests/qtest/migration-helpers.h      |  11 +-
 backends/tpm/tpm_emulator.c          |   2 +-
 hw/usb/hcd-ehci.c                    |   2 +-
 hw/usb/redirect.c                    |   2 +-
 hw/xen/xen-hvm-common.c              |   2 +-
 migration/channel.c                  |   9 +-
 migration/global_state.c             |  47 ++++---
 migration/migration-hmp-cmds.c       |   8 +-
 migration/migration.c                |  42 ++-----
 migration/multifd.c                  |  27 ++--
 migration/options.c                  |   4 +-
 migration/rdma.c                     |   6 +-
 migration/savevm.c                   |  23 ++--
 system/cpus.c                        |  47 +++++--
 system/runstate.c                    |   9 ++
 system/vl.c                          |   2 +
 tests/qtest/migration-helpers.c      |  25 ++--
 tests/qtest/migration-test.c         | 181 +++++++++++++++++++--------
 .mailmap                             |   1 +
 tests/migration/i386/Makefile        |   5 +-
 tests/migration/i386/a-b-bootblock.S |  50 +++++++-
 28 files changed, 385 insertions(+), 199 deletions(-)

-- 
2.41.0



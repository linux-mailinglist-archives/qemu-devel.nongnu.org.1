Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2817CBD7D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfTp-0004n3-94; Tue, 17 Oct 2023 04:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfT3-0004g0-MI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfSw-00054k-OL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Eud8ZUD2wrzUAmLgJxcIBCox2p+Ub2tuvOrSg2EFMRg=;
 b=JrxqG2tphWCXEnqg2TM00+zYGbjQFKa8kA6Xt014jPybKGfb7R9VnZnI3AcCiMOgpKDGI7
 UW0xH942UKMqUaVxzUy+sKR43xGuaT7gkFUvaWAm4NjA9vrkB3p9ccSitAEBCWFcP2sU3H
 ywmCPVOLOsKJdBisBij4ksjZLOZcogU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-iYzSfjOTODaS6GzqJqngdQ-1; Tue, 17 Oct 2023 04:30:08 -0400
X-MC-Unique: iYzSfjOTODaS6GzqJqngdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFE9E38116F5;
 Tue, 17 Oct 2023 08:30:07 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6800B1C060AE;
 Tue, 17 Oct 2023 08:30:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 00/38] Migration 20231017 patches
Date: Tue, 17 Oct 2023 10:29:25 +0200
Message-ID: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 800485762e6564e04e2ab315132d477069562d91:

  Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into staging (2023-10-16 12:37:48 -0400)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231017-pull-request

for you to fetch changes up to 967e3889874b1116090a60c0cb43157130bdbd16:

  migration/multifd: Clarify Error usage in multifd_channel_connect (2023-10-17 09:25:14 +0200)

----------------------------------------------------------------
Migration Pull request (20231017)

Hi

Same that yesterday one, except:
- rebased to latest (clean rebase)
- fixed 64 bits read on big endian host

CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1039214198

Please, apply.

----------------------------------------------------------------

Dmitry Frolov (1):
  migration: fix RAMBlock add NULL check

Elena Ufimtseva (3):
  migration: check for rate_limit_max for RATE_LIMIT_DISABLED
  multifd: fix counters in multifd_send_thread
  multifd: reset next_packet_len after sending pages

Fabiano Rosas (13):
  migration: Fix analyze-migration.py 'configuration' parsing
  migration: Add capability parsing to analyze-migration.py
  migration: Fix analyze-migration.py when ignore-shared is used
  migration: Fix analyze-migration read operation signedness
  tests/qtest/migration: Add a test for the analyze-migration script
  tests/qtest: migration-test: Add tests for file-based migration
  migration/ram: Remove RAMState from xbzrle_cache_zero_page
  migration/ram: Stop passing QEMUFile around in save_zero_page
  migration/ram: Move xbzrle zero page handling into save_zero_page
  migration/ram: Merge save_zero_page functions
  migration/multifd: Remove direct "socket" references
  migration/multifd: Unify multifd_send_thread error paths
  migration/multifd: Clarify Error usage in multifd_channel_connect

Fiona Ebner (1):
  migration: hold the BQL during setup

Juan Quintela (15):
  migration: Non multifd migration don't care about multifd flushes
  migration: Create migrate_rdma()
  migration/rdma: Unfold ram_control_before_iterate()
  migration/rdma: Unfold ram_control_after_iterate()
  migration/rdma: Remove all uses of RAM_CONTROL_HOOK
  migration/rdma: Unfold hook_ram_load()
  migration/rdma: Create rdma_control_save_page()
  qemu-file: Remove QEMUFileHooks
  migration/rdma: Move rdma constants from qemu-file.h to rdma.h
  migration/rdma: Remove qemu_ prefix from exported functions
  migration/rdma: Check sooner if we are in postcopy for save_page()
  migration/rdma: Use i as for index instead of idx
  migration/rdma: Declare for index variables local
  migration/rdma: Remove all "ret" variables that are used only once
  migration: Improve json and formatting

Nikolay Borisov (2):
  migration: Add the configuration vmstate to the json writer
  migration/ram: Refactor precopy ram loading code

Peter Xu (1):
  migration: Allow user to specify available switchover bandwidth

Philippe Mathieu-Daudé (1):
  migration: Use g_autofree to simplify ram_dirty_bitmap_reload()

Wei Wang (1):
  migration: refactor migration_completion

 qapi/migration.json            |  41 ++++-
 include/migration/register.h   |   2 +-
 migration/migration.h          |   4 +-
 migration/options.h            |   2 +
 migration/qemu-file.h          |  49 ------
 migration/rdma.h               |  42 +++++
 migration/block-dirty-bitmap.c |   3 -
 migration/block.c              |   5 -
 migration/migration-hmp-cmds.c |  14 ++
 migration/migration-stats.c    |   9 +-
 migration/migration.c          | 199 +++++++++++++--------
 migration/multifd.c            | 101 +++++------
 migration/options.c            |  35 ++++
 migration/qemu-file.c          |  61 +------
 migration/ram.c                | 306 ++++++++++++++++++---------------
 migration/rdma.c               | 259 ++++++++++++----------------
 migration/savevm.c             |  22 ++-
 tests/qtest/migration-test.c   | 207 ++++++++++++++++++++++
 migration/trace-events         |  33 ++--
 scripts/analyze-migration.py   |  67 +++++++-
 tests/qtest/meson.build        |   2 +
 21 files changed, 895 insertions(+), 568 deletions(-)

-- 
2.41.0



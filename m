Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0C7CA4CC
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKVf-0001Qe-Pt; Mon, 16 Oct 2023 06:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVR-0001NG-O9
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVP-0007Q0-M4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KisSM/xCxP/NZ4mj6+1kynwnDu1jXhao9Kk4dI4g8U4=;
 b=cf9OYqLDvfjJRVqInjQC0uDhIPPfyHaGfcmqNrDVd3D/gXaLgMlwbYn9XRtbHFRCuJqowZ
 sJrBbUFd0sI/+m6iKpG6TJm1ZZTOZWYQ7ay+fAZaVKJTqWnRPiIW6mMn+lIzYZz4H7TPIC
 u+qKOeAlLlbxApyG7au/KWlCg+ZDxHo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-TxYwKiRoNxa0i3JOyPhsVw-1; Mon, 16 Oct 2023 06:07:11 -0400
X-MC-Unique: TxYwKiRoNxa0i3JOyPhsVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 291AA3C1F124;
 Mon, 16 Oct 2023 10:07:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F8AC63F48;
 Mon, 16 Oct 2023 10:07:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 00/38] Migration 20231016 patches
Date: Mon, 16 Oct 2023 12:06:28 +0200
Message-ID: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 63011373ad22c794a013da69663c03f1297a5c56:

  Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alistair23/qemu into staging (2023-10-12 10:24:44 -0400)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231016-pull-request

for you to fetch changes up to f39b0f42753635b0f2d8b00a26d11bb197bf51e2:

  migration/multifd: Clarify Error usage in multifd_channel_connect (2023-10-16 11:01:33 +0200)

----------------------------------------------------------------
Migration Pull request (20231016)

In this pull request:
- rdma cleanups
- removal of QEMUFileHook
- test for analyze-migration.py
- test for multifd file
- multifd cleanups
- available switchover bandwidth
- lots of cleanups.

CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1037878829

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



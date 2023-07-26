Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCB76360B
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:16:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdQU-0006IV-S5; Wed, 26 Jul 2023 08:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQ4-0006Hz-R7
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQ2-00040F-Pz
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690373705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zOGwEVRfK1CgfPXTWPl79vEamwam6+pArT1iGtb4PjA=;
 b=X+ZVHx5ZRo9YC7xLtYbZD7vrBupCHvjQfj+LatXA0ytzeYupWstfSATRaXpnNqo/gltEqK
 0hXPI2dgqP1oy/46+cWV3LDi3+nUuWHvmiKjkuNDiXFBScQMj48QtR8MYDYDAiWnVkF66k
 n6dWoZbk1XuZwEGXBMiXik4iNzdDWqk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-Ij_m-T-yMS6XeShU8o5-xA-1; Wed, 26 Jul 2023 08:15:04 -0400
X-MC-Unique: Ij_m-T-yMS6XeShU8o5-xA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7B042A59561
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 12:15:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3A2240C2063;
 Wed, 26 Jul 2023 12:15:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 00/25] Migration 20230726 patches
Date: Wed, 26 Jul 2023 14:14:34 +0200
Message-Id: <20230726121459.1837-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 6cb2011fedf8c4e7b66b4a3abd6b42c1bae99ce6:

  Update version for v8.1.0-rc1 release (2023-07-25 20:09:05 +0100)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20230726-pull-request

for you to fetch changes up to 697c4c86ab515a728ffb2adc2c3c04b22fa9210f:

  migration/rdma: Split qemu_fopen_rdma() into input/output functions (2023-07-26 10:55:56 +0200)

----------------------------------------------------------------
Migration Pull request

Hi

This is the migration PULL request.  It is the same than yesterday with proper PULL headers.
It pass CI. It contains:
- Fabiano rosas trheadinfo cleanups
- Hyman Huang dirtylimit changes
- Part of my changes
- Peter Xu documentation
- Tejus updato to migration descriptions
- Wei want improvements for postocpy and multifd setup

Please apply.

Thanks, Juan.

----------------------------------------------------------------

Fabiano Rosas (2):
  migration/multifd: Rename threadinfo.c functions
  migration/multifd: Protect accesses to migration_threads

Hyman Huang(黄勇) (8):
  softmmu/dirtylimit: Add parameter check for hmp "set_vcpu_dirty_limit"
  qapi/migration: Introduce x-vcpu-dirty-limit-period parameter
  qapi/migration: Introduce vcpu-dirty-limit parameters
  migration: Introduce dirty-limit capability
  migration: Refactor auto-converge capability logic
  migration: Put the detection logic before auto-converge checking
  migration: Implement dirty-limit convergence algo
  migration: Extend query-migrate to provide dirty page limit info

Juan Quintela (11):
  migration-test: Be consistent for ppc
  migration-test: Make machine_opts regular with other options
  migration-test: Create arch_opts
  migration-test: machine_opts is really arch specific
  migration: skipped field is really obsolete.
  qemu-file: Rename qemu_file_transferred_ fast -> noflush
  migration: Change qemu_file_transferred to noflush
  qemu_file: Make qemu_file_is_writable() static
  qemu-file: Simplify qemu_file_shutdown()
  qemu-file: Make qemu_file_get_error_obj() static
  migration/rdma: Split qemu_fopen_rdma() into input/output functions

Peter Xu (1):
  docs/migration: Update postcopy bits

Tejus GK (1):
  migration: Update error description whenever migration fails

Wei Wang (2):
  migration: enforce multifd and postcopy preempt to be set before
    incoming
  qtest/migration-tests.c: use "-incoming defer" for postcopy tests

 docs/about/deprecated.rst      | 10 ++++
 docs/devel/migration.rst       | 94 ++++++++++++++++++++++----------
 qapi/migration.json            | 87 ++++++++++++++++++++++++++----
 include/sysemu/dirtylimit.h    |  2 +
 migration/options.h            |  1 +
 migration/qemu-file.h          | 14 ++---
 migration/threadinfo.h         |  7 +--
 migration/migration-hmp-cmds.c | 26 +++++++++
 migration/migration.c          | 36 +++++++++----
 migration/multifd.c            |  4 +-
 migration/options.c            | 87 +++++++++++++++++++++++++++++-
 migration/qemu-file.c          | 24 ++-------
 migration/ram.c                | 59 +++++++++++++++++----
 migration/rdma.c               | 39 +++++++-------
 migration/savevm.c             |  6 +--
 migration/threadinfo.c         | 19 +++++--
 migration/vmstate.c            |  4 +-
 softmmu/dirtylimit.c           | 97 ++++++++++++++++++++++++++++++----
 tests/qtest/migration-test.c   | 48 ++++++++---------
 migration/trace-events         |  1 +
 20 files changed, 510 insertions(+), 155 deletions(-)

-- 
2.40.1



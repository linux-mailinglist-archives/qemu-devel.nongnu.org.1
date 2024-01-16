Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5739282E827
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:21:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPZzb-0005e9-Cj; Mon, 15 Jan 2024 22:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzZ-0005e1-NQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzY-0002ke-27
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C4JcOauSrpYQBWURST6MCpJ6Db6Tu9+/JhuEtUCCa9Q=;
 b=FZJHyGWqI0rsm64IRA5GgotLVh8fEkxBqvejzbdL0YbJvErditKXk02+MVqKtPSMczZh34
 zCEkXCoerLft5rZYsm+YbLBvrMgE+wmMuZC+qyyEEsZo7M0hclrxegsW2VmysRukrV6DyZ
 ILE1fRbx5pxrbWvvpuZ0byFMizJ/HiM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-nitWsYcmMzahdj7Y8YQVDA-1; Mon,
 15 Jan 2024 22:19:52 -0500
X-MC-Unique: nitWsYcmMzahdj7Y8YQVDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E723811F50;
 Tue, 16 Jan 2024 03:19:52 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA1643C25;
 Tue, 16 Jan 2024 03:19:49 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/20] Migration 20240116 patches
Date: Tue, 16 Jan 2024 11:19:27 +0800
Message-ID: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:

  Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240116-pull-request

for you to fetch changes up to 44ce1b5d2fc77343f6a318cb3de613336a240048:

  migration/rdma: define htonll/ntohll only if not predefined (2024-01-16 11:16:10 +0800)

----------------------------------------------------------------
Migration pull request 2nd batch for 9.0

- Het's cleanup on migration qmp command paths
- Fabiano's migration cleanups and test improvements
- Fabiano's patch to re-enable multifd-cancel test
- Peter's migration doc reorganizations
- Nick Briggs's fix for Solaries build on rdma

----------------------------------------------------------------

Fabiano Rosas (8):
  migration/multifd: Remove MultiFDPages_t::packet_num
  migration/multifd: Remove QEMUFile from where it is not needed
  migration/multifd: Change multifd_pages_init argument
  migration: Report error in incoming migration
  tests/qtest/migration: Print migration incoming errors
  tests/qtest/migration: Add a wrapper to print test names
  tests/qtest/migration: Use the new migration_test_add
  tests/qtest: Re-enable multifd cancel test

Het Gala (1):
  migration: Simplify initial conditionals in migration for better
    readability

Nick Briggs (1):
  migration/rdma: define htonll/ntohll only if not predefined

Peter Xu (10):
  docs/migration: Create migration/ directory
  docs/migration: Create index page
  docs/migration: Convert virtio.txt into rST
  docs/migration: Split "Backwards compatibility" separately
  docs/migration: Split "Debugging" and "Firmware"
  docs/migration: Split "Postcopy"
  docs/migration: Split "dirty limit"
  docs/migration: Organize "Postcopy" page
  docs/migration: Further move vfio to be feature of migration
  docs/migration: Further move virtio to be feature of migration

 docs/devel/index-internals.rst                |    3 +-
 docs/devel/migration.rst                      | 1514 -----------------
 docs/devel/migration/best-practices.rst       |   48 +
 docs/devel/migration/compatibility.rst        |  517 ++++++
 docs/devel/migration/dirty-limit.rst          |   71 +
 docs/devel/migration/features.rst             |   12 +
 docs/devel/migration/index.rst                |   13 +
 docs/devel/migration/main.rst                 |  575 +++++++
 docs/devel/migration/postcopy.rst             |  313 ++++
 .../vfio.rst}                                 |    2 +-
 docs/devel/migration/virtio.rst               |  115 ++
 docs/devel/virtio-migration.txt               |  108 --
 migration/multifd.h                           |    6 +-
 tests/qtest/migration-helpers.h               |    1 +
 migration/migration.c                         |   43 +-
 migration/multifd.c                           |   19 +-
 migration/ram.c                               |   15 +-
 migration/rdma.c                              |    4 +
 tests/qtest/migration-helpers.c               |   38 +
 tests/qtest/migration-test.c                  |  219 +--
 20 files changed, 1861 insertions(+), 1775 deletions(-)
 delete mode 100644 docs/devel/migration.rst
 create mode 100644 docs/devel/migration/best-practices.rst
 create mode 100644 docs/devel/migration/compatibility.rst
 create mode 100644 docs/devel/migration/dirty-limit.rst
 create mode 100644 docs/devel/migration/features.rst
 create mode 100644 docs/devel/migration/index.rst
 create mode 100644 docs/devel/migration/main.rst
 create mode 100644 docs/devel/migration/postcopy.rst
 rename docs/devel/{vfio-migration.rst => migration/vfio.rst} (99%)
 create mode 100644 docs/devel/migration/virtio.rst
 delete mode 100644 docs/devel/virtio-migration.txt

-- 
2.43.0



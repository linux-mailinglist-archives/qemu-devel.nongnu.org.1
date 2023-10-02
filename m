Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A79567B52E8
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHui-0007Ht-Ed; Mon, 02 Oct 2023 08:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHuf-0007GN-Ra
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHub-0007LE-HI
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696249227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=byZ+7HDMN8pSuxGQF+zr6zPNG+invGPtccwMI8BDDoI=;
 b=NNsS43whoQfGgVXVQUd+SPWhMV/RmhLyT4I7I/6kROwRpir4xQkUkA7Ohx34twLH7bHYBT
 MMwo8L30hoviNZXjO/O2OI+l3z/SYagtC6HUporrDymHVTp4UE38bdzFDeXBIBaynN6g9s
 u50AZ/JBLmV5tfOgDJop0B+ycBX88NQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-_0Nti47eNUSvPgfEKWTrkQ-1; Mon, 02 Oct 2023 08:20:24 -0400
X-MC-Unique: _0Nti47eNUSvPgfEKWTrkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A1233C19921;
 Mon,  2 Oct 2023 12:20:24 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A09C2156701;
 Mon,  2 Oct 2023 12:20:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/13] Migration 20231002 patches
Date: Mon,  2 Oct 2023 14:20:08 +0200
Message-ID: <20231002122021.231959-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:

  migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231002-pull-request

for you to fetch changes up to 9c53d369e5903375a2e3358f739be77dcb8dae49:

  migration/rdma: Simplify the function that saves a page (2023-09-29 18:13:53 +0200)

----------------------------------------------------------------
Migration Pull request (20231002)

In this migration pull request:

- Refactor repeated call of yank_unregister_instance (tejus)
- More migraton-test changes

Please, apply.

----------------------------------------------------------------

Juan Quintela (12):
  migration-test: Create kvm_opts
  migration-test: bootpath is the same for all tests and for all archs
  migration-test: Add bootfile_create/delete() functions
  migration-test: dirtylimit checks for x86_64 arch before
  migration-test: simplify shmem_opts handling
  migration: Use qemu_file_transferred_noflush() for block migration.
  migration: Don't abuse qemu_file transferred for RDMA
  migration/RDMA: It is accounting for zero/normal pages in two places
  migration/rdma: Remove QEMUFile parameter when not used
  migration/rdma: Don't use imaginary transfers
  migration: Remove unused qemu_file_credit_transfer()
  migration/rdma: Simplify the function that saves a page

Tejus GK (1):
  migration: Refactor repeated call of yank_unregister_instance

 migration/migration-stats.h  |  4 ++
 migration/qemu-file.h        | 22 +++--------
 migration/block.c            |  4 +-
 migration/migration-stats.c  |  5 ++-
 migration/migration.c        |  4 --
 migration/qemu-file.c        | 22 ++++-------
 migration/ram.c              | 18 ++-------
 migration/rdma.c             | 64 ++++++++++++++++--------------
 tests/qtest/migration-test.c | 77 ++++++++++++++++++++++--------------
 migration/trace-events       |  2 +-
 10 files changed, 107 insertions(+), 115 deletions(-)

-- 
2.41.0



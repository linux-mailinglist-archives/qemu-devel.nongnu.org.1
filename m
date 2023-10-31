Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500ED7DC90E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkde-00086m-6J; Tue, 31 Oct 2023 05:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdW-00082W-EL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdT-0006pO-BD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uwpj1IUuifUQJMxYK6SY/uhElh+t5cWtF2u18KRBa/Y=;
 b=KLAjaBi3RjOiPHZyDc3ZxUhIqJQqGWT1pW+3bMknIUhgM9BqS8Zm26oklVVkQAIEqs3zXE
 EtYlsUSQ5aVxuxYLsFd8ZrKBsAj/44lbt9skCUUDoDU2i+nHIPmSCWfApigmAsny0Zj3ku
 bN6b0129tlmXk3iHouGUXplxMEo45sI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-BqI4EyJrPkCXPNS6urOpaQ-1; Tue,
 31 Oct 2023 05:01:47 -0400
X-MC-Unique: BqI4EyJrPkCXPNS6urOpaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C982E3C100A7;
 Tue, 31 Oct 2023 09:01:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E64531C060B0;
 Tue, 31 Oct 2023 09:01:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/38] Migration 20231031 patches
Date: Tue, 31 Oct 2023 10:01:04 +0100
Message-ID: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit fd9a38fd437c4c31705071c240f4be11394ca1f8:

  Merge tag 'pull-hex-20231018' of https://github.com/quic/qemu into staging (2023-10-30 13:42:29 +0900)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231031-pull-request

for you to fetch changes up to be07a0ed22cf10ede7330efbb4818f5896cd6fe3:

  qemu-file: Make qemu_fflush() return errors (2023-10-31 08:44:33 +0100)

----------------------------------------------------------------
Migration Pull request (20231031)

Hi

This is repeat of the Migration PULL for 20231020.
- I removed vmstate_register(big problems with s390x)
- I added yet more countes (juan)

CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1055797950

Please apply.

Thanks, Juan.

----------------------------------------------------------------

Juan Quintela (34):
  migration/doc: Add contents
  migration/doc: Add documentation for backwards compatiblity
  migration/doc: How to migrate when hosts have different features
  migration/doc: We broke backwards compatibility
  migration: Receiving a zero page non zero is an error
  migration: Rename ram_handle_compressed() to ram_handle_zero()
  migration: Give one error if trying to set MULTIFD and XBZRLE
  migration: Give one error if trying to set COMPRESSION and XBZRLE
  migration: Remove save_page_use_compression()
  migration: Make compress_data_with_multithreads return bool
  migration: Simplify compress_page_with_multithread()
  migration: Move busy++ to migrate_with_multithread
  migration: Create compress_update_rates()
  migration: Export send_queued_data()
  migration: Move ram_flush_compressed_data() to ram-compress.c
  migration: Merge flush_compressed_data() and compress_flush_data()
  migration: Rename ram_compressed_pages() to compress_ram_pages()
  qemu-iotests: Filter warnings about block migration being deprecated
  migration: migrate 'inc' command option is deprecated.
  migration: migrate 'blk' command option is deprecated.
  migration: Deprecate block migration
  migration: Deprecate old compression method
  qemu-file: Don't increment qemu_file_transferred at
    qemu_file_fill_buffer
  qemu_file: Use a stat64 for qemu_file_transferred
  qemu_file: total_transferred is not used anymore
  migration: Use the number of transferred bytes directly
  qemu_file: Remove unused qemu_file_transferred()
  qemu-file: Remove _noflush from qemu_file_transferred_noflush()
  migration: migration_transferred_bytes() don't need the QEMUFile
  migration: migration_rate_limit_reset() don't need the QEMUFile
  qemu-file: Simplify qemu_file_get_error()
  migration: Use migration_transferred_bytes()
  migration: Remove transferred atomic counter
  qemu-file: Make qemu_fflush() return errors

Marc-André Lureau (2):
  migration: rename vmstate_save_needed->vmstate_section_needed
  migration: set file error on subsection loading

Peter Xu (1):
  migration: Stop migration immediately in RDMA error paths

Thomas Huth (1):
  migration/ram: Fix compilation with -Wshadow=local

 docs/about/deprecated.rst        |  35 +++
 docs/devel/migration.rst         | 520 +++++++++++++++++++++++++++++++
 qapi/migration.json              |  93 ++++--
 include/migration/vmstate.h      |   2 +-
 migration/migration-stats.h      |  16 +-
 migration/qemu-file.h            |  27 +-
 migration/ram-compress.h         |  10 +-
 migration/ram.h                  |   3 +-
 migration/block.c                |   7 +-
 migration/colo.c                 |  11 +-
 migration/migration-hmp-cmds.c   |  10 +
 migration/migration-stats.c      |  10 +-
 migration/migration.c            |  27 +-
 migration/multifd.c              |   3 -
 migration/options.c              |  36 ++-
 migration/qemu-file.c            |  43 +--
 migration/ram-compress.c         | 112 +++++--
 migration/ram.c                  | 150 +++------
 migration/rdma.c                 |  12 +-
 migration/savevm.c               |  11 +-
 migration/vmstate.c              |   9 +-
 tests/qemu-iotests/183           |   2 +-
 tests/qemu-iotests/common.filter |   7 +
 23 files changed, 880 insertions(+), 276 deletions(-)

-- 
2.41.0



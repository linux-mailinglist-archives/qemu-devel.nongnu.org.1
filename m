Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D27C4F2D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQ0-00075N-25; Wed, 11 Oct 2023 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVPx-00074z-7u
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVPu-0004nw-Kf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oE4PI8jdBNDtErAWcvKS2obJsahu4+WCoA2+c5tyXIk=;
 b=SN67c79K3m6KdigimtFs9m00bN8NYCwe+z0ZOseCk+3Cw0w3XrYJ8Q2IMV/wmQO4pcqWV2
 oRlmnX50phD1kluY2Si74fU1WtRcvT3svVxRgSUdhgb8ylAiOnX2XdJIMgLLGmHKRdAwy6
 kAGCLWlX1/LnkYlAp5qFs365Ib0K3Jk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-zw2I5U4JMu-fpDIVGCRUMA-1; Wed, 11 Oct 2023 05:22:06 -0400
X-MC-Unique: zw2I5U4JMu-fpDIVGCRUMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A5788007A4;
 Wed, 11 Oct 2023 09:22:06 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 208081C060AE;
 Wed, 11 Oct 2023 09:22:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/65] Migration 20231011 patches
Date: Wed, 11 Oct 2023 11:20:58 +0200
Message-ID: <20231011092203.1266-1-quintela@redhat.com>
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

The following changes since commit 0ad0d9dcd16f2ea816a413008ac5191ebef45c95:

  Merge tag 'firmware/seabios-20231010-pull-request' of https://gitlab.com/kraxel/qemu into staging (2023-10-10 10:22:16 -0400)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231011-pull-request

for you to fetch changes up to 5e79a4bf032213fd59aa614781751fe76584f8e8:

  migration: Add migration_rp_wait|kick() (2023-10-11 11:17:05 +0200)

----------------------------------------------------------------
Migration Pull request (20231011 edition)

Hi

In this pull request:

- Markus RDMA cleanup series
- recover fixes from peter
- migration capability from fabiano
- negative migration test from fabiano.

Please, pull.

Thanks, Juan.

----------------------------------------------------------------

Fabiano Rosas (5):
  tests/qtest: migration: Expose migrate_set_capability
  tests/qtest: migration: Add migrate_incoming_qmp helper
  tests/qtest: migration: Use migrate_incoming_qmp where appropriate
  migration: Set migration status early in incoming side
  tests/qtest: migration: Add support for negative testing of
    qmp_migrate

Markus Armbruster (53):
  migration/rdma: Clean up qemu_rdma_poll()'s return type
  migration/rdma: Clean up qemu_rdma_data_init()'s return type
  migration/rdma: Clean up rdma_delete_block()'s return type
  migration/rdma: Drop fragile wr_id formatting
  migration/rdma: Consistently use uint64_t for work request IDs
  migration/rdma: Fix unwanted integer truncation
  migration/rdma: Clean up two more harmless signed vs. unsigned issues
  migration/rdma: Give qio_channel_rdma_source_funcs internal linkage
  migration/rdma: Fix qemu_rdma_accept() to return failure on errors
  migration/rdma: Put @errp parameter last
  migration/rdma: Eliminate error_propagate()
  migration/rdma: Drop rdma_add_block() error handling
  migration/rdma: Drop qemu_rdma_search_ram_block() error handling
  migration/rdma: Make qemu_rdma_buffer_mergeable() return bool
  migration/rdma: Use bool for two RDMAContext flags
  migration/rdma: Fix or document problematic uses of errno
  migration/rdma: Ditch useless numeric error codes in error messages
  migration/rdma: Fix io_writev(), io_readv() methods to obey contract
  migration/rdma: Replace dangerous macro CHECK_ERROR_STATE()
  migration/rdma: Fix qemu_rdma_broken_ipv6_kernel() to set error
  migration/rdma: Fix qemu_get_cm_event_timeout() to always set error
  migration/rdma: Drop dead qemu_rdma_data_init() code for !@host_port
  migration/rdma: Fix QEMUFileHooks method return values
  migration/rdma: Fix rdma_getaddrinfo() error checking
  migration/rdma: Return -1 instead of negative errno code
  migration/rdma: Dumb down remaining int error values to -1
  migration/rdma: Replace int error_state by bool errored
  migration/rdma: Drop superfluous assignments to @ret
  migration/rdma: Check negative error values the same way everywhere
  migration/rdma: Plug a memory leak and improve a message
  migration/rdma: Delete inappropriate error_report() in macro ERROR()
  migration/rdma: Retire macro ERROR()
  migration/rdma: Fix error handling around rdma_getaddrinfo()
  migration/rdma: Drop "@errp is clear" guards around error_setg()
  migration/rdma: Convert qemu_rdma_exchange_recv() to Error
  migration/rdma: Convert qemu_rdma_exchange_send() to Error
  migration/rdma: Convert qemu_rdma_exchange_get_response() to Error
  migration/rdma: Convert qemu_rdma_reg_whole_ram_blocks() to Error
  migration/rdma: Convert qemu_rdma_write_flush() to Error
  migration/rdma: Convert qemu_rdma_write_one() to Error
  migration/rdma: Convert qemu_rdma_write() to Error
  migration/rdma: Convert qemu_rdma_post_send_control() to Error
  migration/rdma: Convert qemu_rdma_post_recv_control() to Error
  migration/rdma: Convert qemu_rdma_alloc_pd_cq() to Error
  migration/rdma: Silence qemu_rdma_resolve_host()
  migration/rdma: Silence qemu_rdma_connect()
  migration/rdma: Silence qemu_rdma_reg_control()
  migration/rdma: Don't report received completion events as error
  migration/rdma: Silence qemu_rdma_block_for_wrid()
  migration/rdma: Silence qemu_rdma_register_and_get_keys()
  migration/rdma: Downgrade qemu_rdma_cleanup() errors to warnings
  migration/rdma: Use error_report() & friends instead of stderr
  migration/rdma: Replace flawed device detail dump by tracing

Peter Xu (7):
  migration/qmp: Fix crash on setting tls-authz with null
  migration: Allow RECOVER->PAUSED convertion for dest qemu
  migration: Display error in query-migrate irrelevant of status
  migration: Introduce migrate_has_error()
  qemufile: Always return a verbose error
  migration: Remember num of ramblocks to sync during recovery
  migration: Add migration_rp_wait|kick()

 qapi/migration.json               |    5 +-
 migration/migration.h             |   16 +
 tests/qtest/libqtest.h            |   28 +
 tests/qtest/migration-helpers.h   |   10 +
 migration/migration.c             |   36 +-
 migration/options.c               |    9 +-
 migration/qemu-file.c             |   15 +-
 migration/ram.c                   |   33 +-
 migration/rdma.c                  | 1023 ++++++++++++++---------------
 migration/savevm.c                |    3 +-
 tests/qtest/libqtest.c            |   33 +
 tests/qtest/migration-helpers.c   |   60 ++
 tests/qtest/migration-test.c      |   39 +-
 tests/qtest/virtio-net-failover.c |   77 +--
 migration/trace-events            |   10 +-
 tests/qtest/meson.build           |    1 +
 16 files changed, 757 insertions(+), 641 deletions(-)

-- 
2.41.0



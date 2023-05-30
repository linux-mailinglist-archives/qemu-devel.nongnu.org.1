Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C6716C5E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q442W-0001Qa-LZ; Tue, 30 May 2023 14:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442S-0001Mr-4X
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442L-0000b7-01
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ql+c0EP0xKIGxwWFYaTh3w41Ot67OTxyZn3RGYdnpgw=;
 b=OZLxXwg0IpuDhTs2vS7+AiHaY43WqjikkGvZgeYiWnqnA++wVtpRGoQPNeINWxZc7TOtOq
 xAYygypfdAIdaxGVBoj0s2Srm/7XSQGNKIPU4D0IfQpg2l/edO4dPCLBhy19hA93pYF/N/
 02IM0tm760JSOeYARUTdmqGJjgZawPw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-1ht2Ea2_McO3XXKs0hqO9g-1; Tue, 30 May 2023 14:25:33 -0400
X-MC-Unique: 1ht2Ea2_McO3XXKs0hqO9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C268811E7C
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:25:33 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2151E420A8;
 Tue, 30 May 2023 18:25:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PULL 00/21] Migration 20230530 patches
Date: Tue, 30 May 2023 20:25:10 +0200
Message-Id: <20230530182531.6371-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:

  Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu into staging (2023-05-29 14:31:52 -0700)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20230530-pull-request

for you to fetch changes up to c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:

  migration/rdma: Check sooner if we are in postcopy for save_page() (2023-05-30 19:23:50 +0200)

----------------------------------------------------------------
Migration 20230530 Pull request (take 2)

Hi

Resend last PULL request, this time it compiles when CONFIG_RDMA is
not configured in.

[take 1]
On this PULL request:

- Set vmstate migration failure right (vladimir)
- Migration QEMUFileHook removal (juan)
- Migration Atomic counters (juan)

Please apply.

----------------------------------------------------------------

Juan Quintela (16):
  migration: Don't abuse qemu_file transferred for RDMA
  migration/RDMA: It is accounting for zero/normal pages in two places
  migration/rdma: Remove QEMUFile parameter when not used
  migration/rdma: Don't use imaginary transfers
  migration: Remove unused qemu_file_credit_transfer()
  migration/rdma: Simplify the function that saves a page
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

Vladimir Sementsov-Ogievskiy (5):
  runstate: add runstate_get()
  migration: never fail in global_state_store()
  runstate: drop unused runstate_store()
  migration: switch from .vm_was_running to .vm_old_state
  migration: restore vmstate on migration failure

 include/migration/global_state.h |   2 +-
 include/sysemu/runstate.h        |   2 +-
 migration/migration-stats.h      |   4 +
 migration/migration.h            |  12 +-
 migration/options.h              |   1 +
 migration/qemu-file.h            |  59 ----------
 migration/rdma.h                 |  42 +++++++
 migration/global_state.c         |  29 +++--
 migration/migration-stats.c      |   5 +-
 migration/migration.c            |  55 +++++----
 migration/options.c              |   7 ++
 migration/qemu-file.c            |  69 +-----------
 migration/ram.c                  |  66 ++++++-----
 migration/rdma.c                 | 185 +++++++++++++++----------------
 migration/savevm.c               |   6 +-
 softmmu/runstate.c               |  25 ++---
 migration/trace-events           |  30 ++---
 17 files changed, 268 insertions(+), 331 deletions(-)

-- 
2.40.1



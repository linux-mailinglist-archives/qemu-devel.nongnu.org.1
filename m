Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F388B71F6CA
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ry9-0005w3-1x; Thu, 01 Jun 2023 19:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ry4-0005t8-Rb
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ry3-0000vZ-2N
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UMtERBIFewoMRAL1MVe5EFUC3vcKQtau2gJsiMaXBLo=;
 b=dDlll6J8IJZAufcmukz8yby5kMrNWYYYg1D/2H3TiBOm4LzImsV++PEJAw2UqqHONChfRN
 qEwVQDgAX6kSHq+nZpx3c2284AiLoj7SkUneTKz6N03ki1jKAMyRYMERH3MWgH6jn0fcrl
 adE/zSwZj6fpeAEGbn+GLeyrof3BAq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-m1um0VI5MrSt5-hvstNo2A-1; Thu, 01 Jun 2023 19:44:28 -0400
X-MC-Unique: m1um0VI5MrSt5-hvstNo2A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2CC9185A78F
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 23:44:28 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8AB0492B00;
 Thu,  1 Jun 2023 23:44:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/6] Migration 20230601 patches
Date: Fri,  2 Jun 2023 01:44:20 +0200
Message-Id: <20230601234426.29984-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

The following changes since commit 9eb400cdd7b0940bd696aa01462dd53004ae04e9:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-06-01 11:47:58 -0700)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20230601-pull-request

for you to fetch changes up to 3a8b81f2e6393828589699bb0b8ef557b9ae5937:

  migration: stop tracking ram writes when cancelling background migration (2023-06-02 01:03:19 +0200)

----------------------------------------------------------------
Migration Pull request (20230601)

Hi

In this series:
- improve background migration (fiona)
- improve vmstate failure states (vladimir)
- dropped all the RDMA cleanups

Please, apply.

----------------------------------------------------------------

Fiona Ebner (1):
  migration: stop tracking ram writes when cancelling background
    migration

Vladimir Sementsov-Ogievskiy (5):
  runstate: add runstate_get()
  migration: never fail in global_state_store()
  runstate: drop unused runstate_store()
  migration: switch from .vm_was_running to .vm_old_state
  migration: restore vmstate on migration failure

 include/migration/global_state.h |  2 +-
 include/sysemu/runstate.h        |  2 +-
 migration/migration.h            |  9 +++--
 migration/global_state.c         | 29 +++++++-------
 migration/migration.c            | 68 ++++++++++++++++----------------
 migration/savevm.c               |  6 +--
 softmmu/runstate.c               | 25 ++++++------
 7 files changed, 68 insertions(+), 73 deletions(-)

-- 
2.40.1



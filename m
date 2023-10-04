Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539367B7F76
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1BL-0006Ym-Sc; Wed, 04 Oct 2023 08:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BJ-0006Yd-UV
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BE-0003Tr-R2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Jjk2pZHP1jVIqKEdcHxFlgQrZSx4iLJHz4C1FXNNBg=;
 b=HTJfj+DuJ8yFStcjl3by73rYsXPX3arkaJd5xcSe9mS+UEGnycVJpAHkCJjlHoydox0cQl
 HAi27qUpaKhL3XAdJsNoH2CQu9bwL/CpQoH03aOrIHSJ9wzPjMZUU0SMoHxSTt26kbXXvy
 cbd/ikeF79SIQVM9cPVnjDrcTgw/zvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-2-E5sPEZPAGLklA1oQJoZQ-1; Wed, 04 Oct 2023 08:40:41 -0400
X-MC-Unique: 2-E5sPEZPAGLklA1oQJoZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3AF4858293;
 Wed,  4 Oct 2023 12:40:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E8B32026D4B;
 Wed,  4 Oct 2023 12:40:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org
Subject: [PULL 00/11] Migration 20231004 patches
Date: Wed,  4 Oct 2023 14:40:27 +0200
Message-ID: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7e0:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-10-03 07:43:44 -0400)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231004-pull-request

for you to fetch changes up to 579cedf430582b37f804f6b6ed131554cebb11b5:

  migration: Unify and trace vmstate field_exists() checks (2023-10-04 13:19:47 +0200)

----------------------------------------------------------------
Migration Pull request (20231004)

Hi

In this series:

* make sure migration-tests get 0's (daniil)
  Notice that this creates a checkpatch negative, everything on that
  file is volatile, no need to add a comment.

* RDMA fix from li
* MAINTAINERS
  Get peter and fabiano to become co-maintainers of migration
  Get Entry fro migration-rdma for Li Zhijian
* Create field_exists() (peterx)
* Improve error messages (Tejus)

Please apply.

s

----------------------------------------------------------------

Daniil Tatianin (3):
  i386/a-b-bootblock: factor test memory addresses out into constants
  i386/a-b-bootblock: zero the first byte of each page on start
  s390x/a-b-bios: zero the first byte of each page on start

Li Zhijian (1):
  migration/rdma: zore out head.repeat to make the error more clear

Peter Xu (3):
  MAINTAINERS: Add entry for rdma migration
  migration: Add co-maintainers for migration
  migration: Unify and trace vmstate field_exists() checks

Steve Sistare (2):
  migration: file URI
  migration: file URI offset

Tejus GK (2):
  migration/vmstate: Introduce vmstate_save_state_with_err
  migration: Update error description outside migration.c

 MAINTAINERS                          |  12 +-
 include/migration/vmstate.h          |   4 +-
 migration/file.h                     |  14 +
 tests/migration/i386/a-b-bootblock.h |  16 +-
 tests/migration/s390x/a-b-bios.h     | 404 ++++++++++++++-------------
 migration/file.c                     | 103 +++++++
 migration/migration.c                |   5 +
 migration/rdma.c                     |   2 +-
 migration/savevm.c                   |  19 +-
 migration/vmstate.c                  |  53 +++-
 tests/migration/s390x/a-b-bios.c     |   8 +
 migration/meson.build                |   1 +
 migration/trace-events               |   5 +
 qemu-options.hx                      |   7 +-
 tests/migration/i386/a-b-bootblock.S |  18 +-
 15 files changed, 449 insertions(+), 222 deletions(-)
 create mode 100644 migration/file.h
 create mode 100644 migration/file.c

-- 
2.41.0



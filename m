Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28071FFB0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52LP-00077U-T0; Fri, 02 Jun 2023 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52LN-00077I-9X
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52LL-0002FN-AY
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ga83cgap9FcsSCv8FhRZbkZp3ppgBY+yLURJOfZ4DN0=;
 b=O4PLGkWj7J5WIqhIdTJyqZnww9U/EYQJkKEMVb8xmJTQ827KAMcAsLZJdCMZ6yN8G2kbzD
 MNT0RKF+xQ2bXMuggntf6QsMR+0Yuaxbhxfvu/78CxeWHZalTv+p7dubFMWdKFs2fOq73F
 82sInJdLwoB4THM+tIUVHaY3xFhEP54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-TcEYt-bnNOyNabxUrSLtZw-1; Fri, 02 Jun 2023 06:49:12 -0400
X-MC-Unique: TcEYt-bnNOyNabxUrSLtZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80526800B2A
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 10:49:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5558440CFD00;
 Fri,  2 Jun 2023 10:49:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PULL 00/10] Migration 20230602 patches
Date: Fri,  2 Jun 2023 12:49:00 +0200
Message-Id: <20230602104910.35157-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

The following changes since commit a86d7b9ec0adb2f1efce8ab30d9ed2b72db0236e:

  Merge tag 'migration-20230601-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-01 20:59:28 -0700)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20230602-pull-request

for you to fetch changes up to b861383c2690501ff2687f9ef9268b128b0fb3b3:

  qtest/migration: Document live=true cases (2023-06-02 11:46:20 +0200)

----------------------------------------------------------------
Migration Pull request (20230602 vintage)

This PULL request get:
- All migration-test patches except last one (daniel)
- Documentation about live test cases (peter)

Please apply.

----------------------------------------------------------------

Daniel P. Berrangé (9):
  tests/qtest: add various qtest_qmp_assert_success() variants
  tests/qtest: add support for callback to receive QMP events
  tests/qtest: get rid of 'qmp_command' helper in migration test
  tests/qtest: get rid of some 'qtest_qmp' usage in migration test
  tests/qtest: switch to using event callbacks for STOP event
  tests/qtest: replace wait_command() with qtest_qmp_assert_success
  tests/qtest: capture RESUME events during migration
  tests/qtest: distinguish src/dst migration VM stop/resume events
  tests/qtest: make more migration pre-copy scenarios run non-live

Peter Xu (1):
  qtest/migration: Document live=true cases

 tests/qtest/libqtest.h          | 158 ++++++++++++-
 tests/qtest/migration-helpers.h |  16 +-
 tests/qtest/libqtest.c          | 121 +++++++++-
 tests/qtest/migration-helpers.c | 103 ++-------
 tests/qtest/migration-test.c    | 386 ++++++++++++++++++--------------
 5 files changed, 505 insertions(+), 279 deletions(-)

-- 
2.40.1



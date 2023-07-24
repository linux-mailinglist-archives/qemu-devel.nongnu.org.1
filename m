Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6175F800
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvH5-00040R-M1; Mon, 24 Jul 2023 09:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvGz-0003zb-D0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvGw-0002Wk-LS
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+rxIhu3xsP02sW8eb06Y88PuuHy+EOMHo0l35s8WmA=;
 b=QIlzBRSCzQbtRj77xhSoICL/IbY1HT5aAeRKrEU+DH1r6H/XYh2ZL2uh0nEwaO0/k9R2Rt
 BC4TJTG+aX36EvBO90weCEuoc4m1k9V8chHc88Ngq2NOGSnJWaLHVew5gVo2S/z0CCAq8J
 Vfgf2THFnj+LIT0mRGOTSvKfS42C0+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-okGE-K7ZO265AOrNuuqi9Q-1; Mon, 24 Jul 2023 09:06:43 -0400
X-MC-Unique: okGE-K7ZO265AOrNuuqi9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1710E104458E
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 13:06:43 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34710F782E;
 Mon, 24 Jul 2023 13:06:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 00/26] Migration PULL 2023-07-24
Date: Mon, 24 Jul 2023 15:06:13 +0200
Message-Id: <20230724130639.93135-1-quintela@redhat.com>
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

Hi

This is the migration PULL request.  It has:
- Fabiano rosas trheadinfo cleanups
- Hyman Huang dirtylimit changes
- Part of my changes
- Peter Xu documentation
- Tejus updato to migration descriptions
- Wei want improvements for postocpy and multifd setup

Please apply.

Now a not on CI, thas has been really bad.  After too many problems
with last PULLS, I decided to learn to use qemu CI.  On one hand, it
is not so difficult, even I can use it O:-)

On the other hand, the amount of problems that I got is inmense.  Some
of them dissapear when I rerun the checks, but I never know if it is
my PULL request, the CI system or the tests themselves.

So it ends going something like:

while (true); do
- git pull
- git rebase
- git push ci blah, blah
- Next day cames, and too many errors, so I rebase again

The last step takes more time than expected and not always trivial to
know how the failure is.

This (last) patch is not part of the PULL request, but I have found
that it _always_ makes gcov fail.  I had to use bisect to find where
the problem was.

https://gitlab.com/juan.quintela/qemu/-/jobs/4571878922

I could use help to know how a change in test/qtest/migration-test.c
can break block layer tests, I am all ears.

Yes, I tried several times.  It always fails on that patch.  The
passes with flying colors.

Later, Juan.

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

Juan Quintela (12):
  migration-test: Be consistent for ppc
  migration-test: Make machine_opts regular with other options
  migration-test: Create arch_opts
  migration-test: machine_opts is really arch specific
  migration.json: Don't use space before colon
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

 docs/about/deprecated.rst      |  10 +++
 docs/devel/migration.rst       |  94 ++++++++++++++++++++---------
 qapi/migration.json            | 107 ++++++++++++++++++++++++++-------
 include/sysemu/dirtylimit.h    |   2 +
 migration/options.h            |   1 +
 migration/qemu-file.h          |  14 ++---
 migration/threadinfo.h         |   7 +--
 migration/migration-hmp-cmds.c |  26 ++++++++
 migration/migration.c          |  36 ++++++++---
 migration/multifd.c            |   4 +-
 migration/options.c            |  87 ++++++++++++++++++++++++++-
 migration/qemu-file.c          |  24 ++------
 migration/ram.c                |  59 +++++++++++++++---
 migration/rdma.c               |  39 ++++++------
 migration/savevm.c             |   6 +-
 migration/threadinfo.c         |  19 +++++-
 migration/vmstate.c            |   4 +-
 softmmu/dirtylimit.c           |  97 +++++++++++++++++++++++++++---
 tests/qtest/migration-test.c   |  48 +++++++--------
 migration/trace-events         |   1 +
 20 files changed, 520 insertions(+), 165 deletions(-)

-- 
2.40.1



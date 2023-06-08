Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E6E728B41
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSF-0003SF-Ri; Thu, 08 Jun 2023 18:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSD-0003RJ-Fe
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OS4-0004cc-P6
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F1l3Ud+hvDoqO1ct2IA6NNGQgf3LWBONBrZNTg07qhw=;
 b=BxDDh4wiRGkcT8AdqBaaeAxCr7XL9x4HmGJt9waQVJn6VPsLBqBlSzQJf9rfWfzYhb414G
 pCUeu/zEvjltIGB4lDx42QnAxhcRPFaLlRDt5HJQbo/s91s0W7cKI1HVBBF2L0vXF0WLv3
 GvkU9vZpfgG7cwTEKBRlnvelgVAv7oQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-z39SlCWaPrmfztIIb6VyYg-1; Thu, 08 Jun 2023 18:49:46 -0400
X-MC-Unique: z39SlCWaPrmfztIIb6VyYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9BF63C0C88F;
 Thu,  8 Jun 2023 22:49:45 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A684492B00;
 Thu,  8 Jun 2023 22:49:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 00/42] Migration test refactoring
Date: Fri,  9 Jun 2023 00:49:01 +0200
Message-Id: <20230608224943.3877-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi

This series do a lot of much neededs cleanups and fixes to migration-test:

- We make source and target machines coherent/constent
- We make all command line options consistent
- We split test_migrate_start() and test_migrate_end() into:

  * guest_start() from from and to.  It is the same function, just
    defines the basic options.  I am open to renaming it to
    guest_define() or anything else that people can came with.

  * guest_destroy(), you have guessed it, right?

  * guest_realize() after guest_start() and adding any options we
    need, we just create the guest.  We use the same function from
    source and target, making inconsistencies disapear.

- uri: right now it is a mess, we can have:
  * uri created with migration_start()
  * or listen_uri
  * or connect_uri
  * or by hand
  now we just setup to->uri, and we get the migrate uri automatically from there.

- we were creating bootfile for each migration test.  Change the code
  so we only create it once for the whole migration test.

- Introduce GuestState.  Using QTestState directly means that we can
  add state by guest, making it abuse local variables.  Now we move
  all guest state into GuestState.

- Apart from test found by Fabiano, we had another problems with
  multifd + cancel:

  * We didn't wait for "to" guest to finish before we launch second
    target guest "to2".  We fixed it by destroying "to" before
    launching "to2".

  * We reused "dest_serial" filename from "to" and "to2", so in a very
    loaded host, it could be that we contact with the wrong vm, and we
    never end.

  * I change the code so the serial filename is dependent on guest
    name, that made changing the interface:
    wait_for_serial("dest_serial") to
    wait_for_relial(to) (or to2 or ...) so we can't fail.

- we move the global event variables to GuestState, so no more
  got_src_stop or got_dst_resume, we just check
    who->got_event

- create a function from migrate-incoming, so now we do:
  migrate_incoming(uri) and it does what we want/expect.

- vcpu_dirty_limit is not related to migration at all, just is easier
  to write with migration infrastructure.  Move all useful functions
  to migration-helpers.[ch] and split the test into
  vcpu-dirty-limit-test.c.  I think that we can declare that test slow.

- Now that guest_create/destry exist, we can "reuse" them in
  vcpu_dirty_limit test.

- The removal of files, like "migsocket" was flaky at least, i.e. not
  always removed.  "migsocket-recover" was not even tried to remove.
  New code just remove them by default.

- MigrationStart is gone, instead of creating that flags, I just call
  functions that do that function.

- if no uri is given for a target guest, it launches with -incoming
  defer, that should be the default.

ToDo:

- Tests shouldn't really use QMP, if we need QMP, we should hide it
  behind a c function.  Almost everything is there now, except things
  like "reuse".

- I think we should split auto-converge test:
  * we are not testing migration there, we are testing vcpu slowdown
  * the test is really slow, see documentation why we can't make it much faster.

- I still need to make test faster with stoping switchover.

Please, review.

Juan Quintela (42):
  migration-test: Be consistent for ppc
  migration-test: Make ignore_stderr regular with other options
  migration-test: simplify shmem_opts handling
  migration-test: Make machine_opts regular with other options
  migration-test: Create arch_opts
  migration-test: machine_opts is really arch specific
  migration-test: Create kvm_opts
  migration-test: bootpath is the same for all tests and for all archs
  migration-test: Add bootfile_create/delete() functions
  migration-test: dirtylimit checks for x86_64 arch before
  migration-test: Update test_ignore_shared to use args
  migration-test: Enable back ignore-shared test
  migration-test: Check for shared memory like for everything else
  migration-test: test_migrate_start() always return 0
  migration-test: migrate_postcopy_prepare() always return 0
  migration-test: Create do_migrate()
  migration-test: Introduce GuestState
  migration-test: Create guest before calling do_test_validate_uuid()
  migration-test: Create guest before calling test_precopy_common()
  migration-test: Create guest before calling test_postcopy_common()
  migration-test: Move common guest code to guest_create()
  migration-test: Create guest_use_dirty_log()
  migration-test: Move serial to GuestState
  migration-test: Re-enable multifd_cancel test
  migration-test: We were not waiting for "target" to finish
  migration-test: create guest_use_shmem()
  migration-test: Create guest_extra_opts()
  migration-test: Create guest_hide_stderr()
  migration-test: Create the migration unix socket by guest
  migration-test: Hooks also need GuestState
  migration-test: Preffer to->uri to uri parameter for migration
  migration-test: Create guest_set_uri()
  migration-test: Remove connect_uri
  migration-test: Use new schema for all tests that use unix sockets
  migration-test: Set uri for tcp tests with guest_set_uri()
  migration-test: Remove unused listen_uri
  migration-test: Create get_event GuestState variable
  migration-test: Create guest_realize()
  migration-test: Unfold test_migrate_end() into three functions
  migration-test: Create migrate_incoming() function
  migration-test: Move functions to migration-helpers.c
  migration-test: Split vcpu-dirty-limit-test

 MAINTAINERS                         |    3 +-
 tests/qtest/migration-helpers.h     |   39 +
 tests/qtest/migration-helpers.c     |  242 +++++
 tests/qtest/migration-test.c        | 1525 +++++++++------------------
 tests/qtest/vcpu-dirty-limit-test.c |  310 ++++++
 tests/qtest/meson.build             |    5 +-
 6 files changed, 1113 insertions(+), 1011 deletions(-)
 create mode 100644 tests/qtest/vcpu-dirty-limit-test.c


base-commit: 45ae97993a75f975f1a01d25564724c7e10a543f
prerequisite-patch-id: f95418b6f47019ec82d47aac8ba5247775f503a3
-- 
2.40.1



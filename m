Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D474A9C2
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 06:11:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHcoF-0000uh-08; Fri, 07 Jul 2023 00:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qHcoA-0000s2-He
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 00:11:02 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qHco8-0006l5-Hh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 00:11:02 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id DA08A11F01E;
 Fri,  7 Jul 2023 04:10:58 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Fri, 07 Jul 2023 04:10:58 +0000
MIME-Version: 1.0
Subject: [PATCH QEMU v8 0/9] migration: introduce dirtylimit capability
Message-ID: <168870305868.29142.5121604177475325995-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi, Juan and Markus, thanks for reviewing the previous
versions and please review the latest version if you have time :)

Yong

v8:
1. Rebase on master and refactor the docs suggested by Markus

v7:
1. Rebase on master and fix conflicts

v6:
1. Rebase on master
2. Split the commit "Implement dirty-limit convergence algo" into two as
    Juan suggested as the following:
    a. Put the detection logic before auto-converge checking
    b. Implement dirty-limit convergence algo
3. Put the detection logic before auto-converge checking
4. Sort the migrate_dirty_limit function in commit
    "Introduce dirty-limit capability" suggested by Juan
5. Substitute the the int64_t to uint64_t in the last 2 commits
6. Fix the comments spell mistake
7. Add helper function in the commit
    "Implement dirty-limit convergence algo" suggested by Juan

v5:
1. Rebase on master and enrich the comment for "dirty-limit" capability,
    suggesting by Markus.
2. Drop commits that have already been merged.

v4:
1. Polish the docs and update the release version suggested by Markus
2. Rename the migrate exported info "dirty-limit-throttle-time-per-
round"
   to "dirty-limit-throttle-time-per-full".

v3(resend):
- fix the syntax error of the topic.

v3:
This version make some modifications inspired by Peter and Markus
as following:
1. Do the code clean up in [PATCH v2 02/11] suggested by Markus
2. Replace the [PATCH v2 03/11] with a much simpler patch posted by
   Peter to fix the following bug:
   https://bugzilla.redhat.com/show_bug.cgi?id=3D2124756
3. Fix the error path of migrate_params_check in [PATCH v2 04/11]
   pointed out by Markus. Enrich the commit message to explain why
   x-vcpu-dirty-limit-period an unstable parameter.
4. Refactor the dirty-limit convergence algo in [PATCH v2 07/11]
   suggested by Peter:
   a. apply blk_mig_bulk_active check before enable dirty-limit
   b. drop the unhelpful check function before enable dirty-limit
   c. change the migration_cancel logic, just cancel dirty-limit
      only if dirty-limit capability turned on.
   d. abstract a code clean commit [PATCH v3 07/10] to adjust
      the check order before enable auto-converge
5. Change the name of observing indexes during dirty-limit live
   migration to make them more easy-understanding. Use the
   maximum throttle time of vpus as "dirty-limit-throttle-time-per-full"
6. Fix some grammatical and spelling errors pointed out by Markus
   and enrich the document about the dirty-limit live migration
   observing indexes "dirty-limit-ring-full-time"
   and "dirty-limit-throttle-time-per-full"
7. Change the default value of x-vcpu-dirty-limit-period to 1000ms,
   which is optimal value pointed out in cover letter in that
   testing environment.
8. Drop the 2 guestperf test commits [PATCH v2 10/11],
   [PATCH v2 11/11] and post them with a standalone series in the
   future.

v2:
This version make a little bit modifications comparing with
version 1 as following:
1. fix the overflow issue reported by Peter Maydell
2. add parameter check for hmp "set_vcpu_dirty_limit" command
3. fix the racing issue between dirty ring reaper thread and
   Qemu main thread.
4. add migrate parameter check for x-vcpu-dirty-limit-period
   and vcpu-dirty-limit.
5. add the logic to forbid hmp/qmp commands set_vcpu_dirty_limit,
   cancel_vcpu_dirty_limit during dirty-limit live migration when
   implement dirty-limit convergence algo.
6. add capability check to ensure auto-converge and dirty-limit
   are mutually exclusive.
7. pre-check if kvm dirty ring size is configured before setting
   dirty-limit migrate parameter

Hyman Huang(=E9=BB=84=E5=8B=87) (9):
  softmmu/dirtylimit: Add parameter check for hmp "set_vcpu_dirty_limit"
  qapi/migration: Introduce x-vcpu-dirty-limit-period parameter
  qapi/migration: Introduce vcpu-dirty-limit parameters
  migration: Introduce dirty-limit capability
  migration: Refactor auto-converge capability logic
  migration: Put the detection logic before auto-converge checking
  migration: Implement dirty-limit convergence algo
  migration: Extend query-migrate to provide dirty page limit info
  tests: Add migration dirty-limit capability test

 include/sysemu/dirtylimit.h    |   2 +
 migration/migration-hmp-cmds.c |  26 ++++++
 migration/migration.c          |  13 +++
 migration/options.c            |  73 ++++++++++++++++
 migration/options.h            |   1 +
 migration/ram.c                |  61 ++++++++++---
 migration/trace-events         |   1 +
 qapi/migration.json            |  75 ++++++++++++++--
 softmmu/dirtylimit.c           |  91 +++++++++++++++++--
 tests/qtest/migration-test.c   | 155 +++++++++++++++++++++++++++++++++
 10 files changed, 473 insertions(+), 25 deletions(-)

--=20
2.38.5


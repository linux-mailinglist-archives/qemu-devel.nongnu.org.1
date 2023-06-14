Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278A727615
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 06:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q77BM-0006BR-0c; Thu, 08 Jun 2023 00:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q74z3-0006Qj-FC
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:02:41 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q74z1-0000D8-Mh
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:02:41 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id AF84811EFC6;
 Thu,  8 Jun 2023 02:02:38 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 08 Jun 2023 02:02:38 +0000
MIME-Version: 1.0
Subject: [PATCH QEMU v5 0/8] migration: introduce dirtylimit capability
Message-ID: <168618975839.6361.17407633874747688653-0@git.sr.ht>
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
X-Mailman-Approved-At: Thu, 08 Jun 2023 00:23:09 -0400
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

I'm awfully sorry about having not updated the patchset for a long time.
I have changed my email address to "yong.huang@smartx.com", and
this email address will used to post the unfinished commits in the
further.

I have dropped the performance improvement data, please refer to the
following link to see the details.
https://lore.kernel.org/qemu-
devel/13a62aaf-f340-0dc7-7b68-7ecc4bb643a3@chinatelecom.cn/

Please review if anyone have time. Thanks.
Yong

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

Hyman Huang(=E9=BB=84=E5=8B=87) (8):
  softmmu/dirtylimit: Add parameter check for hmp "set_vcpu_dirty_limit"
  qapi/migration: Introduce x-vcpu-dirty-limit-period parameter
  qapi/migration: Introduce vcpu-dirty-limit parameters
  migration: Introduce dirty-limit capability
  migration: Refactor auto-converge capability logic
  migration: Implement dirty-limit convergence algo
  migration: Extend query-migrate to provide dirty page limit info
  tests: Add migration dirty-limit capability test

 include/sysemu/dirtylimit.h    |   2 +
 migration/migration-hmp-cmds.c |  26 ++++++
 migration/migration.c          |  13 +++
 migration/options.c            |  72 +++++++++++++++
 migration/options.h            |   1 +
 migration/ram.c                |  63 +++++++++++---
 migration/trace-events         |   1 +
 qapi/migration.json            |  73 ++++++++++++++--
 softmmu/dirtylimit.c           |  90 +++++++++++++++++--
 tests/qtest/migration-test.c   | 154 +++++++++++++++++++++++++++++++++
 10 files changed, 464 insertions(+), 31 deletions(-)

--=20
2.38.5


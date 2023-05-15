Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D7F703DF9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:58:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeJw-0007LE-DY; Mon, 15 May 2023 15:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeJt-0007KH-Rl
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeJs-0005F2-9G
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dJAcp6jQMlpCux9fuoD26nUYbprDXGsvjZGO56vSl48=;
 b=cs1TjZXPi4z4+8mXZJ4YgkXxEn0N3YXcy8iK48NewddOyf5Ssdsskr0PacciCQ4afrfSCn
 rcDpfgZ6Jv5rt4yS2xqlfgTtiLwl33Oc22fk6ST117VCjqxK7hFSQI9D5+PvBAr3a+IhMF
 uVEjeZxInth5AEjJaOeHhUTo0H5fyGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-ooVOF3wuNZ6-m3knqWuBGQ-1; Mon, 15 May 2023 15:57:15 -0400
X-MC-Unique: ooVOF3wuNZ6-m3knqWuBGQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E717867955;
 Mon, 15 May 2023 19:57:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32EB8492B00;
 Mon, 15 May 2023 19:57:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 00/16] Migration: More migration atomic counters
Date: Mon, 15 May 2023 21:56:53 +0200
Message-Id: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In this v2 series:
- More documentation here and there.
- Fix migration_rate_set() to really / XFER_LIMIT_RATIO
- All reviewed patches are in Migration PULL request 20230515
- There are later reviewed patches, but that depend on the first ones
  that are still not reviewed.

Please review.

Thanks, Juan.

Subject: [PULL 00/11] Migration 20230515 patches
Based-on: Message-Id: <20230515123334.58995-1-quintela@redhat.com>

[v1]
In this series:
- play with rate limit
  * document that a value of 0 means no rate-limit
  * change all users of INT64_MAX to use 0
  * Make sure that transferred value is right
    This gets transferred == multifd_bytes + qemu_file_transferred()
    until the completation stage.  Changing all devices is overkill and not useful.
  * Move all rate_limit calculations to use atomics instead of qemu_file_transferred().
    Use atomics for rate_limit.
  * RDMA
    Adjust counters here and there
    Change the "imaginary" 1 byte transfer to say if it has sent a page or not.
    More cleanups due to this changes
  * multifd: Adjust the number of transferred bytes in the right place and right amount
    right place: just after write, now with atomic counters we can
    right ammount: Now that we are in the right place, we can do it right also for compressing

Please review.

ToDo: Best described as ToSend:
- qemu_file_transfered() is based on atomics on my branch
- transferred atomic is not needed anymore

ToDo before my next send:

- downtime_bytes, precopy_bytes and postcopy_bytes should be based on
  migration_transfered_bytes and not need a counter of their own.

With that my cleanup would have finishing, moving from:
- total_transferred in QEMUFile (not atomic)
- rate_limit_used in QEMUFile (not atomic)
- multifd_bytes in mig_stats
- transferred in mig_stats (not updated everywhere needed, the
  following ones are based on this one)
- downtime_bytes in mig_stats
- precopy_bytes in mig_stats
- postcopy_bytes in mig_stats

To just:
- qemu_file_transferred in mig_stats
- multifd_bytes in mig_stats
- rdma_bytes in mig_stats

And for each transfer, we only update one of the three, everything
else is derived from this three values.

Later, Juan.

Juan Quintela (16):
  migration: Don't use INT64_MAX for unlimited rate
  migration: Correct transferred bytes value
  migration: Move setup_time to mig_stats
  qemu-file: Account for rate_limit usage on qemu_fflush()
  migration: Move rate_limit_max and rate_limit_used to migration_stats
  migration: Move migration_total_bytes() to migration-stats.c
  migration: Add a trace for migration_transferred_bytes
  migration: Use migration_transferred_bytes() to calculate rate_limit
  migration: We don't need the field rate_limit_used anymore
  migration: Don't abuse qemu_file transferred for RDMA
  migration/RDMA: It is accounting for zero/normal pages in two places
  migration/rdma: Remove QEMUFile parameter when not used
  migration/rdma: Don't use imaginary transfers
  migration: Remove unused qemu_file_credit_transfer()
  migration/rdma: Simplify the function that saves a page
  migration/multifd: Compute transferred bytes correctly

 include/migration/qemu-file-types.h | 12 ++++-
 migration/migration-stats.h         | 73 +++++++++++++++++++++++++++
 migration/migration.h               |  1 -
 migration/options.h                 |  7 ---
 migration/qemu-file.h               | 33 +++----------
 hw/ppc/spapr.c                      |  4 +-
 hw/s390x/s390-stattrib.c            |  2 +-
 migration/block-dirty-bitmap.c      |  2 +-
 migration/block.c                   |  5 +-
 migration/migration-stats.c         | 59 ++++++++++++++++++++++
 migration/migration.c               | 36 ++++++--------
 migration/multifd.c                 | 14 +++---
 migration/options.c                 |  7 ++-
 migration/qemu-file.c               | 77 ++++-------------------------
 migration/ram.c                     | 34 +++++++------
 migration/rdma.c                    | 64 +++++++++++++-----------
 migration/savevm.c                  | 21 ++++++--
 migration/vmstate.c                 |  3 ++
 migration/meson.build               |  2 +-
 migration/trace-events              |  3 ++
 20 files changed, 268 insertions(+), 191 deletions(-)

-- 
2.40.1



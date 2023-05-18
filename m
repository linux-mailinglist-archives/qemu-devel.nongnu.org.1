Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86B708680
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhBv-0006UC-LM; Thu, 18 May 2023 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhBs-0006S3-EZ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhBm-0000eO-7C
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684429996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7jHLOJ/fovLPHO+HB81m3zS5JeaSlxzye6WGnDjYbc=;
 b=O3l99DbI/xqlq0sXsBT2pKDpp/ZVxdli/3sTN2yfhJUCErQqnbkHp7o0/Y12dnK/NG9sQM
 +M4rANqJj4lsbWh+tTCmNT/EGwlJEghyuhMm7/rYQ3vQ5T30m4rz0l8LK3NhdTdAzThw+l
 n2jzzhqDmT1m3AVPKOHZxI8SjZkJMQI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-yJ6AeEfaOEuRdZL6lwhdXg-1; Thu, 18 May 2023 13:13:13 -0400
X-MC-Unique: yJ6AeEfaOEuRdZL6lwhdXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAD011C04321;
 Thu, 18 May 2023 17:13:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 674BF40C6EC4;
 Thu, 18 May 2023 17:13:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Juan Quintela <quintela@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/12] Migration 20230518 patches
Date: Thu, 18 May 2023 19:12:52 +0200
Message-Id: <20230518171304.95006-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The following changes since commit 266ccbb27b3ec6661f22395ec2c41d854c94d761:

  Merge tag 'pull-target-arm-20230518' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-05-18 06:08:30 -0700)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20230518-pull-request

for you to fetch changes up to ba9d2cbc01b4e33f9a97edcd77247831a333eac2:

  migration: Fix duplicated included in meson.build (2023-05-18 18:41:53 +0200)

----------------------------------------------------------------
Migration Pull request

Hi

Based on latest reviewed parts of migration:
- Disable colo (vladimir)
- Migration atomic counters (juan)

Please apply.

----------------------------------------------------------------

Juan Quintela (9):
  migration: Don't use INT64_MAX for unlimited rate
  qemu-file: Account for rate_limit usage on qemu_fflush()
  migration: Move rate_limit_max and rate_limit_used to migration_stats
  migration: Move migration_total_bytes() to migration-stats.c
  migration: Add a trace for migration_transferred_bytes
  migration: Use migration_transferred_bytes() to calculate rate_limit
  migration: We don't need the field rate_limit_used anymore
  migration/multifd: Compute transferred bytes correctly
  migration: Fix duplicated included in meson.build

Vladimir Sementsov-Ogievskiy (3):
  configure: add --disable-colo-proxy option
  migration: split migration_incoming_co
  migration: process_incoming_migration_co(): move colo part to colo

 include/migration/colo.h            |  9 ++++-
 include/migration/qemu-file-types.h | 12 +++++-
 migration/migration-stats.h         | 55 ++++++++++++++++++++++++++++
 migration/migration.h               |  9 ++++-
 migration/options.h                 |  7 ----
 migration/qemu-file.h               | 11 ------
 hw/ppc/spapr.c                      |  4 +-
 hw/s390x/s390-stattrib.c            |  2 +-
 migration/block-dirty-bitmap.c      |  2 +-
 migration/block.c                   |  5 ++-
 migration/colo.c                    | 43 ++++++++++++++++++++--
 migration/migration-stats.c         | 51 ++++++++++++++++++++++++++
 migration/migration.c               | 57 ++++++++---------------------
 migration/multifd.c                 | 14 ++++---
 migration/options.c                 |  7 ++--
 migration/qemu-file.c               | 55 ++--------------------------
 migration/ram.c                     |  2 +-
 migration/rdma.c                    |  5 +--
 migration/savevm.c                  |  2 +-
 stubs/colo-compare.c                |  7 ++++
 stubs/colo.c                        |  6 +--
 meson_options.txt                   |  2 +
 migration/meson.build               |  3 +-
 migration/trace-events              |  3 ++
 net/meson.build                     | 13 +++++--
 scripts/meson-buildoptions.sh       |  3 ++
 stubs/meson.build                   |  1 +
 27 files changed, 242 insertions(+), 148 deletions(-)
 create mode 100644 stubs/colo-compare.c

-- 
2.40.1



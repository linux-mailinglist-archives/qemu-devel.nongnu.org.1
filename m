Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9B7E0282
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:06:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qysvJ-0007OA-Cj; Fri, 03 Nov 2023 08:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysv3-0007Jh-8L
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysv1-0001Ty-E7
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699013094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hReB1MhV9OsgUMaQuV8GIOOcl2eYaz5BSd1LeWnLN3Q=;
 b=CB+UBjq0UycXa0fG1wpv02TTl2GxQbcC0Z2qFgxLTlQ3xX7g/ODV7rx6LEiZAY3zYgjK1Q
 NiOmqubJk8c70wIYj9aPw1pF8Ce2jSxquICKRVjfiV1P4cZI9JI9cj3S81f60ZTOvHoptL
 bZD6B6Rt5JvYaTQQpvLFeGZu4mpxV4Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-WpIps51sP--SrbkklDt3Ag-1; Fri,
 03 Nov 2023 08:04:51 -0400
X-MC-Unique: WpIps51sP--SrbkklDt3Ag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80A8F29AA38E;
 Fri,  3 Nov 2023 12:04:51 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8BFF492BE0;
 Fri,  3 Nov 2023 12:04:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 0/7] Migration 20231103 patches
Date: Fri,  3 Nov 2023 13:04:41 +0100
Message-ID: <20231103120448.58428-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231103-pull-request

for you to fetch changes up to 0983125b405c479a6e7eb49b81cfdae969e28cee:

  migration: Unlock mutex in error case (2023-11-03 10:48:37 +0100)

----------------------------------------------------------------
Migration Pull request (20231103)

Hi

In this PULL:
- dirty limit fixes (hyman)
- coverity issues (juan)

Please apply.

----------------------------------------------------------------

Hyman Huang (6):
  system/dirtylimit: Fix a race situation
  system/dirtylimit: Drop the reduplicative check
  tests: Add migration dirty-limit capability test
  tests/migration: Introduce dirty-ring-size option into guestperf
  tests/migration: Introduce dirty-limit into guestperf
  docs/migration: Add the dirty limit section

Juan Quintela (1):
  migration: Unlock mutex in error case

 docs/devel/migration.rst                |  71 ++++++++++
 migration/ram.c                         | 106 +++++++--------
 system/dirtylimit.c                     |  24 ++--
 tests/qtest/migration-test.c            | 164 ++++++++++++++++++++++++
 tests/migration/guestperf/comparison.py |  23 ++++
 tests/migration/guestperf/engine.py     |  23 +++-
 tests/migration/guestperf/hardware.py   |   8 +-
 tests/migration/guestperf/progress.py   |  16 ++-
 tests/migration/guestperf/scenario.py   |  11 +-
 tests/migration/guestperf/shell.py      |  24 +++-
 10 files changed, 399 insertions(+), 71 deletions(-)

-- 
2.41.0



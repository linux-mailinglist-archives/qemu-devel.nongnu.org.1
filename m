Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF5718183
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:24:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LoS-0006QF-Ir; Wed, 31 May 2023 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoI-0005qN-Pv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4Lo6-0004Lm-MA
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685539445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N0STxZxV6Zrx1DSghZHkWO92v8cEg6JqumT5Afo702U=;
 b=ZZ1ajgfOBsvO+iEyZhQFMvB2FWF7sW5Nv3UGB88HTGIUWWNu8N00pO3PUDSV1+oUfHQ+dZ
 LS+Uq98b2xrMukz44d1WTb53drz4kBGEFg71YVPBveuYEb2T161ocK756sLNFts8fcltK9
 6q3Uci5NbsEhBmi/0D6I41ajzxrThy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-4nL8KYQUOGqCK8FJLzh_TA-1; Wed, 31 May 2023 09:24:04 -0400
X-MC-Unique: 4nL8KYQUOGqCK8FJLzh_TA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2D9E803471
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:24:03 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12C3F170ED;
 Wed, 31 May 2023 13:24:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/9] tests/qtest: make migration-test massively faster
Date: Wed, 31 May 2023 14:23:51 +0100
Message-Id: <20230531132400.1129576-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

This makes migration-test faster by observing that most of the pre-copy
tests don't need to be doing a live migration. They get sufficient code
coverage with the guest CPUs paused.

On my machine this cuts the overall execution time of migration-test
from 13 minutes, down to 8 minutes, without sacrificing any noticeable
code coverage.

Of the tests which do still run in live mode, some need to guarantee
a certain number of iterions. This is achieved by running the 1
iteration with an incredibly small bandwidth and max downtime to
prevent convergance, and watching query-migrate for the reported
iteration to increment. This guarantees that all the tests take at
least 30 seconds to run per iteration required.

Watching for the iteration counter to flip is inefficient and not
actually needed, except on the final iteration before starting
convergance. On this final iteration we merely need to prove that
some amount of already transferred data has been made dirty again.
This in turn will guarantee that a further iteration is required
beyond the current one. This proof is easy to achieve by monitoring
the values at two distinct addresses in guest RAM, and can cut the
30 second duration down to 1 second for one of the iterations.

After this this second optimization the runtime is reduced from
8 minutes, down to 1 minute 40 seconds, which is pretty decent given
the amount of coverage we're getting.

Daniel P. Berrangé (9):
  tests/qtest: add various qtest_qmp_assert_success() variants
  tests/qtest: add support for callback to receive QMP events
  tests/qtest: get rid of 'qmp_command' helper in migration test
  tests/qtest: get rid of some 'qtest_qmp' usage in migration test
  tests/qtest: switch to using event callbacks for STOP event
  tests/qtest: replace wait_command() with qtest_qmp_assert_success
  tests/qtest: capture RESUME events during migration
  tests/qtest: make more migration pre-copy scenarios run non-live
  tests/qtest: massively speed up migration-test

 tests/qtest/libqtest.c          | 119 ++++++++-
 tests/qtest/libqtest.h          | 152 ++++++++++-
 tests/qtest/migration-helpers.c | 101 ++-----
 tests/qtest/migration-helpers.h |  16 +-
 tests/qtest/migration-test.c    | 458 ++++++++++++++++++++------------
 5 files changed, 577 insertions(+), 269 deletions(-)

-- 
2.40.1



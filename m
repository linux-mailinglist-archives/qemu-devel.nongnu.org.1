Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A9756C1B
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:30:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLSyJ-0002l0-Kp; Mon, 17 Jul 2023 14:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLSy2-0002hW-8M
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLSy0-0004mT-0F
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689618543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lH6trQ9jMaZrFsZKHvnYglRDkIxKczBUOX+TamJOO+M=;
 b=c3iYwdXXE6/x1qM+aAs+9rnRqk2OiVsg7ukgWK1ouLTy9wXiKsmEmMbTPlv+12gE14BE1s
 u/EEHGTjmzlucIoUO79OWFIaR/enerPplNVawCVSelSiNvhwx58p49Ez44a2cePuBmvFkR
 +fekjoUOnK18DY/KId2WLDLFWCNKFc4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-xFRyZB55PDKMjt9WTdRPSQ-1; Mon, 17 Jul 2023 14:29:01 -0400
X-MC-Unique: xFRyZB55PDKMjt9WTdRPSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07086280BC98;
 Mon, 17 Jul 2023 18:29:01 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF5E72166B26;
 Mon, 17 Jul 2023 18:28:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/12] tests: enable meson test timeouts to improve
 debuggability
Date: Mon, 17 Jul 2023 19:28:46 +0100
Message-ID: <20230717182859.707658-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Perhaps the most painful of all the GitLab CI failures we see are
the enforced job timeouts:

   "ERROR: Job failed: execution took longer than 1h15m0s seconds"

   https://gitlab.com/qemu-project/qemu/-/jobs/4387047648

when that hits the CI log shows what has *already* run, but figuring
out what was currently running (or rather stuck) is an horrendously
difficult.

The initial meson port disabled the meson test timeouts, in order to
limit the scope for introducing side effects from the port that would
complicate adoption.

Now that the meson port is basically finished we can take advantage of
more of its improved features. It has the ability to set timeouts for
test programs, defaulting to 30 seconds, but overridable per test. This
is further helped by fact that we changed the iotests integration so
that each iotests was a distinct meson test, instead of having one
single giant (slow) test.

We already set overrides for a bunch of tests, but they've not been
kept up2date since we had timeouts disabled. So this series first
updates the timeout overrides such that all tests pass when run in
my test gitlab CI pipeline. Then it enables use of meson timeouts.

We might still hit timeouts due to non-deterministic performance of
gitlab CI runners. So we'll probably have to increase a few more
timeouts in the short term. Fortunately this is going to be massively
easier to diagnose. For example this job during my testing:

   https://gitlab.com/berrange/qemu/-/jobs/4392029495

we can immediately see  the problem tests

Summary of Failures:
  6/252 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test                TIMEOUT        120.02s   killed by signal 15 SIGTERM
  7/252 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test          TIMEOUT        120.03s   killed by signal 15 SIGTERM
 64/252 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test                  TIMEOUT        300.03s   killed by signal 15 SIGTERM

The full meson testlog.txt will show each individual TAP log output,
so we can then see exactly which test case we got stuck on.

NB, the artifacts are missing on the job links above, until this
patch merges:

   https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04668.html

Changed in v2:

 * Increase timeouts for many more tests, such that
   an --enable-debug build stands a better chance of
   passing tests too, without the user manually setting
   a timeout multiplier for meson.

Daniel P. Berrangé (12):
  qtest: bump min meson timeout to 60 seconds
  qtest: bump migration-test timeout to 5 minutes
  qtest: bump qom-test timeout to 15 minutes
  qtest: bump npcm7xx_pwn-test timeout to 5 minutes
  qtest: bump test-hmp timeout to 4 minutes
  qtest: bump pxe-test timeout to 3 minutes
  qtest: bump prom-env-test timeout to 3 minutes
  qtest: bump boot-serial-test timeout to 3 minutes
  qtest: bump qos-test timeout to 2 minutes
  qtest: bump aspeed_smc-test timeout to 4 minutes
  qtest: bump bios-table-test timeout to 9 minutes
  mtest2make: stop disabling meson test timeouts

 scripts/mtest2make.py   |  3 ++-
 tests/qtest/meson.build | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.41.0



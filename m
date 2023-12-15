Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 089DF814222
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 08:06:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE2F5-0003sl-S6; Fri, 15 Dec 2023 02:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rE2Ez-0003ql-P7
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 02:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rE2Ex-0000sX-H5
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 02:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702623845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PV/2spyMqX8TnPUaQotmlgq88BuiifILAJNIEIiYOn0=;
 b=L/wMLtTzp1v7BhSQIuEm2cGC8e2imSfE8Iap2mDHytQwt0O0nN1Tg5qcd+4o76TSM+Rii4
 buJYUxK0Xrr8wg7J9m+Fxd+TTry9VgOO0PKd0CJUI3J/LpTGVUUiSfydxEaqRn7d57FVHt
 ay+WQgVZ5RMxPGe/X5v6dNdiS2qtlqk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-EbRK_yE5P4CH3Nrb844SfA-1; Fri,
 15 Dec 2023 02:04:01 -0500
X-MC-Unique: EbRK_yE5P4CH3Nrb844SfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89C7380662C;
 Fri, 15 Dec 2023 07:04:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51ECD2026D66;
 Fri, 15 Dec 2023 07:03:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/16] tests: enable meson test timeouts to improve
 debuggability
Date: Fri, 15 Dec 2023 08:03:41 +0100
Message-ID: <20231215070357.10888-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

This is a respin of Daniel's series that re-enables the meson test
runner timeouts. To make sure that we do not get into trouble on
older systems, I ran all the tests with "make check SPEED=slow -j32"
on my laptop that has only 16 SMT threads, so each test was running
quite a bit slower than with a normal "-j$(nproc)" run. I think
that these timeouts should now work in most cases - if not, we still
can adjust them easily later.

Daniel's original patch series description follows:

---------------------------- 8< -------------------------------------

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

---------------------------- 8< -------------------------------------

Daniel P. Berrangé (12):
  qtest: bump min meson timeout to 60 seconds
  qtest: bump migration-test timeout to 8 minutes
  qtest: bump qom-test timeout to 15 minutes
  qtest: bump npcm7xx_pwn-test timeout to 5 minutes
  qtest: bump test-hmp timeout to 4 minutes
  qtest: bump pxe-test timeout to 10 minutes
  qtest: bump prom-env-test timeout to 6 minutes
  qtest: bump boot-serial-test timeout to 3 minutes
  qtest: bump qos-test timeout to 2 minutes
  qtest: bump aspeed_smc-test timeout to 6 minutes
  qtest: bump bios-table-test timeout to 9 minutes
  mtest2make: stop disabling meson test timeouts

Thomas Huth (4):
  tests/qtest: Bump the device-introspect-test timeout to 12 minutes
  tests/unit: Bump test-aio-multithread test timeout to 2 minutes
  tests/unit: Bump test-crypto-block test timeout to 5 minutes
  tests/fp: Bump fp-test-mulAdd test timeout to 3 minutes

 scripts/mtest2make.py   |  3 ++-
 tests/fp/meson.build    |  2 +-
 tests/qtest/meson.build | 25 +++++++++++++------------
 tests/unit/meson.build  |  2 ++
 4 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.43.0



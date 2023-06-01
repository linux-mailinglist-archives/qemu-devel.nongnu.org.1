Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D671EF18
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lD4-0002W6-Nu; Thu, 01 Jun 2023 12:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lD2-0002Vb-Fq
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lD0-0007FA-Mv
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685637089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gLjqzzdiskjaUYNfvxkCygJlMWGcu53CK/3YZWV5Q7k=;
 b=MWr79uiCNojzdyyVtXlB1lLxPT8dT6cpqvWZnWxvfTG7IyeMNeTv0EPvjWP5QUOPNF47kM
 P6/hq6lkyRqkQv7ydP6LQcNnbN2HHPcwG8nBzdUtgRMTx8cH6g+rSDIDKoN9qTsmO45li7
 P53TaeIvtKfiPbj8E1hkgchATHLByBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510--t2gxMXoNEy1RwKzA7qV8Q-1; Thu, 01 Jun 2023 12:31:26 -0400
X-MC-Unique: -t2gxMXoNEy1RwKzA7qV8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23137101AA44;
 Thu,  1 Jun 2023 16:31:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91E862166B25;
 Thu,  1 Jun 2023 16:31:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] tests: enable meson test timeouts to improve debuggability
Date: Thu,  1 Jun 2023 17:31:17 +0100
Message-Id: <20230601163123.1805282-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

NB, this series sets the migration-test timeout to 5 minutes, which
is only valid if this series is merged to make the migration test
not suck:

  https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00286.html

without that series, we'll need to set the migration-test timeout to
30 minutes instead.

Daniel P. Berrangé (6):
  qtest: bump min meson timeout to 60 seconds
  qtest: bump migration-test timeout to 5 minutes
  qtest: bump qom-test timeout to 7 minutes
  qtest: bump aspeed_smc-test timeout to 2 minutes
  qtest: bump bios-table-test timeout to 6 minutes
  mtest2make: stop disabling meson test timeouts

 scripts/mtest2make.py   |  3 ++-
 tests/qtest/meson.build | 16 ++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.40.1



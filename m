Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF2A91B18
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 13:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Nbg-0006eh-QO; Thu, 17 Apr 2025 07:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u5Nbb-0006co-H8
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:40:32 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u5NbX-0003fF-Ny
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:40:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4195:0:640:137b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3F74360E85;
 Thu, 17 Apr 2025 14:40:22 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6b8:b081:8014::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FeHLbV5FamI0-rsqcvn0f; Thu, 17 Apr 2025 14:40:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744890021;
 bh=lRTA0dnyXW+bE/I759jXbwr6fCfRClqebKvBuqzXPYs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=r5LizdYJGkAXNXNHT1czjAQpqjSvX9Vho0osO8e2nw/bT5iTvGuZAEq5Wkufk+/ZD
 QCdgHE0D4Den66mAn3XbXqQPtMEbRRphUT48sT+DJ5pr3iOcDS5ixk+uGVed+xuKSp
 WtnLvcfjwkT7ye1CTX/gIi7ylXqXPnOtLNUuA1Pc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v6 0/2] tests/functional: add memlock tests
Date: Thu, 17 Apr 2025 16:40:07 +0500
Message-Id: <20250417114008.169350-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add new tests to check the correctness of the `-overcommit memlock`
option (possible values: off, on, on-fault) by using
`/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
anonymous segments:

* if `memlock=off`, then Locked = 0 on every anonymous smaps;
* if `memlock=on`, then Size, Rss and Locked values must be equal for
every anon smaps where Rss is not 0;
* if `memlock=on-fault`, then Rss and Locked must be equal on every anon
smaps and anonymous segment with Rss < Size must exists.

---

v5 -> v6:
* add python3 shebang to tests/functional/test_memlock.py

v4 -> v5:
* refactor skipLockedMemoryTest decorator: using resource.getrlimit()
  function instead of spawning a process

v3 -> v4:
* add skipLockedMemoryTest decorator to skip test if system's locked
  memory limit is below the required threashold;
* add to MemlockTest skipLockedMemoryTest decorator with 2 GB limit.

v2 -> v3:
Move tests to tests/functional dir, as the tests/avocado dir is being phased out.
v2 was [PATCH v2] tests/avocado: add memlock tests.
Supersedes: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>

v1 -> v2:
In the previous send, i forgot to specify new patch version (v2)
So i resend previous patch with version specified.


Alexandr Moshkov (2):
  tests/functional: add skipLockedMemoryTest decorator
  tests/functional: add memlock tests

 tests/functional/meson.build             |   1 +
 tests/functional/qemu_test/__init__.py   |   2 +-
 tests/functional/qemu_test/decorators.py |  18 ++++
 tests/functional/test_memlock.py         | 104 +++++++++++++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_memlock.py

-- 
2.34.1



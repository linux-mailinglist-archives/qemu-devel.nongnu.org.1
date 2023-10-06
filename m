Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D57BBBF9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomxi-0006ZX-EY; Fri, 06 Oct 2023 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxf-0006Yb-Tz; Fri, 06 Oct 2023 11:41:55 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxX-0003Vg-Lf; Fri, 06 Oct 2023 11:41:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 1584760DA8;
 Fri,  6 Oct 2023 18:41:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VfbK2W5OrKo0-auSLcbq5; Fri, 06 Oct 2023 18:41:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696606900;
 bh=UniU2JTIAvUQj65e52ol/M928RVmEpiMwNO5GIM9jRU=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=BpQUPvCkoFZVA+7HRPdy85E53H2oqYigF4Z1l+o5PmgXFfYTnoTFwyvLmPtGVwa2Q
 3Fb1Xh1X82Jm3yhrsm1Ehgxfvvc/hAvER5Y4FEzL0YtPrFPEoLLQEXaadUTMc0mTul
 lji7EDAQBiUNBTPzk/ly1eRiu6/GxLCWvioONsgw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com
Subject: [PATCH v7 00/15] iotests: use vm.cmd()
Date: Fri,  6 Oct 2023 18:41:10 +0300
Message-Id: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all!

Let's get rid of pattern

    result = self.vm.qmp(...)
    self.assert_qmp(result, 'return', {})

And switch to just

    self.vm.cmd(...)

v7: add r-bs and small wording/grammar fixes by Eric
  05: handle missed tests/avocado/machine_aspeed.py, keep r-bs
  10: patch renamed: s/occasional/extra/
  14: new
  15: rebuilt with the script: some hunks are added, old are unchanged
      (look comparison with previous version in patchew or by
       git check-rebase)

Vladimir Sementsov-Ogievskiy (15):
  python/qemu/qmp/legacy: cmd(): drop cmd_id unused argument
  qmp_shell.py: _fill_completion() use .command() instead of .cmd()
  scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()
  python: rename QEMUMonitorProtocol.cmd() to cmd_raw()
  python/qemu: rename command() to cmd()
  python/machine.py: upgrade vm.cmd() method
  iotests: QemuStorageDaemon: add cmd() method like in QEMUMachine.
  iotests: add some missed checks of qmp result
  iotests: refactor some common qmp result checks into generic pattern
  iotests: drop some extra semicolons
  iotests: drop some extra ** in qmp() call
  iotests.py: pause_job(): drop return value
  tests/vm/basevm.py: use cmd() instead of qmp()
  scripts: add python_qmp_updater.py
  python: use vm.cmd() instead of vm.qmp() where appropriate

 docs/devel/testing.rst                        |  10 +-
 python/qemu/machine/machine.py                |  20 +-
 python/qemu/qmp/legacy.py                     |  10 +-
 python/qemu/qmp/qmp_shell.py                  |  20 +-
 python/qemu/utils/qemu_ga_client.py           |   2 +-
 python/qemu/utils/qom.py                      |   8 +-
 python/qemu/utils/qom_common.py               |   2 +-
 python/qemu/utils/qom_fuse.py                 |   6 +-
 scripts/cpu-x86-uarch-abi.py                  |   8 +-
 scripts/device-crash-test                     |   8 +-
 scripts/python_qmp_updater.py                 | 136 +++++
 scripts/render_block_graph.py                 |   8 +-
 tests/avocado/avocado_qemu/__init__.py        |   4 +-
 tests/avocado/cpu_queries.py                  |   5 +-
 tests/avocado/hotplug_cpu.py                  |  10 +-
 tests/avocado/info_usernet.py                 |   4 +-
 tests/avocado/machine_arm_integratorcp.py     |   6 +-
 tests/avocado/machine_aspeed.py               |  12 +-
 tests/avocado/machine_m68k_nextcube.py        |   4 +-
 tests/avocado/machine_mips_malta.py           |   6 +-
 tests/avocado/machine_s390_ccw_virtio.py      |  28 +-
 tests/avocado/migration.py                    |  10 +-
 tests/avocado/pc_cpu_hotplug_props.py         |   2 +-
 tests/avocado/version.py                      |   4 +-
 tests/avocado/virtio_check_params.py          |   6 +-
 tests/avocado/virtio_version.py               |   5 +-
 tests/avocado/vnc.py                          |  16 +-
 tests/avocado/x86_cpu_model_versions.py       |  13 +-
 tests/migration/guestperf/engine.py           | 150 +++---
 tests/qemu-iotests/030                        | 168 +++---
 tests/qemu-iotests/040                        | 171 +++----
 tests/qemu-iotests/041                        | 482 ++++++++----------
 tests/qemu-iotests/045                        |  15 +-
 tests/qemu-iotests/055                        |  62 +--
 tests/qemu-iotests/056                        |  77 ++-
 tests/qemu-iotests/093                        |  42 +-
 tests/qemu-iotests/118                        | 225 ++++----
 tests/qemu-iotests/124                        | 102 ++--
 tests/qemu-iotests/129                        |  14 +-
 tests/qemu-iotests/132                        |   5 +-
 tests/qemu-iotests/139                        |  45 +-
 tests/qemu-iotests/147                        |  30 +-
 tests/qemu-iotests/151                        | 103 ++--
 tests/qemu-iotests/152                        |   8 +-
 tests/qemu-iotests/155                        |  55 +-
 tests/qemu-iotests/165                        |   8 +-
 tests/qemu-iotests/196                        |   3 +-
 tests/qemu-iotests/205                        |   6 +-
 tests/qemu-iotests/218                        | 105 ++--
 tests/qemu-iotests/245                        | 245 ++++-----
 tests/qemu-iotests/256                        |  34 +-
 tests/qemu-iotests/257                        |  36 +-
 tests/qemu-iotests/264                        |  31 +-
 tests/qemu-iotests/281                        |  21 +-
 tests/qemu-iotests/295                        |  16 +-
 tests/qemu-iotests/296                        |  21 +-
 tests/qemu-iotests/298                        |  13 +-
 tests/qemu-iotests/300                        |  54 +-
 tests/qemu-iotests/iotests.py                 |  21 +-
 .../tests/backing-file-invalidation           |  11 +-
 tests/qemu-iotests/tests/copy-before-write    |  15 +-
 .../tests/export-incoming-iothread            |   6 +-
 .../qemu-iotests/tests/graph-changes-while-io |  18 +-
 tests/qemu-iotests/tests/image-fleecing       |   3 +-
 .../tests/migrate-bitmaps-postcopy-test       |  31 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test |  45 +-
 .../qemu-iotests/tests/migrate-during-backup  |  41 +-
 .../qemu-iotests/tests/migration-permissions  |   9 +-
 .../tests/mirror-ready-cancel-error           |  74 ++-
 tests/qemu-iotests/tests/mirror-top-perms     |  16 +-
 tests/qemu-iotests/tests/nbd-multiconn        |  12 +-
 tests/qemu-iotests/tests/reopen-file          |   3 +-
 .../qemu-iotests/tests/stream-error-on-reset  |   6 +-
 .../qemu-iotests/tests/stream-under-throttle  |   7 +-
 tests/vm/basevm.py                            |   4 +-
 75 files changed, 1367 insertions(+), 1675 deletions(-)
 create mode 100755 scripts/python_qmp_updater.py

-- 
2.34.1



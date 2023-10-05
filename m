Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1001F7B9DEC
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOqA-0000AG-Vp; Thu, 05 Oct 2023 09:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOpw-0008WP-1U; Thu, 05 Oct 2023 09:56:20 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOpn-0001wG-NB; Thu, 05 Oct 2023 09:56:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id BC5E95E774;
 Thu,  5 Oct 2023 16:56:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qtYmoW4Oi4Y0-UJwhn3k2; Thu, 05 Oct 2023 16:56:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696514166;
 bh=EPcpmXOBCWwLXR6CAXy9kt7iYvbA5gG07SjgyiMBexU=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=0k8NYMv981TXJimf0nKPhhWG2wRWqUWGdJZTEACbYFoYze7HjJ2VIVF8tlqd5rR6m
 vpseDra6T4TfXJPHSk8LhLFnjQXklmQC0irh4t/FaX9oHFKaHhLIiaTkX01jkPTtlY
 H99A5vP1yFcBKWyTupeD3owrQOU6nAgv4six+k0s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 00/14] iotests: use vm.cmd()
Date: Thu,  5 Oct 2023 16:55:36 +0300
Message-Id: <20231005135550.331657-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

v6: rebase on master

Vladimir Sementsov-Ogievskiy (14):
  python/qemu/qmp/legacy: cmd(): drop cmd_id unused argument
  qmp_shell.py: _fill_completion() use .command() instead of .cmd()
  scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()
  python: rename QEMUMonitorProtocol.cmd() to cmd_raw()
  python/qemu: rename command() to cmd()
  python/machine.py: upgrade vm.cmd() method
  iotests: QemuStorageDaemon: add cmd() method like in QEMUMachine.
  iotests: add some missed checks of qmp result
  iotests: refactor some common qmp result checks into generic pattern
  iotests: drop some occasional semicolons
  iotests: drop some extra ** in qmp() call
  iotests.py: pause_job(): drop return value
  tests/vm/basevm.py: use cmd() instead of qmp()
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
 scripts/render_block_graph.py                 |   8 +-
 tests/avocado/avocado_qemu/__init__.py        |   4 +-
 tests/avocado/cpu_queries.py                  |   5 +-
 tests/avocado/hotplug_cpu.py                  |  10 +-
 tests/avocado/info_usernet.py                 |   4 +-
 tests/avocado/machine_arm_integratorcp.py     |   6 +-
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
 tests/qemu-iotests/151                        |  56 +-
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
 .../tests/export-incoming-iothread            |   6 +-
 .../qemu-iotests/tests/graph-changes-while-io |   6 +-
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
 tests/vm/basevm.py                            |   4 +-
 70 files changed, 1188 insertions(+), 1614 deletions(-)

-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FE7C8D85
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNXn-0006Ug-Do; Fri, 13 Oct 2023 15:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNXl-0006U8-3Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNXi-0001ZU-2Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eC6AjDlIvMTiZth3TEPCkJHOJ7BUyz4tXU1pEWCvznQ=;
 b=Gb1zK+QXl3CaQ3uv1LP+vnIsVHUI8kHkLz7ecyFxjRuUN/TKaZz8E7zYwRxGH7VLZyZ5cd
 fDjuwQcrT/0tSxg1SjwCQUDNn7pFyv8y7m0YOZWE/b35SjMqgFOG4rGku4x4YQDAjGo94V
 3rTrFogw+1G1vdufSQ4kIWaowWdYFAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-Cojth_ZoPoaKgp8_3KFJmw-1; Fri, 13 Oct 2023 15:09:44 -0400
X-MC-Unique: Cojth_ZoPoaKgp8_3KFJmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F341801E80;
 Fri, 13 Oct 2023 19:09:43 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8F940C6F79;
 Fri, 13 Oct 2023 19:09:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 00/25] Python patches
Date: Fri, 13 Oct 2023 15:09:15 -0400
Message-ID: <20231013190941.3699288-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=216.145.221.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2=
:=0D
=0D
  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into=
 staging (2023-10-11 09:43:10 -0400)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to b6aed193e5ecca32bb07e062f58f0daca06e7009:=0D
=0D
  python: use vm.cmd() instead of vm.qmp() where appropriate (2023-10-12 14=
:21:44 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python Pullreq=0D
=0D
Python PR:=0D
=0D
- Use socketpair for all machine.py connections=0D
- Support Python 3.12=0D
- Switch iotests over to using raise-on-error QMP command interface=0D
  (Thank you very much, Vladimir!)=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (10):=0D
  python/machine: move socket setup out of _base_args property=0D
  python/machine: close sock_pair in cleanup path=0D
  python/console_socket: accept existing FD in initializer=0D
  python/machine: use socketpair() for console connections=0D
  python/machine: use socketpair() for qtest connection=0D
  python/machine: remove unused sock_dir argument=0D
  Python/iotests: Add type hint for nbd module=0D
  python/qmp: remove Server.wait_closed() call for Python 3.12=0D
  configure: fix error message to say Python 3.8=0D
  Python: Enable python3.12 support=0D
=0D
Vladimir Sementsov-Ogievskiy (15):=0D
  python/qemu/qmp/legacy: cmd(): drop cmd_id unused argument=0D
  qmp_shell.py: _fill_completion() use .command() instead of .cmd()=0D
  scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()=0D
  python: rename QEMUMonitorProtocol.cmd() to cmd_raw()=0D
  python/qemu: rename command() to cmd()=0D
  python/machine.py: upgrade vm.cmd() method=0D
  iotests: QemuStorageDaemon: add cmd() method like in QEMUMachine.=0D
  iotests: add some missed checks of qmp result=0D
  iotests: refactor some common qmp result checks into generic pattern=0D
  iotests: drop some extra semicolons=0D
  iotests: drop some extra ** in qmp() call=0D
  iotests.py: pause_job(): drop return value=0D
  tests/vm/basevm.py: use cmd() instead of qmp()=0D
  scripts: add python_qmp_updater.py=0D
  python: use vm.cmd() instead of vm.qmp() where appropriate=0D
=0D
 docs/devel/testing.rst                        |  10 +-=0D
 configure                                     |   5 +-=0D
 python/qemu/machine/console_socket.py         |  29 +-=0D
 python/qemu/machine/machine.py                |  78 +--=0D
 python/qemu/machine/qtest.py                  |  54 +-=0D
 python/qemu/qmp/legacy.py                     |  10 +-=0D
 python/qemu/qmp/protocol.py                   |   1 -=0D
 python/qemu/qmp/qmp_shell.py                  |  20 +-=0D
 python/qemu/utils/qemu_ga_client.py           |   2 +-=0D
 python/qemu/utils/qom.py                      |   8 +-=0D
 python/qemu/utils/qom_common.py               |   2 +-=0D
 python/qemu/utils/qom_fuse.py                 |   6 +-=0D
 python/setup.cfg                              |   3 +-=0D
 scripts/cpu-x86-uarch-abi.py                  |   8 +-=0D
 scripts/device-crash-test                     |   8 +-=0D
 scripts/python_qmp_updater.py                 | 136 +++++=0D
 scripts/render_block_graph.py                 |   8 +-=0D
 tests/avocado/acpi-bits.py                    |   5 +-=0D
 tests/avocado/avocado_qemu/__init__.py        |   6 +-=0D
 tests/avocado/cpu_queries.py                  |   5 +-=0D
 tests/avocado/hotplug_cpu.py                  |  10 +-=0D
 tests/avocado/info_usernet.py                 |   4 +-=0D
 tests/avocado/machine_arm_integratorcp.py     |   6 +-=0D
 tests/avocado/machine_aspeed.py               |  17 +-=0D
 tests/avocado/machine_m68k_nextcube.py        |   4 +-=0D
 tests/avocado/machine_mips_malta.py           |   6 +-=0D
 tests/avocado/machine_s390_ccw_virtio.py      |  28 +-=0D
 tests/avocado/migration.py                    |  10 +-=0D
 tests/avocado/pc_cpu_hotplug_props.py         |   2 +-=0D
 tests/avocado/version.py                      |   4 +-=0D
 tests/avocado/virtio_check_params.py          |   6 +-=0D
 tests/avocado/virtio_version.py               |   5 +-=0D
 tests/avocado/vnc.py                          |  16 +-=0D
 tests/avocado/x86_cpu_model_versions.py       |  13 +-=0D
 tests/docker/dockerfiles/python.docker        |   6 +-=0D
 tests/migration/guestperf/engine.py           | 144 +++---=0D
 tests/qemu-iotests/030                        | 168 +++----=0D
 tests/qemu-iotests/040                        | 171 +++----=0D
 tests/qemu-iotests/041                        | 470 ++++++++----------=0D
 tests/qemu-iotests/045                        |  15 +-=0D
 tests/qemu-iotests/055                        |  62 +--=0D
 tests/qemu-iotests/056                        |  77 ++-=0D
 tests/qemu-iotests/093                        |  42 +-=0D
 tests/qemu-iotests/118                        | 223 ++++-----=0D
 tests/qemu-iotests/124                        | 102 ++--=0D
 tests/qemu-iotests/129                        |  14 +-=0D
 tests/qemu-iotests/132                        |   5 +-=0D
 tests/qemu-iotests/139                        |  45 +-=0D
 tests/qemu-iotests/147                        |  30 +-=0D
 tests/qemu-iotests/151                        | 103 ++--=0D
 tests/qemu-iotests/152                        |   8 +-=0D
 tests/qemu-iotests/155                        |  55 +-=0D
 tests/qemu-iotests/165                        |   8 +-=0D
 tests/qemu-iotests/196                        |   3 +-=0D
 tests/qemu-iotests/205                        |   6 +-=0D
 tests/qemu-iotests/218                        |  95 ++--=0D
 tests/qemu-iotests/245                        | 245 ++++-----=0D
 tests/qemu-iotests/256                        |  34 +-=0D
 tests/qemu-iotests/257                        |  34 +-=0D
 tests/qemu-iotests/264                        |  31 +-=0D
 tests/qemu-iotests/281                        |  21 +-=0D
 tests/qemu-iotests/295                        |  16 +-=0D
 tests/qemu-iotests/296                        |  21 +-=0D
 tests/qemu-iotests/298                        |  13 +-=0D
 tests/qemu-iotests/300                        |  54 +-=0D
 tests/qemu-iotests/iotests.py                 |  23 +-=0D
 .../tests/backing-file-invalidation           |  11 +-=0D
 tests/qemu-iotests/tests/copy-before-write    |  18 +-=0D
 .../tests/export-incoming-iothread            |   6 +-=0D
 .../qemu-iotests/tests/graph-changes-while-io |  18 +-=0D
 tests/qemu-iotests/tests/image-fleecing       |   3 +-=0D
 .../tests/migrate-bitmaps-postcopy-test       |  31 +-=0D
 tests/qemu-iotests/tests/migrate-bitmaps-test |  45 +-=0D
 .../qemu-iotests/tests/migrate-during-backup  |  37 +-=0D
 .../qemu-iotests/tests/migration-permissions  |   9 +-=0D
 .../tests/mirror-ready-cancel-error           |  74 ++-=0D
 tests/qemu-iotests/tests/mirror-top-perms     |  16 +-=0D
 tests/qemu-iotests/tests/nbd-multiconn        |  16 +-=0D
 tests/qemu-iotests/tests/reopen-file          |   3 +-=0D
 .../qemu-iotests/tests/stream-error-on-reset  |   6 +-=0D
 .../qemu-iotests/tests/stream-under-throttle  |   7 +-=0D
 tests/vm/basevm.py                            |   4 +-=0D
 82 files changed, 1466 insertions(+), 1717 deletions(-)=0D
 create mode 100755 scripts/python_qmp_updater.py=0D
=0D
-- =0D
2.41.0=0D
=0D



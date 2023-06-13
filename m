Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E89C72E79B
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96Fn-0007ds-Or; Tue, 13 Jun 2023 11:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q96Fl-0007dI-1O; Tue, 13 Jun 2023 11:48:17 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q96Fi-0001Zm-LL; Tue, 13 Jun 2023 11:48:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 8EACA60825;
 Tue, 13 Jun 2023 18:48:01 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8910::1:11] (unknown
 [2a02:6b8:b081:8910::1:11])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0mcIGq1OjSw0-f6RlOyIs; Tue, 13 Jun 2023 18:48:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686671280; bh=qVhkS1Gg1FJqEczCOc6Pb55GQ/4WXyGX8PQUKSuB7Cc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TdRU2UfjQBKfMyV2E9MvAcxVuw8AESLzw8e1GOEL+2lKwz9HTXePmrwbCNM3Xo6or
 B+QvL50M617nV/LzH3QjizpOaTpY6uqiSi/UYRNegFsrvkT3xdXHwgHq1EE/WOFvb6
 4d35Dct+GFUmcGT9rSCRtH6ucKax4i3yVP6/BbqA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <63c42d0d-630b-b509-217c-93889bc9af82@yandex-team.ru>
Date: Tue, 13 Jun 2023 18:48:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 00/16] iotests: use vm.cmd()
Content-Language: en-US
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230215132547.1620575-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230215132547.1620575-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

ping. 03-16 are still applicable to master with "git am -3" and very small conflict in "iotests: QemuStorageDaemon: add cmd() method like in QEMUMachine."

On 15.02.23 16:25, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Let's get rid of pattern
> 
>      result = self.vm.qmp(...)
>      self.assert_qmp(result, 'return', {})
> 
> And switch to just
> 
>      self.vm.cmd(...)
> 
> v5:
> - include fixups by John
> - fix 'make check-dev'
> - split first patch into several [Daniel]
> 
> 
> Vladimir Sementsov-Ogievskiy (16):
>    python: fix superfluous-parens pylint error
>    python: fix broad-exception-raised pylint error
>    python/qemu/qmp/legacy: cmd(): drop cmd_id unused argument
>    qmp_shell.py: _fill_completion() use .command() instead of .cmd()
>    scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()
>    python: rename QEMUMonitorProtocol.cmd() to cmd_raw()
>    python/qemu: rename command() to cmd()
>    python/machine.py: upgrade vm.cmd() method
>    iotests: QemuStorageDaemon: add cmd() method like in QEMUMachine.
>    iotests: add some missed checks of qmp result
>    iotests: refactor some common qmp result checks into generic pattern
>    iotests: drop some occasional semicolons
>    iotests: drop some extra ** in qmp() call
>    iotests.py: pause_job(): drop return value
>    tests/vm/basevm.py: use cmd() instead of qmp()
>    python: use vm.cmd() instead of vm.qmp() where appropriate
> 
>   docs/devel/testing.rst                        |  10 +-
>   python/qemu/machine/machine.py                |  20 +-
>   python/qemu/qmp/legacy.py                     |  10 +-
>   python/qemu/qmp/protocol.py                   |   2 +-
>   python/qemu/qmp/qmp_client.py                 |   2 +-
>   python/qemu/qmp/qmp_shell.py                  |  20 +-
>   python/qemu/utils/qemu_ga_client.py           |   8 +-
>   python/qemu/utils/qom.py                      |   8 +-
>   python/qemu/utils/qom_common.py               |   2 +-
>   python/qemu/utils/qom_fuse.py                 |   6 +-
>   scripts/cpu-x86-uarch-abi.py                  |   8 +-
>   scripts/device-crash-test                     |   8 +-
>   scripts/render_block_graph.py                 |   8 +-
>   tests/avocado/avocado_qemu/__init__.py        |   4 +-
>   tests/avocado/cpu_queries.py                  |   5 +-
>   tests/avocado/hotplug_cpu.py                  |  10 +-
>   tests/avocado/info_usernet.py                 |   4 +-
>   tests/avocado/machine_arm_integratorcp.py     |   6 +-
>   tests/avocado/machine_m68k_nextcube.py        |   4 +-
>   tests/avocado/machine_mips_malta.py           |   6 +-
>   tests/avocado/machine_s390_ccw_virtio.py      |  28 +-
>   tests/avocado/migration.py                    |  10 +-
>   tests/avocado/pc_cpu_hotplug_props.py         |   2 +-
>   tests/avocado/version.py                      |   4 +-
>   tests/avocado/virtio_check_params.py          |   6 +-
>   tests/avocado/virtio_version.py               |   5 +-
>   tests/avocado/vnc.py                          |  16 +-
>   tests/avocado/x86_cpu_model_versions.py       |  13 +-
>   tests/migration/guestperf/engine.py           | 150 +++---
>   tests/qemu-iotests/030                        | 168 +++---
>   tests/qemu-iotests/040                        | 171 +++----
>   tests/qemu-iotests/041                        | 482 ++++++++----------
>   tests/qemu-iotests/045                        |  15 +-
>   tests/qemu-iotests/055                        |  62 +--
>   tests/qemu-iotests/056                        |  77 ++-
>   tests/qemu-iotests/093                        |  42 +-
>   tests/qemu-iotests/118                        | 225 ++++----
>   tests/qemu-iotests/124                        | 102 ++--
>   tests/qemu-iotests/129                        |  14 +-
>   tests/qemu-iotests/132                        |   5 +-
>   tests/qemu-iotests/139                        |  45 +-
>   tests/qemu-iotests/147                        |  30 +-
>   tests/qemu-iotests/151                        |  56 +-
>   tests/qemu-iotests/152                        |   8 +-
>   tests/qemu-iotests/155                        |  55 +-
>   tests/qemu-iotests/165                        |   8 +-
>   tests/qemu-iotests/196                        |   3 +-
>   tests/qemu-iotests/205                        |   6 +-
>   tests/qemu-iotests/218                        | 105 ++--
>   tests/qemu-iotests/245                        | 245 ++++-----
>   tests/qemu-iotests/256                        |  34 +-
>   tests/qemu-iotests/257                        |  36 +-
>   tests/qemu-iotests/264                        |  31 +-
>   tests/qemu-iotests/281                        |  21 +-
>   tests/qemu-iotests/295                        |  16 +-
>   tests/qemu-iotests/296                        |  21 +-
>   tests/qemu-iotests/298                        |  13 +-
>   tests/qemu-iotests/300                        |  54 +-
>   tests/qemu-iotests/iotests.py                 |  25 +-
>   .../tests/export-incoming-iothread            |   6 +-
>   .../qemu-iotests/tests/graph-changes-while-io |   6 +-
>   tests/qemu-iotests/tests/image-fleecing       |   3 +-
>   .../tests/migrate-bitmaps-postcopy-test       |  33 +-
>   tests/qemu-iotests/tests/migrate-bitmaps-test |  45 +-
>   .../qemu-iotests/tests/migrate-during-backup  |  41 +-
>   .../qemu-iotests/tests/migration-permissions  |   9 +-
>   .../tests/mirror-ready-cancel-error           |  74 ++-
>   tests/qemu-iotests/tests/mirror-top-perms     |  16 +-
>   tests/qemu-iotests/tests/nbd-multiconn        |  12 +-
>   tests/qemu-iotests/tests/reopen-file          |   3 +-
>   .../qemu-iotests/tests/stream-error-on-reset  |   6 +-
>   tests/vm/basevm.py                            |   4 +-
>   72 files changed, 1196 insertions(+), 1622 deletions(-)
> 

-- 
Best regards,
Vladimir



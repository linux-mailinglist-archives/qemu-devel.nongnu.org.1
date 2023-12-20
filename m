Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40166819B8B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:42:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt4u-0002Ss-DH; Wed, 20 Dec 2023 04:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4m-0002S0-Pr
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4g-0005gN-QT
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ARCSmU4XprD3GK1uyFnS9MnGkBpFlMml12BMyxdEzus=;
 b=S0mA64OM63SQuAactWeICUSyFpZtu95Rs8WA6IKeTdo8BmHZvvTgDhKKVo1rAIckjIlc8I
 mD0HV+KRM5d0FbP+1zY9Ko5Vvq85y8szdgi84wMo5Ab686JiNN9zHlhGAsM1iOrGT9V7xX
 1FLTh+YcTVH9t5qfwxmrzsmGYNJibH0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-_reMSGISMfCCNe72w6Ik6g-1; Wed,
 20 Dec 2023 04:41:07 -0500
X-MC-Unique: _reMSGISMfCCNe72w6Ik6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 673AD2825E83;
 Wed, 20 Dec 2023 09:41:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53AB52166B31;
 Wed, 20 Dec 2023 09:41:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/19] First batch of misc patches for QEMU 9.0
Date: Wed, 20 Dec 2023 10:40:46 +0100
Message-ID: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

 Hi!

The following changes since commit bd00730ec0f621706d0179768436f82c39048499:

  Open 9.0 development tree (2023-12-19 09:46:22 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-12-20

for you to fetch changes up to 17b2ecc331eab274d448446aa51883040f9185ed:

  tests/unit/test-qmp-event: Replace fixture by global variables (2023-12-20 10:29:23 +0100)

----------------------------------------------------------------
* Add compat machines for QEMU 9.0
* Some header clean-ups by Philippe
* Restrict type names to alphanumerical range (and a few special characters)
* Fix analyze-migration.py script on s390x
* Clean up and improve some tests
* Document handling of commas in CLI options parameters

----------------------------------------------------------------
Cornelia Huck (1):
      hw: Add compat machines for 9.0

Markus Armbruster (5):
      docs/system/arm: Fix for rename of type "xlnx.bbram-ctrl"
      hw: Replace anti-social QOM type names (again)
      tests/unit/test-qmp-event: Drop superfluous mutex
      tests/unit/test-qmp-event: Simplify event emission check
      tests/unit/test-qmp-event: Replace fixture by global variables

Philippe Mathieu-Daudé (6):
      system/qtest: Include missing 'hw/core/cpu.h' header
      system/qtest: Restrict QTest API to system emulation
      hw/ppc/spapr_hcall: Remove unused 'exec/exec-all.h' included header
      hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h' header
      hw/s390x/ipl: Remove unused 'exec/exec-all.h' included header
      target: Restrict 'sysemu/reset.h' to system emulation

Thomas Huth (6):
      MAINTAINERS: Add some more vmware-related files to the corresponding section
      memory: Remove "qemu:" prefix from the "qemu:ram-discard-manager" type name
      tests/unit/test-io-task: Rename "qemu:dummy" to avoid colon in the name
      qom/object: Limit type names to alphanumerical and some few special characters
      tests/qtest/migration-test: Fix analyze-migration.py for s390x
      tests/qtest/npcm7xx_pwm-test: Only do full testing in slow mode

Yihuan Pan (1):
      qemu-options: Clarify handling of commas in options parameters

 MAINTAINERS                              |   5 ++
 docs/system/arm/xlnx-versal-virt.rst     |   4 +-
 docs/system/invocation.rst               |   5 ++
 docs/system/qemu-manpage.rst             |   5 ++
 include/exec/memory.h                    |   2 +-
 include/hw/boards.h                      |   3 +
 include/hw/i386/pc.h                     |   3 +
 include/hw/misc/xlnx-versal-cframe-reg.h |   2 +-
 include/hw/misc/xlnx-versal-cfu.h        |   6 +-
 include/hw/misc/xlnx-versal-crl.h        |   2 +-
 include/hw/nvram/xlnx-efuse.h            |   2 +-
 include/hw/nvram/xlnx-versal-efuse.h     |   4 +-
 include/hw/nvram/xlnx-zynqmp-efuse.h     |   2 +-
 include/sysemu/qtest.h                   |   2 +
 hw/arm/virt.c                            |   9 ++-
 hw/core/machine.c                        |   3 +
 hw/i386/pc.c                             |   3 +
 hw/i386/pc_piix.c                        |  17 ++++-
 hw/i386/pc_q35.c                         |  13 +++-
 hw/m68k/virt.c                           |   9 ++-
 hw/misc/mips_itu.c                       |   3 +-
 hw/ppc/spapr.c                           |  15 ++++-
 hw/ppc/spapr_hcall.c                     |   1 -
 hw/s390x/ipl.c                           |   1 -
 hw/s390x/s390-virtio-ccw.c               |  14 +++-
 qom/object.c                             |  41 ++++++++++++
 system/qtest.c                           |   1 +
 target/i386/cpu.c                        |   2 +-
 target/loongarch/cpu.c                   |   2 +
 tests/qtest/migration-test.c             |   4 +-
 tests/qtest/npcm7xx_pwm-test.c           |  13 +++-
 tests/unit/test-io-task.c                |   2 +-
 tests/unit/test-qmp-event.c              | 108 +++++++++----------------------
 qemu-options.hx                          |   4 ++
 scripts/analyze-migration.py             |  35 +++++++++-
 35 files changed, 236 insertions(+), 111 deletions(-)



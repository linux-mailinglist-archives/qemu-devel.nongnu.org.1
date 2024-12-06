Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1309E76FC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 18:23:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJc1M-000435-RK; Fri, 06 Dec 2024 12:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc1J-00041W-Da; Fri, 06 Dec 2024 12:21:37 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc1H-0000uX-3Q; Fri, 06 Dec 2024 12:21:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9C6605C6634;
 Fri,  6 Dec 2024 17:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E2CC4CED1;
 Fri,  6 Dec 2024 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733505686;
 bh=KHSPLvcdOse9dRgvQF4pAyTeTPNTrvilvb49AHVAbw8=;
 h=From:To:Cc:Subject:Date:From;
 b=hQgSqJE6xXw6TYTxe/2yyLe/NdEtLzPyXoEBLqJuZWHrMlRZz5d8N4jpFkxhNrMqp
 zh9cK8H1ciAADALMxmpCiCeQa3TQEpybeK8XWACJCL4/2cCLS840APgim33gzOcvV/
 u2giMYogtNPUWUd8zRA7xG773+AkbHV9wAmpD3zOOlMc0OPaTyrRvz8dwW1LjeXHhw
 hlRjahTwEwsaa7hM6ml44jmoXqixloVpnReG0hrvwGTYF4FB/mO5Wj6QuzRlJXFbrK
 3gyDbxMhjTGZP3AvRYy6FnWFIyIibaVnGCP9SvIY/FwOg2ENl+ENU4S/nalPtn46/d
 dMNCJ95CC6uug==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc15-00000005RJX-3lA0; Fri, 06 Dec 2024 18:21:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 00/31] Prepare GHES driver to support error injection
Date: Fri,  6 Dec 2024 18:12:22 +0100
Message-ID: <cover.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Michael,

Could you please merge this series for ACPI stuff? All patches were already
reviewed by Igor. The changes against v4 are just on some patch descriptions,
plus the addition of Reviewed-by. No Code changes.

Thanks,
Mauro

-

During the development of a patch series meant to allow GHESv2 error injections,
it was requested a change on how CPER offsets are calculated, by adding a new
BIOS pointer and reworking the GHES logic. See:

https://lore.kernel.org/qemu-devel/cover.1726293808.git.mchehab+huawei@kernel.org/

Such change ended being a big patch, so several intermediate steps are needed,
together with several cleanups and renames.

As agreed duing v10 review, I'll be splitting the big patch series into separate pull 
requests, starting with the cleanup series. This is the first patch set, containing
only such preparation patches.

The next series will contain the shift to use offsets from the location of the
HEST table, together with a migration logic to make it compatible with 9.1.

---

v5:
- some changes at patches description and added some R-B;
- no changes at the code.

v4:
- merged a patch renaming the function which calculate offsets to:
  get_hw_error_offsets(), to avoid the need of such change at the next
  patch series;
- removed a functional change at the logic which makes
  the GHES record generation more generic;
- a couple of trivial changes on patch descriptions and line break cleanups.

v3:
- improved some patch descriptions;
- some patches got reordered to better reflect the changes;
- patch v2 08/15: acpi/ghes: Prepare to support multiple sources on ghes
  was split on two patches. The first one is in this cleanup series:
      acpi/ghes: Change ghes fill logic to work with only one source
  contains just the simplification logic. The actual preparation will
  be moved to this series:
     https://lore.kernel.org/qemu-devel/cover.1727782588.git.mchehab+huawei@kernel.org/

v2: 
- some indentation fixes;
- some description improvements;
- fixed a badly-solved merge conflict that ended renaming a parameter.

Mauro Carvalho Chehab (31):
  acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
  acpi/ghes: simplify acpi_ghes_record_errors() code
  acpi/ghes: simplify the per-arch caller to build HEST table
  acpi/ghes: better handle source_id and notification
  acpi/ghes: Fix acpi_ghes_record_errors() argument
  acpi/ghes: Remove a duplicated out of bounds check
  acpi/ghes: Change the type for source_id
  acpi/ghes: don't check if physical_address is not zero
  acpi/ghes: make the GHES record generation more generic
  acpi/ghes: better name GHES memory error function
  acpi/ghes: don't crash QEMU if ghes GED is not found
  acpi/ghes: rename etc/hardware_error file macros
  acpi/ghes: better name the offset of the hardware error firmware
  acpi/ghes: Prepare to support multiple sources on ghes
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available
  acpi/ghes: add a notifier to notify when error data is ready
  acpi/generic_event_device: add an APEI error device
  arm/virt: Wire up a GED error device for ACPI / GHES
  qapi/acpi-hest: add an interface to do generic CPER error injection
  scripts/ghes_inject: add a script to generate GHES error inject
  target/arm: add an experimental mpidr arm cpu property object
  scripts/arm_processor_error.py: retrieve mpidr if not filled
  acpi/ghes: move offset calculus to a separate function
  DEBUG
  acpi/ghes: Change ghes fill logic to work with only one source
  HACK: use GPIO as source ID for virt-9.1 machines
  docs: acpi_hest_ghes: fix documentation for CPER size
  FIXME: acpi/ghes: properly set data record size

 MAINTAINERS                            |  10 +
 docs/specs/acpi_hest_ghes.rst          |   6 +-
 hw/acpi/Kconfig                        |   5 +
 hw/acpi/aml-build.c                    |  10 +
 hw/acpi/generic_event_device.c         |  42 +-
 hw/acpi/ghes-stub.c                    |   2 +-
 hw/acpi/ghes.c                         | 391 ++++++++++----
 hw/acpi/ghes_cper.c                    |  32 ++
 hw/acpi/ghes_cper_stub.c               |  19 +
 hw/acpi/meson.build                    |   2 +
 hw/arm/virt-acpi-build.c               |  36 +-
 hw/arm/virt.c                          |  19 +-
 hw/core/machine.c                      |   2 +
 include/hw/acpi/acpi_dev_interface.h   |   1 +
 include/hw/acpi/aml-build.h            |   2 +
 include/hw/acpi/generic_event_device.h |   1 +
 include/hw/acpi/ghes.h                 |  39 +-
 include/hw/arm/virt.h                  |   2 +
 qapi/acpi-hest.json                    |  35 ++
 qapi/meson.build                       |   1 +
 qapi/qapi-schema.json                  |   1 +
 scripts/arm_processor_error.py         | 390 ++++++++++++++
 scripts/ghes_inject.py                 |  51 ++
 scripts/qmp_helper.py                  | 702 +++++++++++++++++++++++++
 target/arm/cpu.c                       |   1 +
 target/arm/cpu.h                       |   1 +
 target/arm/helper.c                    |  10 +-
 target/arm/kvm.c                       |   2 +-
 28 files changed, 1678 insertions(+), 137 deletions(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/acpi-hest.json
 create mode 100644 scripts/arm_processor_error.py
 create mode 100755 scripts/ghes_inject.py
 create mode 100644 scripts/qmp_helper.py

-- 
2.47.1




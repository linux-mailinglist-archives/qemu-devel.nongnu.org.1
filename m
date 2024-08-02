Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D3394654E
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Aug 2024 23:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa04x-00056O-Af; Fri, 02 Aug 2024 17:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sa04j-0004PZ-EO; Fri, 02 Aug 2024 17:44:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sa04f-0001AT-V0; Fri, 02 Aug 2024 17:44:37 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 935D062B67;
 Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C34C4AF0C;
 Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722635063;
 bh=KvfS8Zj0iXfOAFSgl/qErNklfmGfAyj6npJsq1urDf4=;
 h=From:To:Cc:Subject:Date:From;
 b=XcI1a0eLdJzA5hd7VXgzLp5hyV6JnF6z1eCSsKG2fLPQS74HsoITdnbx7fdOnkMCf
 EL5ymYPcm11T3bc00gq+j0Ojxxo1wgcp9XDTT1tJNIZRSUxiDHYJ64G1ikAvtdp/1v
 THVpQQdmzHgD3+zf1WPX6RmgiS6Gd2xNwjQjhV2d6rxz2DSEby9IiG2994BZG8WfGR
 qFk7+W/t2tpzIPVrK0BAhdEKib2SfTXfamH6aJsR0zyPI//udDLP2R9N4o/tltZW5L
 nLJn02chU4Rua4GQFtC1U816FTL4KlkHNEji1hYUp0tmvy0NkvfZx5b2xsil6ID3pK
 UYa3e1Sbeg14w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sa04T-00000002naA-2XCg; Fri, 02 Aug 2024 23:44:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 0/7] Add ACPI CPER firmware first error injection on ARM
 emulation
Date: Fri,  2 Aug 2024 23:43:55 +0200
Message-ID: <cover.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Testing OS kernel ACPI APEI CPER support is tricky, as one depends on
having hardware with special-purpose BIOS and/or hardware.

With QEMU, it becomes a lot easier, as it can be done via QMP.

This series add support for injecting CPER records on ARM emulation.

The QEMU side changes add a QAPI able to do CPER error injection
on ARM, with a raw data parameter, making it very flexible.

A script is provided at the final patch implementing support for
ARM Processor CPER error injection according with ACPI 6.x and 
UEFI 2.9A/2.10 specs, via QMP.

Injecting such errors can be done using the provided script:

	$ ./scripts/ghes_inject.py arm 
	Error injected.

Produces a simple CPER register, properly handled by the Linux
Kernel:

[  794.983753] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  794.984150] {4}[Hardware Error]: event severity: recoverable
[  794.984391] {4}[Hardware Error]:  Error 0, type: recoverable
[  794.984652] {4}[Hardware Error]:   section_type: ARM processor error
[  794.984926] {4}[Hardware Error]:   MIDR: 0x0000000000000000
[  794.985184] {4}[Hardware Error]:   running state: 0x0
[  794.985411] {4}[Hardware Error]:   Power State Coordination Interface state: 0
[  794.985720] {4}[Hardware Error]:   Error info structure 0:
[  794.985960] {4}[Hardware Error]:   num errors: 2
[  794.986175] {4}[Hardware Error]:    error_type: 0x02: cache error
[  794.986442] {4}[Hardware Error]:    error_info: 0x000000000091000f
[  794.986755] {4}[Hardware Error]:     transaction type: Data Access
[  794.987027] {4}[Hardware Error]:     cache error, operation type: Data write
[  794.987310] {4}[Hardware Error]:     cache level: 2
[  794.987529] {4}[Hardware Error]:     processor context not corrupted
[  794.987867] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error

More complex use cases can be done, like:

	$ ./scripts/ghes_inject.py arm --mpidr 0x444 --running --affinity 1 \
	  --error-info 12345678 --vendor 0x13,123,4,5,1 --ctx-array 0,1,2,3,4,5 \
	  -t cache tlb bus micro-arch tlb,micro-arch
	Error injected.

[  899.181246] {5}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[  899.181769] {5}[Hardware Error]: event severity: recoverable
[  899.182069] {5}[Hardware Error]:  Error 0, type: recoverable
[  899.182370] {5}[Hardware Error]:   section_type: ARM processor error
[  899.182689] {5}[Hardware Error]:   MIDR: 0x0000000000000000
[  899.182980] {5}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000000000000
[  899.183395] {5}[Hardware Error]:   error affinity level: 0
[  899.183683] {5}[Hardware Error]:   running state: 0x1
[  899.183962] {5}[Hardware Error]:   Power State Coordination Interface state: 0
[  899.184332] {5}[Hardware Error]:   Error info structure 0:
[  899.184610] {5}[Hardware Error]:   num errors: 2
[  899.184864] {5}[Hardware Error]:    error_type: 0x02: cache error
[  899.185181] {5}[Hardware Error]:    error_info: 0x0000000000bc614e
[  899.185504] {5}[Hardware Error]:     cache level: 2
[  899.185771] {5}[Hardware Error]:     processor context not corrupted
[  899.186082] {5}[Hardware Error]:   Error info structure 1:
[  899.186366] {5}[Hardware Error]:   num errors: 2
[  899.186613] {5}[Hardware Error]:    error_type: 0x04: TLB error
[  899.186929] {5}[Hardware Error]:    error_info: 0x000000000054007f
[  899.187236] {5}[Hardware Error]:     transaction type: Instruction
[  899.187588] {5}[Hardware Error]:     TLB error, operation type: Instruction fetch
[  899.187962] {5}[Hardware Error]:     TLB level: 1
[  899.188209] {5}[Hardware Error]:     processor context not corrupted
[  899.188535] {5}[Hardware Error]:     the error has not been corrected
[  899.188853] {5}[Hardware Error]:     PC is imprecise
[  899.189114] {5}[Hardware Error]:   Error info structure 2:
[  899.189404] {5}[Hardware Error]:   num errors: 2
[  899.189653] {5}[Hardware Error]:    error_type: 0x08: bus error
[  899.189967] {5}[Hardware Error]:    error_info: 0x00000080d6460fff
[  899.190293] {5}[Hardware Error]:     transaction type: Generic
[  899.190611] {5}[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)
[  899.191174] {5}[Hardware Error]:     affinity level at which the bus error occurred: 1
[  899.191563] {5}[Hardware Error]:     processor context corrupted
[  899.191872] {5}[Hardware Error]:     the error has been corrected
[  899.192185] {5}[Hardware Error]:     PC is imprecise
[  899.192445] {5}[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.
[  899.192939] {5}[Hardware Error]:     participation type: Local processor observed
[  899.193324] {5}[Hardware Error]:     request timed out
[  899.193596] {5}[Hardware Error]:     address space: External Memory Access
[  899.193945] {5}[Hardware Error]:     memory access attributes:0x20
[  899.194273] {5}[Hardware Error]:     access mode: secure
[  899.194544] {5}[Hardware Error]:   Error info structure 3:
[  899.194838] {5}[Hardware Error]:   num errors: 2
[  899.195088] {5}[Hardware Error]:    error_type: 0x10: micro-architectural error
[  899.195456] {5}[Hardware Error]:    error_info: 0x0000000078da03ff
[  899.195782] {5}[Hardware Error]:   Error info structure 4:
[  899.196070] {5}[Hardware Error]:   num errors: 2
[  899.196331] {5}[Hardware Error]:    error_type: 0x14: TLB error|micro-architectural error
[  899.196733] {5}[Hardware Error]:   Context info structure 0:
[  899.197024] {5}[Hardware Error]:    register context type: AArch64 EL1 context registers
[  899.197427] {5}[Hardware Error]:    00000000: 00000000 00000000
[  899.197741] {5}[Hardware Error]:   Vendor specific error info has 5 bytes:
[  899.198096] {5}[Hardware Error]:    00000000: 13 7b 04 05 01                                   .{...
[  899.198610] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
[  899.199000] [Firmware Warn]: GHES: Unhandled processor error type 0x04: TLB error
[  899.199388] [Firmware Warn]: GHES: Unhandled processor error type 0x08: bus error
[  899.199767] [Firmware Warn]: GHES: Unhandled processor error type 0x10: micro-architectural error
[  899.200194] [Firmware Warn]: GHES: Unhandled processor error type 0x14: TLB error|micro-architectural error

---

v5:
- CPER guid is now passing as string;
- raw-data is now passed with base64 encode;
- Removed several GPIO left-overs from arm/virt.c changes;
- Lots of cleanups and improvements at the error injection script.
  It now better handles QMP dialog and doesn't print debug messages.
  Also, code was split on two modules, to make easier to add more
  error injection commands.

v4:
- CPER generation moved to happen outside QEMU;
- One patch adding support for mpidr query was removed.

v3:
- patch 1 cleanups with some comment changes and adding another place where
  the poweroff GPIO define should be used. No changes on other patches (except
  due to conflict resolution).

v2:
- added a new patch using a define for GPIO power pin;
- patch 2 changed to also use a define for generic error GPIO pin;
- a couple cleanups at patch 2 removing uneeded else clauses.


Jonathan Cameron (1):
  acpi/ghes: Support GPIO error source

Mauro Carvalho Chehab (6):
  arm/virt: place power button pin number on a define
  acpi/generic_event_device: add an APEI error device
  arm/virt: Wire up GPIO error source for ACPI / GHES
  qapi/ghes-cper: add an interface to do generic CPER error injection
  acpi/ghes: add support for generic error injection via QAPI
  scripts/ghes_inject: add a script to generate GHES error inject

 MAINTAINERS                            |  10 +
 hw/acpi/Kconfig                        |   5 +
 hw/acpi/generic_event_device.c         |  17 ++
 hw/acpi/ghes.c                         | 178 +++++++++++--
 hw/acpi/ghes_cper.c                    |  45 ++++
 hw/acpi/ghes_cper_stub.c               |  18 ++
 hw/acpi/meson.build                    |   2 +
 hw/arm/Kconfig                         |   5 +
 hw/arm/virt-acpi-build.c               |   7 +-
 hw/arm/virt.c                          |  23 +-
 include/hw/acpi/acpi_dev_interface.h   |   1 +
 include/hw/acpi/generic_event_device.h |   3 +
 include/hw/acpi/ghes.h                 |  16 +-
 include/hw/arm/virt.h                  |   4 +
 qapi/ghes-cper.json                    |  55 ++++
 qapi/meson.build                       |   1 +
 qapi/qapi-schema.json                  |   1 +
 scripts/arm_processor_error.py         | 352 +++++++++++++++++++++++++
 scripts/ghes_inject.py                 |  59 +++++
 scripts/qmp_helper.py                  | 249 +++++++++++++++++
 20 files changed, 1026 insertions(+), 25 deletions(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/ghes-cper.json
 create mode 100644 scripts/arm_processor_error.py
 create mode 100755 scripts/ghes_inject.py
 create mode 100644 scripts/qmp_helper.py

-- 
2.45.2




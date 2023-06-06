Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DBC723702
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgH-0004jh-Ua; Tue, 06 Jun 2023 01:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgD-0004jH-Pl
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgB-00044A-P2
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686030986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ttotlTd78mJncGQmUPpvR37rkBK37r26SESLm66j4p8=;
 b=ZgGncbZCvZOd1iurTmbYJTrtcM1OnGMS4zL5+1qAm0kBp8GNrSm9BU/c6aiVdNDp0TA7mF
 ZixvpU4csUeOKYdgr7smI2B529D98rzD+mjN0JL518+q/VWkgNIoG947VeC05P5jMVgJbD
 3H0N1Mi40u6Luh1BqnZS3KcuQVDYPIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-k8sZz0glO3edOcE3mZofCQ-1; Tue, 06 Jun 2023 01:56:25 -0400
X-MC-Unique: k8sZz0glO3edOcE3mZofCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C51DF8060B9;
 Tue,  6 Jun 2023 05:56:24 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9C4A2166B25;
 Tue,  6 Jun 2023 05:56:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/18] s390x and misc patches
Date: Tue,  6 Jun 2023 07:56:03 +0200
Message-Id: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

 Hi Richard!

The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:

  Merge tag 'migration-20230602-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-02 17:33:29 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-06-06

for you to fetch changes up to 1fb9bdaf59719c0d0c28043e58c8e3452fd6d7de:

  linux-user: Emulate /proc/cpuinfo on s390x (2023-06-05 20:48:34 +0200)

----------------------------------------------------------------
* Fix emulated LCCB, LOCFHR, MXDB and MXDBR s390x instructions
* Fix the malta machine on s390x (big endian) hosts
* Emulate /proc/cpuinfo on s390x
* Remove pointless QOM casts
* Improve the inclusion logic for libkeyutils and ipmi-bt-test in meson.build

----------------------------------------------------------------
Camilla Conte (1):
      gitlab-ci: Remove unused Python package

Ilya Leoshkevich (12):
      target/s390x: Fix LCBB overwriting the top 32 bits
      tests/tcg/s390x: Test LCBB
      target/s390x: Fix LOCFHR taking the wrong half of R2
      tests/tcg/s390x: Test LOCFHR
      linux-user/s390x: Fix single-stepping SVC
      tests/tcg/s390x: Test single-stepping SVC
      target/s390x: Fix MXDB and MXDBR
      tests/tcg/s390x: Test MXDB and MXDBR
      s390x/tcg: Fix CPU address returned by STIDP
      linux-user/elfload: Expose get_elf_hwcap() on s390x
      linux-user/elfload: Introduce elf_hwcap_str() on s390x
      linux-user: Emulate /proc/cpuinfo on s390x

Max Fritz (1):
      Add conditional dependency for libkeyutils

Philippe Mathieu-Daudé (2):
      scripts: Add qom-cast-macro-clean-cocci-gen.py
      bulk: Remove pointless QOM casts

Thomas Huth (2):
      tests/qtest: Run ipmi-bt-test only if CONFIG_IPMI_EXTERN is set
      hw/mips/malta: Fix the malta machine on big endian hosts

 MAINTAINERS                               |   1 +
 meson.build                               |   6 +-
 linux-user/loader.h                       |   5 ++
 target/s390x/cpu_models.h                 |  10 ++-
 target/s390x/helper.h                     |   2 +-
 target/s390x/tcg/insn-data.h.inc          |   8 +--
 block/nbd.c                               |   4 +-
 chardev/char-pty.c                        |   2 +-
 hw/arm/musicpal.c                         |   2 +-
 hw/arm/xlnx-versal.c                      |   2 +-
 hw/display/vhost-user-gpu.c               |   4 +-
 hw/intc/loongarch_extioi.c                |   6 +-
 hw/m68k/q800.c                            |   2 +-
 hw/mips/malta.c                           |   4 +-
 hw/pci-host/bonito.c                      |   2 +-
 hw/ppc/pnv_lpc.c                          |   2 +-
 hw/ppc/pnv_occ.c                          |   2 +-
 hw/ppc/pnv_sbe.c                          |   2 +-
 hw/riscv/virt.c                           |  10 +--
 hw/rx/rx62n.c                             |   2 +-
 hw/scsi/esp-pci.c                         |  18 ++---
 hw/sparc/sun4m.c                          |   4 +-
 hw/virtio/virtio-mem-pci.c                |   6 +-
 hw/virtio/virtio-pmem-pci.c               |   6 +-
 linux-user/elfload.c                      |  29 +++++++-
 linux-user/s390x/cpu_loop.c               |   9 +++
 linux-user/syscall.c                      | 106 +++++++++++++++++++++++++++++-
 migration/fd.c                            |   4 +-
 migration/multifd.c                       |   2 +-
 migration/yank_functions.c                |   4 +-
 nbd/client-connection.c                   |   2 +-
 nbd/server.c                              |   2 +-
 softmmu/qdev-monitor.c                    |   2 +-
 target/s390x/cpu_models.c                 |   4 +-
 target/s390x/tcg/fpu_helper.c             |   5 +-
 target/s390x/tcg/translate.c              |   8 +--
 tests/tcg/s390x/lcbb.c                    |  51 ++++++++++++++
 tests/tcg/s390x/locfhr.c                  |  29 ++++++++
 tests/tcg/s390x/mxdb.c                    |  30 +++++++++
 ui/vnc-ws.c                               |   6 +-
 .gitlab-ci.d/container-template.yml       |   1 -
 scripts/qom-cast-macro-clean-cocci-gen.py |  49 ++++++++++++++
 tests/qtest/meson.build                   |   3 +-
 tests/tcg/s390x/Makefile.target           |  14 +++-
 tests/tcg/s390x/gdbstub/test-svc.py       |  64 ++++++++++++++++++
 tests/tcg/s390x/hello-s390x-asm.S         |  20 ++++++
 46 files changed, 480 insertions(+), 76 deletions(-)
 create mode 100644 tests/tcg/s390x/lcbb.c
 create mode 100644 tests/tcg/s390x/locfhr.c
 create mode 100644 tests/tcg/s390x/mxdb.c
 create mode 100644 scripts/qom-cast-macro-clean-cocci-gen.py
 create mode 100644 tests/tcg/s390x/gdbstub/test-svc.py
 create mode 100644 tests/tcg/s390x/hello-s390x-asm.S



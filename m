Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D611A704D2B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pytGr-0006tO-M6; Tue, 16 May 2023 07:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pytGp-0006st-6d
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pytGn-0003P1-7o
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684238108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nyKawLpdi1KV2G0RRHMtNYkfNRPX2/oUvk6jGHfCDsA=;
 b=b0Re1pJ/SYaLsIw9Fr+ASmrjSEoAMIBPAF9rG369HI5CrtkCcf711rOLu9iPkwn90NelS7
 18ezFEBXfDieVATxv+bY7kcFnFrkg41iSddkg6zdXHYvxiLbaRY8HEIpa5+Kh/JvoobmIS
 KWgsnj4XGM5F6WXVGXL66mXHyp6TKqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-Q1ozhD4XM0SQirLhgTfzdA-1; Tue, 16 May 2023 07:55:04 -0400
X-MC-Unique: Q1ozhD4XM0SQirLhgTfzdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EC253850543;
 Tue, 16 May 2023 11:54:57 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1142C15BA0;
 Tue, 16 May 2023 11:54:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 00/21] Tests, docs, s390x and misc patches
Date: Tue, 16 May 2023 13:54:54 +0200
Message-Id: <20230516115455.599584-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-05-15 13:54:33 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-05-15v2

for you to fetch changes up to bfa72590df14e4c94c03d2464f3abe18bf2e5dac:

  tests/tcg/s390x: Test EXECUTE of relative branches (2023-05-16 09:14:18 +0200)

----------------------------------------------------------------
* Various small test updates
* Some small doc updates
* Introduce replacement for -async-teardown that shows up in the QAPI
* Make machine-qmp-cmds.c and xilinx_ethlite.c target-independent
* Fix s390x LDER instruction
* Fix s390x EXECUTE instruction with relative branches

v2: Fix the "sysemu/kvm: Remove unused headers" patch to avoid
    a compilation failure

----------------------------------------------------------------
Ani Sinha (3):
      tests: libvirt-ci: Update to commit 'c8971e90ac' to pull in mformat and xorriso
      tests/lcitool: Add mtools and xorriso and remove genisoimage as dependencies
      docs/devel: remind developers to run CI container pipeline when updating images

Claudio Imbrenda (2):
      util/async-teardown: wire up query-command-line-options
      s390x/pv: Fix spurious warning with asynchronous teardown

Daniel P. Berrangé (1):
      tests/qtest: replace qmp_discard_response with qtest_qmp_assert_success

Ilya Leoshkevich (5):
      s390x/tcg: Fix LDER instruction format
      tests/tcg/multiarch: Make the system memory test work on big-endian
      tests/tcg/s390x: Enable the multiarch system tests
      target/s390x: Fix EXECUTE of relative branches
      tests/tcg/s390x: Test EXECUTE of relative branches

Jonathan Cameron (1):
      hw/pci-bridge: Fix release ordering by embedding PCIBridgeWindows within PCIBridge

Laurent Vivier (1):
      net: stream: test reconnect option with an unix socket

Lizhi Yang (1):
      docs/about/emulation: fix typo

Mateusz Krawczuk (1):
      Add information how to fix common build error on Windows in symlink-install-tree

Philippe Mathieu-Daudé (1):
      sysemu/kvm: Remove unused headers

Thomas Huth (5):
      tests/avocado/virtio-gpu: Fix the URLs of the test_virtio_vga_virgl test
      hw/core: Use a callback for target specific query-cpus-fast information
      cpu: Introduce a wrapper for being able to use TARGET_NAME in common code
      hw/core: Move machine-qmp-cmds.c into the target independent source set
      hw/net: Move xilinx_ethlite.c to the target-independent source set

 docs/about/deprecated.rst                          |   5 +
 docs/about/emulation.rst                           |   2 +-
 docs/devel/testing.rst                             |   6 +
 include/hw/core/cpu.h                              |   6 +
 include/hw/pci/pci_bridge.h                        |   2 +-
 include/hw/s390x/pv.h                              |   6 +-
 include/qemu/typedefs.h                            |   1 +
 include/sysemu/kvm.h                               |   3 -
 target/s390x/tcg/insn-data.h.inc                   |   2 +-
 cpu.c                                              |   5 +
 hw/core/machine-qmp-cmds.c                         |  20 +--
 hw/net/xilinx_ethlite.c                            |   2 +-
 hw/pci/pci_bridge.c                                |  19 ++-
 hw/s390x/pv.c                                      |  10 +-
 hw/s390x/s390-virtio-ccw.c                         |   2 +-
 migration/dirtyrate.c                              |   1 +
 os-posix.c                                         |  14 ++
 target/s390x/cpu.c                                 |   8 ++
 target/s390x/tcg/translate.c                       |  81 ++++++++---
 tests/qtest/ahci-test.c                            |  31 ++--
 tests/qtest/boot-order-test.c                      |   5 +-
 tests/qtest/cdrom-test.c                           |  14 +-
 tests/qtest/fdc-test.c                             |  15 +-
 tests/qtest/ide-test.c                             |   5 +-
 tests/qtest/migration-test.c                       |   5 +-
 tests/qtest/netdev-socket.c                        |  39 +++--
 tests/qtest/test-filter-mirror.c                   |   5 +-
 tests/qtest/test-filter-redirector.c               |   7 +-
 tests/qtest/virtio-blk-test.c                      |  24 ++--
 tests/tcg/multiarch/system/memory.c                |  67 +++++----
 tests/tcg/s390x/console.c                          |  12 ++
 tests/tcg/s390x/ex-branch.c                        | 158 +++++++++++++++++++++
 util/async-teardown.c                              |  21 +++
 .gitlab-ci.d/cirrus/freebsd-13.vars                |   2 +-
 .gitlab-ci.d/cirrus/macos-12.vars                  |   2 +-
 hw/core/meson.build                                |   5 +-
 hw/net/meson.build                                 |   2 +-
 qemu-options.hx                                    |  34 +++--
 scripts/symlink-install-tree.py                    |   3 +
 tests/avocado/virtio-gpu.py                        |   4 +-
 tests/docker/dockerfiles/alpine.docker             |   3 +-
 tests/docker/dockerfiles/centos8.docker            |   3 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-amd64.docker       |   3 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   3 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
 tests/docker/dockerfiles/fedora-win32-cross.docker |   3 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |   3 +-
 tests/docker/dockerfiles/fedora.docker             |   3 +-
 tests/docker/dockerfiles/opensuse-leap.docker      |   3 +-
 tests/docker/dockerfiles/ubuntu2004.docker         |   3 +-
 tests/docker/dockerfiles/ubuntu2204.docker         |   3 +-
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/projects/qemu.yml                    |   3 +-
 tests/tcg/s390x/Makefile.softmmu-target            |  40 ++++--
 tests/tcg/s390x/Makefile.target                    |   1 +
 tests/tcg/s390x/head64.S                           |  31 ++++
 62 files changed, 558 insertions(+), 225 deletions(-)
 create mode 100644 tests/tcg/s390x/console.c
 create mode 100644 tests/tcg/s390x/ex-branch.c
 create mode 100644 tests/tcg/s390x/head64.S



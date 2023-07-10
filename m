Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4B74D7F0
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIr8R-0007cD-Ig; Mon, 10 Jul 2023 09:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIr8Q-0007YR-Eb
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIr8N-0005vi-W3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688996457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/KhNoEP1KB5GG/f3LQj9P59A9YixvYHip1/K6mSGUms=;
 b=Co1OPCSpvmzHbvsJ0t0PmurNfbU+1qQYsD88x6t1eyNsMvHbGcX6IJdfhKbpGbRT6DJoBh
 l2MtJZlQRa/N8Dmy2sXYAbuVB6ZS1vTJUw4+KyKKEF7r5qaNTZA/6AaV5uvzPMqXI8KByz
 0AThZfRQ5RHWD49ZnKmZRaLsYeEjKXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-iglrAX6IMGK0UYmBbBpKyw-1; Mon, 10 Jul 2023 09:40:54 -0400
X-MC-Unique: iglrAX6IMGK0UYmBbBpKyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61E618DBB4D;
 Mon, 10 Jul 2023 13:40:54 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD06A200A7CA;
 Mon, 10 Jul 2023 13:40:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 00/21] s390x,
 qtest and misc patches before the 8.1 soft freeze
Date: Mon, 10 Jul 2023 15:40:49 +0200
Message-Id: <20230710134050.209922-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

 Hi Richard!

The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:

  Merge tag 'pull-vfio-20230710' of https://github.com/legoater/qemu into staging (2023-07-10 09:17:06 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-07-10v2

for you to fetch changes up to 7233bd122370155abfd75a42c86a9087ca5a8dbf:

  docs/devel: Fix coding style in style.rst (2023-07-10 15:34:57 +0200)

----------------------------------------------------------------
* s390x instruction emulation fixes and corresponding TCG tests
* Extend the readconfig qtest
* Introduce "-run-with chroot=..." and deprecate the old "-chroot" option
* Speed up migration tests
* Fix coding style in the coding style document

----------------------------------------------------------------
Daniel P. Berrangé (1):
      tests/qtest: massively speed up migration-test

Ilya Leoshkevich (13):
      linux-user: elfload: Add more initial s390x PSW bits
      target/s390x: Fix EPSW CC reporting
      target/s390x: Fix MDEB and MDEBR
      target/s390x: Fix MVCRL with a large value in R0
      target/s390x: Fix LRA overwriting the top 32 bits on DAT error
      target/s390x: Fix LRA when DAT is off
      target/s390x: Fix relative long instructions with large offsets
      tests/tcg/s390x: Test EPSW
      tests/tcg/s390x: Test LARL with a large offset
      tests/tcg/s390x: Test LRA
      tests/tcg/s390x: Test MDEB and MDEBR
      tests/tcg/s390x: Test MVCRL with a large value in R0
      tests/tcg/s390x: Fix test-svc with clang

Philippe Mathieu-Daudé (1):
      hw/s390x: Move KVM specific PV from hw/ to target/s390x/kvm/

Thomas Huth (6):
      tests/qtest/readconfig-test: Allow testing for arbitrary memory sizes
      tests/qtest: Move mkimg() and have_qemu_img() from libqos to libqtest
      tests/qtest/readconfig: Test the docs/config/q35-*.cfg files
      os-posix: Allow 'chroot' via '-run-with' and deprecate the old '-chroot' option
      meson.build: Skip C++ detection unless we're targeting Windows
      docs/devel: Fix coding style in style.rst

 MAINTAINERS                                 |   2 -
 docs/about/deprecated.rst                   |   5 +
 docs/devel/style.rst                        |   9 +-
 meson.build                                 |   2 +-
 target/s390x/helper.h                       |   2 +-
 {include/hw/s390x => target/s390x/kvm}/pv.h |   0
 tests/qtest/libqos/libqos.h                 |   2 -
 tests/qtest/libqtest.h                      |  20 +++
 target/s390x/tcg/insn-data.h.inc            |   4 +-
 hw/s390x/ipl.c                              |   2 +-
 hw/s390x/s390-pci-kvm.c                     |   2 +-
 hw/s390x/s390-virtio-ccw.c                  |   2 +-
 hw/s390x/tod-kvm.c                          |   2 +-
 linux-user/elfload.c                        |   4 +-
 os-posix.c                                  |  35 ++++-
 target/s390x/arch_dump.c                    |   2 +-
 target/s390x/cpu-sysemu.c                   |   2 +-
 target/s390x/cpu_features.c                 |   2 +-
 target/s390x/cpu_models.c                   |   2 +-
 target/s390x/diag.c                         |   2 +-
 target/s390x/helper.c                       |   2 +-
 target/s390x/ioinst.c                       |   2 +-
 target/s390x/kvm/kvm.c                      |   2 +-
 {hw/s390x => target/s390x/kvm}/pv.c         |   2 +-
 target/s390x/mmu_helper.c                   |   2 +-
 target/s390x/tcg/fpu_helper.c               |   3 +-
 target/s390x/tcg/mem_helper.c               |   5 +-
 target/s390x/tcg/translate.c                |   8 +-
 tests/qtest/libqos/libqos.c                 |  49 +------
 tests/qtest/libqtest.c                      |  52 +++++++
 tests/qtest/migration-test.c                | 143 ++++++++++++++++---
 tests/qtest/readconfig-test.c               | 204 +++++++++++++++++++++++++++-
 tests/tcg/s390x/epsw.c                      |  23 ++++
 tests/tcg/s390x/larl.c                      |  21 +++
 tests/tcg/s390x/mdeb.c                      |  30 ++++
 tests/tcg/s390x/mie3-mvcrl.c                |  46 +++++--
 util/async-teardown.c                       |  21 ---
 hw/s390x/meson.build                        |   1 -
 qemu-options.hx                             |  18 ++-
 target/s390x/kvm/meson.build                |   1 +
 tests/tcg/s390x/Makefile.softmmu-target     |   1 +
 tests/tcg/s390x/Makefile.target             |   3 +
 tests/tcg/s390x/gdbstub/test-svc.py         |   2 +-
 tests/tcg/s390x/hello-s390x-asm.S           |   4 +-
 tests/tcg/s390x/lra.S                       |  19 +++
 45 files changed, 626 insertions(+), 141 deletions(-)
 rename {include/hw/s390x => target/s390x/kvm}/pv.h (100%)
 rename {hw/s390x => target/s390x/kvm}/pv.c (99%)
 create mode 100644 tests/tcg/s390x/epsw.c
 create mode 100644 tests/tcg/s390x/larl.c
 create mode 100644 tests/tcg/s390x/mdeb.c
 create mode 100644 tests/tcg/s390x/lra.S



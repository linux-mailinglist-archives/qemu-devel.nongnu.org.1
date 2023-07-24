Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 765EB75FCB6
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyp5-0001Gt-9D; Mon, 24 Jul 2023 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyos-0001ED-31
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyoo-0006sz-6L
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JbyFE65pPjU3e4n/Pr37FyrrcFcaEiNZ2FTX7V+0A4U=;
 b=VqEoOei4UWZNUqnMT37BIJCyDykLomy5He1vvVl5BR15e6M5kL9Id2L3+E+nY6cwSDZDiQ
 nTOuv7wCRh1u5Q9u+6UJ1RGEVscXTYiD+C8fcP1xombysizR7wMfagd8IMzg53JoO/51nR
 7CbnLrAtP4g08GjS8zREXCuYkicbyGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-gDEgh3i6MImxO09KItUlmw-1; Mon, 24 Jul 2023 12:53:52 -0400
X-MC-Unique: gDEgh3i6MImxO09KItUlmw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2876181DA5D;
 Mon, 24 Jul 2023 16:53:52 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83FE6492CAC;
 Mon, 24 Jul 2023 16:53:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/16] s390x fixes
Date: Mon, 24 Jul 2023 18:53:33 +0200
Message-Id: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

The following changes since commit 885fc169f09f5915ce037263d20a59eb226d473d:

  Merge tag 'pull-riscv-to-apply-20230723-3' of https://github.com/alistair23/qemu into staging (2023-07-24 11:34:35 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-07-24

for you to fetch changes up to bd39b7b5f34c2f6b9272bf281ee0324cb07fc3ee:

  tests/avocado/machine_s390_ccw_virtio: Skip the flaky virtio-gpu test by default (2023-07-24 18:44:48 +0200)

----------------------------------------------------------------
* Fix emulation of s390x instructions: CKSM, CLM, ICM, MC, CLGEBR(A)
* Remove useless and non-working s390x migration avocado tests
* Fix loongarch CSRRD CPUID instruction when running on s390x hosts
* Disable flaky s390x virtio-gpu test by default

----------------------------------------------------------------
Ilya Leoshkevich (13):
      target/s390x: Make CKSM raise an exception if R2 is odd
      target/s390x: Fix CLM with M3=0
      target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range inputs
      target/s390x: Fix ICM with M3=0
      target/s390x: Make MC raise specification exception when class >= 16
      target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13
      tests/tcg/s390x: Test CKSM
      tests/tcg/s390x: Test CLGEBR and CGEBRA
      tests/tcg/s390x: Test CLM
      tests/tcg/s390x: Test ICM
      tests/tcg/s390x: Test MC
      tests/tcg/s390x: Test STPQ
      tests/tcg/s390x: Test VCKSM

Thomas Huth (3):
      tests/avocado/migration: Remove the malfunctioning s390x tests
      target/loongarch: Fix the CSRRD CPUID instruction on big endian hosts
      tests/avocado/machine_s390_ccw_virtio: Skip the flaky virtio-gpu test by default

 target/loongarch/cpu.h                             |  1 +
 target/loongarch/helper.h                          |  1 +
 tests/tcg/s390x/vx.h                               |  2 +
 target/s390x/tcg/insn-data.h.inc                   |  2 +-
 target/loongarch/csr_helper.c                      |  9 ++++
 target/s390x/tcg/excp_helper.c                     |  2 +-
 target/s390x/tcg/fpu_helper.c                      |  3 +-
 target/s390x/tcg/mem_helper.c                      |  5 ++
 target/s390x/tcg/translate.c                       | 16 ++++++-
 tests/tcg/s390x/cgebra.c                           | 32 +++++++++++++
 tests/tcg/s390x/clgebr.c                           | 32 +++++++++++++
 tests/tcg/s390x/vcksm.c                            | 31 ++++++++++++
 target/loongarch/insn_trans/trans_privileged.c.inc |  8 +---
 target/s390x/tcg/translate_vx.c.inc                |  2 +-
 tests/avocado/machine_s390_ccw_virtio.py           | 51 ++++++++++----------
 tests/avocado/migration.py                         | 18 -------
 tests/tcg/s390x/Makefile.softmmu-target            |  5 ++
 tests/tcg/s390x/Makefile.target                    |  6 +++
 tests/tcg/s390x/cksm.S                             | 29 +++++++++++
 tests/tcg/s390x/clm.S                              | 29 +++++++++++
 tests/tcg/s390x/icm.S                              | 32 +++++++++++++
 tests/tcg/s390x/mc.S                               | 56 ++++++++++++++++++++++
 tests/tcg/s390x/stpq.S                             | 20 ++++++++
 23 files changed, 337 insertions(+), 55 deletions(-)
 create mode 100644 tests/tcg/s390x/cgebra.c
 create mode 100644 tests/tcg/s390x/clgebr.c
 create mode 100644 tests/tcg/s390x/vcksm.c
 create mode 100644 tests/tcg/s390x/cksm.S
 create mode 100644 tests/tcg/s390x/clm.S
 create mode 100644 tests/tcg/s390x/icm.S
 create mode 100644 tests/tcg/s390x/mc.S
 create mode 100644 tests/tcg/s390x/stpq.S



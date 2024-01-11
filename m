Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987E82B394
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:03:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQg-00041b-OU; Thu, 11 Jan 2024 12:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQS-0003nk-3Y
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQK-0003T6-Ks
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YBwJadbocxSEu6aV35OaHQGN2+uRoLoJ1qQsp+kMyEw=;
 b=abIPEjQEJnWHjAEXwO8cB9a55LxOxJ04QJjgXwBqGl2FCiiD1hJ6PJ/Y8DQMXAf0SLhzSk
 Vz4E89xVdyK3zbPO83yoicHPCJ23pG39JKUnLOZR/G3JShlbkxP7JOX10R4sC3ucmnjwjO
 gFy8Jog4zIKMiQg00vjSmd79CAikI9g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-WUoKNXN1NcG6ZpfMYlsroA-1; Thu,
 11 Jan 2024 12:00:49 -0500
X-MC-Unique: WUoKNXN1NcG6ZpfMYlsroA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BC3C28AC1F4;
 Thu, 11 Jan 2024 17:00:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64CE551D5;
 Thu, 11 Jan 2024 17:00:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/17] Misc patches (qtests, s390x, m68k, gitlab-ci)
Date: Thu, 11 Jan 2024 18:00:29 +0100
Message-ID: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

 Hi Peter!

The following changes since commit 34eac35f893664eb8545b98142e23d9954722766:

  Merge tag 'pull-riscv-to-apply-20240110' of https://github.com/alistair23/qemu into staging (2024-01-10 11:41:56 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-11

for you to fetch changes up to 52a21689cd829c1cc931b59b5ee5bdb10dd578c1:

  .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large (2024-01-11 17:49:21 +0100)

----------------------------------------------------------------
* Fix non-deterministic failures of the 'netdev-socket' qtest
* Fix device presence checking in the virtio-ccw qtest
* Support codespell checking in checkpatch.pl
* Fix emulation of LAE s390x instruction
* Work around htags bug when environment is large
* Some other small clean-ups here and there

----------------------------------------------------------------
Daniel P. Berrangé (7):
      qtest: use correct boolean type for failover property
      Revert "netdev: set timeout depending on loadavg"
      Revert "osdep: add getloadavg"
      Revert "tests/qtest/netdev-socket: Raise connection timeout to 120 seconds"
      net: add explicit info about connecting/listening state
      net: handle QIOTask completion to report useful error message
      qtest: ensure netdev-socket tests have non-overlapping names

Ilya Leoshkevich (2):
      target/s390x: Fix LAE setting a wrong access register
      tests/tcg/s390x: Test LOAD ADDRESS EXTENDED

Mark Cave-Ayland (1):
      q800: move dp8393x_prom memory region to Q800MachineState

Nicholas Piggin (1):
      gitlab: fix s390x tag for avocado-system-centos

Peter Maydell (1):
      .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large

Samuel Tardieu (1):
      tests/qtest/virtio-ccw: Fix device presence checking

Thomas Huth (1):
      target/s390x/kvm/pv: Provide some more useful information if decryption fails

Zhao Liu (3):
      hw/s390x/ccw: Replace basename() with g_path_get_basename()
      hw/s390x/ccw: Replace dirname() with g_path_get_dirname()
      scripts/checkpatch: Support codespell checking

 meson.build                       |   1 -
 hw/s390x/ipl.h                    |   2 +-
 include/hw/m68k/q800.h            |   1 +
 include/qemu/osdep.h              |  10 ---
 target/s390x/kvm/pv.h             |   5 +-
 hw/m68k/q800.c                    |   7 +--
 hw/s390x/ipl.c                    |   5 +-
 hw/s390x/s390-ccw.c               |   7 ++-
 hw/s390x/s390-virtio-ccw.c        |   5 +-
 net/stream.c                      |  18 ++++--
 target/s390x/kvm/pv.c             |  25 ++++++--
 target/s390x/tcg/translate.c      |   3 +-
 tests/qtest/netdev-socket.c       |  42 +++----------
 tests/qtest/virtio-ccw-test.c     |   2 +-
 tests/qtest/virtio-net-failover.c |  36 +++++------
 tests/tcg/s390x/lae.c             |  31 ++++++++++
 .gitlab-ci.d/buildtest.yml        |   7 ++-
 scripts/checkpatch.pl             | 125 ++++++++++++++++++++++++++++++++------
 tests/tcg/s390x/Makefile.target   |   1 +
 19 files changed, 223 insertions(+), 110 deletions(-)
 create mode 100644 tests/tcg/s390x/lae.c



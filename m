Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F147323EA
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9wll-0002PZ-8O; Thu, 15 Jun 2023 19:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wlj-0002P8-9x
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:52:47 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wlh-0003jU-GA
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:52:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA2A60A49;
 Thu, 15 Jun 2023 23:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A33C433C0;
 Thu, 15 Jun 2023 23:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686873163;
 bh=87sbTy8afFIB1CwG/k/G28GLTAWWKBZBhwqBsWDYhE8=;
 h=Date:From:To:cc:Subject:From;
 b=bsVqs6D++Rtq4hleS1m75Pi0jxrIYXi0daYFFUIJlLySVp6DRjaGt/Ab+IMasH3Qy
 Y/hJ3nm/zUpw3M1+BTgzhFUz/N4bzpq9GZBraD9tHq1IcEN17xwM+yDPOC0jDq/a3z
 gJG3m2W2OoGhILMgz6euWAfUGggWTM/aUP4HdQVPfqpAQn2Smh45ucoMNYy7LojA14
 b2bFsttuUmRNWcIXYXpPEu6s0ivA/gck5XJnpwkrmdQVq8VCwkpqcYQoNhPZRzlxdo
 HbaRpAkYD1Qz856y1gu1B883NHuYV+lgPwfeOIfjWL4M5dW/gqhmc1VWDvwBVFnIoE
 8yQr4EzMnzdFg==
Date: Thu, 15 Jun 2023 16:52:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: peter.maydell@linaro.org, richard.henderson@linaro.org
cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com
Subject: [PULL v5 00/11] xenpvh5-tag
Message-ID: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Peter, Richard,

Vikram fixed the gitlab test problem yet again. I appended a tiny qtest
fix at the end of the series.

Cheers,

Stefano


The following changes since commit 7efd65423ab22e6f5890ca08ae40c84d6660242f:

  Merge tag 'pull-riscv-to-apply-20230614' of https://github.com/alistair23/qemu into staging (2023-06-14 05:28:51 +0200)

are available in the Git repository at:

  https://gitlab.com/sstabellini/qemu.git xenpvh5-tag

for you to fetch changes up to d8a714eba68cd7221d44a6acb6b8a69cf6f2f86b:

  test/qtest: add xepvh to skip list for qtest (2023-06-15 16:46:58 -0700)

----------------------------------------------------------------
Stefano Stabellini (5):
      hw/i386/xen/xen-hvm: move x86-specific fields out of XenIOState
      xen-hvm: reorganize xen-hvm and move common function to xen-hvm-common
      include/hw/xen/xen_common: return error from xen_create_ioreq_server
      hw/xen/xen-hvm-common: skip ioreq creation on ioreq registration failure
      meson.build: do not set have_xen_pci_passthrough for aarch64 targets

Vikram Garhwal (6):
      hw/i386/xen/: move xen-mapcache.c to hw/xen/
      hw/i386/xen: rearrange xen_hvm_init_pc
      hw/xen/xen-hvm-common: Use g_new and error_report
      hw/arm: introduce xenpvh machine
      meson.build: enable xenpv machine build for ARM
      test/qtest: add xepvh to skip list for qtest

 docs/system/arm/xenpvh.rst       |   34 ++
 docs/system/target-arm.rst       |    1 +
 hw/arm/meson.build               |    2 +
 hw/arm/xen_arm.c                 |  181 +++++++
 hw/i386/meson.build              |    1 +
 hw/i386/xen/meson.build          |    1 -
 hw/i386/xen/trace-events         |   19 -
 hw/i386/xen/xen-hvm.c            | 1075 ++++----------------------------------
 hw/xen/meson.build               |    7 +
 hw/xen/trace-events              |   19 +
 hw/xen/xen-hvm-common.c          |  879 +++++++++++++++++++++++++++++++
 hw/{i386 => }/xen/xen-mapcache.c |    0
 include/hw/arm/xen_arch_hvm.h    |    9 +
 include/hw/i386/xen_arch_hvm.h   |   11 +
 include/hw/xen/arch_hvm.h        |    5 +
 include/hw/xen/xen-hvm-common.h  |   99 ++++
 include/hw/xen/xen_native.h      |    8 +-
 meson.build                      |    4 +-
 tests/qtest/libqtest.c           |    3 +-
 19 files changed, 1349 insertions(+), 1009 deletions(-)
 create mode 100644 docs/system/arm/xenpvh.rst
 create mode 100644 hw/arm/xen_arm.c
 create mode 100644 hw/xen/xen-hvm-common.c
 rename hw/{i386 => }/xen/xen-mapcache.c (100%)
 create mode 100644 include/hw/arm/xen_arch_hvm.h
 create mode 100644 include/hw/i386/xen_arch_hvm.h
 create mode 100644 include/hw/xen/arch_hvm.h
 create mode 100644 include/hw/xen/xen-hvm-common.h


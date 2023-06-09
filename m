Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBF72A0DF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7faJ-0005gh-Pg; Fri, 09 Jun 2023 13:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7faH-0005gI-QM
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 13:07:33 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7faG-000241-0Y
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 13:07:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CCC9F61471;
 Fri,  9 Jun 2023 17:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C83FC433D2;
 Fri,  9 Jun 2023 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686330449;
 bh=G5TIlIqb+wC3Va49Vo4kACIEvbDh1EqTt2sXcEupH/E=;
 h=Date:From:To:cc:Subject:From;
 b=EyzC+H6OPGwJtSCQA+eV5SLQGlmwwhZFyC71xndm6zMX7L7ZJmxCtNs09KD1Q2xZf
 2vakjTv4uxzz3y7hvpFkNZCxt0YIrjBcFOrxEQ8i9mPtDHtl3eLqCdPCnbytq6rGOY
 nyyHCblkCC10GeFvIWmzpIqOUBQz+razG4n5Z43V0l7bjnmF9xIpbC+YiGemcDxwPB
 AZUg2Ns1JDnhHuCAgx8xUUBRQd+pdYfN9jl5QpDvfXBO7HDaVTj831lJYmc/ee8991
 uEyfK0735Ii9gGyGzPtgKdDFsrVqTc3XC7Rs0pN+H2g2pU8ZvoyYu7jbROxS5M/stm
 ctkp0cc2+SsiA==
Date: Fri, 9 Jun 2023 10:07:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: peter.maydell@linaro.org
cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com, 
 richard.henderson@linaro.org
Subject: [PULL v4 0/10] xenpvh4-tag
Message-ID: <alpine.DEB.2.22.394.2306091007210.3803068@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Peter,

Vikram fixed the gitlab test problem again. This time I am providing
proof that it is not introducing build regressions:

baseline: https://gitlab.com/sstabellini/qemu/-/pipelines/894578994
with new commits: https://gitlab.com/sstabellini/qemu/-/pipelines/894471770

Cheers,

Stefano


The following changes since commit 5f9dd6a8ce3961db4ce47411ed2097ad88bdf5fc:

  Merge tag 'pull-9p-20230608' of https://github.com/cschoenebeck/qemu into staging (2023-06-08 08:47:35 -0700)

are available in the Git repository at:

  https://gitlab.com/sstabellini/qemu xenpvh4-tag

for you to fetch changes up to 236c27fd61dd0961631076a56286dd108fe5ef1f:

  meson.build: enable xenpv machine build for ARM (2023-06-08 16:54:31 -0700)

----------------------------------------------------------------
Stefano Stabellini (5):
      hw/i386/xen/xen-hvm: move x86-specific fields out of XenIOState
      xen-hvm: reorganize xen-hvm and move common function to xen-hvm-common
      include/hw/xen/xen_common: return error from xen_create_ioreq_server
      hw/xen/xen-hvm-common: skip ioreq creation on ioreq registration failure
      meson.build: do not set have_xen_pci_passthrough for aarch64 targets

Vikram Garhwal (5):
      hw/i386/xen/: move xen-mapcache.c to hw/xen/
      hw/i386/xen: rearrange xen_hvm_init_pc
      hw/xen/xen-hvm-common: Use g_new and error_report
      hw/arm: introduce xenpvh machine
      meson.build: enable xenpv machine build for ARM

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
 18 files changed, 1347 insertions(+), 1008 deletions(-)
 create mode 100644 docs/system/arm/xenpvh.rst
 create mode 100644 hw/arm/xen_arm.c
 create mode 100644 hw/xen/xen-hvm-common.c
 rename hw/{i386 => }/xen/xen-mapcache.c (100%)
 create mode 100644 include/hw/arm/xen_arch_hvm.h
 create mode 100644 include/hw/i386/xen_arch_hvm.h
 create mode 100644 include/hw/xen/arch_hvm.h
 create mode 100644 include/hw/xen/xen-hvm-common.h


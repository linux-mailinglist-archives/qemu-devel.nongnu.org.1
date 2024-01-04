Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C738282484B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaE-0001L5-Ui; Thu, 04 Jan 2024 13:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaB-0001HL-9y
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:44 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSa9-0004pa-6q
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 08583B81A19;
 Thu,  4 Jan 2024 18:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E618AC433C8;
 Thu,  4 Jan 2024 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393392;
 bh=kppn6/8aqphYn7jxY1OJtjBn3tczlhMoWZRE9Gt68TE=;
 h=From:To:Cc:Subject:Date:From;
 b=PXlrs/YH/KKTDOZKXrjdxy/R2JQl5RkAtkBnGbYhl1/3FiQXIV103fM7AAYvxKhDZ
 n2yZtDvIiQt/TlbP/V1mBokLnTDtRjDAKWa/igiXIxU4x+833Ry9YUDAp7xcxwezs7
 kTRR7gGQEZbITSq+jF5QVadOe9I4ntJ9YLqqTatvx6m+ZYRz68KuJj7rm7XST4WpQ3
 sEaJlIru1YZlrRMOYprso5orfsYdL5/RfCmUeieurQydOzk5wHvnnu3UXXNuMjCctG
 Yac792eukN7FB3PlZ1l8rFlQGkyX8Azj6iFDZbn+sGMpQVjAyNqolOeZhPES74D6k3
 6/PnGsP3VxnCA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 0/9] target/hppa qemu v8.2 regression fixes
Date: Thu,  4 Jan 2024 19:36:19 +0100
Message-ID: <20240104183628.101366-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

From: Helge Deller <deller@gmx.de>

There were some regressions introduced with Qemu v8.2 on the hppa/hppa64
target, e.g.:

- 32-bit HP-UX crashes on B160L (32-bit) machine
- NetBSD boot failure due to power button in page zero
- NetBSD FPU detection failure

This small patch series fixes those known regressions and
additionally:

- allows usage of the max. 3840MB of memory (instead of 3GB),
- adds support for the qemu --nodefaults option (to debug other devices)

I tried to keep the patches small to make backporting easier.

This patch set will not fix those known (non-regression) bugs:
- HP-UX and NetBSD still fail to boot on the new 64-bit C3700 machine
- Linux kernel will still fail to boot on C3700 as long as kernel modules are used.

The whole series can be pulled from the "hppa-fixes-8.2" branch from:
https://github.com/hdeller/qemu-hppa.git        hppa-fixes-8.2

Please test and review.

Helge

Helge Deller (9):
  hw/hppa/machine: Allow up to 3840 MB total memory
  hw/hppa/machine: Disable default devices with --nodefaults option
  hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
  target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
  target/hppa: Strip upper 32-bits of IOR on error in probe
  target/hppa: Strip upper 32-bits of IOR on unaligned access error
  hw/hppa: Move software power button address back into PDC
  target/hppa: Avoid accessing %gr0 when raising exception
  target/hppa: Update SeaBIOS-hppa to version 14

 hw/hppa/machine.c         |  33 ++++++++++++++++++++-------------
 hw/pci-host/astro.c       |  26 +++++++++++++++++++++++---
 pc-bios/hppa-firmware.img | Bin 681388 -> 163316 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.c         |   2 +-
 target/hppa/mem_helper.c  |   4 ++--
 target/hppa/op_helper.c   |   2 +-
 7 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.43.0



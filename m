Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E382BEA0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEnF-0007w3-6b; Fri, 12 Jan 2024 05:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnC-0007va-34
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEn8-0006B3-Vm
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 40AC2CE1DBE;
 Fri, 12 Jan 2024 10:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E97C433C7;
 Fri, 12 Jan 2024 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705055370;
 bh=WR4WgIy85WDnCKSCthU+kTyqhKmJuWqfwvx5rx59yuI=;
 h=From:To:Cc:Subject:Date:From;
 b=CCCP+NQ75x/wJqe5wiMmRkJb/q7mzl6PseokJAuRVpN6Q2qhw8yZLnI9xAdu/3iqa
 9IPFkoIwbplzqLNkzvCvk7vKEKAQqHSMEsnPgB32rJsHbszJW98o2su1jXvRqu2b6T
 wuZbbQOXAqioBU3dvYjehMnF1tgkvWTWV7+O2fyksJGUFe6PdmWwLDwsnzbppaesX2
 bgrqVCGigbFJYlb3ZM53s3RUgZIOWfy47xuS2h4hbahZ6Mm2UEky7y7P7uCt1IH2/C
 Uchdygnmvt+mZ8CS2xxkpiFR2aML+N152k28rTzZ9bIJrZzpPxj1ZqF6/+rDIl08Nu
 i3/wKpCeZfGZA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 0/9] target/hppa qemu v8.2 regression fixes
Date: Fri, 12 Jan 2024 11:29:18 +0100
Message-ID: <20240112102927.35406-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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
- OpenBSD 7.4 boot failure

This patch series fixes those known regressions and additionally:

- allows usage of the max. 3840MB of memory (instead of 3GB),
- adds support for the qemu --nodefaults option (to debug other devices)

This patch set will not fix those known (non-regression) bugs:
- HP-UX and NetBSD still fail to boot on the new 64-bit C3700 machine
- Linux kernel will still fail to boot on C3700 as long as kernel modules are used.

The whole series can be pulled from the "hppa-fixes-8.2" branch from:
https://github.com/hdeller/qemu-hppa.git        hppa-fixes-8.2

SeaBIOS v15 has not changed in v3, so it is not included in this
patch review series but will be added in final pull request.

Please review.

Changes v2->v3:
- Added comment about Figures H-10 and H-11 in the parisc2.0 spec
  in patch which calculate PDC address translation if PSW.W=0
- Introduce and use hppa_set_ior_and_isr()
- Use drive_get_max_bus(IF_SCSI), nd_table[] and serial_hd() to check
  if default devices should be created
- Added Tested-by and Reviewed-by tags

Changes v1->v2:
- fix OpenBSD boot with SeaBIOS v15 instead of v14
- commit message enhancements suggested by BALATON Zoltan
- use uint64_t for ram_max in patch #1

Helge Deller (9):
  hw/hppa/machine: Allow up to 3840 MB total memory
  hw/hppa/machine: Disable default devices with --nodefaults option
  hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
  target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
  hw/hppa: Move software power button address back into PDC
  target/hppa: Avoid accessing %gr0 when raising exception
  target/hppa: Export function hppa_set_ior_and_isr()
  target/hppa: Fix IOR and ISR on unaligned access trap
  target/hppa: Fix IOR and ISR on error in probe

 hw/hppa/machine.c        | 28 +++++++++++++++++-----------
 hw/pci-host/astro.c      | 26 +++++++++++++++++++++++---
 target/hppa/cpu.c        |  6 +-----
 target/hppa/cpu.h        |  1 +
 target/hppa/mem_helper.c | 27 ++++++++++++++-------------
 target/hppa/op_helper.c  |  6 +-----
 6 files changed, 57 insertions(+), 37 deletions(-)

-- 
2.43.0



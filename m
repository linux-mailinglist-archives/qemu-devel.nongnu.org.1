Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3690773617
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBwm-0002Zj-7Y; Mon, 07 Aug 2023 21:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwk-0002ZS-5g
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:42 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwg-0003cM-W2
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:40 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id D878943F3A;
 Tue,  8 Aug 2023 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459736; bh=Q6y0igZMEbXmkXQ3PRnhPjW3rKM/COFNMPNpgtmkPfo=;
 h=From:To:Cc:Subject:Date;
 b=Kp30l+vVTz+RcHF1VpPHpo3Ka4SW9BBLxs748ldXqX1gIUg/ShhGsGK+ms6VoGYQe
 5Xc9X/pY416yGBFd0PuQEaHLxtePnaqMkEyIRvz+lHQr2DjJIlCWvORI0rFOpLjwhq
 7DB7/dkbds9cvwz8xY2byXWVpJpiOMwKlINCFU5c=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 00/11] Add la32 & va32 mode for loongarch64-softmmu
Date: Tue,  8 Aug 2023 09:54:26 +0800
Message-ID: <20230808015506.1705140-1-c@jia.je>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch series allow qemu-system-loongarch64 to emulate a LoongArch32
machine. A new CPU model is added for loongarch32. Initial GDB support
is added.

At the same time, VA32(32-bit virtual address) support is introduced for
LoongArch64.

LA32 support is tested using a small supervisor program at
https://github.com/jiegec/supervisor-la32. VA32 mode under LA64 is not
tested yet.

Changes since v3:

- Support VA32 mode for LoongArch64
- Check the current arch from CPUCFG.ARCH
- Reject la64-only instructions in la32 mode

Changes since v2:

- Fix typo in previous commit
- Fix VPPN width in TLBEHI/TLBREHI

Changes since v1:

- No longer create a separate qemu-system-loongarch32 executable, but
  allow user to run loongarch32 emulation using qemu-system-loongarch64
- Add loongarch32 cpu support for virt machine

Full changes:

Jiajie Chen (11):
  target/loongarch: Add macro to check current arch
  target/loongarch: Add new object class for loongarch32 cpus
  target/loongarch: Add GDB support for loongarch32 mode
  target/loongarch: Support LoongArch32 TLB entry
  target/loongarch: Support LoongArch32 DMW
  target/loongarch: Support LoongArch32 VPPN
  target/loongarch: Add LA32 & VA32 to DisasContext
  target/loongarch: Reject la64-only instructions in la32 mode
  target/loongarch: Truncate high 32 bits of address in VA32 mode
  target/loongarch: Sign extend results in VA32 mode
  target/loongarch: Add loongarch32 cpu la132

 configs/targets/loongarch64-softmmu.mak       |  2 +-
 gdb-xml/loongarch-base32.xml                  | 45 ++++++++++
 hw/loongarch/virt.c                           |  5 --
 target/loongarch/cpu-csr.h                    | 22 ++---
 target/loongarch/cpu.c                        | 88 ++++++++++++++++---
 target/loongarch/cpu.h                        | 33 ++++++-
 target/loongarch/gdbstub.c                    | 32 +++++--
 target/loongarch/insn_trans/trans_arith.c.inc | 34 +++----
 .../loongarch/insn_trans/trans_atomic.c.inc   | 77 ++++++++--------
 target/loongarch/insn_trans/trans_bit.c.inc   | 28 +++---
 .../loongarch/insn_trans/trans_branch.c.inc   |  9 +-
 target/loongarch/insn_trans/trans_extra.c.inc | 16 ++--
 .../loongarch/insn_trans/trans_fmemory.c.inc  |  8 ++
 target/loongarch/insn_trans/trans_fmov.c.inc  |  4 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   |  6 ++
 .../loongarch/insn_trans/trans_memory.c.inc   | 78 +++++++++-------
 target/loongarch/insn_trans/trans_shift.c.inc | 14 +--
 target/loongarch/tlb_helper.c                 | 66 +++++++++++---
 target/loongarch/translate.c                  | 26 ++++++
 target/loongarch/translate.h                  | 12 +++
 20 files changed, 430 insertions(+), 175 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D097C738A99
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0Td-0004gc-Q7; Wed, 21 Jun 2023 12:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0Ta-0004g7-ES
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:14:34 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0TX-0007Mj-Lf
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UNXVAnO2CHKrSfMElGZ6Jp+zM0cIL4vN3FTw5C4l28g=; b=DlzhInrTXt8V0st3CdQg8Jhvmh
 lrn4F2Io0mlEpSnf6DdX7hRDdpzplkzj5hAQfxJie6u7L0oLxyYNUADWJUINVpYgtaunIcQxn2DFm
 DnuYh1NY1BGcDwRAHOVDlrnHST56hVFPZHoRc+bfci3/c/flt5EVq10SdXRtmec3dmR4=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL 00/20] tricore queue
Date: Wed, 21 Jun 2023 18:14:02 +0200
Message-Id: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160018, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.21.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1208958, da=174973131, mc=141, sc=0,
 hc=141, sp=0, fso=1208958, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

The following changes since commit c5ffd16ba4c8fd3601742cc9d2b3cff03995dd5d:

  Revert "cputlb: Restrict SavedIOTLB to system emulation" (2023-06-21 07:19:46 +0200)

are available in the Git repository at:

  https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20230621-1

for you to fetch changes up to a9c37abdff65a07d0191123a21d318c4d8cc7f33:

  target/tricore: Fix ICR.IE offset in RESTORE insn (2023-06-21 18:09:54 +0200)

----------------------------------------------------------------
- Implement privilege levels for TriCore
- Fix missing REG_PAIR() for insns using two 32 regs
- Fix erroneously saving PSW.CDC on CALL insns
- Added some missing v1.6.2 insns

----------------------------------------------------------------
Bastian Koppelmann (19):
      target/tricore: Introduce ISA 1.6.2 feature
      target/tricore: Add popcnt.w insn
      target/tricore: Add LHA insn
      target/tricore: Add crc32l.w insn
      target/tricore: Add crc32.b insn
      target/tricore: Add shuffle insn
      target/tricore: Implement SYCSCALL insn
      target/tricore: Add DISABLE insn variant
      target/tricore: Correctly fix saving PSW.CDE to CSA on call
      target/tricore: Add CHECK_REG_PAIR() for insn accessing 64 bit regs
      target/tricore: Fix helper_ret() not correctly restoring PSW
      target/tricore: Fix RR_JLI clobbering reg A[11]
      target/tricore: Introduce DISAS_TARGET_EXIT
      target/tricore: ENABLE exit to main-loop
      target/tricore: Indirect jump insns use tcg_gen_lookup_and_goto_ptr()
      target/tricore: Introduce priv tb flag
      target/tricore: Implement privilege level for all insns
      target/tricore: Honour privilege changes on PSW write
      target/tricore: Fix ICR.IE offset in RESTORE insn

Siqi Chen (1):
      target/tricore: Fix out-of-bounds index in imask instruction

 target/tricore/cpu.c             |  13 +++
 target/tricore/cpu.h             |  18 +++--
 target/tricore/helper.h          |   5 +-
 target/tricore/op_helper.c       |  69 ++++++++++++++--
 target/tricore/translate.c       | 167 ++++++++++++++++++++++++++++++---------
 target/tricore/tricore-opcodes.h |  16 +++-
 6 files changed, 237 insertions(+), 51 deletions(-)


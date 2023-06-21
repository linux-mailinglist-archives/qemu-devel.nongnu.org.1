Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D39A737F75
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuwe-0003Mu-GE; Wed, 21 Jun 2023 06:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBuwY-0003JI-RA
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:07 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBuwW-0000wO-2j
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TJGC9vBE/Ggg8VDPsnGh9bgaWfzGDXmsj1ogkangZmQ=; b=SwRtsvvQGqgbt8+ouK7E1bVgeZ
 FB16/ytxtKMUHRCExbe32q24dTvFkkJ0FHsUZf87TWkZPyGpmCDnxEpI5UVzNTWO5o/iNYaUn2kYZ
 WoGv952iVNV5T9P6kdKR64IHF8bcTk7KytVeJqpdfwgwFeQS/mnIxXeejWZyFhRDdJmw=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v3 0/8] TriCore Privilege Levels
Date: Wed, 21 Jun 2023 12:19:42 +0200
Message-Id: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.101217, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1187687, da=174951860, mc=104, sc=0,
 hc=104, sp=0, fso=1187687, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
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

Hi,

this patch series tries to properly implement privilege levels for the TriCore,
as discussed in
https://lore.kernel.org/qemu-devel/20230118090319.32n4uto7ogy3gfr6@schnipp.zuhause/.

While implementing privilege traps for the SV/UM1 only insns, I saw that
the RESTORE insn uses the wrong ICR.IE bit. So I fixed that as well.

Cheers,
Bastian

v1 -> v2:
    - Fixed bug where JLI clobbered reg A[11]          | PATCH [01/08]
    - Moved all calls to tcg_gen_exit_tb() to          | PATCH [02/08]
      tricore_tr_tb_stop()                             |
    - Enable/disable insns now exit to main-loop       | PATCH [03/08]
    - Indirect jumps us tcg_gen_lookup_and_goto_ptr()  | PATCH [04/08]
    - Removed (uint32_t) cast                          | PATCH [05/08]
    - Removed psw_write() calling cpu_loop_exit()      | PATCH [07/08]

v2 -> v3:
    - DISABLE insns don't end the TB                   | PATCH [03/08]
    - generate_trap() for indirct jump now set         | PATCH [04/08]
      DISAS_NORETURN                                   |

Bastian Koppelmann (8):
  target/tricore: Fix RR_JLI clobbering reg A[11]
  target/tricore: Introduce DISAS_TARGET_EXIT
  target/tricore: ENABLE/DISABLE exit to main-loop
  target/tricore: Indirect jump insns use tcg_gen_lookup_and_goto_ptr()
  target/tricore: Introduce priv tb flag
  target/tricore: Implement privilege level for all insns
  target/tricore: Honour privilege changes on PSW write
  target/tricore: Fix ICR.IE offset in RESTORE insn

 target/tricore/cpu.h       | 17 +++++--
 target/tricore/translate.c | 97 ++++++++++++++++++++++++++------------
 2 files changed, 78 insertions(+), 36 deletions(-)

--
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E57334C2
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABNF-0004Ua-7J; Fri, 16 Jun 2023 11:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABN7-0004PP-N0
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:22 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABN5-0000k8-5K
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HysUMYOUXOAM/IgNpg8/rYqW9k1OQXC7c9ZmhPI3Blg=; b=Xs0Im1+WtqdpOY+zZWu6NBTf5W
 gRyUj3tRT0CTKCUBaigDaHVbyLd/iN2q9uzjQxBexTMopaRjmgEDKwlDeWXg9CdnfmbiPzDKT22Fm
 2J7dgxRsMiNMbR40831QuTEpTokAk6aAC0ABynuV3Co5RfbR7+neCCQzmoa6SHNy6EHM=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 0/8] TriCore Privilege Levels
Date: Fri, 16 Jun 2023 17:28:00 +0200
Message-Id: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.16.152116, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=774183, da=174538356, mc=84, sc=0,
 hc=84, sp=0, fso=774183, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 target/tricore/translate.c | 98 ++++++++++++++++++++++++++------------
 2 files changed, 79 insertions(+), 36 deletions(-)

--
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9772AB09
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 12:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7wGs-0006mo-A7; Sat, 10 Jun 2023 06:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q7wGp-0006mT-7i
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 06:56:35 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q7wGn-000339-3O
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 06:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvQFphxWlPXA0QSzq1gPeoaMKvbd4PqNIXp1wc1bejw=; b=oxJDyRtN1L2FmOaOr9QZ7XhaNv
 9iBDAUBjSUGUZFfBv8RDmK4h8PAtAXSEkP2W7HhA8wvGnGe++bvJs/ABexDuhoknIRHPUJnoNlxHy
 85hd46THln7384W42Q+PPFD/DVABd3VV9bgrYgxn/hUaHmiGgheoOK6RAqM1VDbaX2NI=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 0/6] TriCore 1.6.2 Instructions
Date: Sat, 10 Jun 2023 12:55:41 +0200
Message-Id: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.10.104517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.10.600000
X-Sophos-SenderHistory: ip=79.202.219.6, fs=239478, da=174003651, mc=14, sc=0,
 hc=14, sp=0, fso=239478, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
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

this patch series is in response to the tickets [1] [2], which point out missing
instructions from ISA v1.6.2. This is the first series that implements the low
hanging fruits.

Cheers,
Bastian

[1] https://gitlab.com/qemu-project/qemu/-/issues/1452
[2] https://gitlab.com/qemu-project/qemu/-/issues/1667

Bastian Koppelmann (6):
  target/tricore: Introduce ISA 1.6.2 feature
  target/tricore: Add popcnt.w insn
  target/tricore: Add LHA insn
  target/tricore: Add crc32l.w insn
  target/tricore: Add crc32.b insn
  target/tricore: Add shuffle insn

 target/tricore/cpu.c             | 13 +++++++
 target/tricore/cpu.h             |  1 +
 target/tricore/helper.h          |  5 ++-
 target/tricore/op_helper.c       | 66 +++++++++++++++++++++++++++++++-
 target/tricore/translate.c       | 48 +++++++++++++++++++++--
 target/tricore/tricore-opcodes.h | 15 +++++++-
 6 files changed, 140 insertions(+), 8 deletions(-)

-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E80738AB2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0UN-0006Pv-QL; Wed, 21 Jun 2023 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0UM-0006PK-Dz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:15:22 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0UK-0007jd-RM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RHciuW2fEWc0swd4kloYT+oqZYQTeQiigRooo87XSpc=; b=PTHDIf6LAOZhr9G3O4e/Xb8EJJ
 GUT+tdxRIhsJVt+f/X4uYSoWsDtNAVl8mVsQBEGltKBBxh+OwCYQ82XJ7DgaXFVG/ctgH3aV8absW
 QEz4BFwpuPx4tiuJT5t56YeEe9d3blZvkpJgjc/0Y0hoCKgfliogRtVmnsclBr8oFI4k=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	Siqi Chen <coc.cyqh@gmail.com>
Subject: [PULL 09/20] target/tricore: Fix out-of-bounds index in imask
 instruction
Date: Wed, 21 Jun 2023 18:14:11 +0200
Message-Id: <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160616, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1209010, da=174973183, mc=159, sc=0,
 hc=159, sp=0, fso=1209010, re=0, sd=0, hd=0
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

From: Siqi Chen <coc.cyqh@gmail.com>

When translating  "imask" instruction of Tricore architecture, QEMU did not check whether the register index was out of bounds, resulting in a global-buffer-overflow.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1698
Reported-by: Siqi Chen <coc.cyqh@gmail.com>
Signed-off-by: Siqi Chen <coc.cyqh@gmail.com>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230612065633.149152-1-coc.cyqh@gmail.com>
Message-Id: <20230612113245.56667-2-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6712d98f6e..74faad4794 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5339,6 +5339,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RCRW_IMASK:
+        CHECK_REG_PAIR(r4);
         tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
         tcg_gen_movi_tl(temp2, (1 << width) - 1);
         tcg_gen_shl_tl(cpu_gpr_d[r4 + 1], temp2, temp);
-- 
2.40.1



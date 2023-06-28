Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9200F74105D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETdI-0003KE-8H; Wed, 28 Jun 2023 07:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcO-0002gD-62
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:46:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcL-0005F5-Hp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FV+chXvjmNEXKyHiXB6vsfOn/aoT2Gsa6mwo/x6dy/A=; b=k44+/gkvrg96DyXI7wEj/HPu+g
 MNgtOi8+sSfBhrniLJEdevSh/Vo6qH3DdK0m7JJEC6TC9FaOTqoiir65Jgz1secpFALo8xJiU0Tfv
 muqHVAQYqupxioVh7Kpkp3i9YlMVf/f2wvyhbBRjFkQuSiHy2bzUaGCz94gahIWYhoMEzwTOGTZT+
 6swtuAXVQD5LDvc7pIivNSK/ahSa6cXnNIFYCaxl4W9thaZPF+epYrdsk6Aunb829aKY1xtMT0/W8
 bYLkgio+Qc3cIB4KUZ1E54F4v9UgtCztll+RGpu06xhvhF1ww3KGk5wnrmFCBA+T4u5OnE6PoPNzl
 UoV93tw+sqqSQUKVHQhaFiVg4LYCfuS06cJSKbCerQ/JYnJvfNZUkKFmUItYy/cqi/qAtLZKLjBNn
 Tjwr6GfrHjw8upDgXu9NdSVmyqtvd9I/yAg9Q6b/koKHw4ncimEeoq+17czQ1vQ4qvbTiP2orv3vW
 y01d0gFskWDjXiGHuWX5mtLDg/e+bugG1wXFnmJhJopzp5spajcku+OTF3np/BWlj2xHx/SmZsKpT
 otGh0VUBBQdD51ZzTMcSmCpnQHKZ88Fgtoae7Lf/A4L3eLXP7io0/oyE3QtUm2GupZ7urNSQL/8Jo
 cVAd98olF9aD3wy5xoZ+kBxvV5COBGJNaeIZ3ENvc=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETc7-00007c-En; Wed, 28 Jun 2023 12:45:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:45:03 +0100
Message-Id: <20230628114504.546265-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 09/10] target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9
 WRASI
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

We incorporate %asi into tb->flags so that we may generate
inline code for the many ASIs for which it is easy to do so.
Setting %asi is common for e.g. memcpy and memset performing
block copy and clear, so it is worth noticing this case.

We must end the TB but do not need to return to the main loop.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230628071202.230991-9-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9148e33283..bd877a5e4a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4147,10 +4147,14 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 tcg_gen_andi_tl(cpu_tmp0, cpu_tmp0, 0xff);
                                 tcg_gen_st32_tl(cpu_tmp0, cpu_env,
                                                 offsetof(CPUSPARCState, asi));
-                                /* End TB to notice changed ASI.  */
+                                /*
+                                 * End TB to notice changed ASI.
+                                 * TODO: Could notice src1 = %g0 and IS_IMM,
+                                 * update DisasContext and not exit the TB.
+                                 */
                                 save_state(dc);
                                 gen_op_next_insn();
-                                tcg_gen_exit_tb(NULL, 0);
+                                tcg_gen_lookup_and_goto_ptr();
                                 dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0x6: /* V9 wrfprs */
-- 
2.30.2



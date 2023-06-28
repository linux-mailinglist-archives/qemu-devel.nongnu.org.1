Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7474104A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETcb-0002TM-1u; Wed, 28 Jun 2023 07:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbw-0002GR-OR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbt-00053f-GU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EwVYgIJkKuX6qaEES3ORCAC9rPrXsnb3WcOmlW8B9yY=; b=oPGccwFxMoeAReRwLPcPst7DJD
 1wB2x5hEi6O0Zwc7X8b8shATzq5ZxY/w3ZQXQSqVhVLCwtyOHgLqxSaL/55t+k/866W0xhsiNk/vj
 8ycy1lUzLepk7UYrRaqV5G9v2bTtHEIs8pg0hxcxY5GjTz6eHnHRqEq147E/AHniKfnGvDRD/ZDME
 cqKBtO/ynwO5A24sWGPpibQdo4mNND/aONZJGbHd509aeT6t+0Npc41NyfTkGJ2C/RS4O98HS46Po
 iW3fLR0SxUOg25tmUDyghABCdMXsmlG/gFzJxTO00bJ1nFo+Ym6rc0fJqEDhSsrvfIjnospwmjBsa
 C+hijygBkwMWahkNUsGVX9XQc+3q2O7PZk6BllYUYjolPLPZNujos376Nl267Cl1ETDfVflu/pAyo
 XLyhj0WERidf2fBrYNmqX60+i7gMMwISVbzz1HPiRgFO47oxBT5dSasxdk7q13Wg+urUaOTkXRq3e
 6OqINLtaFo0mSX+3qFQmo8MXnORTfoDDk8B0njywEtJpDFIgzr+1UX5Sb5PLp9NvSFgky5lG9z5GL
 mcm4P5awyIMH46XQ8goJJWs8OiUB75D3PE2l4T72xlZ/pA0LBD60W7dlEZnopzkir3xOpetC7QoQk
 4VyozcYdb9pTu4c0LO8Gn8zOyExUmx5NFzZAYx7k0=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbf-00007c-CX; Wed, 28 Jun 2023 12:45:11 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:44:56 +0100
Message-Id: <20230628114504.546265-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 02/10] target/sparc: Use tcg_gen_lookup_and_goto_ptr in
 gen_goto_tb
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230628071202.230991-2-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bad2ec90a0..28d4cdb8b4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -318,10 +318,10 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
         tcg_gen_movi_tl(cpu_npc, npc);
         tcg_gen_exit_tb(s->base.tb, tb_num);
     } else {
-        /* jump to another page: currently not optimized */
+        /* jump to another page: we can use an indirect jump */
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
 }
 
-- 
2.30.2



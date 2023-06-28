Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72393741050
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETdN-00040X-Of; Wed, 28 Jun 2023 07:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcM-0002g8-Ku
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:46:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcJ-0005BW-6z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=puy44AvdZMQUEA3aEHuBFbJ1B7IKOJW00RpQVJ7zYyE=; b=hnnQhb+mFJjUGNwrPIDeToupEM
 YYR5SHaA3zcFfUUYrzw0qydAIqp/FyjIgrEfFb2tNFeJ2eWbRzaNn6TjO9xr2OaGTN6IQ17e7FUBu
 NZuTRhp/APe4vFI9LUfQwAk70FZVS46HFdC7HAETxVKMFgCrRrytwWb6KvoqILW9nthsRoz/d3mZU
 BD2As80vPf/W0in7xqN0MvHjOwvfSP/SFligdnaAT0snYB1MmsqjNeVaTKFzcdwpeag1YGJfnEZ9W
 oc4pRItLnh7pnybzuQl27m9SMc/Yd7PYxtEvxYk7vRzisnvsacDOkLbXsYJRILsJF2YtHWPyJKyru
 WFfkxWP5Ba3eSjX1MCsSRx2Bq6LzlV8zR8F2v4l/xdyWg5FatEI6RmjqWas8J0DVijdU62SMnHKZg
 /7zZK/EwS/AgxZQHIQ3PJYDHLPPE5J/JzzPKdBAJqdS1B2OAAWWpReB5lv/If16tL80e7SZefAX/h
 ByzAx9aOvFOOGr6UaasMTDppfGwVXWSfPPE0Ig2NS3ZJTeJ3RzaTkQY0nR7ljCnDHyybll8XW+Ewi
 C+tcUOn7JKdTV0Ip3jQJeJx5Q+Llqn25phg4h/+d/XStdL7RZOSXUDI8bpDtFRmLGUwY0EnIP5zn4
 tr1nddMJ8bmXkF9Pxxaj09ELWS4ZODloPn7BHWqwQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETc1-00007c-Ov; Wed, 28 Jun 2023 12:45:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:45:01 +0100
Message-Id: <20230628114504.546265-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 07/10] target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
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

This is for a plain indirect branch with no other side effects.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230628071202.230991-7-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d7b569d910..17afe98523 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5058,7 +5058,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         gen_check_align(cpu_tmp0, 3);
                         gen_address_mask(dc, cpu_tmp0);
                         tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC;
+                        dc->npc = DYNAMIC_PC_LOOKUP;
                     }
                     goto jmp_insn;
 #if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
-- 
2.30.2



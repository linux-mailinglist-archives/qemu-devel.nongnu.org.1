Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C374104B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETcb-0002Uc-Jm; Wed, 28 Jun 2023 07:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbz-0002GU-Pj
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETby-00055S-Be
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kA8U5ZqxC+smogql+DAxDyinmV9IOFsn3lSKwKB0BTU=; b=MI5HTISLb7cbS3trzdbz9nfh/b
 B4rco69fQgG9jTvfrJEaQul8Jc+StmB+QDq2bhR8jBJCz31VQ+YxuDj1ja4ZCoOAtcFHt1DKxle/+
 LabU6zh1MsKUAxMMtCG2lKMHkuTEqJcuDvcXk6WPmHIKfVL4IsISzU3HJGxM6+wPXiCUVPUZKiXlL
 Y5ThxuqLnfv35GwMi6CwpQynPm2jU5QGQcbxuIszYfMwdC5XWozU3ZFwaGrLwTuj0sExofx6nQet/
 HIPdQWHhgKF5DT4n1mw4KF1sONnO8e+AwebkINxc9e331eKKwCO29nMpLCyKDnxwkIHZytRzb6jYT
 xqQtNJcakMW5OcUP00/wlrIA5HH9V1JFKOqwO0zBTA7UAJOLyLooLuibuOICIckwxdI/mff66bmNy
 otHjY6EtWnvXPbe+0ni3G7AUUGJwfXlqrgTTd0oIEOUWLeChFwDv3+kGSFO+VlZwY1THoG9ZifHN5
 3KyxD4RTW0Zr3/+mrkPoMfiNB+SsS/LZ7H20+yrA5QF5bwHStrD9kWVFPUTsXlyJ3lYHfTh/elxNt
 /KarAwFN7oTWbfkv9G7mcY/UxFlga9CNkrh59S1HY2qZp+LJi6wG5g/cPOAaKOSu+yt+SaVoCGGMB
 TLw9vp6bjqKrlM8jKrEU9VR8Fs2LbQEBS/M25P2Zs=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbk-00007c-1P; Wed, 28 Jun 2023 12:45:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:44:57 +0100
Message-Id: <20230628114504.546265-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 03/10] target/sparc: Fix npc comparison in sparc_tr_insn_start
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

During translation, npc == address, DYNAMIC_PC, or JUMP_PC.
It is only the encoding between here and sparc_restore_state_to_opc
that considers JUMP_PC to be a bit within a larger value.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230628071202.230991-3-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 28d4cdb8b4..eec6f9ca67 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5594,7 +5594,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (dc->npc & JUMP_PC) {
+    if (dc->npc == JUMP_PC) {
         assert(dc->jump_pc[1] == dc->pc + 4);
         tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
     } else {
-- 
2.30.2



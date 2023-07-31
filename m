Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B97691ED
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPMy-0004v7-UK; Mon, 31 Jul 2023 05:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qQPMv-0004uO-Dk
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:39:13 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qQPMt-00077p-Ct
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:39:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B66FA60FD0;
 Mon, 31 Jul 2023 09:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21129C433C8;
 Mon, 31 Jul 2023 09:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690796349;
 bh=e5b+jaLb9qzOD64Op6iaJSDogIEYmK5afQapkfb1vj8=;
 h=From:To:Cc:Subject:Date:From;
 b=Ve0AGchtr4uvvrBK6fkwhrTC54RVtehU6xfhhANwK6Mv6NvVvDHk1lzNO7fSmpK2V
 t+7Pm1NB+Vz+Qic6Ei0dZqtEStSF8YY6+pb1xVTQNOzdnv1w1cafbJK2lusIfCJ0+d
 w75peVPmi6HheUUCLzhkltDwp/3/A2gWoMb8tdprNhYhQ61WHzrBkq52ztBxYv5PlD
 KXumx6RhKXNSh9OFYWJBIHEsoJ/oZC8r6abPQXZ5YXtVuL1N94T97lxzrLO05WblFh
 50r07/bpNAK/pxdvvXxWFfywFQIfGZ7rwGJhlQFBzfa1suIO4zB5QgLFABJa7MCz00
 IOEeFaUP/eqrA==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/riscv: Use accelerated helper for AES64KS1I
Date: Mon, 31 Jul 2023 11:39:02 +0200
Message-Id: <20230731093902.1796249-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=ardb@kernel.org;
 h=from:subject; bh=e5b+jaLb9qzOD64Op6iaJSDogIEYmK5afQapkfb1vj8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV4o4lRgvDD1T5+Ksszbd4oHntcOlNvxrOjwY+Up2p/y
 rl5buGujlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR1/8Z/ntn/9c+IDLzQPup
 La/v+Oqc7/+6t36ixe3vjIbX5vUsWi7P8Id/harO5/K/57xrl/NN3jt1xRv1PbMeVzffF7H3c3G
 IrGECAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the accelerated SubBytes/ShiftRows/AddRoundKey AES helper to
implement the first half of the key schedule derivation. This does not
actually involve shifting rows, so clone the same uint32_t 4 times into
the AES vector to counter that.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 target/riscv/crypto_helper.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 4d65945429c6dcc4..257c5c4863fb160f 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -148,24 +148,17 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, target_ulong rnum)
 
     uint8_t enc_rnum = rnum;
     uint32_t temp = (RS1 >> 32) & 0xFFFFFFFF;
-    uint8_t rcon_ = 0;
-    target_ulong result;
+    AESState t, rc = {};
 
     if (enc_rnum != 0xA) {
         temp = ror32(temp, 8); /* Rotate right by 8 */
-        rcon_ = round_consts[enc_rnum];
+        rc.w[0] = rc.w[1] = rc.w[2] = rc.w[3] = round_consts[enc_rnum];
     }
 
-    temp = ((uint32_t)AES_sbox[(temp >> 24) & 0xFF] << 24) |
-           ((uint32_t)AES_sbox[(temp >> 16) & 0xFF] << 16) |
-           ((uint32_t)AES_sbox[(temp >> 8) & 0xFF] << 8) |
-           ((uint32_t)AES_sbox[(temp >> 0) & 0xFF] << 0);
+    t.w[0] = t.w[1] = t.w[2] = t.w[3] = temp;
+    aesenc_SB_SR_AK(&t, &t, &rc, false);
 
-    temp ^= rcon_;
-
-    result = ((uint64_t)temp << 32) | temp;
-
-    return result;
+    return t.d[0];
 }
 
 target_ulong HELPER(aes64im)(target_ulong rs1)
-- 
2.39.2



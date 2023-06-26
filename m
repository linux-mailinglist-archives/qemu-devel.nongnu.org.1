Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413D73EA9F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrN1-0002nU-9z; Mon, 26 Jun 2023 14:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMQ-0001z2-2M; Mon, 26 Jun 2023 14:54:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrLr-0005ho-Ex; Mon, 26 Jun 2023 14:54:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A37FEF42;
 Mon, 26 Jun 2023 21:50:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 041F3F7D1;
 Mon, 26 Jun 2023 21:50:28 +0300 (MSK)
Received: (nullmailer pid 1574088 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Siqi Chen <coc.cyqh@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 43/54] target/tricore: Fix out-of-bounds index in imask
 instruction
Date: Mon, 26 Jun 2023 21:49:50 +0300
Message-Id: <20230626185002.1573836-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
(cherry picked from commit d34b092cab606a47a0d76edde45aab7100bb2435)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2646cb3eb5..1921b7bfb5 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5327,6 +5327,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RCRW_IMASK:
+        CHECK_REG_PAIR(r4);
         tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
         tcg_gen_movi_tl(temp2, (1 << width) - 1);
         tcg_gen_shl_tl(cpu_gpr_d[r4 + 1], temp2, temp);
-- 
2.39.2



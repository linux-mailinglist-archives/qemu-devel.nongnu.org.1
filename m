Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD18393B7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:51:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJ0i-0003J1-63; Tue, 23 Jan 2024 10:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSIzo-0002nL-Sj; Tue, 23 Jan 2024 10:47:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSIzh-0000gL-Ge; Tue, 23 Jan 2024 10:47:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AA9C46920;
 Tue, 23 Jan 2024 18:47:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1289B69EAF;
 Tue, 23 Jan 2024 18:47:09 +0300 (MSK)
Received: (nullmailer pid 3847903 invoked by uid 1000);
 Tue, 23 Jan 2024 15:47:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, guoguangyao <guoguangyao18@mails.ucas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 41/54] target/i386: fix incorrect EIP in PC-relative
 translation blocks
Date: Tue, 23 Jan 2024 18:46:42 +0300
Message-Id: <20240123154708.3847837-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
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

From: guoguangyao <guoguangyao18@mails.ucas.ac.cn>

The PCREL patches introduced a bug when updating EIP in the !CF_PCREL case.
Using s->pc in func gen_update_eip_next() solves the problem.

Cc: qemu-stable@nongnu.org
Fixes: b5e0d5d22fbf ("target/i386: Fix 32-bit wrapping of pc/eip computation")
Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240115020804.30272-1-guoguangyao18@mails.ucas.ac.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2926eab8969908bc068629e973062a0fb6ff3759)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e68375b19d..312ca0d594 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -566,9 +566,9 @@ static void gen_update_eip_next(DisasContext *s)
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
     } else if (CODE64(s)) {
-        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
+        tcg_gen_movi_tl(cpu_eip, s->pc);
     } else {
-        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->pc - s->cs_base));
     }
     s->pc_save = s->pc;
 }
-- 
2.39.2



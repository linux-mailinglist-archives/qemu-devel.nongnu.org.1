Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183C761A98
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINZ-0007GO-EI; Tue, 25 Jul 2023 09:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMQ-0005NS-O3; Tue, 25 Jul 2023 09:46:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMP-0001Tc-5i; Tue, 25 Jul 2023 09:45:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 71AC0160F3;
 Tue, 25 Jul 2023 16:45:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2E93B194B6;
 Tue, 25 Jul 2023 16:45:32 +0300 (MSK)
Received: (nullmailer pid 3370816 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 11/31] target/mips: enable GINVx support for I6400 and
 I6500
Date: Tue, 25 Jul 2023 16:44:56 +0300
Message-Id: <20230725134517.3370706-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Marcin Nowakowski <marcin.nowakowski@fungible.com>

GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
so indicate that properly in CP0.Config5 register bits [16:15].

Cc: qemu-stable@nongnu.org
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit baf21eebc3e1026d21d94fdf8ca470050e49968f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d45f245a67..da122e72d7 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -709,7 +709,7 @@ const mips_def_t mips_defs[] =
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
@@ -749,7 +749,7 @@ const mips_def_t mips_defs[] =
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
-- 
2.39.2



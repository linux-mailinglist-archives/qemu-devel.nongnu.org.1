Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A37C981B
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 08:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qruI9-0002E3-7z; Sun, 15 Oct 2023 02:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qruI6-00026H-Ew; Sun, 15 Oct 2023 02:07:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qruI4-0002RB-Eu; Sun, 15 Oct 2023 02:07:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C83CE2A697;
 Sun, 15 Oct 2023 09:07:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A34852F2FF;
 Sun, 15 Oct 2023 09:07:39 +0300 (MSK)
Received: (nullmailer pid 129209 invoked by uid 1000);
 Sun, 15 Oct 2023 06:07:39 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alvin Chang <vivahavey@gmail.com>,
 Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 63/64] disas/riscv: Fix the typo of inverted order of
 pmpaddr13 and pmpaddr14
Date: Sun, 15 Oct 2023 09:07:18 +0300
Message-Id: <20231015060739.129177-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231015090447@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231015090447@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alvin Chang <vivahavey@gmail.com>

Fix the inverted order of pmpaddr13 and pmpaddr14 in csr_name().

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230907084500.328-1-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit cffa9954908830276c93b430681f66cc0e599aef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index 3873a69157..8e89e1d115 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2116,8 +2116,8 @@ static const char *csr_name(int csrno)
     case 0x03ba: return "pmpaddr10";
     case 0x03bb: return "pmpaddr11";
     case 0x03bc: return "pmpaddr12";
-    case 0x03bd: return "pmpaddr14";
-    case 0x03be: return "pmpaddr13";
+    case 0x03bd: return "pmpaddr13";
+    case 0x03be: return "pmpaddr14";
     case 0x03bf: return "pmpaddr15";
     case 0x0780: return "mtohost";
     case 0x0781: return "mfromhost";
-- 
2.39.2



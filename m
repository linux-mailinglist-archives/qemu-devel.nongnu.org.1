Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BEE744C3B
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 06:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFory-0007qH-6E; Sun, 02 Jul 2023 00:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qForu-0007pi-Uj; Sun, 02 Jul 2023 00:39:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qFort-0002Tc-7y; Sun, 02 Jul 2023 00:39:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E5A9C10D1B;
 Sun,  2 Jul 2023 07:39:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 365E2110AA;
 Sun,  2 Jul 2023 07:39:08 +0300 (MSK)
Received: (nullmailer pid 2090169 invoked by uid 1000);
 Sun, 02 Jul 2023 04:39:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, sdicaro@DDCI.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 47/49] target/ppc: Fix decrementer time underflow and
 infinite timer loop
Date: Sun,  2 Jul 2023 07:38:47 +0300
Message-Id: <20230702043850.2090131-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230702073703@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230702073703@cover.tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

It is possible to store a very large value to the decrementer that it
does not raise the decrementer exception so the timer is scheduled, but
the next time value wraps and is treated as in the past.

This can occur if (u64)-1 is stored on a zero-triggered exception, or
(u64)-1 is stored twice on an underflow-triggered exception, for
example.

If such a value is set in DECAR, it gets stored to the decrementer by
the timer function, which then immediately causes another timer, which
hangs QEMU.

Clamp the decrementer to the implemented width, and use that as the
value for the timer calculation, effectively preventing this overflow.

Reported-by: sdicaro@DDCI.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230530131214.373524-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 09d2db9f46e38e2da990df8ad914d735d764251a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index dc86c1c7db..fbdc48911e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -806,6 +806,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     int64_t signed_decr;
 
     /* Truncate value to decr_width and sign extend for simplicity */
+    value = extract64(value, 0, nr_bits);
+    decr = extract64(decr, 0, nr_bits);
     signed_value = sextract64(value, 0, nr_bits);
     signed_decr = sextract64(decr, 0, nr_bits);
 
-- 
2.39.2



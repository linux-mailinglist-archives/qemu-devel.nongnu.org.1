Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D7831993
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:53:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRrY-0003m6-0k; Thu, 18 Jan 2024 07:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrS-0003kI-ET; Thu, 18 Jan 2024 07:51:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrP-0000U9-OA; Thu, 18 Jan 2024 07:51:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 34093452C9;
 Thu, 18 Jan 2024 15:51:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EA4CA668BD;
 Thu, 18 Jan 2024 15:50:56 +0300 (MSK)
Received: (nullmailer pid 2502737 invoked by uid 1000);
 Thu, 18 Jan 2024 12:50:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Grant Ramsay <gramsay@enphaseenergy.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 04/11] hw/net/can/sja1000: fix bug for single
 acceptance filter and standard frame
Date: Thu, 18 Jan 2024 15:50:42 +0300
Message-Id: <20240118125056.2502687-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
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

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

A CAN sja1000 standard frame filter mask has been computed and applied
incorrectly for standard frames when single Acceptance Filter Mode
(MOD_AFM = 1) has been selected. The problem has not been found
by Linux kernel testing because it uses dual filter mode (MOD_AFM = 0)
and leaves falters fully open.

The problem has been noticed by Grant Ramsay when testing with Zephyr
RTOS which uses single filter mode.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reported-by: Grant Ramsay <gramsay@enphaseenergy.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2028
Fixes: 733210e754 ("hw/net/can: SJA1000 chip register level emulation")
Message-ID: <20240103231426.5685-1-pisa@fel.cvut.cz>
(cherry picked from commit 25145a7d7735344a469551946fc2a7f19eb4aa3d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 73201f9139..575df7d2f8 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -108,7 +108,7 @@ void can_sja_single_filter(struct qemu_can_filter *filter,
         }
 
         filter->can_mask = (uint32_t)amr[0] << 3;
-        filter->can_mask |= (uint32_t)amr[1] << 5;
+        filter->can_mask |= (uint32_t)amr[1] >> 5;
         filter->can_mask = ~filter->can_mask & QEMU_CAN_SFF_MASK;
         if (!(amr[1] & 0x10)) {
             filter->can_mask |= QEMU_CAN_RTR_FLAG;
-- 
2.39.2



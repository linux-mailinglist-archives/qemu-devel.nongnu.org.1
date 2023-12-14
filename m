Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30484812D4F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 11:48:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDjF3-0001hl-KH; Thu, 14 Dec 2023 05:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1rDjF1-0001hQ-3T; Thu, 14 Dec 2023 05:46:55 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1rDjEz-0005pe-1u; Thu, 14 Dec 2023 05:46:54 -0500
Received: from localhost (styx2022 [192.168.200.17])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 07EDF159C5;
 Thu, 14 Dec 2023 11:46:48 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: styx2022.feld.cvut.cz (amavisd-new);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (styx2022.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
 with ESMTP id oofccjdfPLoY; Thu, 14 Dec 2023 11:46:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1702550806;
 bh=Zb5APN4uqaSzAZKkjptFJnQGnBUdOdxQ+b/ocH9eVmU=;
 h=From:To:Cc:Subject:Date:From;
 b=CfFcBEWgx3jxYdZaYDC/ctx4mZxjYixKSERKV6urScOtLY1rpTa6+3EvGTeJV3s2H
 q9wWTYJZD/AtZQaULbxxznofV9dUaKvLfiDCCdetVfMLOLZhK8mRxSkFicee2nSTwB
 MWjN9IKz0iyql3lkP8D8VQxYj9aMIruvy4NGVE+TzGGUzVkXS/okDVVdmf6s9HrPky
 9aoE2QeRA09PryR0de4kqJY0MTq3TbIcnhRORVHOjmNRNoXTcrhUFGnHXIwBr9avvN
 TknFnPOBuqZeBW1d7r4ZVM9FrK5e3eNamdHaDcIMEpGAV8fPzGCLWpr4RDePqDRsBk
 pKW/WDXpvnP7A==
Received: from fel.cvut.cz (ip-78-102-109-231.bb.vodafone.cz [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 001DA157E1;
 Thu, 14 Dec 2023 11:46:44 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@redhat.com>,
 Grant Ramsay <gramsay@enphaseenergy.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jin-Yang <jinyang.sia@gmail.com>,
 qemu-stable@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH] hw/net/can/sja1000: fix bug for single acceptance filer and
 standard frame
Date: Thu, 14 Dec 2023 11:46:23 +0100
Message-Id: <20231214104623.31147-1-pisa@fel.cvut.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 hw/net/can/can_sja1000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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



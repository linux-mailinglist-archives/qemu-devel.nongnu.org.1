Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D63957224A2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:33:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68Sb-0004Tu-F2; Mon, 05 Jun 2023 07:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SV-0004Mn-V1
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SU-0008OY-56
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAcSpmjwvpkF2flzrSx5p4R/sOCKrgCPpszY3QtnuMM=; b=rPmZhCOHPKvBT5pLXgH7u55lrg
 AFO8ZVRAPDoE3Wk11GNXKxl+M45ruUPFfS7EgIjnHLnUPl2W50+erwnj47G/9q/zEIwcZzF7SV59B
 Fl5R8Wwg3yw/xJQVEUQinFqIHpliGTfFq9ipmvNpAJdzvQ1z6EsUfnawFMwXnIHCHzl5aY+ryeK80
 2ZbKLD41KTeGRj+tLW/USxEJRRvyyMA/0hKIRfQMYOnABh5Crgb+gaY8K478LrlsJm2WrjFTaB5wt
 y75zDenZ6d8D4DzdbxIiJUwRHtkTcfYBaQOV9ouzRgtDZlG+nhu+zNXqUUXEOBZNkTw6LinvlAqZa
 nrqKiW25x3ST9QWUaTYClR+YPR19qyUJ6iHshQHNtpwOpl89NCNoznwZYdrkySrr/t3paQ5suN/SE
 k00NnqINjxeceogJT6pfpn3Ps+4CmYgOj7BnOccNBKDkmK3eDSVp8VxW+6WP7Go1S2hAbiulzARk7
 e+DZi+js6+HOhV9FIN6u6jnJhi//HwpSpMroSf9LZTCuGCtjqAC0VvwofZ49hZIL0ahdizy2KbYpp
 +O+pkoITcMBzh7jEE9+lLTuAOAB+svHwA+2Fx+wHOcp6AVPf64qn0MRvuMCOpWtAeSme8ykRXXC1Q
 zKK9y2ry+f/zFbi1Ss/tf96xZg/PqpTZRNkisYpt8=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SR-0005fJ-M6; Mon, 05 Jun 2023 12:33:07 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Mon,  5 Jun 2023 12:32:53 +0100
Message-Id: <20230605113253.455937-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
References: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 3/3] hw/isa/i82378: Remove unused "io" attribute
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

From: Bernhard Beschow <shentey@gmail.com>

The attribute isn't used since commit 5c9736789b79ea49cd236ac326f0a414f63b1015
"i82378: Cleanup implementation".

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230523195608.125820-4-shentey@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/isa/i82378.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 5432ab5065..63e0857208 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -34,7 +34,6 @@ struct I82378State {
 
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
-    MemoryRegion io;
 };
 
 static const VMStateDescription vmstate_i82378 = {
-- 
2.30.2



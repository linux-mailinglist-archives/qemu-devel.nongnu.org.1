Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC17B2EAB
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DR-0004zt-Hr; Fri, 29 Sep 2023 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DH-0004wc-Qk
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9D9-0005bP-Vz
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfRZm1Tr+msFGXcXQgGvHu4UGdfHaMt0ZevvgeflFQQ=;
 b=Ajny/UbTfumUbizb8Qd1l3ALuYaNhKRY/L2ZZIgIbBt1tjpkPU7LFLJE2T7OrVNnAnw9gP
 Qq8mwlaIW3yx8BRTfHjdChAGEX90eXpk0DldeyOiL1FVvg4JY7ueQLn/Lnki1p44Kl7gwl
 Mc/Cpk46H6cA+MGFdGf7RdG+bdBWq6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-RMuwZ1bQPsqn7-JME4WGhA-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: RMuwZ1bQPsqn7-JME4WGhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3673802D35;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B155C14171CB;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FE7521E6890; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/56] hw/intc/openpic: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:25 +0200
Message-ID: <20230929085053.2789105-29-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  hw/intc/openpic.c: In function ‘openpic_gbl_write’:
  hw/intc/openpic.c:614:17: warning: declaration of ‘idx’ shadows a previous local [-Wshadow=compatible-local]
    614 |             int idx;
        |                 ^~~
  hw/intc/openpic.c:568:9: note: shadowed declaration is here
    568 |     int idx;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904162824.85385-3-philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/intc/openpic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index c757adbe53..a6f91d4bcd 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -610,11 +610,8 @@ static void openpic_gbl_write(void *opaque, hwaddr addr, uint64_t val,
     case 0x10B0:
     case 0x10C0:
     case 0x10D0:
-        {
-            int idx;
-            idx = (addr - 0x10A0) >> 4;
-            write_IRQreg_ivpr(opp, opp->irq_ipi0 + idx, val);
-        }
+        idx = (addr - 0x10A0) >> 4;
+        write_IRQreg_ivpr(opp, opp->irq_ipi0 + idx, val);
         break;
     case 0x10E0: /* SPVE */
         opp->spve = val & opp->vector_mask;
-- 
2.41.0



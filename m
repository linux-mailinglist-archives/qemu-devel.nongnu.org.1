Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08F713ABE
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Jaf-0000Z3-Cj; Sun, 28 May 2023 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jad-0000Yc-BE; Sun, 28 May 2023 12:49:55 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jab-0003cX-Td; Sun, 28 May 2023 12:49:55 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-38ea3f8e413so1436133b6e.2; 
 Sun, 28 May 2023 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292592; x=1687884592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl6x8lKukdyzopG2akGEIx/P7NrVHI+Tu1U5FAgEB2c=;
 b=sxyxHU3VyR0GUqcXzqKp4wrTb9Wp7X4otJ0nYTKAsZ2evHtjgOYffdNHcDfYmIKMzc
 qvUma1ORSFG2ME+kunWq21tnUic1n/tbVNyk4dI/IW1foMubhDHivS6HpqZOHtgra8bq
 UJnAGakbIBN36g4Dtc9AQ/TAlH3SyQ+ucxkvBYYLUmazQ4DS0w7q722Xrirw1zTVwT06
 xPnjrdIk3MKZ8mU0Mx6T4kFT13qOFTC8zK2/voyBuJbm40qqIpZH99A5aZ/pNBTAsVDu
 0c+uwrLTgin24hWJBT0T1ixEyCFnq438Vqo5RXUlrOkGR9frAc/962LjVEn2s6uMs2e9
 x93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292592; x=1687884592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yl6x8lKukdyzopG2akGEIx/P7NrVHI+Tu1U5FAgEB2c=;
 b=Xe3AREOWS4owcY/t0YilxmRi0vdz9NwA8B3Kga4j9S3vnHNi3mj7sBQnvrklK8lqFB
 TJmgKGdAKWe+RsjwIT8Gyd9G0LlO+wXUvu4AS40GyWWTzOmRUDx2NWGrPah5QUaKfOE1
 02ZlkMwFZYLzsGxjAb/HQrYRuNx3B9reg2086Yn9wI39bodSbctrNFiQa03zAGwObMl0
 leIm/VuRKNE6/W5otyD9IRsuDq3wKgwt1ydejr1FtcHs8BY02cvhzWIZUmAGEP3iXJhN
 DXN4ybAxvzsq240UhlbN8GmTaOVvFijCdtSNa2dYoTdrsG2MNY//GkJAbmeMYxCm+r/J
 3BrQ==
X-Gm-Message-State: AC+VfDxM15eyeO4ZupTjNgp/aYjFL0AmKCJeqGHB28KASuXJWhrxzTcr
 pPrKhTaCbUunL/X7neVagoIkkxo0mzE=
X-Google-Smtp-Source: ACHHUZ59RxgQ4PgL4GuQwCZNAIFtj1nlVKqjvk9iT6uvKmAipEeY4cGNsGLNDuoAgR5nZJlMsCExHA==
X-Received: by 2002:a05:6808:287:b0:398:9ee4:1dac with SMTP id
 z7-20020a056808028700b003989ee41dacmr4151425oic.32.1685292592385; 
 Sun, 28 May 2023 09:49:52 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:52 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 07/10] pnv_lpc: disable reentrancy detection for lpc-hc
Date: Sun, 28 May 2023 13:49:19 -0300
Message-Id: <20230528164922.20364-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Alexander Bulekov <alxndr@bu.edu>

As lpc-hc is designed for re-entrant calls from xscom, mark it
re-entrancy safe.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
[clg: mark opb_master_regs as re-entrancy safe also ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230526073850.2772197-1-clg@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_lpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 01f44c19eb..605d390861 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -734,10 +734,13 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
     /* Create MMIO regions for LPC HC and OPB registers */
     memory_region_init_io(&lpc->opb_master_regs, OBJECT(dev), &opb_master_ops,
                           lpc, "lpc-opb-master", LPC_OPB_REGS_OPB_SIZE);
+    lpc->opb_master_regs.disable_reentrancy_guard = true;
     memory_region_add_subregion(&lpc->opb_mr, LPC_OPB_REGS_OPB_ADDR,
                                 &lpc->opb_master_regs);
     memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), &lpc_hc_ops, lpc,
                           "lpc-hc", LPC_HC_REGS_OPB_SIZE);
+    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
+    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
     memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
                                 &lpc->lpc_hc_regs);
 
-- 
2.40.1



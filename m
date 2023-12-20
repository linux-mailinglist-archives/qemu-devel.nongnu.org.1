Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6D819FB2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:19:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwRl-0007oF-1K; Wed, 20 Dec 2023 08:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rFwRa-0007nH-DB
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rFwRW-0002Hb-59
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:01 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so440903f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703078207; x=1703683007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWsmIw6iLJhdrMIwV2iaM9JN1V7QNwi3prAKw6KRwIw=;
 b=ktNtpZhXcGu+1kqQKQuUr0jENUig+uDVEr4Lhk4ZObfTRwl4t66rJ/QNzsmc0AznVw
 OZxXPlyqBuXcT+DTkh4ucAOSH7+L/GG529l2IkPlieOgeR2rDutYz3NN3a/dXDKjZk5F
 5oFhM410zMIPtxr8at6vzurk63+kab7frF2PnPVdr8dE4ZvF2QUOFjL22GdvFfZHRb17
 8NaDDmGkGVV4+NoD/sR9XyhE+aZkisH5s/FxSXVFqas2kb1VxNpezRygMibjXl2fW+VE
 1KEq/oZduf6nXGmm4wmyOiB13dE3Q43txWYfjYio0gjIrOB1dEnAbKHCdqWXh6jgr2Df
 BagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703078207; x=1703683007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gWsmIw6iLJhdrMIwV2iaM9JN1V7QNwi3prAKw6KRwIw=;
 b=IrHQElG86KUFLX+F8YPyBEFzuuGpy9d3R8sSmRnMCmmsEBHJn2wtwuHQ2tKjkEh5YW
 9IJcfkup3zXrbQbYJeUBt4ZEDUdY0imuK0NEHcEjj2ESgDPhsLBs6t0QGROiUHJS8BZA
 CG1Ff79Vp2gpSB4Wruk48av69qpq/CWuWnZWq5sqH87pmF7JjaT2Kxr7TAXY6tQS1eaP
 q7BuRqf1tPwOr+2Sx6gwxHtyinPFLNb4WroOiswuTnDC8AE/WhIn6Xxz88SoDXzhfh/D
 nFIdiwbh/mcOLt7eDEXnrsiM9W9cygqODabFOH+J0LXcNHuk6qPwr6hvTtRcg/K+qR6J
 1v0w==
X-Gm-Message-State: AOJu0YwKMJeTWGHe4m2VshMLrLw9zk12/EHl5iHEKjKt/oI0DufrRw5+
 W5EzJCfm+OlX3JuGqlt14Wz/bcMG73oyuw==
X-Google-Smtp-Source: AGHT+IFEVHwBM7KyAbzJ0lYwgUYCw3DsryAuebbWxf6i8744VSVIDJR8wXsH5Ah289kQH0agRUfwfQ==
X-Received: by 2002:a05:600c:474c:b0:40c:451b:45de with SMTP id
 w12-20020a05600c474c00b0040c451b45demr1683696wmo.121.1703078206571; 
 Wed, 20 Dec 2023 05:16:46 -0800 (PST)
Received: from Dev-shlomop.pliops.ent ([213.8.195.28])
 by smtp.googlemail.com with ESMTPSA id
 j7-20020a05600c190700b0040c31bb66dcsm7266972wmq.20.2023.12.20.05.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 05:16:45 -0800 (PST)
From: Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, shlomop@pliops.com,
 shlomopongratz@gmail.com
Subject: [PATCH] Fix iATU num viewports manipulation
Date: Wed, 20 Dec 2023 15:16:38 +0200
Message-Id: <20231220131638.103357-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The number of iATU ports in the RP emulation is 4.
This value is exported via register at address 0x900
The specification states that the value in the resisetr
is 1 less then the actual number.
the Linux kernel routine dw_pcie_iatu_detect in
drivers/pci/controller/dwc/pcie-designware.c follows the
following protocol, fisrt it reads this register,
and if this value is not 0xFFFFFFFF it write 0xFF
to this registers and reads it back, then it set the number
of region to be 1 the number read plus 1.
Then the kernel code tries to initialize this number of inbound
and outbound entries.
The current code in QEMU just accepts the number given by the kernel
and returns it back without considering the implementation limit (4).
As a result, with the current code the kernel tries to initalizes
256 enties. This patch limits the number the kernel can set to
the value imposed by the implementation.

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
---
 hw/pci-host/designware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f477f97847..4558d552ab 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -340,7 +340,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_VIEWPORT:
-        root->atu_viewport = val;
+        root->atu_viewport = val < DESIGNWARE_PCIE_NUM_VIEWPORTS ?
+                             val : (DESIGNWARE_PCIE_NUM_VIEWPORTS - 1);
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
-- 
2.25.1



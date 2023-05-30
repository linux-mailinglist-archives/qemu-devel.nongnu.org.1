Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9921171619A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zIM-00069d-6b; Tue, 30 May 2023 09:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zIC-0005oX-SH; Tue, 30 May 2023 09:21:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zI9-00081t-Ey; Tue, 30 May 2023 09:21:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b02fcde49aso17837595ad.0; 
 Tue, 30 May 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685452895; x=1688044895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7qF842y09Fzet4ZX9MB88Ilyd7JJ5xGKQbvtsPuslkI=;
 b=mgFP31fDMhrVxAqnzU242RyEWjWvMFdQeDppz8MutUQRgdhY+H+Nu74u+D2hGNPZ3U
 a3pgW+ZC7vW54clkaO9lBo94lXl1aJcr1JfDf9I7ISqTc99F/CZBLJP5YBP4GALLHAcB
 MfP38eMzQ/HIIOw7ae2uBrmt8DeW0E57gH9n0D3N0XGRBWA2Qbqo9qBsi8Ceam8a1rrG
 F1C7PnNWJAebUK4OF4AMEayxintRjGqoBd+gD5ZX4pTwZLljdNHdxLKrvrPm/01t7Xod
 FJSj5ezcYWkZIoiRDZz4iGC6PmmHKIXFGDbuEjE83QL80rJnbYXfzcGKUBOafJbCwZxZ
 JW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452895; x=1688044895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7qF842y09Fzet4ZX9MB88Ilyd7JJ5xGKQbvtsPuslkI=;
 b=C/NDCCwGaaKqH3JFMfspYkrRt6te2JaEMiWN/YUcYxbF9BfGuJrwyuyt8SOOVnzA2p
 GwZ0XT/JijrQyZh5P1yZV4bTDU5brlJDHqlAsD+c+xl9d6WC8Zqndi2sB7FuAHTcVPE3
 +VJvn0XT7speJXcES39XHvVQiOnmWSs6p4DZbcR+nHGZurMGVSCKpiXnAeBmYdSuPRbn
 NhsQl0wxXcZq4wpj08n1Tu8QO/UFhlsqjfr+zXZh22ez3uJG2pDPCQcbI8Lkh6p+rcLo
 8hWBOWvTyVkrtI2XkIOENr5OV1rnuqf2U3fFkR8nb5t4ihUi7UiKUw8t8jG7SVWjDfYs
 ohUg==
X-Gm-Message-State: AC+VfDwc9JqhAjlcnf5eYyIlztYMqsiuOybuqiuN62yVibn1cGxK8Wgd
 7/yH5vnHR96cxxEgt+zhf9T/g2W6O9Y=
X-Google-Smtp-Source: ACHHUZ59FpBDqgxM5OsPMDWCC8MOfnLu80hY7C9ZwfMAbnBhsH79H/F2UB1LijoUIMCLsH3PPMqnFQ==
X-Received: by 2002:a17:902:d482:b0:1ac:8cd4:a82d with SMTP id
 c2-20020a170902d48200b001ac8cd4a82dmr2634746plg.27.1685452894933; 
 Tue, 30 May 2023 06:21:34 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 jb18-20020a170903259200b001ac2c3e54adsm2978124plb.118.2023.05.30.06.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:21:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, balaton@eik.bme.hu,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2] target/ppc: Fix nested-hv HEAI delivery
Date: Tue, 30 May 2023 23:21:27 +1000
Message-Id: <20230530132127.385001-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

ppc hypervisors turn HEAI interrupts into program interrupts injected
into the guest that executed the illegal instruction, if the hypervisor
doesn't handle it some other way.

The nested-hv implementation failed to account for this HEAI->program
conversion. The virtual hypervisor wants to see the HEAI when running
a nested guest, so that interrupt type can be returned to its KVM
caller.

Fixes: 7cebc5db2eba6 ("target/ppc: Introduce a vhyp framework for nested HV support")
Cc: balaton@eik.bme.hu
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Address review comments style and typo fixes

 target/ppc/excp_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d69bd0033a..0f7ed58673 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1387,9 +1387,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     /*
      * We don't want to generate a Hypervisor Emulation Assistance
-     * Interrupt if we don't have HVB in msr_mask (PAPR mode).
+     * Interrupt if we don't have HVB in msr_mask (PAPR mode),
+     * unless running a nested-hv guest, in which case the L1
+     * kernel wants the interrupt.
      */
-    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB)) {
+    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB) &&
+            !books_vhyp_handles_hv_excp(cpu)) {
         excp = POWERPC_EXCP_PROGRAM;
     }
 
-- 
2.40.1



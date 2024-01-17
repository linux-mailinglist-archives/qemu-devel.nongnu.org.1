Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AF5830956
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:13:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7bG-00056n-Lt; Wed, 17 Jan 2024 10:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7bD-00054y-De; Wed, 17 Jan 2024 10:13:03 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7bB-0005bf-71; Wed, 17 Jan 2024 10:13:02 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so9510836b3a.1; 
 Wed, 17 Jan 2024 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504379; x=1706109179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOpxPL7UfJ3J3NSWgF0N5OGvfpZmCNYUT7hRbE9IT6s=;
 b=K3bjS5JLbKlHskeKy8XL5R8l7umf4Qh962Y/1icsKk7vYCzdMDsjfIJ0XKZFVbe1m2
 V92jLDy/xjhAZI3yZALiLE6CdsABlY/ekf5zM6YgHjaXIoajfr03tMBeVpNyoMtz+GqN
 LiGv+MdVUsfL7vVqAgU999yRIdn1NCntqtTU3FDq0qHAnWE7B5GtT8lgqmMwWNQXRzcP
 vVe7MNiZ9tf5Dt/f9+rtKWmNCg2rDWXxIMnuuKAuVCce4Hyh9cTw68U8zSox7+MzVJKh
 4dphg/bJ4YEL0YVAC1X1DF9JucpGBZrYKryeTkF4MJFB4VTqQAtRp2wjDM+rP/NwpC5K
 GUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504379; x=1706109179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOpxPL7UfJ3J3NSWgF0N5OGvfpZmCNYUT7hRbE9IT6s=;
 b=FjPfq5JTx3+htswK4sRMdfGmDcGVi7QPZsu1C2QTsZoLkiMpIRSFYLt5wEZSRdKxZX
 oL43gvtO86AqyXrMoVMYdtlsobJKBod22ti0fT43JeoMrOLRxZCXrB36N6f1vWiWVaFi
 /Biwx2nG1HCDzTPO1Gzj8+V05p7H/dBN+oyR+6xPRdmKO4LasT5UK1IC1ZuV+uTR1A3X
 dBaCTEpBjVcjG9gIk1xuAfcmBauWDgXdcbXewVH+O/+dtygj+xTK/XcuJrk+55rTXW/6
 MAdAqNGaDY5o3Wl+bUpkeM+8Pgm6SGVIN4ag0zB4CaxKU7G7UBmTFuwIuc9L5Yn5OQ0u
 nraQ==
X-Gm-Message-State: AOJu0Yz7cwDPWb/RCminFeYNS/XuoGa0xg7oBUJXohj9q5xejsgDi857
 /Za0dWja7iNRG0hMxVGWgSUdlKQDcCU=
X-Google-Smtp-Source: AGHT+IHG9GDmwBmTXaVG8i2Xk0atYuhOKZ0IaXE8AIAjeQkDMWznsLiF6hNFcfNoUqOn/yg0LAOG/g==
X-Received: by 2002:a05:6a20:f392:b0:199:7850:8d24 with SMTP id
 qr18-20020a056a20f39200b0019978508d24mr9018277pzb.124.1705504379087; 
 Wed, 17 Jan 2024 07:12:59 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 fb42-20020a056a002daa00b006d9aa4b65fasm1586976pfb.98.2024.01.17.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:12:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/ppc: 4xx optimise tlbwe_lo TLB flushing
Date: Thu, 18 Jan 2024 01:12:36 +1000
Message-ID: <20240117151238.93323-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
References: <20240117151238.93323-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

Rather than tlbwe_lo always flushing all TCG TLBs, have it flush just
those corresponding to the old software TLB, and only if it was valid.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 68632bf54e..923779d052 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -813,12 +813,20 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
 void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
+    CPUState *cs = env_cpu(env);
     ppcemb_tlb_t *tlb;
 
     qemu_log_mask(CPU_LOG_MMU, "%s entry %i val " TARGET_FMT_lx "\n",
                   __func__, (int)entry, val);
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
+    /* Invalidate previous TLB (if it's valid) */
+    if (tlb->prot & PAGE_VALID) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
+                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
+    }
     tlb->attr = val & PPC4XX_TLBLO_ATTR_MASK;
     tlb->RPN = val & PPC4XX_TLBLO_RPN_MASK;
     tlb->prot = PAGE_READ;
@@ -836,8 +844,6 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_WRITE ? 'w' : '-',
                   tlb->prot & PAGE_EXEC ? 'x' : '-',
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
-
-    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
 }
 
 target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
-- 
2.42.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6E716137
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z9S-0004to-IK; Tue, 30 May 2023 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z9L-0004Rj-9U; Tue, 30 May 2023 09:12:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z9J-0004Qz-Lz; Tue, 30 May 2023 09:12:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d41763796so3237067b3a.2; 
 Tue, 30 May 2023 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685452347; x=1688044347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZk9HFHylUBGQNTOU+ahJjareCkgZMqckVE8wTORKio=;
 b=pP8Y1jF2I762XP70tIquZFBVpgD2laaf3CYALGiDIJtrd2+usoKpAi4x9EZdU+6Ylw
 WvE3VktQ50ZjDT651gn4Ib8EjUooJe+oGu0Pu3TFi4/pMF01zije1SVPQ6e8VjNBNC1l
 JpXVT20fvGPv+n9WifNTa2pKfBFeq9Njn2sFlThlgXL5A1l32QJLmT1X5YqATibbATO8
 BuRAtiM7tHP/rdExfqfjjjzUdGlOWq23Dd7DhnpP+GSQTuYIA1pw1pnFogp/CAG+0Ymi
 2zoEWjhRy8ZUud/MRtutpKX2edQX4wSYjIyamjlLv3PGYQfMnfSQ8uBLk9qlyp55BNgU
 Ve6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452347; x=1688044347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZk9HFHylUBGQNTOU+ahJjareCkgZMqckVE8wTORKio=;
 b=l+VdsaCvposRQ64OxizaGFGMua943Kdb0fFuhGp48HGt6HdD74nAtTTTgoWnlciVOY
 yYI/W6Im3TXiW3vAY9LRsALpWCf2FsYDaA3wSJxl9f2lG2HnARaEyo4gd/GXpow8MOLE
 zX+Nd1KSCU2PyimDOt1oMwOKzl4itRg5SSREqffZaRzkuZYAcVvgb9RPlq8+9sQjMSaB
 zi4hLUFrA5pHgV0q/AgYmafwUwLBhn4K4ZeaWpXe4bwbLwipLGhkFyGDDZYKzxI6SZKW
 VuoOZhAoeCj7mDTbjt8XvI6YOgGlaqGg0+PpOcQpL254BShLglsXPHo9qyXJdXeI51nD
 hlNA==
X-Gm-Message-State: AC+VfDz1THFCLehrzKIPcqAwfzsoZBPbmKqPl+Ev4C0tliF1IqfLxaSO
 Shi70mrmh2UIENSj8wB7sHgVNDtiklI=
X-Google-Smtp-Source: ACHHUZ7KjYHEZVtQkZREa4Kkh2u+MDaO1n3U17FtFUtKfBjfQCZn0orZl0HmEFCv+L26YSYSXnsxLQ==
X-Received: by 2002:a05:6a21:99a7:b0:105:53:998 with SMTP id
 ve39-20020a056a2199a700b0010500530998mr2762904pzb.12.1685452347270; 
 Tue, 30 May 2023 06:12:27 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a6567d7000000b0050a0227a4bcsm7904796pgs.57.2023.05.30.06.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:12:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
Subject: [PATCH v1 2/2] target/ppc: Decrementer fix BookE semantics
Date: Tue, 30 May 2023 23:12:13 +1000
Message-Id: <20230530131214.373524-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530131214.373524-1-npiggin@gmail.com>
References: <20230530131214.373524-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

The decrementer store function has logic that short-cuts the timer if a
very small value is stored (0, 1, or 2) and raises an interrupt
directly. There are two problem with this on BookE.

First is that BookE says a decrementer interrupt should not be raised
on a store of 0, only of a decrement from 1. Second is that raising
the irq directly will bypass the auto-reload logic in the booke decr
timer function, breaking autoreload when 1 or 2 is stored.

Fix this by removing that small-value special case. It makes this
tricky logic even more difficult to reason about, and it hardly matters
for performance.

Cc: sdicaro@DDCI.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
These were some booke decrementer corner case issues I saw, probably
a little less important than the first patch so could go later.

Thanks,
Nick

 hw/ppc/ppc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d80b0adc6c..1b1220c423 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -811,11 +811,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     }
 
     /*
-     * Going from 2 -> 1, 1 -> 0 or 0 -> -1 is the event to generate a DEC
-     * interrupt.
-     *
-     * If we get a really small DEC value, we can assume that by the time we
-     * handled it we should inject an interrupt already.
+     * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
      *
      * On MSB level based DEC implementations the MSB always means the interrupt
      * is pending, so raise it on those.
@@ -823,8 +819,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
      * On MSB edge based DEC implementations the MSB going from 0 -> 1 triggers
      * an edge interrupt, so raise it here too.
      */
-    if ((value < 3) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+    if (((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
         ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
-- 
2.40.1



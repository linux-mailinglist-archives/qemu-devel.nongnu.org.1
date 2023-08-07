Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3328D77275B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT110-000076-IW; Mon, 07 Aug 2023 10:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10y-00005U-6v
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10w-0005RC-Gj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb724cso25946915e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417717; x=1692022517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bd+htH+P/WAjyuut/9qNXD2yHqngSJFvzj95KpMX1XE=;
 b=b9GWWpqXYW/sxNzDU1E9+PZeNZADDu5zouObLzVPCQcoP4Q0517U1RCjfzutnvs5qo
 QOILXRh/Df8QxzEgRWrkmlVetzFYs6EFCkAQ+hdWWyQpcf2qNj/zFsjPAdJ1W14ZeSQ6
 sQYhmiemo+8aBhlWD+rAIYKQDGrsqzwUz46f22odvZJaQWMhG+VWDomJsPg+yja7LT0L
 b+DJdEC59q+8Ks5JWNndKupjs3gfKcd3UuvsZQBQ0d4qp1x1vGLJjUcR8brGoLAkwkjB
 0vI+MglgY1QbNuGlWzjqYJbB/diNdsDMNufycfaqt/jfOwOW7nnLmcUCi6DL0PLW3CoJ
 RHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417717; x=1692022517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bd+htH+P/WAjyuut/9qNXD2yHqngSJFvzj95KpMX1XE=;
 b=DMOR69zuhhXf034eKLvmPxkmHwXNyU5If0OT8DQntGvJAOr6gPXj+LEXwzxf//6IO7
 CBr2ylfdAxeIkx4Nqk6funMMJ3EjZSiz3wdHpy1t++faWgpES/FZOq13NcWJfut6IHYf
 WA6QlkxSPE3xpxZ5DWPDwXVdy/mpmcSe4dH+2N8c5igjRlZhdC0c3aISDJ0T02sMRw1Q
 DIGmtIVuo8iOUQan8hNzpkkQaTspIEKXdyRJja5Z+y+0fn9lnBXmGkRnS05zcZEo/aA2
 s2foEwxNJLBAxfzefAGNpdcxywpRzWweCJ9D99hpOpPO9Ag+3gcZ2z3beAf2nb9b40E3
 RKDA==
X-Gm-Message-State: AOJu0YwKyycrjdPj3ODuWhKr8ITcAk4//kSdP/UjxD8dbtsuP03XQCcq
 eNtZ9KGLR2k4hvNgdQo923sJphhZytOdif8oYYc=
X-Google-Smtp-Source: AGHT+IHonYggG74sTbz1Se8sctQqU0LTlogRZdxSQx3M99zyTWvdbuoCaH+/eJ6b5hZXQU8wSlmb/g==
X-Received: by 2002:a7b:c846:0:b0:3fe:20ef:1d32 with SMTP id
 c6-20020a7bc846000000b003fe20ef1d32mr7428318wml.10.1691417717000; 
 Mon, 07 Aug 2023 07:15:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/15] target/arm/ptw: Don't set fi->s1ptw for
 UnsuppAtomicUpdate fault
Date: Mon,  7 Aug 2023 15:15:00 +0100
Message-Id: <20230807141514.19075-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For an Unsupported Atomic Update fault where the stage 1 translation
table descriptor update can't be done because it's to an unsupported
memory type, this is a stage 1 abort (per the Arm ARM R_VSXXT).  This
means we should not set fi->s1ptw, because this will cause the code
in the get_phys_addr_lpae() error-exit path to mark it as stage 2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8f94100c61f..bafeb876ad7 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -701,7 +701,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 
     if (unlikely(!host)) {
         fi->type = ARMFault_UnsuppAtomicUpdate;
-        fi->s1ptw = true;
         return 0;
     }
 
-- 
2.34.1



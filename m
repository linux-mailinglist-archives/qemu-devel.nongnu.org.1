Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D697DDBD7
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:15:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aC-0005yb-TA; Wed, 01 Nov 2023 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a6-0005xH-8f
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:50 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a4-0007Zl-Qb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:50 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7b9ff2b6f9bso1967212241.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811907; x=1699416707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7kpY1PECNyEhx9ZhSr9SclPou5q1iimRjB/rHnoAhI=;
 b=J06fwaBC58NO5eKfj9Pb6z7BHvh9Ukib4kEanhno5urXOcmzcxYFUOxiaRZLYOXUkU
 MGMEhVcRsfzx9DLgPUqXTGEMZAcUqkjPwYUsUyv/F4kyxr0cTWCTtpHHNd2/Uh0a0D1N
 ndPaokUoKoB7UtKarLmbx+KQVji2N/2Q3qYdUy0NrEdx53bjxCyc+zZ3y4X8kV5tsNQ0
 PpHOLOIEO8s8+LziDg0MqWmrwRB9JOuwgQKG+zw+ObfrJk61csfJaN17dAmn+rwuorkL
 YrrNBX6CnuJik4NddtFF5lOaHE6aURUhbXmp53IxhWu5/wp4mCssRiKiHV91mk07pKW9
 G0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811907; x=1699416707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7kpY1PECNyEhx9ZhSr9SclPou5q1iimRjB/rHnoAhI=;
 b=mAeu2gKDDIAZT3vMsapBSnwBWrVwkkdI8rDUzzlA0zAkiqElvqAbOG518ITFuYZFCI
 JhRtAB0cDQDGq8nrJJ348pflNXEMKTosSA9Gg2sHXU5yy6covLNNRw7Wd0wVxTsIlY5r
 xAXC3hRt//VO5XNlDO7ZQ8WEahRXkKuXKnv6aV1dJPYtDPHASpUJhmfGzFdUxaMybm+q
 g+vZKg2Yn4jxFChqVb4nBr5Yv6hZOrjZDzWzCso0e47MEq+B48lVa5Kr67Aa3tbESRi5
 4W/qWVg5SljIzgbrlVqIguVrnxPh6C1O3F4K2yJptW5Hf4aIkA0+vGuHiYjZo7dlI3e1
 UtZA==
X-Gm-Message-State: AOJu0YyMLcs/SgS7i2OSWlTFN0H6v1jkQ5UryzeTGbMZAHkxxrCPQbvz
 RF+x8RXWaZTYeRlIMOSYAa/TDto33qMSNJHRvDA=
X-Google-Smtp-Source: AGHT+IG57NkDZL46uMmelr/YYYuSBRy2zVdzVLjOkv7Bht8uLHVqeUPvXbXYUae13mJZK+mJz7J6BA==
X-Received: by 2002:a67:c29c:0:b0:457:fbe2:b8f with SMTP id
 k28-20020a67c29c000000b00457fbe20b8fmr13478681vsj.10.1698811907736; 
 Tue, 31 Oct 2023 21:11:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 16/21] target/sparc: Merge gen_op_next_insn into only caller
Date: Tue, 31 Oct 2023 21:11:27 -0700
Message-Id: <20231101041132.174501-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1233911b69..0bbe4cff3b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1015,12 +1015,6 @@ static void gen_mov_pc_npc(DisasContext *dc)
     }
 }
 
-static void gen_op_next_insn(void)
-{
-    tcg_gen_mov_tl(cpu_pc, cpu_npc);
-    tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
-}
-
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
@@ -2346,7 +2340,8 @@ static bool advance_pc(DisasContext *dc)
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
             dc->pc = dc->npc;
-            gen_op_next_insn();
+            tcg_gen_mov_tl(cpu_pc, cpu_npc);
+            tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
             break;
 
         case JUMP_PC:
-- 
2.34.1



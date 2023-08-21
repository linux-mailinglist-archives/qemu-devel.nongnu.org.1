Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 806667821B7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXv8p-0007o1-Ic; Sun, 20 Aug 2023 22:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXv8n-0007n9-Jm
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 22:59:41 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXv8l-00016r-8t
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 22:59:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso2094375ad.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692586777; x=1693191577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=peYWs1kPHtFQSShaofkQJ//VXB5VvaV3hfjcG2ER1aA=;
 b=gXYtq2qSJrMAbDTSxDU1TELuC1S9XJFx4Z7v77HQoxoZ6VAkTB8R5g6RznDDFWCVV/
 yv21HuVmNVhTSd7t1IxZRwRbP3Yp8Wmc1j2d89ryaIqU6filTzd1BOmzwxn4trmzUfcf
 KYjEB+bWd3wZvYXWi7KirjySOO41XveGgWy2LNnvFyLvw9C/ahQpkqGdD/9ZSufIOWJj
 yBEzxsy8yHC8s/1fI696dMDXmr8wSJHZOc8RcqNSkkUYbxQ3P0vhaLJ4c42JJE5KjaEu
 ahdW8dx/pSYLihP3GMo4klhtWjGbAcTHpx+xwDGVfChU7dgECBRzduyElktF3hFwmDg6
 k/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692586777; x=1693191577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peYWs1kPHtFQSShaofkQJ//VXB5VvaV3hfjcG2ER1aA=;
 b=kXGV0qLqbLaQ98nmS584+/FPeDlsEJI6wVa7/CVmLPbiKlUb43no0vPrAi4mWtvnIR
 VN4Fn6MHIJKDsDkS2HWHEhlh4pCcOsSZVHkyoTEDP2524NCaWwYQQmok1a1RIIVZF0P9
 M3kHd1Z7P1ummm8QhO52/b/zASRkYfssF8uX7QkaAPraDW1OsL04FJQ9ycYRapQCcud5
 wa/G0C5j3fzXi1i4gcGmZFYaI63+2Oz5iR+i0xg0QzomQZ6JC0vDZ01xYaUqafChTXZ8
 /Ues5cjfjB9JsvPUN4DBYClZ8uMhwW0gIgQXXcsYrXtIgpuEzKjcCWm2Myjz0nw/SV+t
 /vmw==
X-Gm-Message-State: AOJu0YxkLCcI7XYOI+iD9NSTSsNjDqtRFs+2XJvJUvpSbAb32a2iO57l
 JyRgfTkvmCvDqf1ciK2OgDHfSGeiTT7Cmlvbyd8=
X-Google-Smtp-Source: AGHT+IFlqPief0tRNVYTD7POGpE3lDRQz1sK1pEEYJGuPpGZD5HLcfbhDqBfjY+URXTt13q9nYozjw==
X-Received: by 2002:a17:902:efd4:b0:1bb:c87d:756d with SMTP id
 ja20-20020a170902efd400b001bbc87d756dmr2994217plb.42.1692586777359; 
 Sun, 20 Aug 2023 19:59:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:7da6:8db:fd7a:4d62])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170902ea0200b001bc9bfaba3esm5769293plg.126.2023.08.20.19.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 19:59:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Subject: [PATCH] target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
Date: Sun, 20 Aug 2023 19:59:35 -0700
Message-Id: <20230821025935.401914-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1779
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 424f2e1741..48257f7225 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -59,6 +59,7 @@ void ppc_store_vscr(CPUPPCState *env, uint32_t vscr)
     env->vscr_sat.u64[0] = vscr & (1u << VSCR_SAT);
     env->vscr_sat.u64[1] = 0;
     set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
+    set_flush_inputs_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
 
 uint32_t ppc_get_vscr(CPUPPCState *env)
-- 
2.34.1



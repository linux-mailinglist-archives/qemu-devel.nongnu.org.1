Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E79817640FB
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 23:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOkt7-00037N-IM; Wed, 26 Jul 2023 16:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOkt5-00036z-O8
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:13:35 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOkt4-00087v-9o
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:13:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bb775625e2so918035ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690402412; x=1691007212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UO4NGNMOmfX4cDWpdhP1KDrgQG8uGQRDWa46RjUxab0=;
 b=gNHfxS7tDwh0K27WQx+5FSXIzqLVvwaxz+zQ9QPqxl7XxoHP1QehtkkWlVGC9nkK32
 znan2SQ296PF5quTa5DuxsvfkAcBvJQSWdP6KSyu/1kk9tuoO8WsEReY4isnQUWM8UGK
 5DfsDy21nLMlfEvpbui9gMh3hYgwItSi/5ydPSblbR51THMEY+7fmgz8sWIXwWt1AATG
 VD/ybjLgT9fu7nvJA//4bQKrKsS23O9NkP4KKVZv5ZlFEFYR6EMMHbkp6K2cTIbpNdBc
 jC/Q1e1VvJpzKM9wKiwOTBnfbkwS035n41GV8vnbmQoHmXkO0RpJayy98ZGXay2xyndm
 qTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690402412; x=1691007212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UO4NGNMOmfX4cDWpdhP1KDrgQG8uGQRDWa46RjUxab0=;
 b=YJtMsSKLmaVPHyAM5iALC7U1pO8GiScHU8MMBQGUsE9dPVm8Xv+2+KV/blrAKrsCrD
 kJKoR5gTijhJyQ5U0+4eP6FR4lpkKa2fcl8wHIEbkwoboKNCFSvV8rklg4yV+l6Dqgq6
 wxp2Qjoe4HVMwwPRjdC6NYPC9wTu1vNZqb4HRBSuLbHM+WFbuw7LkiH1k8kdKzhner1Q
 XLEBtWskH+MOXEWQ0CnZ98Hl2sW2bKw6ZmIzP2AH7ZeEyzRb2KDCQL0QGn6cLuU25bwd
 L9am/tkWR/XBIhcTCqHxExgG+q14MqsIZnKKLViYBTTye2I5GAkBIzdixFL1rdDAtMT1
 +B5w==
X-Gm-Message-State: ABy/qLb3ObWIZY8cBQOLaVrVl3lFKST2+xXpZTNfVSa/WXz9+owMk2ul
 pE0iJZD3H7eXnKIRwcvAqCp/idyaaKkuKSwRL3U=
X-Google-Smtp-Source: APBJJlHZIK+RFL3PFjtiHfdXueuLkU5Fm7Rea6cPiYWg5rJNrQae6z0mi4kQVDf5YOBeabNvvmHZWg==
X-Received: by 2002:a17:903:41c7:b0:1b3:b84b:9008 with SMTP id
 u7-20020a17090341c700b001b3b84b9008mr615229ple.5.1690402412010; 
 Wed, 26 Jul 2023 13:13:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 ji17-20020a170903325100b001b246dcffb7sm13545894plb.300.2023.07.26.13.13.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 13:13:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-8.1] accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow
Date: Wed, 26 Jul 2023 13:13:30 -0700
Message-Id: <20230726201330.357175-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On overflow of code_gen_buffer, we unlock the guest pages we had been
translating, but failed to clear gen_tb.  On restart, if we cannot
allocate a TB, we exit to the main loop to perform the flush of all
TBs as soon as possible.  With garbage in gen_tb, we hit an assert:

../src/accel/tcg/tb-maint.c:348:page_unlock__debug: \
    assertion failed: (page_is_locked(pd))

Fixes: deba78709ae8 ("accel/tcg: Always lock pages before translation")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a1782db5dd..b2d4e22c17 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -374,6 +374,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                           "Restarting code generation for "
                           "code_gen_buffer overflow\n");
             tb_unlock_pages(tb);
+            tcg_ctx->gen_tb = NULL;
             goto buffer_overflow;
 
         case -2:
-- 
2.34.1



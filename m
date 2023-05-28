Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D2713AC0
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3JaU-0000WF-VK; Sun, 28 May 2023 12:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaT-0000W3-L3; Sun, 28 May 2023 12:49:45 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaS-0003aQ-4J; Sun, 28 May 2023 12:49:45 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3980f932206so1605656b6e.1; 
 Sun, 28 May 2023 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292582; x=1687884582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IetsKQMIb1Qgngbwf3+eq9RRIN5h/pB5AKRI4osu4C8=;
 b=Uu3uFxjX7ulOvSgBj0u2/3ZPpBGCSmTQXnXRAMKBx5x/b9sZoAbYrBbgIuN4AOsmcT
 H4t6NLEmeD8LqugJSMMI3xRus142mcTd4jBKh+Nmu34+vCg4MTT+QB+VEVuWjUZBF5Ck
 ETwCEfG7ql1jLTNouOzYp6+N+4cg2mCYijhCNvWX7eHkJiCZQ1EGB40LC2mxCnXLu4gM
 HVCoDIp6Pl4XXdQenE+aQH61e55uY7hI/30vKwF6+4w7WBqtVGDCDmxvmJLNO48VUlP4
 0ZSwaf4GVhMODt9SwzNNxrhM2bgwMbAdyMVqIhlK0R39XupV//7EEmKGjuj1mpS29Mrq
 Adfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292582; x=1687884582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IetsKQMIb1Qgngbwf3+eq9RRIN5h/pB5AKRI4osu4C8=;
 b=FAypQqi3oQ5/8yhZpPh7iw7jt5a+Y86GlafvwJaWjFEcnfp/QEAjaaEWpqW2vLBK+L
 gQOZc1M00P2Y7HnWt5gon6W4PT/Pr19uwarokDuGrMinR+A/kI1w+iT0g+nwwkm6Fxnh
 M3kx2ppkeFMQpMHsUCaLDsLUcjQ5Tm3jSYjNVHkap7oDoeyLN3he8cvWuzQkvlydyHIO
 14zd5jLyZmecEt17QqmJpKPr5sbTFXGguCeZGxTRurEWnWEigA/sIgkyj4A5OB8zYtkA
 Z0TwVs4FBSjAdfl4shJhRHymzgHTnqD/4e8WZhOrQDZTHoNrWm3qrCBAhbIXaQ8+ltpB
 /E2A==
X-Gm-Message-State: AC+VfDxxVH1ft0CFEsUGQSqtIJulqqtcbrRDwPy0WZLtRkNaOqLvrpZh
 CJ/mQtsxg4BgwnlnmCyZsyBo1rZH6nc=
X-Google-Smtp-Source: ACHHUZ78dZ541jeLLJIlii3Ckk93unnwtFeEiOtPm4dypYAK65l9oCG6rIA1zZWOKGnvhl98GHCSxA==
X-Received: by 2002:a54:4890:0:b0:398:77:e2aa with SMTP id
 r16-20020a544890000000b003980077e2aamr4202751oic.30.1685292582409; 
 Sun, 28 May 2023 09:49:42 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:42 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 03/10] target/ppc: Alignment faults do not set DSISR in ISA
 v3.0 onward
Date: Sun, 28 May 2023 13:49:15 -0300
Message-Id: <20230528164922.20364-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x233.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

This optional behavior was removed from the ISA in v3.0, see
Summary of Changes preface:

  Data Storage Interrupt Status Register for Alignment Interrupt:
  Simplifies the Alignment interrupt by remov- ing the Data Storage
  Interrupt Status Register (DSISR) from the set of registers modified
  by the Alignment interrupt.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230515092655.171206-5-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 199328f4b6..fea9221501 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1431,13 +1431,16 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         break;
     }
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
-        /* Get rS/rD and rA from faulting opcode */
-        /*
-         * Note: the opcode fields will not be set properly for a
-         * direct store load/store, but nobody cares as nobody
-         * actually uses direct store segments.
-         */
-        env->spr[SPR_DSISR] |= (env->error_code & 0x03FF0000) >> 16;
+        /* Optional DSISR update was removed from ISA v3.0 */
+        if (!(env->insns_flags2 & PPC2_ISA300)) {
+            /* Get rS/rD and rA from faulting opcode */
+            /*
+             * Note: the opcode fields will not be set properly for a
+             * direct store load/store, but nobody cares as nobody
+             * actually uses direct store segments.
+             */
+            env->spr[SPR_DSISR] |= (env->error_code & 0x03FF0000) >> 16;
+        }
         break;
     case POWERPC_EXCP_PROGRAM:   /* Program exception                        */
         switch (env->error_code & ~0xF) {
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D37D7932
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:18:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2j-00070L-7E; Wed, 25 Oct 2023 20:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2Q-0006wt-7T
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:15:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2M-0004pB-Ag
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:15:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1caa7597af9so2153385ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279345; x=1698884145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJ6RCYZtqS9hM9/RkJUGxHsAy/nMvqiERtpBq5MiRjQ=;
 b=PWvk4i4bdEw3gTHNM5sVe4vj2PzzZiQZLACV0iiAzSLAWZ9/NHzmQ3AgWl6c+Qy8vU
 bZ/jL0a5jKeq/Mslm+Yym3RDpfCzoA35QNItEYSfcyabFewdNX/71SiVXVZdg7UROads
 rA+9tRQpJcHRPUyQSKrNb9vmdTttej+HX95oIQuQ5EHKuQ34h5sqGOjlDVs54pQ6pFx0
 m51wLhHCoG+PwlCgqRPT28T4MWOPlgUgc+lIvZcKeWzj708EDFwcle5irLQLxfdemb2c
 SPd57f75DSgVkYZJyDfjYTP0gVByaRoKnE0ngPz5J8sj3u9OnLCRI1Pf3upT9S8Ed75z
 Bw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279345; x=1698884145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJ6RCYZtqS9hM9/RkJUGxHsAy/nMvqiERtpBq5MiRjQ=;
 b=CczMlr7usE6IA/4KDDnfzuMTJtGuePbzz2sMOzRhLXoZbxXJjYBJzscARIP3wur2cu
 N/nn7mfSPVnG9dj3R9MEZeuE6VDAZOyDJ4JKeVvn+ofDpvrGuyeSudLejlxv+nubOkQV
 Jdw/C8R47Yh4O/G969o7IOOQjgnrMTNAEAkpN6N0RealHAz+JHX0j9Hv1tFdLqWczXXN
 XE0phicZoId7469QXf8MeI/Kp6IoZ/V/5N8O+EftFEez2oQqchxuRmITyi9IYbfbTyD/
 uN6rLBMXewmZbKYNhHzixB3QmpCmbypihK+jXwVVZLCOI2C4FYkHKLGu9Op9iQw/76kr
 cdJA==
X-Gm-Message-State: AOJu0YybhAqaffHrtEN5AE00Gpi9EW42ox7wukZXikBMe9EPx77WtxJ9
 ugtnE5hNqDp2rT0jjFhO4517zBVY5vkuHOstNig=
X-Google-Smtp-Source: AGHT+IFs7Gz9HpSNg5U5PHN0/mW+UI2BYTkCqvvwNzqAgC8efbqk/7hV+qzPc2iol62LERnIc8MvAw==
X-Received: by 2002:a17:902:f904:b0:1ca:1c89:9adb with SMTP id
 kw4-20020a170902f90400b001ca1c899adbmr12484141plb.51.1698279344769; 
 Wed, 25 Oct 2023 17:15:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 01/94] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
Date: Wed, 25 Oct 2023 17:13:40 -0700
Message-Id: <20231026001542.1141412-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

With pairs of jmp+rett, pc == DYNAMIC_PC_LOOKUP and
npc == DYNAMIC_PC.  Make sure that we exit for interrupts.

Cc: qemu-stable@nongnu.org
Fixes: 633c42834c7 ("target/sparc: Introduce DYNAMIC_PC_LOOKUP")
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..8fabed28fd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5654,10 +5654,10 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
 
+        may_lookup = true;
         if (dc->pc & 3) {
             switch (dc->pc) {
             case DYNAMIC_PC_LOOKUP:
-                may_lookup = true;
                 break;
             case DYNAMIC_PC:
                 may_lookup = false;
@@ -5667,10 +5667,24 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             }
         } else {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-            may_lookup = true;
         }
 
-        save_npc(dc);
+        if (dc->npc & 3) {
+            switch (dc->npc) {
+            case JUMP_PC:
+                gen_generic_branch(dc);
+                break;
+            case DYNAMIC_PC:
+                may_lookup = false;
+                break;
+            case DYNAMIC_PC_LOOKUP:
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            tcg_gen_movi_tl(cpu_npc, dc->npc);
+        }
         if (may_lookup) {
             tcg_gen_lookup_and_goto_ptr();
         } else {
-- 
2.34.1



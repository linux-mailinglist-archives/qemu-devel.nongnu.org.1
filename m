Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B967E164A
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUA-0003PR-Do; Sun, 05 Nov 2023 15:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU7-0003O4-DI
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:39 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU5-0002AC-RL
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:39 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b2b1af964dso2546617b6e.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215156; x=1699819956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFSCl5lnV2U9VXq8eQaIzYhW+oJcX4r3EEzkiMuRW8Q=;
 b=YnQx0Y1Kk+MI3wAaE1eCCUCQ/hzSeW6nEHpveCX994v7Tns4JBGCr9fDZ32iaWORpk
 EGDKIt1tPoi98AUR0+VmJeWz/rpkD8O5V77WuqLHn7CLeC+lHOwPXW/WVrDRNbu2MRJZ
 4ZQXT+SkEoxDbZ30yd93SNGhTmitbDZUlz+mvfVDiN7L1uLcFvBcWxYnIftkQIlbWUvh
 ZqVJE1Gq9Y+nCE307kAfcnfGGe0rvsGUAr1JbwY8Mitq6ylO/mLXu41CxTmeOqkwgZbX
 IgsNex4MPojngJCCz7/2iDQfNcpm+WPU97CmJyehinhWyKyrwNtCIwMwgLOTWHGEP0HO
 x7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215156; x=1699819956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFSCl5lnV2U9VXq8eQaIzYhW+oJcX4r3EEzkiMuRW8Q=;
 b=AcbtiILXQHqbWKInmadQtBup2AO5DKWIjK9Hov3+Dv2RVl+mZ7y2gm5M91Ua6dVTx7
 /hj9yptARzzF7JF22KzQxIfyQJvlWiwg5eTHPSEyw99K3EJZNzqzVxK85TGHZdA+i/pi
 W06lP2TVWU/Pk0CXfleq5CCu2a16FLLRkiB6WzR+ASNIN9UljSuU2kkdbQ4AiKYl2784
 I4ekuvv3y73FsDdRg8zRizVr1NKZomevLHYqkeHJ/hawyVZmvLrPuGaIxi2ko4MPDJRk
 QVnMBjZWCLESi9vp3ui8OJLasqfUlNL039bWLofRWKI8bDiD4URYGODnL4FNFthOTupl
 n3gQ==
X-Gm-Message-State: AOJu0Yzvu6ebpnZwhTrWGToq7dx0TuDTFdDnVrC8TXBWWBC1eX8r/5hn
 PhDzeP64k27npnCFUCPO1gq86slD8lU+vMW3bhI=
X-Google-Smtp-Source: AGHT+IFbaauyyYaT+U6dKKoOXXlznGjFB066RdK2LeWrGIbHqO3w4qPQiD2l/He3ykVIbzpVjkDBDw==
X-Received: by 2002:a05:6808:189c:b0:3b5:9541:cb43 with SMTP id
 bi28-20020a056808189c00b003b59541cb43mr9291154oib.14.1699215155774; 
 Sun, 05 Nov 2023 12:12:35 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 14/21] target/sparc: Merge advance_jump_uncond_{never,
 always} into advance_jump_cond
Date: Sun,  5 Nov 2023 12:12:15 -0800
Message-Id: <20231105201222.202395-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Handle these via TCG_COND_{ALWAYS,NEVER}.
Allow dc->npc to be variable, using gen_mov_pc_npc.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 74 ++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e134ba8821..cbee5435a3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2378,37 +2378,37 @@ static bool advance_pc(DisasContext *dc)
  * Major opcodes 00 and 01 -- branches, call, and sethi
  */
 
-static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
-{
-    if (annul) {
-        dc->pc = dc->npc + 4;
-        dc->npc = dc->pc + 4;
-    } else {
-        dc->pc = dc->npc;
-        dc->npc = dc->pc + 4;
-    }
-    return true;
-}
-
-static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
-                                       target_ulong dest)
-{
-    if (annul) {
-        dc->pc = dest;
-        dc->npc = dest + 4;
-    } else {
-        dc->pc = dc->npc;
-        dc->npc = dest;
-        tcg_gen_mov_tl(cpu_pc, cpu_npc);
-    }
-    return true;
-}
-
 static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
                               bool annul, target_ulong dest)
 {
     target_ulong npc;
 
+    if (cmp->cond == TCG_COND_ALWAYS) {
+        if (annul) {
+            dc->pc = dest;
+            dc->npc = dest + 4;
+        } else {
+            gen_mov_pc_npc(dc);
+            dc->npc = dest;
+        }
+        return true;
+    }
+
+    if (cmp->cond == TCG_COND_NEVER) {
+        npc = dc->npc;
+        if (npc & 3) {
+            gen_mov_pc_npc(dc);
+            if (annul) {
+                tcg_gen_addi_tl(cpu_pc, cpu_pc, 4);
+            }
+            tcg_gen_addi_tl(cpu_npc, cpu_pc, 4);
+        } else {
+            dc->pc = npc + (annul ? 4 : 0);
+            dc->npc = dc->pc + 4;
+        }
+        return true;
+    }
+
     flush_cond(dc);
     npc = dc->npc;
 
@@ -2478,15 +2478,8 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
     DisasCompare cmp;
 
-    switch (a->cond) {
-    case 0x0:
-        return advance_jump_uncond_never(dc, a->a);
-    case 0x8:
-        return advance_jump_uncond_always(dc, a->a, target);
-    default:
-        gen_compare(&cmp, a->cc, a->cond, dc);
-        return advance_jump_cond(dc, &cmp, a->a, target);
-    }
+    gen_compare(&cmp, a->cc, a->cond, dc);
+    return advance_jump_cond(dc, &cmp, a->a, target);
 }
 
 TRANS(Bicc, ALL, do_bpcc, a)
@@ -2500,15 +2493,8 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    switch (a->cond) {
-    case 0x0:
-        return advance_jump_uncond_never(dc, a->a);
-    case 0x8:
-        return advance_jump_uncond_always(dc, a->a, target);
-    default:
-        gen_fcompare(&cmp, a->cc, a->cond);
-        return advance_jump_cond(dc, &cmp, a->a, target);
-    }
+    gen_fcompare(&cmp, a->cc, a->cond);
+    return advance_jump_cond(dc, &cmp, a->a, target);
 }
 
 TRANS(FBPfcc,  64, do_fbpfcc, a)
-- 
2.34.1



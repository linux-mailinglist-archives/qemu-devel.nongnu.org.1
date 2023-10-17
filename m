Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E597CBB87
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmY-0000BQ-BL; Tue, 17 Oct 2023 02:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdld-0007tP-8L
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdla-0001sH-J1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:24 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso1409427b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524881; x=1698129681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kewAVssE39LvjouWsvZcTjjrjFgZixtCBX1Kb1O7gh4=;
 b=I3F0LaIGNg+z6xftua3Y7m977hvo+a5xhYLn1i5bX3eHNykkkomFUiu5FVWlnKoELl
 46nu3M5uCYeXegdKHlBFZ2yXThZ/r9JHm2MB4UWtOo3eTK5hXh1tOXavFbZu7Iu7mQDr
 7ftJZZ8ooeElwO0kVKTHuKXc1OnJC+TYme7cN8s7mbih0Zu5Hg8bjqNtcckuDebJPQYO
 ON5tn5XI5LEPqrF18smIivOUsAJUTm7gAdLmF/yUc61l3nPME442u6vyolWAh5ncnwcq
 kKkRhfJOYXOeAGQ+Tf7cEWFKoE4ZUFhhDCwEAq7Y6XYFw7q4+Gcc8kXdlNVhgMW2e0z4
 IHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524881; x=1698129681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kewAVssE39LvjouWsvZcTjjrjFgZixtCBX1Kb1O7gh4=;
 b=Ie/G9cPLyJhMlu4lXVVAkEQ4bMRhLhJ5LG55AoWV7xiE++mhTLB1ZkVRwL4fkx4oeY
 nBGnsjx+izlf9KVjfRcyyp3HCev1NdEyIpXXKuWC/30rZp9c7+IOYq7kHXGx5DW6LBLc
 bHBGJI3dgUbYl9msQZWiwds+a/5rzmyBj1t8NPnJq23SUfwD2M/+Y8rdB8Z4fzrj4g9s
 SMa4FhQ5dAKhDF8R929BoxYS9iG901VDOL28fHReUX8IgSF9QHOkngcLAbpUrp8BLjRx
 WWAUNQNapPWBcMe7zJQByWnJuyGgL5i+6DNoN1ewhqqI0DzSEoGysvfHlI0eDY4zHRRU
 n8IA==
X-Gm-Message-State: AOJu0YyabB+jS1Cy+1/bfiy0w9zV+10PVDSOPBZKu5iZZOpeqTSGTv3W
 vBNCDuC3HM8DORtlPNRghRPWgaOMJMKZn2S77Hs=
X-Google-Smtp-Source: AGHT+IFwOs4+OplD/GxItK1BhDsMWErRE22ejNZZiZrIL48Yv4Q/kYZACVOXfQ8i4UQKIi7zTJV0Yw==
X-Received: by 2002:a05:6a20:8f28:b0:16b:f3b1:c040 with SMTP id
 b40-20020a056a208f2800b0016bf3b1c040mr1398398pzk.38.1697524881283; 
 Mon, 16 Oct 2023 23:41:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 14/20] target/sparc: Merge advance_jump_uncond_{never,
 always} into advance_jump_cond
Date: Mon, 16 Oct 2023 23:41:03 -0700
Message-Id: <20231017064109.681935-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Handle these via TCG_COND_{ALWAYS,NEVER}.
Allow dc->npc to be variable, using gen_mov_pc_npc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 73 ++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4c52425702..53a755874e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2286,37 +2286,36 @@ static bool advance_pc(DisasContext *dc)
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
     target_ulong npc = dc->npc;
 
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
 
     if (annul) {
@@ -2388,15 +2387,8 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
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
 
 TRANS(BPcc,  64, do_bpcc, a)
@@ -2413,15 +2405,8 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
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



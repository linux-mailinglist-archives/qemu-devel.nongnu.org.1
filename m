Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE27D217E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRau-0003vB-PF; Sun, 22 Oct 2023 02:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa4-0000pb-59
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:56 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZw-0002FL-MK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:52 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-581f78a0206so1331186eaf.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954686; x=1698559486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUuu11MzrRlUr2WMpsShk9sCSBE/f2VIDlDq3G60qeg=;
 b=YWSGdgSz60akDEld7GC4le47iU1LXulI9wy9FDGEpOf0OHvU6pO3wuDWYvefRnWx7a
 KI4A4TPzpEPaYlNsY+JGOfeOQaW3D8iYt6JX5LbdZj4WqCy/zgTgyduK7/gwd4V/BENM
 Ilm9ZoiTgBXYp5kt+64cNBkMzIdS4bXwihwezPYNVN3kvzBsx8IbFs2UsDKeXSAtxvED
 C53oqtHVq3V4UptKBKQTvmk9H7ItRKypzbJQc8XyXMLLaTXajrodDqqS/1+jwFWQA07j
 2pVX29t1WoJAf6JuCywBiX6s1cBtobdBPfHTv+Bjo1JDS1uAYOlfyz20oWxOtzQdBjG1
 CdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954686; x=1698559486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUuu11MzrRlUr2WMpsShk9sCSBE/f2VIDlDq3G60qeg=;
 b=JIcmwPf9pTHVmbjv2QsVwI/cSZayhYlPAlH3IB2OxEarE5oPqPe0eyKNPrlk5+7NEH
 vYHnRSUvsvcAZ/KjBbzYWw19P0EQZGPsnsFGzj9hYF5N8g1pHsGIuTicnc+QMstfcOBJ
 LC+hy1xt2VvsJwh1oDlR0FX0V7ULTPnZJUuZhbSdgxHz8xBAjZyloysW/JfSnZRPBj6x
 BjNRUNCVSOrf947QFCXpviUhq1UWIaROgewF3Gbp7eivsKsv7vAWz1/qjH7tpd218cvr
 bIAZhSUtp3nYuJ+LXNK1+W3jauuyB2YCKKz665wKLu5z5QoJmO+TIXb4Z6S++9naq7Cw
 JnQQ==
X-Gm-Message-State: AOJu0YzBfydYoeM7bu+0cZkZnb8uWN+/UMN11JcK46DqThJ6SEaHGoXZ
 6Au8lab2PW8OOEsr8cVBAksnW6Khg/UdmL44Ztk=
X-Google-Smtp-Source: AGHT+IEdsHCyiri4a/rhB5if6Ecx+lrKf8ZQRmmlhMGDD2NloXA74rhTK1cfpR+Sf+nE4C6PRff8zA==
X-Received: by 2002:a05:6358:921c:b0:13a:d269:bd22 with SMTP id
 d28-20020a056358921c00b0013ad269bd22mr7366572rwb.25.1697954686302; 
 Sat, 21 Oct 2023 23:04:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 53/90] target/sparc: Move PREFETCH, PREFETCHA to decodetree
Date: Sat, 21 Oct 2023 22:59:54 -0700
Message-Id: <20231022060031.490251-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  8 ++++++--
 target/sparc/translate.c  | 14 ++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 82c484fbc7..aa452f1d00 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -231,6 +231,9 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+
 ##
 ## Major Opcode 11 -- load and store instructions
 ##
@@ -299,8 +302,9 @@ CASA        11 ..... 111100 ..... . .............          @casa_imm
 CASXA       11 ..... 111110 ..... . .............          @r_r_r_asi
 CASXA       11 ..... 111110 ..... . .............          @casa_imm
 
-NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
-NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+NOP_v9      11 ----- 101101 ----- 0 00000000 -----         # PREFETCH
+NOP_v9      11 ----- 101101 ----- 1 -------------          # PREFETCH
+NOP_v9      11 ----- 111101 ----- - -------------          # PREFETCHA
 
 NCP         11 ----- 110000 ----- --------- -----          # v8 LDC
 NCP         11 ----- 110001 ----- --------- -----          # v8 LDCSR
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c5dd9e6dd6..07bd3c123a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4176,6 +4176,14 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
     return false;
 }
 
+static bool trans_NOP_v9(DisasContext *dc, arg_NOP_v9 *a)
+{
+    if (avail_64(dc)) {
+        return advance_pc(dc);
+    }
+    return false;
+}
+
 static bool do_arith(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
                      void (*func)(TCGv, TCGv, TCGv),
                      void (*funci)(TCGv, TCGv, target_long))
@@ -5609,10 +5617,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x0b:      /* V9 ldx */
                 case 0x18:      /* V9 ldswa */
                 case 0x1b:      /* V9 ldxa */
+                case 0x2d:      /* V9 prefetch */
+                case 0x3d:      /* V9 prefetcha */
                     goto illegal_insn;  /* in decodetree */
 #ifdef TARGET_SPARC64
-                case 0x2d: /* V9 prefetch, no effect */
-                    goto skip_move;
                 case 0x30: /* V9 ldfa */
                     if (gen_trap_ifnofpu(dc)) {
                         goto jmp_insn;
@@ -5627,8 +5635,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_ldf_asi(dc, cpu_addr, insn, 8, DFPREG(rd));
                     gen_update_fprs_dirty(dc, DFPREG(rd));
                     goto skip_move;
-                case 0x3d: /* V9 prefetcha, no effect */
-                    goto skip_move;
                 case 0x32: /* V9 ldqfa */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     if (gen_trap_ifnofpu(dc)) {
-- 
2.34.1



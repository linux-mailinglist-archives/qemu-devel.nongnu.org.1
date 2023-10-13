Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB187C8F28
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPlw-0008Jb-OU; Fri, 13 Oct 2023 17:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlt-000876-7d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlq-0001Mf-7b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:36 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690b7cb71aeso1919552b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232753; x=1697837553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZtAaeyKUrm7/P1h9gCX0cVz3IDBozdAXsKCjCqVfbw=;
 b=iEPRxzE2o1buO2r//5ckMR36A0yoxXF8hqapDd+R1P/sHyR2JrNJYoBdqbYQccS8hB
 z9sK/7K7s/4HGwj1XGGD1j2lPDR0S9tIpd1YpwMtDR2mcOhefR0wTjk3dt9K8wZm8xNT
 wqP9ulDMN1atfynzfgjME3CPOidOoUr3/iHHFFbdYFcr011SVCDi0BCy6WF1uNfgviIw
 0VbDiGJPBfEY7sg/z7rXBpNqelLe1HIWsuv+4c21aSA/ZxfVG5+S02rdvv0hinebfV8e
 DcKUVwcHpCaI2QQjMaBparuYg07PyFmFPyZRzq4xXTQQLkw3jccqwreemv8AjYdfl8Db
 AMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232753; x=1697837553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZtAaeyKUrm7/P1h9gCX0cVz3IDBozdAXsKCjCqVfbw=;
 b=C08+8Kl0sDF04XS1Jb2pw2xaFCSQhU2pAcL2aC6zya2NSrfP3nI0v+x1DzE4eVwBYG
 egywjv9a4r6qLog3WAntsUsrIYbtuKR08/vKwU0O9sfpMLdBVBcx0gCOIF92yAPj2IFO
 Ted7ZxpT1uW4GtpQBrOsrgHZyBbkQe4L+Hy7iTsOl0gAOXp0PHyksIfyIOo74sIJuCrl
 PVjdQE34DhO9GNfNgVcHdz6h/wEacq/pYNZmRP0ZmZJ9PUyX2kaE0KlXz/mgABY2bn+F
 jYYlnekGKnx7Bc0NMH228x6NFY9qnfDIPthhJApjkKOlR9m30GlR3qj+3QG5XNcvQvvS
 hG7w==
X-Gm-Message-State: AOJu0YyQ3lfylnN15xRQaPX9grsADHh1n/ES3HaXA1/2VdbsIpf4E9DT
 aVzQHHzQBb8zcrdRHnUrtn+XpS9pe9lw0oz7MrM=
X-Google-Smtp-Source: AGHT+IEj3ft2HPu/kIzaGWyCiGif8zkBbxZ1giMmrXN6usWZpp9PkTEgpT6A+1xLK4KGDg3qWBd0AA==
X-Received: by 2002:aa7:8888:0:b0:68e:2c2a:5172 with SMTP id
 z8-20020aa78888000000b0068e2c2a5172mr1975624pfe.6.1697232752894; 
 Fri, 13 Oct 2023 14:32:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 48/85] target/sparc: Move PREFETCH, PREFETCHA to decodetree
Date: Fri, 13 Oct 2023 14:28:09 -0700
Message-Id: <20231013212846.165724-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index 1a641248ce..c032b81c16 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -225,6 +225,9 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+
 ##
 ## Major Opcode 11 -- load and store instructions
 ##
@@ -293,8 +296,9 @@ CASA        11 ..... 111100 ..... . .............          @casa_imm
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
index beb42b9fb7..02030bd99b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4055,6 +4055,14 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
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
 static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
                         void (*func)(TCGv, TCGv, TCGv),
                         void (*funci)(TCGv, TCGv, target_long))
@@ -5468,10 +5476,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5486,8 +5494,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0C7D1B10
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:41:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eW-0003AW-Vq; Sat, 21 Oct 2023 01:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eN-0002fP-2t
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:51 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eH-00016x-J4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:50 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-565334377d0so1123588a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866544; x=1698471344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQauA42ukOEfv4/p0Y5GO/oTAcUVJILosfHC4tqX3BU=;
 b=VP4+C3IsR8efYerz5UElu/stmKoLDDBCPZYsgHlW2uNs8H38tNvAEEETZR0MlrgfWz
 8BqO8cJDI88uaPdePpjhiOTQ+yLXipIy3BXJ7fwAYIqQrnkkpNr8sng+DzkPxW9UEMab
 hiF0E5OXGAFwHaWVqLlwhjEXZiJ679dF9Kg57Yz0os7tQvfdvXSZ6Lh7LeYTsvjp/ffq
 QFNTcaalKZ3uN6/GYercXRq5A7O/4yVXNT4JTfR/rKgnZc6e686Hh5MTds0yVRKVExvc
 x1PJBVrGp9XkMS5UJCuE36qU2hEJ1OWu6PbhyEe9zPuLNc/61npJr6Puiv3bHOfxGlPP
 HrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866544; x=1698471344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQauA42ukOEfv4/p0Y5GO/oTAcUVJILosfHC4tqX3BU=;
 b=jqQ69iaF/Pdyzd/ByEAX3zHNCJvDB5OlIR/Y5REEw8kcCNY2yyAzCpUFbOIWxmR679
 HUv7Ltr94K2EGoL7YEkDPoyaYzrb+k3PPefUgUyuoXuRE1ODgf47q21a5iCmsTSaowai
 sUCrhic446CpuZVA9XoB9OfK3TgJB7jG0D2l0ehORphdRnQELQwtD4OXdxkajOEdcDp1
 3sbb92RPV468dQMWFh+G1tOVhLSv7/03gbJHQINPYz6NULVpNvAh9mS9f6E22LkDLFwg
 upR8hS2AuDYG+5P5BNg2qnoXTDTQsoxTF7/9wQEeSZ1nmgOUGRzH1enZwFx2vMZ3dBeG
 pZKg==
X-Gm-Message-State: AOJu0YwpIy3DYRuhZdwWTNpWK7XZvSilqL8GS5h84NREHXsC8KIatG2N
 TzrQU0quEDfg0UwY/7e+OnhXFDt8F+N68bLD2vc=
X-Google-Smtp-Source: AGHT+IH5vDLhCRFESsIYCmDgRK+zpTK1po7QC5bskR2pNTiVgoH1oCALK0nBeU/3gPV8m1LMLEV9xg==
X-Received: by 2002:a05:6a20:6a28:b0:155:2359:2194 with SMTP id
 p40-20020a056a206a2800b0015523592194mr4693521pzk.46.1697866543980; 
 Fri, 20 Oct 2023 22:35:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 53/90] target/sparc: Move PREFETCH, PREFETCHA to decodetree
Date: Fri, 20 Oct 2023 22:31:21 -0700
Message-Id: <20231021053158.278135-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index f4c55db313..96c6e19fc9 100644
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
index e1749ec12c..9053cafd47 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4135,6 +4135,14 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
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
@@ -5568,10 +5576,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5586,8 +5594,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



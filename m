Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF17D7967
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9S-0000kr-Qc; Wed, 25 Oct 2023 20:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9N-0000XK-5Q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:01 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9K-0008BO-8D
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso294149a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279775; x=1698884575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mb776AbN/UqgNrPvlR/H9NLV+RfwQ56KQuO6pLUVjFA=;
 b=OjVTX4+O6doMeodf+ZSca7uoyAUIX3+m6etFm3eGH3/VkxxmZxauh2eYjz1bfwXlrz
 vv3JsGAbWnaRtJ/E6UwqqthO1RS8XzDnUE2CJ6GjAPwYaqTf91obbCwTjt0B/YHmKTrs
 cOGf4VNkTc4/BE4EHlczR9o9ex7rbm1SYq9yGrf/VZaITMDxvfdV1UBNw2uTJ9hOveDn
 5RP89M2NHblcvl9Pebmix0MYKy2gYjDVSQstnfzdiq65w1FzJ3W6G4YEAzNywWhYqyrP
 vKlApIfkrU8Y/On20Zthrl9VNvIaeKFBPgu2oUIDJizqA7guCMJGeFbNvG4zpIwZ9xin
 cnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279775; x=1698884575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mb776AbN/UqgNrPvlR/H9NLV+RfwQ56KQuO6pLUVjFA=;
 b=vPwsguRjtUk67XNWLAw9BfUtgi3+cy6/9/Ag1nyx5wL4GuNBuTLdzlyOYylFyqK7np
 HVMEcxdD+EtRRzK/BuWdBhOLg67HvFweuiGC7se/JRsxRxodkSaeIYF6pQOVrI4Pk7jq
 MLGb4sx/sMLOI3pGun3dlkagjYM9PNM8+TqP89BAq+NeyLkrHoMKaDZOwr+LhJ0bhfLG
 wjVvyFQhwWdsjScAuOaib6O7s3zyKP4Om8QbVmMGpokHadHSDkw05GYK15R7pF/Bn8tB
 QTbN+UV4ggXKcDmxNQCy+L4ASh/PejwfPk6/VDH/W/IMIgo/3PkVmJpKqWcXrLPykUsA
 Up7Q==
X-Gm-Message-State: AOJu0YxNEwJnZKkI2dMwAoj1XHf7+cTMJyxNib48s7VPKCyFa8kCov6h
 AG9YbUt5soHJbSa64+otws7l6kxiVYOFgOp0P6Y=
X-Google-Smtp-Source: AGHT+IG7T00cHiGmGNeTgQ7aUpzJwZq1AYZRpyBQJCK2N9mTQUPgUoMMpbgfeERiQcl2qwfTa31e4Q==
X-Received: by 2002:a17:90b:3883:b0:27d:669e:5a10 with SMTP id
 mu3-20020a17090b388300b0027d669e5a10mr13225442pjb.13.1698279775248; 
 Wed, 25 Oct 2023 17:22:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 57/94] target/sparc: Move PREFETCH, PREFETCHA to decodetree
Date: Wed, 25 Oct 2023 17:15:05 -0700
Message-Id: <20231026001542.1141412-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  8 ++++++--
 target/sparc/translate.c  | 23 ++++++++---------------
 2 files changed, 14 insertions(+), 17 deletions(-)

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
index 2175c00ded..363d8b7fc8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4031,17 +4031,12 @@ static bool trans_NOP(DisasContext *dc, arg_NOP *a)
     return advance_pc(dc);
 }
 
-static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
-{
-    /*
-     * TODO: Need a feature bit for sparcv8.
-     * In the meantime, treat all 32-bit cpus like sparcv7.
-     */
-    if (avail_32(dc)) {
-        return advance_pc(dc);
-    }
-    return false;
-}
+/*
+ * TODO: Need a feature bit for sparcv8.
+ * In the meantime, treat all 32-bit cpus like sparcv7.
+ */
+TRANS(NOP_v7, 32, trans_NOP, a)
+TRANS(NOP_v9, 64, trans_NOP, a)
 
 static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
                          void (*func)(TCGv, TCGv, TCGv),
@@ -5457,10 +5452,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5475,8 +5470,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



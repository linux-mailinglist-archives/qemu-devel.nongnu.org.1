Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F97D2754
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhws-0005xf-Fd; Sun, 22 Oct 2023 19:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwj-0004mh-1u
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwg-0007Z9-SJ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1935316b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017601; x=1698622401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9abD2xNgmIf9kDpJL/km2T2MGG+YdIOZ6+xa9duvNgQ=;
 b=Fcd3vhRDnsZId4yYTmQw6OV4QT0D+LZ0QPD7P42sANae1xB3v6Ue5Pixd5X0OA4EyC
 LdboExoN6vHH7qtO6xvsRdJNXnhHhrvi4iEQtoydbtvY/Uq6ZpbmYSX3ZzaGMgsSsIeL
 9TeuIQC0C9DWa4aWKRIg7Vl6R4IOevQe/rq1xnrehxWVwSQHcdupebV1rCHGe2/r+VUR
 5Aeh/WZD6XI0WoIYvUt8Qp+faqUobX9loJeYcCsl65n9cwToQd0GZj2MretTUwWPmgJK
 7O4sBb21+2fAXRoa49VbF7dlwgLgUeLu5u5J8S81dYfFYDtnLkM0hP14NybzmgMmWF12
 nMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017601; x=1698622401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9abD2xNgmIf9kDpJL/km2T2MGG+YdIOZ6+xa9duvNgQ=;
 b=NhzQfjOwW0AmYcQizNy2j2KH2Tcqo8vGI2iC7FtwYOkmrcZeM/2/TZ4Vz4GtmBQBD6
 80/P8jwlOvP+/sHpbIutJVnRy7wrAfhblVu7DmrJyiAzN70ciLo2ztATSUiD6BF3OKk2
 ws2Rata/bAxnYZ1ll2OHvtGMxOzuHHpQM8N7VNzZKLmd4fEXynyd7TTLwRgBhln6UPj/
 +mwbNVVt3CKgv3G+/3jcALGI/7uzqG/2TSDsrG8S7kBkNNWfu0zUDr2wwv7FlGWeU+pZ
 1ShqPrc++aPxZaLxEtQmwyeSiqa1FlJdPD3VFb776cxTU/AyYWkADLxP7S+9nWSenMJi
 EWnA==
X-Gm-Message-State: AOJu0Yynne4T0S2z42+huEPG5Ey2r9AGDxj8PkLnUZusV36cprzhBLSu
 rmubRiCaIzxQjjFBMf/S+XEOHspbGHrbnZBq8HE=
X-Google-Smtp-Source: AGHT+IH+D/PAWwhbU56EBLHwFZ22KIK1V1/p3kfV+tN5rYUEzcfJZtv1XaLcfOy0Kz1BFldv3iofcg==
X-Received: by 2002:a05:6a21:1a5:b0:17a:e981:817e with SMTP id
 le37-20020a056a2101a500b0017ae981817emr11105940pzb.3.1698017600981; 
 Sun, 22 Oct 2023 16:33:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 55/94] target/sparc: Move SWAP, SWAPA to decodetree
Date: Sun, 22 Oct 2023 16:28:53 -0700
Message-Id: <20231022232932.80507-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Remove gen_swap_asi.
Rename gen_swap_asi0 to gen_swap_asi.
Merge gen_swap into gen_swap_asi.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 58 +++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2f950000b5..9c4597317c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -288,6 +288,10 @@ LDSTUB      11 ..... 001101 ..... . .............          @r_r_ri_na
 LDSTUB      11 ..... 011101 ..... . .............          @r_r_r_asi # LDSTUBA
 LDSTUB      11 ..... 011101 ..... . .............          @r_r_i_asi # LDSTUBA
 
+SWAP        11 ..... 001111 ..... . .............          @r_r_ri_na
+SWAP        11 ..... 011111 ..... . .............          @r_r_r_asi # SWAPA
+SWAP        11 ..... 011111 ..... . .............          @r_r_i_asi # SWAPA
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3698e1a84d..6e9f9b8930 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1885,13 +1885,6 @@ static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
     gen_update_fprs_dirty(dc, QFPREG(rd));
 }
 
-static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
-                     TCGv addr, int mmu_idx, MemOp memop)
-{
-    gen_address_mask(dc, addr);
-    tcg_gen_atomic_xchg_tl(dst, addr, src, mmu_idx, memop | MO_ALIGN);
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -2258,14 +2251,15 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
     }
 }
 
-static void gen_swap_asi0(DisasContext *dc, DisasASI *da,
-                          TCGv dst, TCGv src, TCGv addr)
+static void gen_swap_asi(DisasContext *dc, DisasASI *da,
+                         TCGv dst, TCGv src, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DIRECT:
-        gen_swap(dc, dst, src, addr, da->mem_idx, da->memop);
+        tcg_gen_atomic_xchg_tl(dst, addr, src,
+                               da->mem_idx, da->memop | MO_ALIGN);
         break;
     default:
         /* ??? Should be DAE_invalid_asi.  */
@@ -2274,15 +2268,6 @@ static void gen_swap_asi0(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void __attribute__((unused))
-gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUL);
-
-    gen_address_mask(dc, addr);
-    gen_swap_asi0(dc, &da, dst, src, addr);
-}
-
 static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
                          TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
 {
@@ -4610,6 +4595,24 @@ static bool trans_LDSTUB(DisasContext *dc, arg_r_r_ri_asi *a)
     return advance_pc(dc);
 }
 
+static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr, dst, src;
+    DisasASI da;
+
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_TEUL);
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src = gen_load_gpr(dc, a->rd);
+    gen_swap_asi(dc, &da, dst, src, addr);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4621,7 +4624,7 @@ static bool trans_LDSTUB(DisasContext *dc, arg_r_r_ri_asi *a)
 static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
-    TCGv cpu_src1;
+    TCGv cpu_src1 __attribute__((unused));
     TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
@@ -5439,6 +5442,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x9:       /* ldsb, load signed byte */
                 case 0xa:       /* ldsh, load signed halfword */
                 case 0xd:       /* ldstub */
+                case 0x0f:      /* swap */
                 case 0x10:      /* lda, V9 lduwa, load word alternate */
                 case 0x11:      /* lduba, load unsigned byte alternate */
                 case 0x12:      /* lduha, load unsigned halfword alternate */
@@ -5446,25 +5450,13 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x19:      /* ldsba, load signed byte alternate */
                 case 0x1a:      /* ldsha, load signed halfword alternate */
                 case 0x1d:      /* ldstuba */
+                case 0x1f:      /* swapa */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x08:      /* V9 ldsw */
                 case 0x0b:      /* V9 ldx */
                 case 0x18:      /* V9 ldswa */
                 case 0x1b:      /* V9 ldxa */
                     goto illegal_insn;  /* in decodetree */
-                case 0x0f:
-                    /* swap, swap register with memory. Also atomically */
-                    cpu_src1 = gen_load_gpr(dc, rd);
-                    gen_swap(dc, cpu_val, cpu_src1, cpu_addr,
-                             dc->mem_idx, MO_TEUL);
-                    break;
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
-                case 0x1f:      /* swapa, swap reg with alt. memory. Also
-                                   atomically */
-                    cpu_src1 = gen_load_gpr(dc, rd);
-                    gen_swap_asi(dc, cpu_val, cpu_src1, cpu_addr, insn);
-                    break;
-#endif
 #ifdef TARGET_SPARC64
                 case 0x2d: /* V9 prefetch, no effect */
                     goto skip_move;
-- 
2.34.1



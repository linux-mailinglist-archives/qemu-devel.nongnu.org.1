Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5E7CBB2C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRu-0005tM-DM; Tue, 17 Oct 2023 02:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR3-0003kh-9E
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQv-0005DW-9Z
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:04 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3af6bd48093so3507451b6e.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523600; x=1698128400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeYRUl/8fAWyiOtO/ldxHccrm5fOKPmxfUgUi0vKSOI=;
 b=Me3zRcKI0um56sit/wZQG15ar6I2eMD5moiz4EWbfdbuQGYI4gpCsDlJdZaHG5nrdd
 oEb2kHpWheH8XdMh6t1kNKWZ3+fcSzfKseUVyRkeSg318Zb/+OODVaxW5dTOAW8TUSW0
 +KbkFsX8L5nAc0FQkTP28trHr8lL8K3K71issN9XjmyCWgxgNN7YDX0AbhWi+pcH/tu4
 OxaP8NtFc2GvgzWtXOV3dvRxcanLsNK1TNAuEO/D62rgwuaPRaiDsl3i7Uzt7WpfSfuU
 2n9VpDjuJrlxLvNTuEySQu6s8dIr7TggK2K+1H9mNpgKO8FkGgvEAtKFi4UZTYzFigrx
 CnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523600; x=1698128400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeYRUl/8fAWyiOtO/ldxHccrm5fOKPmxfUgUi0vKSOI=;
 b=CpKYxKipsutlA+WjWczpSEP9y3zPl1PHMOP4Jk7PllhLDvxkws3+6iKWW5nHS6SHiU
 inX4MTlGJopg9QmuVoR/TFRvQnJ2B+cHcVU8lKAZWw/dFfZt4mF71NplcfBgdjgg9Wlp
 r6DPP/QFNXaMNEf5npNYNMGId66rW1Ci4wwmjTGxa62YXkuWMAW63dGVXgCkSnhDyfk3
 Zsi4RKjLQokF8/S9NWRmXnjzb5HhUQtWHfBKVeGByZPQ39e7a0LKC1nQaQsYc4D/93EZ
 yW1EOjUinjpryIxZ3TRxR5Cw/vlRN1dVYPvan/dJET1DnLLVb9nvGu1KxxLDwQ61tC68
 Heww==
X-Gm-Message-State: AOJu0YwhZVuY1K9aIdBa5Nw2NzHyNtMBWmrEVsrjpsHP2bdyhvK7U+Jz
 Rd/wChT1yTQ2Ee6cT+6JUMRzm3HO76TSQfqNNww=
X-Google-Smtp-Source: AGHT+IHp8VbVnIpxqFFRG+PrQK/X7pjXjW7U/dCZtPGpJ/EPPLW9sIet35vcJHCQ9ywDDNHN/5H6+w==
X-Received: by 2002:a05:6808:408a:b0:3a7:1e98:80ad with SMTP id
 db10-20020a056808408a00b003a71e9880admr1399899oib.9.1697523599953; 
 Mon, 16 Oct 2023 23:19:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:19:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 88/90] target/sparc: Move FPACK16, FPACKFIX to decodetree
Date: Mon, 16 Oct 2023 23:12:42 -0700
Message-Id: <20231017061244.681584-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 55 ++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0a0c5b2505..c9fe45adff 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -337,6 +337,8 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
     FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
+    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_r2
+    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_r2
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 01063afa30..bee9212ba2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -710,6 +710,24 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_shli_tl(dst, dst, 2);
 }
 
+static void gen_op_fpack16(TCGv_i32 dst, TCGv_i64 src)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpack16(dst, cpu_gsr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_fpackfix(TCGv_i32 dst, TCGv_i64 src)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpackfix(dst, cpu_gsr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 {
 #ifdef TARGET_SPARC64
@@ -4675,6 +4693,26 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_fd(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i32, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_F(dc);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FPACK16, VIS1, do_fd, a, gen_op_fpack16)
+TRANS(FPACKFIX, VIS1, do_fd, a, gen_op_fpackfix)
+
 static bool do_env_ff(DisasContext *dc, arg_r_r *a,
                       void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
 {
@@ -5354,10 +5392,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_src1_64, cpu_dst_64;
+                TCGv_i64 cpu_dst_64;
                 TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rs2 = GET_FIELD(insn, 27, 31);
                 int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
@@ -5440,21 +5477,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x02a: /* VIS I fcmpeq16 */
                 case 0x02c: /* VIS I fcmpgt32 */
                 case 0x02e: /* VIS I fcmpeq32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x03b: /* VIS I fpack16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    gen_helper_fpack16(cpu_dst_32, cpu_gsr, cpu_src1_64);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
                 case 0x03d: /* VIS I fpackfix */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1A7D3ECB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzR1-0005aT-Dn; Mon, 23 Oct 2023 14:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQx-0005Wx-3J
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQu-000892-8Q
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so2707269b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084823; x=1698689623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXDCPRqwkNHEWZB52f+OeRGLQD3oaL6U6LhW5ET5dXA=;
 b=wIEsZnslbevgiZPW+B53hhSGs4BF7V+7425Qi69BAK91QkZfmF6t+Aks1QQG/QMT7+
 cCBckyUCQUXmHD6Zn1GC8pBnfNnwYxIAdhLDaWMT6csTTjf8HyZq5PbmOwYLfzK9qTCl
 Sgw80RcZDfUBMK2LdI8/shry2B1vrJ7cyyPM2OgE+qkoymZdJj50LKOrVKqBLYSTcE6/
 5Js+4zYRKSv0IF9f2YLx2ujCxaw4B1E+br+smnAdla6nEdSexRLVfIVipmZoiH76HXKi
 gaLp/TeZtCuMqtEahgyJ+z4Kq+GH5OFpaEdlQzjxTPo6BwGRP//lbGW8YiLkOorIq2I1
 S1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084823; x=1698689623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXDCPRqwkNHEWZB52f+OeRGLQD3oaL6U6LhW5ET5dXA=;
 b=r8mk/aFgxm0HFUmVTL8B3w3vPEQRRFMTjLQBGFR4BjDwObBEjj/rwdg11zYTux3DoF
 +WqKGfLuwnObhRHDw9C/i9Qt7Yyqa4zowVksp9Ry8vugNiIrDS/RUNuY0/lS6Jfxbpcg
 BysYCSAmk26Rt8unYQazJW9ijuOZpQ2rNpHCrGKiGxyNG+bjr/NVgW5a/Qb/4eSoxv46
 tiz2asbPs+4wNPxAipeH9Q+JxR4wvbnRL/2NwQkFMBBalccJjXJAa4GDuPqNU3xIq12y
 KPYAujNTdL4zcgZsnn4pAi3hN4E4OEbdAd4lNg1XiD5OxcuvBqjS8QIfDIeaCqzhTOm8
 jIvA==
X-Gm-Message-State: AOJu0Yz7fnWNK4PuCykT6UOQ/JLuJHrpH6UG6EeptylvcCSsh2tE1b2s
 lub4qCUqrq+xJK1QxyPtTzohIyXWON4TK2sL8/c=
X-Google-Smtp-Source: AGHT+IEHFaNk/DjXY9GlUMZFPOOkkclO2gV4/qpKyWHCo3TQEWVrHB0zVhKFCXvgm3AX2cor6IPAww==
X-Received: by 2002:a05:6a00:1881:b0:691:2d4:23b2 with SMTP id
 x1-20020a056a00188100b0069102d423b2mr8381417pfh.15.1698084822865; 
 Mon, 23 Oct 2023 11:13:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 14/38] tcg: Introduce tcg_use_softmmu
Date: Mon, 23 Oct 2023 11:13:05 -0700
Message-Id: <20231023181329.171490-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Begin disconnecting CONFIG_SOFTMMU from !CONFIG_USER_ONLY.
Introduce a variable which can be set at startup to select
one method or another for user-only.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  8 ++++++--
 tcg/tcg-op-ldst.c | 14 +++++++-------
 tcg/tcg.c         |  9 ++++++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 680ff00722..a9282cdcc6 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -488,11 +488,9 @@ struct TCGContext {
     int nb_ops;
     TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
 
-#ifdef CONFIG_SOFTMMU
     int page_mask;
     uint8_t page_bits;
     uint8_t tlb_dyn_max_bits;
-#endif
     uint8_t insn_start_words;
     TCGBar guest_mo;
 
@@ -573,6 +571,12 @@ static inline bool temp_readonly(TCGTemp *ts)
     return ts->kind >= TEMP_FIXED;
 }
 
+#ifdef CONFIG_USER_ONLY
+extern bool tcg_use_softmmu;
+#else
+#define tcg_use_softmmu  true
+#endif
+
 extern __thread TCGContext *tcg_ctx;
 extern const void *tcg_code_gen_epilogue;
 extern uintptr_t tcg_splitwx_diff;
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index df4f22c427..2b96687699 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -34,13 +34,13 @@
 
 static void check_max_alignment(unsigned a_bits)
 {
-#if defined(CONFIG_SOFTMMU)
     /*
      * The requested alignment cannot overlap the TLB flags.
      * FIXME: Must keep the count up-to-date with "exec/cpu-all.h".
      */
-    tcg_debug_assert(a_bits + 5 <= tcg_ctx->page_bits);
-#endif
+    if (tcg_use_softmmu) {
+        tcg_debug_assert(a_bits + 5 <= tcg_ctx->page_bits);
+    }
 }
 
 static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
@@ -411,10 +411,11 @@ void tcg_gen_qemu_st_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
  */
 static bool use_two_i64_for_i128(MemOp mop)
 {
-#ifdef CONFIG_SOFTMMU
     /* Two softmmu tlb lookups is larger than one function call. */
-    return false;
-#else
+    if (tcg_use_softmmu) {
+        return false;
+    }
+
     /*
      * For user-only, two 64-bit operations may well be smaller than a call.
      * Determine if that would be legal for the requested atomicity.
@@ -432,7 +433,6 @@ static bool use_two_i64_for_i128(MemOp mop)
     default:
         g_assert_not_reached();
     }
-#endif
 }
 
 static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 637b9e6870..d3a4a17ef2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -226,6 +226,10 @@ static TCGAtomAlign atom_and_align_for_opc(TCGContext *s, MemOp opc,
                                            MemOp host_atom, bool allow_two_ops)
     __attribute__((unused));
 
+#ifdef CONFIG_USER_ONLY
+bool tcg_use_softmmu;
+#endif
+
 TCGContext tcg_init_ctx;
 __thread TCGContext *tcg_ctx;
 
@@ -404,13 +408,12 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
     return (uintptr_t)tcg_splitwx_to_rx(&s->gen_tb->jmp_target_addr[which]);
 }
 
-#if defined(CONFIG_SOFTMMU) && !defined(CONFIG_TCG_INTERPRETER)
-static int tlb_mask_table_ofs(TCGContext *s, int which)
+static int __attribute__((unused))
+tlb_mask_table_ofs(TCGContext *s, int which)
 {
     return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
             sizeof(CPUNegativeOffsetState));
 }
-#endif
 
 /* Signal overflow, starting over with fewer guest insns. */
 static G_NORETURN
-- 
2.34.1



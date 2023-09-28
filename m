Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D17B2607
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwtm-0007zZ-6X; Thu, 28 Sep 2023 15:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtj-0007yM-P3
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwti-0007yy-2t
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso100721845ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930124; x=1696534924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTgXBkn5TnELvpBo0aJHFhInTurB6cKNpUDk0rnkIf0=;
 b=oi/9nNC4hS4yX+wjbCkCeN/s10vg5Y5Gwa6wtLN1KWwJ2tf9Eucf7S+dUnn9Vk4hI6
 PoFnV+jGCvwGeK6DLIf7KewT9WItnNMJcyGiDRHaxGG9q7qrnc0D/CqRBKAdadh8Srrg
 WVpLKjz9h5jZoq05SG1PjkuFVEwKXWW0VtXf6P8KnDa9Y0ljzaJfw/ynduHIg4/aYGQT
 A0e2SgSqiKdX069ocMCfyMUr8hl92RFnKonrEw2MDhP6mJr9FDMUc1c35BpDSQJ8i+1U
 XBUHR5Z//H3Eovf298yIEQmePchVTQ1AE+0sR/XjIP/eA2ehYR2irHtjLEXCaKVcnorY
 jD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930124; x=1696534924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTgXBkn5TnELvpBo0aJHFhInTurB6cKNpUDk0rnkIf0=;
 b=TnaolkGU/vIkav8Ns3bXGg/XEWiFb6yb4QMObeYNQ+XvAu5We/0Qg73BZenwpqJH2R
 3ALKJ/OTHK01KkUa7nbF3VXS/rNfKi0SwR4tSHQE/mPCxXXx552GVvudHBmyjAF6m+R1
 zaJzV87Dm7OXa9PU7qnZbYzAFVvBwId4mmS+/OwehkxZe59KiKkonYQGKHXHNxDEiJsD
 s+g6BdM6UYuViAcBiSazDy48KRHWZuk47XmMlAuyk73B4rJl4oVxYB9nsiWYVUNEqWoY
 JM8nfvJIbFKApB8iz49Icwr7MumVoXUs3mYRdwjssdsYFmQEF5RF3C0J/Sr1GDukU8my
 +2Mg==
X-Gm-Message-State: AOJu0Yzfvxk98W8qzwMhOTYei+T0Z09EYzvX5p969O71rXTY+OcC0ieA
 ypxwUcDaeewcwQsYwkgHqH8ZQzW2GQlp44O54hI=
X-Google-Smtp-Source: AGHT+IFjWcdR089jauWFuykjgLXd783I7ptZSSxaIXPeARYv94MEM5diWzECCkPG2Mqyq4Su9vCc0A==
X-Received: by 2002:a17:902:b783:b0:1c6:1ac5:144c with SMTP id
 e3-20020a170902b78300b001c61ac5144cmr1767692pls.40.1695930123696; 
 Thu, 28 Sep 2023 12:42:03 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:42:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] accel/tcg: Always require can_do_io
Date: Thu, 28 Sep 2023 12:41:56 -0700
Message-Id: <20230928194156.237351-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Require i/o as the last insn of a TranslationBlock always,
not only with icount.  This is required for i/o that alters
the address space, such as a pci config space write.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c      | 20 +++++++-------------
 target/mips/tcg/translate.c |  1 -
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index dd507cd471..358214d526 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -28,12 +28,6 @@ static void set_can_do_io(DisasContextBase *db, bool val)
 
 bool translator_io_start(DisasContextBase *db)
 {
-    uint32_t cflags = tb_cflags(db->tb);
-
-    if (!(cflags & CF_USE_ICOUNT)) {
-        return false;
-    }
-
     set_can_do_io(db, true);
 
     /*
@@ -86,15 +80,15 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
         tcg_gen_st16_i32(count, cpu_env,
                          offsetof(ArchCPU, neg.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
-        /*
-         * cpu->can_do_io is set automatically here at the beginning of
-         * each translation block.  The cost is minimal and only paid for
-         * -icount, plus it would be very easy to forget doing it in the
-         * translator.
-         */
-        set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
     }
 
+    /*
+     * cpu->can_do_io is set automatically here at the beginning of
+     * each translation block.  The cost is minimal, plus it would be
+     * very easy to forget doing it in the translator.
+     */
+    set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
+
     return icount_start_insn;
 }
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9bb40f1849..593fc80458 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -11212,7 +11212,6 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
         /* Branches completion */
         clear_branch_hflags(ctx);
         ctx->base.is_jmp = DISAS_NORETURN;
-        /* FIXME: Need to clear can_do_io.  */
         switch (proc_hflags & MIPS_HFLAG_BMASK_BASE) {
         case MIPS_HFLAG_FBNSLOT:
             gen_goto_tb(ctx, 0, ctx->base.pc_next + insn_bytes);
-- 
2.34.1



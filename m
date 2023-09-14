Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A67A0BF0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqOY-0000jM-JS; Thu, 14 Sep 2023 13:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOV-0000hJ-Gt
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOT-00070k-Lc
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fc9a4ebe9so1101030b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713484; x=1695318284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3EVonE9eg3BvfVh3vmTdOCW0800wHk+spI7M9DnBuQ=;
 b=ZZp/rgAH9B3AR3Ht6cfoY0zEF+7PypQMQfFiT3h8rbpfNOUGiIM+0uwfX9C11nIgKv
 xQNI7Rrl2rsXLBMLZor4TgYzNxgf7RzywpfSS69KHvO2FWH4eSdYTR5gr36tpLZhMxw/
 rDoCBf+c0I3ZalhjkqtnO5gpad35RuZzlRZj+MAElhrRoVhL7TV3LYnDNpFYKFc4gw41
 vOyA3kLF9VaPYXWn+VQ76+v2GHH9MSYO8eGG6/qLY54zQw8QuIgHMcBFhU+gEGYoMPCw
 AJMVUGQ6jhuexh0APuRDOXPkYluL8V1VXKnuoUA4djEmmn7bElrUukKIdxpLOM9kwY0/
 pvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713484; x=1695318284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3EVonE9eg3BvfVh3vmTdOCW0800wHk+spI7M9DnBuQ=;
 b=hzIa0uB0AY/BD350/aBDsXTC7IbT0/k5WuhwL/qor1hfstN6gHpGAkc/HM/Y9fsI5O
 xuvpde3qR7lVo3ZoZhbFL5E/kwj8fuE3QbIg12psX3DnyDc0QnCJUbo8q/yVxqjD7eAw
 FwUPADAAZ6B9N4jW/mWwyJF8Ss1KRPCchx/IcuaFBkt1iF7WkNHKzGGhJcpLdwR7Y5qK
 cvQq2gq5itQJ0ppTKUVUZD7yEsV/LCyAgZ92I1waz/yteq+x9iOQP94b9ZUJuU5m1cKv
 1hfC/lzkVYCkANcF866EGohFjqjlRh/VTOFAGjEcFHVGtY9Rhrmc1/kLhn50atLSa/N4
 2B7A==
X-Gm-Message-State: AOJu0YzSTPeaYaU1QYYghwbalogAtX20dt5gUKBuvCOOm5QD/xst9Pz5
 t7CBjTfOLvsqOMCF+l4Qx1u7l4oRtFFiMhjXv5E=
X-Google-Smtp-Source: AGHT+IGe4Jg7kZH4CxDUbvq4+axBoeQIfi0TXRKzVr0LlH081zNQ4T4gN6El7NR4PiP+RmfEk1N85g==
X-Received: by 2002:a05:6a00:998:b0:68e:2d9d:b0cc with SMTP id
 u24-20020a056a00099800b0068e2d9db0ccmr7487846pfg.6.1694713483670; 
 Thu, 14 Sep 2023 10:44:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0068c5bd3c3b4sm1588933pfn.206.2023.09.14.10.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:44:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 6/6] accel/tcg: Always require can_do_io
Date: Thu, 14 Sep 2023 10:44:36 -0700
Message-Id: <20230914174436.1597356-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174436.1597356-1-richard.henderson@linaro.org>
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
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

Require i/o as the last insn of a TranslationBlock always,
not only with icount.  This is required for i/o that alters
the address space, such as a pci config space write.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
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



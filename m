Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5A7D3ECD
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRn-0006fY-KE; Mon, 23 Oct 2023 14:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRG-0005pQ-1J
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRE-0008J1-Eg
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so2707647b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084843; x=1698689643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZTStllFRXXRJKs8va6Nw+b+x2His96pbgh13vqXpyU=;
 b=zWCWcgyr1LwsgYJPsxF6inFIQZFc7tM5Y2MCFNbfW1MPgGAis33vGJ0sBmekPkEKIW
 UROlc99qoyD0BmQgOzAcNpLbSOfLbQaotoXWBlCmMVuMe/EEkYpk4jOprgcSkxsXZZ9n
 NimKqcopEBaXSE1d7z4S0BuXLyTi+1L0MyPfqHs3GmFv4OMOvmwnWqH2hxmC22QnH+Le
 covKQ2e5Ql/JW9xlkRKkt7T+DaL/XZJtzZZ9FY0W+7j2gCxHyCpQWfg2rVepEHCVcXSW
 GSjiIBwfPFRJdoQFpcegWG8umlLAK8WIo/d5kvk4VKgBT37jmSaMq8fHL22By7qyzRCv
 fiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084843; x=1698689643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZTStllFRXXRJKs8va6Nw+b+x2His96pbgh13vqXpyU=;
 b=mnaGelZJaOYHG5PYT05ClWBlvnonir8zfOwE+1bWYZrBwH7+XR0uslW38gnpq0vXnY
 +2s49bPoOudmstHO2gSlu/CtEQN48HxMYldPKa3mF+7apmw5lKrYi0Vs3q8FjIhIMuwh
 U29nwzs4qxh/HFAWMUXOq4K4mAZXJNyNse7L9JkXLliaYHGqZpU31IEqaxq4NrJIQc0n
 M0+8mg8FkUYGpRQVnSQM13T3/X+Ha5BSWyxrjmUdrcM3NkUHMydSBJYVEE23xa40ONKB
 jqkaLmBBuytf+o0nxmCTI/npba1X8CcYwFaKOH0RsFYKHjEbnkovJ7ty69fxIxJc6qW8
 kKPQ==
X-Gm-Message-State: AOJu0YyTkHvqRBsfoDh1+5gyHPsZ6C3adx4uBwoUfwgDp9lnuXP3j2fw
 fNd67ijQhPcCJI8Vwnpj6oYN635kiLZITGp07S8=
X-Google-Smtp-Source: AGHT+IFqhz89K4Tm5vjhNMzCDcCheLz+603qGY+9j5JHA3bhNsQ16cZ5cDcy9MsZimRREKtxVaZmsA==
X-Received: by 2002:a05:6a20:6a1a:b0:17d:f127:d435 with SMTP id
 p26-20020a056a206a1a00b0017df127d435mr392532pzk.45.1698084843183; 
 Mon, 23 Oct 2023 11:14:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:14:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 36/38] target/rx: Use tcg_gen_ext_i32
Date: Mon, 23 Oct 2023 11:13:27 -0700
Message-Id: <20231023181329.171490-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/translate.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index f8860830ae..c6ce717a95 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -492,13 +492,11 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.<bwl> rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    static void (* const mov[])(TCGv ret, TCGv arg) = {
-        tcg_gen_ext8s_i32, tcg_gen_ext16s_i32, tcg_gen_mov_i32,
-    };
     TCGv tmp, mem, addr;
+
     if (a->lds == 3 && a->ldd == 3) {
         /* mov.<bwl> rs,rd */
-        mov[a->sz](cpu_regs[a->rd], cpu_regs[a->rs]);
+        tcg_gen_ext_i32(cpu_regs[a->rd], cpu_regs[a->rs], a->sz | MO_SIGN);
         return true;
     }
 
@@ -570,10 +568,7 @@ static bool trans_MOVU_mr(DisasContext *ctx, arg_MOVU_mr *a)
 /* movu.<bw> rs,rd */
 static bool trans_MOVU_rr(DisasContext *ctx, arg_MOVU_rr *a)
 {
-    static void (* const ext[])(TCGv ret, TCGv arg) = {
-        tcg_gen_ext8u_i32, tcg_gen_ext16u_i32,
-    };
-    ext[a->sz](cpu_regs[a->rd], cpu_regs[a->rs]);
+    tcg_gen_ext_i32(cpu_regs[a->rd], cpu_regs[a->rs], a->sz);
     return true;
 }
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196687D01B8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXmH-00022F-I1; Thu, 19 Oct 2023 14:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm3-0001EY-NT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm2-00070i-2T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso36144b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697740173; x=1698344973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGIXoZILq0txY1tXatn/JVNUB8nGVXg1ja2k0qG9p7E=;
 b=IQRj3APvcYwc11Onno7NTHpQNNttUTekKgIPcvUxek/Ni1O4uFzvV2V5Qor84Ki+Fh
 Uya8nfGu9ARsWDJlTmdfk8HxvG9Q7mpC5APe+yRCCA7ao3OlfwjVGdiMuM9xFvF2lHfn
 j62hApSjsuk6mNNKIRzgyoDOIawrp5qlD13zPha2toMNJTtj0GCQGpEo0fOtSNn+ZeMl
 3wVhhDG0RusMav8Ntfn5WbDDzpy6a7CXZUOCq3JZEnqBheOoRkJh+scWNd7tlVPdCQNZ
 KyjgOZjSkT3spliXyC+9OpPjXm7MkT5RXlO7S5YDqaPXSeFSjyNmn8qFvu5rhmrHZW/8
 hx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740173; x=1698344973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGIXoZILq0txY1tXatn/JVNUB8nGVXg1ja2k0qG9p7E=;
 b=jyNg5jvtyYC7EGOKE+pkiHWzBo0HkuKlwRPJzEn6IgtWs+Q3i98/L585I+ZRcufA27
 vdNlMdw8I+D6KBZN2vPa13H7FOd83SM3k6rSUil5Wbxq2H9pdopg3ae0jWoH/55wTBTT
 LapGhOo+cHYrx1ywiXxUNTFI0x84wLUqnr3b+QwqqDpAE/ulqt4ZtR+bNlBE2UlcTO75
 /9lDdaJA+oXAtFdmbFg308nxkWEt/b8xlPdnlmgUMDsurtvBaoDLYuahHyAtAF7H9Ja3
 kjuG0r0i5SWhsb/4UVrXJncZGUu71GXPDs7OYEIWGNZbz7/bWbBVxoagLw4TzM6uwz47
 082Q==
X-Gm-Message-State: AOJu0YxIzkv3hgnB8Jw9CarANl1ESXjmqkCHkYI1EaC+2EyqKAKEC/eP
 Ro/BNLHVZ9I/n3N1N1kyylykg7dqA1SNuGJ40MI=
X-Google-Smtp-Source: AGHT+IFnIQTauxorfMiZFdwRoVcpUhNLQlgFCI6Ax3p8oZO9CCyLCL3Is/lMYRuCAJ9til7Bs5EAZg==
X-Received: by 2002:a05:6a21:71c7:b0:17a:f1eb:e143 with SMTP id
 ay7-20020a056a2171c700b0017af1ebe143mr2920421pzc.26.1697740172755; 
 Thu, 19 Oct 2023 11:29:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e1-20020a630f01000000b005b856fab5e9sm72216pgl.18.2023.10.19.11.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:29:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
Subject: [PATCH 5/7] target/rx: Use tcg_gen_ext_i32
Date: Thu, 19 Oct 2023 11:29:19 -0700
Message-Id: <20231019182921.1772928-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019182921.1772928-1-richard.henderson@linaro.org>
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



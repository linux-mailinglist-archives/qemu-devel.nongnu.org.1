Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F87D1771
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM5-0007yQ-2M; Fri, 20 Oct 2023 16:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLp-0007mM-IJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLn-0008Gr-Js
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso1160115b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834646; x=1698439446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y0TWqbSJ7897PJsLkdK8seC1JV+I54PI/WHM1mCLlw=;
 b=I9rivRQQL2ByoK9jUSheD/9LkC29beFLKI9tAD3om2+tsEsGYeFVPl0biChVXo7Ov1
 t7vmi/OjoZbbbPEuHcG1JJ4lO8EwAOj8BCofULZLYWUUJXVID1qeuXci1uor1fZPW3lp
 sFgw+wRzZ4FFWuXKpnhXEUyf3WUzGHaWEFuuXEajY5djdLDKsQCIhQ4Gb195CEdkfdSP
 C32X+Yvb+z3GLloge9xXrkFWXgEgiwDTcjSn0u1AgcMbd47fX7PKaE01EtM821LKBCm+
 0SAXBMOOFuoiXauKIUiEapgFoeYcDobP3kjLLPP3z2BgAGrwlzyWWsRw0aGLImm5xHfD
 NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834646; x=1698439446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y0TWqbSJ7897PJsLkdK8seC1JV+I54PI/WHM1mCLlw=;
 b=TSnuwwBF6fCNr3EDTB+5FaZ/pjSs4M7JqCY4cgT6W0ZpK2aQfKU2Z2k+gvFAtsmSFT
 gofWBrOEghyO8EDbqwjD/h5BTrwpg9NocPFIl0B5omIWfe2n6GDHzfy1rJ+/d4F7LaQT
 vNaRy+FNXhdw+AkaWau5wpVz4AjgMEsgoaZJ/q066M/TSM3PQfsscC3FSKRr29gjvf0l
 suqkX5mT0AlFQVThvUl8LhIp9Ejo7j59tju69bmZ72u658+PsVnqU5V8cXElEA/Ih12h
 t/t26iez0Tlk5hHedmuV91OQzNEJ6SG2HzueZrPvkNw4YYcPkVJK2bFJ+h1g1p5+fyW6
 tw8g==
X-Gm-Message-State: AOJu0YyWDMlMzuX45B8L7pKQX2OxWEh92ClroOllGny/zYjK0qDy1bok
 5M7qaTVnJvsCa1IFuY0EI8dHaZNQ6i+WxqAnXeU=
X-Google-Smtp-Source: AGHT+IF9By1g3a6FB66/xnrrHe+3cJ2sjd06X87HwtUtgZQYR1HK0+30urD9p6d6TrKj58Lje07Cxw==
X-Received: by 2002:a05:6a00:812:b0:6b5:6c95:4671 with SMTP id
 m18-20020a056a00081200b006b56c954671mr3184314pfk.34.1697834646200; 
 Fri, 20 Oct 2023 13:44:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 37/65] target/hppa: Decode CMPIB double-word
Date: Fri, 20 Oct 2023 13:43:03 -0700
Message-Id: <20231020204331.139847-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/hppa/insns.decode | 10 ++++++++--
 target/hppa/translate.c  | 11 ++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index fc327e2bb3..48f09c9b06 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -51,6 +51,7 @@
 %pos_to_m       0:1      !function=pos_to_m
 %neg_to_m       0:1      !function=neg_to_m
 %a_to_m         2:1      !function=neg_to_m
+%cmpbid_c       13:2     !function=cmpbid_c
 
 ####
 # Argument set definitions
@@ -69,6 +70,7 @@
 &rrb_c_f        disp n c f r1 r2
 &rrb_c_d_f      disp n c d f r1 r2
 &rib_c_f        disp n c f r i
+&rib_c_d_f      disp n c d f r i
 
 ####
 # Format definitions
@@ -88,6 +90,8 @@
                 &rrb_c_d_f disp=%assemble_12
 @rib_cf         ...... r:5 ..... c:3 ........... n:1 .  \
                 &rib_c_f disp=%assemble_12 i=%im5_16
+@rib_cdf        ...... r:5 ..... c:3 ........... n:1 .  \
+                &rib_c_d_f disp=%assemble_12 i=%im5_16
 
 ####
 # System
@@ -303,8 +307,10 @@ cmpb            100000 ..... ..... ... ........... . .  @rrb_cdf d=0 f=0
 cmpb            100010 ..... ..... ... ........... . .  @rrb_cdf d=0 f=1
 cmpb            100111 ..... ..... ... ........... . .  @rrb_cdf d=1 f=0
 cmpb            101111 ..... ..... ... ........... . .  @rrb_cdf d=1 f=1
-cmpbi           100001 ..... ..... ... ........... . .  @rib_cf f=0
-cmpbi           100011 ..... ..... ... ........... . .  @rib_cf f=1
+cmpbi           100001 ..... ..... ... ........... . .  @rib_cdf d=0 f=0
+cmpbi           100011 ..... ..... ... ........... . .  @rib_cdf d=0 f=1
+cmpbi           111011 r:5 ..... f:1 .. ........... n:1 . \
+                &rib_c_d_f d=1 disp=%assemble_12 c=%cmpbid_c i=%im5_16
 
 addb            101000 ..... ..... ... ........... . .  @rrb_cf f=0
 addb            101010 ..... ..... ... ........... . .  @rrb_cf f=1
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d1d9a4a137..bb55718a4d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -329,6 +329,12 @@ static int expand_shl11(DisasContext *ctx, int val)
     return val << 11;
 }
 
+/* Translate CMPI doubleword conditions to standard. */
+static int cmpbid_c(DisasContext *ctx, int val)
+{
+    return val ? val : 4; /* 0 == "*<<" */
+}
+
 
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
@@ -3101,9 +3107,12 @@ static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 
 static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 {
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     nullify_over(ctx);
     return do_cmpb(ctx, a->r, tcg_constant_reg(a->i),
-                   a->c, a->f, false, a->n, a->disp);
+                   a->c, a->f, a->d, a->n, a->disp);
 }
 
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
-- 
2.34.1



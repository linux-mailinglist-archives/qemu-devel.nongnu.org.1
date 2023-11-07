Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685217E3420
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRj-0004un-HV; Mon, 06 Nov 2023 22:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRZ-0004aZ-Vd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:58 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRL-0001Mn-HU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:57 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3917861a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326462; x=1699931262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pIuthBYkKwOmsBB1Uq0crYfKMoKtW6F7fMd/Il2eA/A=;
 b=ioGk0gYRo2v2gu7vPR7iTK/Pww/6EZ2mpAa5A2tZDNOzFiN7FnJm+C+eUYctfQygRL
 ufs7gASWCGeYaCpZAU21U7+7xXM+o/Z78qItQzJsV2Eyju9h6zETzoqSB5sWogPuYoWD
 K92my/AvTOHFB91cUjkD0qANtoM8a9cx5PA6eOcfPKNh5p9An/xUMfKVPTAMUx7Oy9lW
 iXuG9JKnI0I8zpWcJdr9ZMwaNIdzs2n9zcTSw/yJUIP8NHQzhKaAq1gohHdBfhmbWmjt
 fUEZqCUiXJMv1nmnt9txCUpBTvAnduC3893/WdSr1/vdzlBc0k8oUL63q75Qgk4NAyBW
 MIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326462; x=1699931262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIuthBYkKwOmsBB1Uq0crYfKMoKtW6F7fMd/Il2eA/A=;
 b=F+U5VgEgHhPJM5umagjD3509sl3nw5yegNzA0PNI7V4PiPoKtTIDTlXJEYqtDFpELN
 yrlnDsxxMus+9OpnOQNyjAWiDi1gh71+rz+V1aojeDGySC6Tkq9cR8fsSuB1C4Euj3T3
 XivYZLuqKPbNV34rGQIGq5Of09ws6vuH70wRhqfiEgFw4MthYuei65qqBYjEpBqSpdpm
 0RYptI4NjqybxfCpTe58kzk0f4ACtXiu/9d1oacbSVh6cWVuWTAZ0oS+RWErTapbgTCc
 OYFJQnwVm9eK6DaQ7a3/192CvrFCTLJYkEPgPiCP3n8he9+cwdxnwHswJ6Z13rlO7aMY
 30hg==
X-Gm-Message-State: AOJu0YzIgUf5XkTn0Ghe+EZ9MXejz9R3QawzB3/n7p41pslhDwSfK4pL
 90xU2wL8XOyfPfeMoWRU+8BXpN4sz+rll4D/5Vs=
X-Google-Smtp-Source: AGHT+IFG3/14zr6n+jALsGKYAc3IDLTiS5H8gBB/p0mGmieMio1UZr0i2ir5YxqcrxDsXQ41GpEDVg==
X-Received: by 2002:a05:6a20:a483:b0:137:74f8:62ee with SMTP id
 y3-20020a056a20a48300b0013774f862eemr24901800pzk.18.1699326462158; 
 Mon, 06 Nov 2023 19:07:42 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/85] target/hppa: Decode CMPIB double-word
Date: Mon,  6 Nov 2023 19:03:27 -0800
Message-Id: <20231107030407.8979-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 6cd06fbc0d..7f767fea64 100644
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
@@ -3122,9 +3128,12 @@ static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 
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



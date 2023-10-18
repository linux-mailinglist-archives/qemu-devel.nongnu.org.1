Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F947CEA7E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESo-000248-R2; Wed, 18 Oct 2023 17:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESZ-0001UJ-94
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:11 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESX-0004Tk-GJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:11 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1ea4a3d0a44so2317582fac.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665927; x=1698270727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8D0T8IVajXJnrSYefRA6ZV+yd9zhaNhLNtJGAv0oPE=;
 b=Wi72NawyS6YK63OBWyi/HgwfGbqA47Q8yvJYw+6xpWsJm7ekT+jfJVJVSu98rqBijw
 2C/GMCO/kd4EKUgMLQINTsDFfkm4DrYiXu4nQd5bErV4phqNnpSbW5zG75jzVbkvdjd5
 Ci4QLSQ+liHivUlH8MHmCMhnHovYB5AsYadgstH47EDhiCIczSusrA7y6rQtSxkfH+e+
 uQ+8LtDYNpnWUAsQqnIC8pK6CdQrCh0NQx4RyYipC8WJHZe8IH+bC3WGjSIuW/WJmHUF
 V2mRQ9yUbeQhu+ITQTjuXOuZWYEw1OeIjqv52VrKXFPiQXiHzUNAg62oggotbuzeKP7e
 XHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665927; x=1698270727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8D0T8IVajXJnrSYefRA6ZV+yd9zhaNhLNtJGAv0oPE=;
 b=rEl0E7ANXZpq7de85G9LqAo9N8o8OprQwKOTHMr9UmgyYmGzkNpOC8NvucaXSeAE7t
 jnEPkywFMVtIxthqhfegq05yln8bcp3FGGC2XssPqu7fHVdrxFQNwDEvyc+MhYYVSkWO
 PJcZJIVVZjqqYEI5hQS3bvDX6J2joyWZ+xHsP7sBeWsmyls6HVlHfUWoEE0uAcMs7WTo
 KN3sUy+V9+vLjxCPkgiollb0QzmGnOlqGsfEPZVU86HL7lD9IKRR8sz0lfkL3OzSrpEJ
 j59pPmF8iJsYo0PwYxrzr8wxVSMLarpLyoA8crprMLOLFHBiNyZ6s3NCyFdVh+qUGlkK
 c+4g==
X-Gm-Message-State: AOJu0YwOjZeeoj8R6jqmERAcrZ6fAhSULFqQnHTBZDnp64X81lsmpuZ6
 Hqk4lVg+txmK551bMGnl/N4B/PBx1QBhxmh9+wY=
X-Google-Smtp-Source: AGHT+IG5qlZQKwPOUAQCLLERlWms4zTiIX0hczwrZr+/YqVBxrPwj+k9mvGlnJrHVVzaQfQKfQzgLQ==
X-Received: by 2002:a05:6870:be99:b0:1e9:feb7:71db with SMTP id
 nx25-20020a056870be9900b001e9feb771dbmr636418oab.36.1697665927272; 
 Wed, 18 Oct 2023 14:52:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 37/61] target/hppa: Decode CMPIB double-word
Date: Wed, 18 Oct 2023 14:51:11 -0700
Message-Id: <20231018215135.1561375-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
index 681c955125..753748082b 100644
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



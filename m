Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EFA7D7A40
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpLl-0001sl-4q; Wed, 25 Oct 2023 21:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLj-0001rh-Ef
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLh-000348-Le
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca215cc713so2413345ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698284388; x=1698889188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IT+iq26XpeNaP4p8agkQswthWt+k2V7nM8eUPcDBar8=;
 b=l/3NxxcXjr8ZuVdTRjiRuhrNC5nDjcOePV2+lHRYqLNFSWzhRgKJboNbMwv2os4Eff
 UM/X2JPeFsvCJs+k8XUQ4tk/UoMm7Q0S35dVvtUarHDPxSux4riuwgOO5owAmC1OMe2h
 ewMiZ+ai1tTSkpOgqCrWytQehS61vfZZAl3iIYnJVtEQIBsJA0pBb5ZPZdZqkJV8MNnQ
 hmEhUB9scSRggJB1rXsWF2mTjuNFiiwYj6It7FSXkxvgI0Qn+P9dm0sNkgOwYweZrc4J
 7DMshuHW+gGEuFpVcd0rIgV1ZM2grGYYWD/QFoz8C6YxKuB3ij0eeB9q3OnkWkEZZd7E
 cnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698284388; x=1698889188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IT+iq26XpeNaP4p8agkQswthWt+k2V7nM8eUPcDBar8=;
 b=cu5mzUJu+jqVD/NyXJFvtgpXJ9Yl+vcE4/fLSwyZiKj0+PoTVqEl51VCFsRMyorbCg
 keszT//nMFb8v8kcZX3pNLT1cXu6poL8dyRn7Am7AKSWqaUI2ZW7qYmOVgPCNE/iDCee
 F2JNU88o6aLXPNko0sUVmOEUxLmnN6ZeZxnm0xpjiwWetS5K5lV2IbuyzM+TnIRMO/cv
 QbObqUMeOGtRihQz7kkdxzFH9rtPIlKqLTkPjU97LPr04pKHE7m2cZUfQe+L+reBRO+C
 q3az8GXCeEiSvR9rFnYg/AMrTgTWgJEtYETaKhn6PAIZnPYgAYt8o4xkxcEJUX+KzD7h
 Bjig==
X-Gm-Message-State: AOJu0YyV4QFRXam3fkiW6TmuwtMMJi2t+yrxU1g7n8/hpoIj6jYZlFeD
 inEgorpmgf08f9qIE6XYeUsf6x7uoeaZqUdEwKg=
X-Google-Smtp-Source: AGHT+IFrBiVu+C4fT/Ae5/5DoekgxxQH40tSnTfO4tDle+zTU/ct/ZoKKSQvSKTNhDoRATapmEhk5Q==
X-Received: by 2002:a17:902:ca14:b0:1ca:8629:829b with SMTP id
 w20-20020a170902ca1400b001ca8629829bmr12274464pld.50.1698284388020; 
 Wed, 25 Oct 2023 18:39:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y6-20020a170902864600b001c0c86a5415sm9817032plt.154.2023.10.25.18.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 18:39:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 2/4] tcg/optimize: Canonicalize subi to addi during
 optimization
Date: Wed, 25 Oct 2023 18:39:43 -0700
Message-Id: <20231026013945.1152174-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026013945.1152174-1-richard.henderson@linaro.org>
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 tcg/optimize.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5e16800cfa..9d91c25f68 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2237,7 +2237,19 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
 
 static bool fold_sub(OptContext *ctx, TCGOp *op)
 {
-    return fold_const2(ctx, op) || fold_sub_vec(ctx, op);
+    if (fold_const2(ctx, op) || fold_sub_vec(ctx, op)) {
+        return true;
+    }
+
+    /* Fold sub r,x,i to add r,x,-i */
+    if (arg_is_const(op->args[2])) {
+        uint64_t val = arg_info(op->args[2])->val;
+
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_add_i32 : INDEX_op_add_i64);
+        op->args[2] = arg_new_constant(ctx, -val);
+    }
+    return false;
 }
 
 static bool fold_sub2(OptContext *ctx, TCGOp *op)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F578E4E2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 04:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbXsL-0004tk-Vx; Wed, 30 Aug 2023 22:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsI-0004t6-OW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:38 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsG-0007op-AH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:38 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-44ea1f87427so215509137.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 19:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693450655; x=1694055455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Bhbbu1kEgOjuWuUFXYYFqctaT2+nMVs+SHOqYCtseg=;
 b=RW4ZdYT4UfTd72U949shH9/GcgYI9X7+tFFpBHoQVd674dmrvnuKzvH+OX1pS5pyqr
 G5gk1dLIy5PQUoNM4Lrxt+8+8c9e0308gHa77cEb35ew2BRD+BYh+25dwD/rJ8w6/a8V
 7O9V8QjKsf5eCWlQjgpXd/Qr+DXGeja7HTsZZ6B0DmGIsDBcfPNZOPPb1gkbtJKAIl2/
 4cyi6id2RSayBCiBJFhf1gKCcyuFiklvO6iDwk5I+HC/Vi9ob6rAzugjwGslKx0bYLU/
 D5mV7g/pSD3Vc+Aw0/Tjk6B+ivojn4y2FOmUMyyF/wybEjCH8Ixwja2SoYiggxIiCo/+
 EIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450655; x=1694055455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Bhbbu1kEgOjuWuUFXYYFqctaT2+nMVs+SHOqYCtseg=;
 b=LkNngv/kXFDztEUOp8sZZ7/WXq9JCNU+GYHoRTBD0kpoRonB8tCwW/GOsLXRVGChFu
 696XhdNshaAYYNVjaHlC0cDSkv4CQdmLRvjeC6tvkwcYO8wyWH/LBosgn2w8ZpwJamLu
 M5ugQCFpcdCZI+R30buuAW7dDo5aeHwlwuEc3kkvFz9xmGO5x3scrde0OOLZGEAPzKtR
 3avoddII+h7bO3LgRfiHXzUQjbJWMKfrrCa6Q3dtotIFRCsWY67/kZn/mMTQGTB5nQGa
 miFnkmqK12+VN0hhF70bABE7KgR0u6bLa4FU8SPL/4MIrMcj+wtWlnuZDRENmYeeVFaG
 3AVg==
X-Gm-Message-State: AOJu0YzIalkXxZzETeVoO+f33p+eWC6yOkDAZJ1XI/zim60mtTQJjtfQ
 Eta7fq9I5uVdeiSjX4Kbc6WPht+g11zg4YGZVhg=
X-Google-Smtp-Source: AGHT+IG5QUAZJZ6OI4frrOGO59POvDxE+Al9/zAfpsCtaFtWCiS8XBEEDEKiPikliHVh49m/qrqUXQ==
X-Received: by 2002:a67:b302:0:b0:44d:5105:b146 with SMTP id
 a2-20020a67b302000000b0044d5105b146mr3995129vsm.23.1693450654959; 
 Wed, 30 Aug 2023 19:57:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 dw24-20020a17090b095800b00265c742a262sm288142pjb.4.2023.08.30.19.57.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 19:57:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tcg: Eliminate duplicate env store operations
Date: Wed, 30 Aug 2023 19:57:29 -0700
Message-Id: <20230831025729.1194388-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831025729.1194388-1-richard.henderson@linaro.org>
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe30.google.com
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

Notice when a constant is stored to the same location twice.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 51c4c61b9f..6efc08f593 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2251,6 +2251,19 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     src = arg_temp(op->args[0]);
     ofs = op->args[2];
     type = ctx->type;
+
+    /*
+     * Eliminate duplicate stores of a constant.
+     * This happens frequently when the target ISA zero-extends.
+     */
+    if (ts_is_const(src)) {
+        TCGTemp *prev = find_mem_copy_for(ctx, type, ofs);
+        if (src == prev) {
+            tcg_op_remove(ctx->tcg, op);
+            return true;
+        }
+    }
+
     last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
     record_mem_copy(ctx, type, src, ofs, last);
-- 
2.34.1



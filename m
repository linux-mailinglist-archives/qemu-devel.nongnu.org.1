Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420277376B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9M-00033L-TR; Mon, 07 Aug 2023 23:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8y-0001ix-MB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:25 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8g-0000Mx-HX
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:24 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bcd4b5ebbaso3104042a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464325; x=1692069125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EOxe5rq5CkC99jUD9BB2Rzj7nk3YmOBqVYbqZbgC9Y=;
 b=YtCr5WT4JZ7PqlIYfbJ/+eQoGlFj4dkbROp4d1fFu7DctOEAQoHHrNE7WBe/SNi93I
 5cwoVe3LPN5NxeeA1dbiZYYVVZDeL14Vz+BjYyqvMYK+RCZTOtJDhv1NvakTE9vqqj8N
 PFYbY2sJfg+zJDAbLghbYT8095C0CwUTvY5DRxDIcBOwlBSedhEgqQzRhywT9cCpqGw5
 n1ou6ExupjHpGBt7r1yA0RmPfqvawJzmDfDECX3K9dvXD7/WsezkL5wAaMXnlsEnBKmy
 9E6hPy/H4OGB6ANUQSovGvp/kny3oN/lXCcL9rrFmNFhFpEa0JL1pVVXe+F5VY1Iks0c
 1VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464325; x=1692069125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EOxe5rq5CkC99jUD9BB2Rzj7nk3YmOBqVYbqZbgC9Y=;
 b=C/c3nRt1AW5OMLImBw8J01152vV6OLUWqbgh52VhwuU3V3VtqqTeLfyOkiKtr9HPC+
 b9jMuX+Qwe8xb9sYWHMJSQrkv0tbpsNiVTUC7eyVGP//WgNbaBcdAYp7Gd2QF7g3dQET
 lNpsKCA1q7vlvm+K21sClrQeSXnHASr/Cyz7YtWZAQJIqxcbQLNxVSXRZdARfMvV5noh
 A2/eMHTbku2S/CsALB/zTXNhEnZHBnGYlI6uiWD02A8vgQeqZ4f9UpLBL+qtTIjqnjpB
 uJOQxZDomIcWCTl49ucutNi4i0o0ZNYlyO+CHfOfCU2S3vI6YPlS7BPl6M2VYaxLlhzX
 dmrg==
X-Gm-Message-State: AOJu0Yz7oINVT6HxIRzf3qw7LdBHO3EA2VNIvt/Mf09CNWqBHdSp6jUS
 JE7fND4w5PCKXrR4dy5SZIgh2Sjm/pxdAe7yLQQ=
X-Google-Smtp-Source: AGHT+IHCr4PhfMZNCUvy8TvETJhBBpSERO9GzvUcf0hprQ6HEDV5JSR9qKvwcufG1lIguTDPodmmHg==
X-Received: by 2002:a05:6830:16c6:b0:6bc:f854:4850 with SMTP id
 l6-20020a05683016c600b006bcf8544850mr4303146otr.4.1691464325089; 
 Mon, 07 Aug 2023 20:12:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 23/24] tcg/i386: Use shift in tcg_out_setcond
Date: Mon,  7 Aug 2023 20:11:42 -0700
Message-Id: <20230808031143.50925-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

For LT/GE vs zero, shift down the sign bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index cca49fe63a..f68722b8a5 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1575,6 +1575,21 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         }
         return;
 
+    case TCG_COND_GE:
+        inv = true;
+        /* fall through */
+    case TCG_COND_LT:
+        /* If arg2 is 0, extract the sign bit. */
+        if (const_arg2 && arg2 == 0) {
+            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, dest, arg1);
+            if (inv) {
+                tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
+            }
+            tcg_out_shifti(s, SHIFT_SHR + rexw, dest, rexw ? 63 : 31);
+            return;
+        }
+        break;
+
     default:
         break;
     }
-- 
2.34.1



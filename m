Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CB73A5E2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:19:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCN0u-0001yJ-NX; Thu, 22 Jun 2023 12:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN0d-0001J6-9y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:18:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN0a-00058N-W8
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:18:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b52d14df27so37248655ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687450687; x=1690042687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0kiv9pO98oPtKQ5Bfc+3IlYT+Xx00DtpI/UiyKMWmE=;
 b=kBdrNbtQey4VgUkVJHxObm0E90sxOzlc3bhYK9BdAte7BaSwtgjeQ6DC2C6oiyBWqk
 MI8cK247/fI1X4Si5mLmY0P8/HO2SqIJ15a+KuCSLRpnKByQv+4IIwA1F5cwe/i8lbyJ
 ekE8vNKlxzMW87g/C9HTOec/KXiqWoC/+r0gA6AZhquzu3MF3Y8lk+VMav8ThYOXjK6b
 faMURH2DMrmJ0y0ZEQD1auTn8YSxsql2vEi0B0tSJ4rVPqQ/ZkEcqcbam9bnbtmmsYUY
 2BJFNkXo4bbgoBFZY3xwlB1nN+17GadrJBieIMr5ILPXPH2mAvohhS0r2Mg/PyMLWsFs
 r98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450687; x=1690042687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0kiv9pO98oPtKQ5Bfc+3IlYT+Xx00DtpI/UiyKMWmE=;
 b=E29mDPYCRXDGmAXqHfNdbmpchwlE+Xx+yk6TbT9x6N/Ejpz3yRR+RiS6+r3dlE+EJG
 2n8HN8zLNmY8KPDwkO97GfWrqgOOtGy+5tdkAPxOSZcUD2k2jZrEFT0Qz8a7qySal56L
 h0FA/CxsqqC4cH2Ox7TdR1jOOmAMtIZNup+oT+E2PACnRW+Y5fq7aKIXNBiItUouEp0E
 f+A/WJOKn6Ma7yEpDGI82spqJcCQ3NPXbzZQ/rMUjV9SnXfytgPbT79bYJGH5C5QHyJX
 We0eEiKf6rk4tYEeJf+K9IlfZUJgHf3EhwTaB6eL0vgSw5ZdE1rJWy3X923y9bKWr0cT
 abVQ==
X-Gm-Message-State: AC+VfDxbTck+sVRZEO4t5sl96gkq3FZyQy33w0LyZAvYjL5jok+jXW77
 5gkq5mZhuxr7CJp2i363f5rHpslPAGw+98x42zOVYvWwxKt1gqvj9skp6qckg+0ej0m+mMAianM
 2yW9IO0fWvy16Ix2LcOII/pMy7LW+VtZZLD55dQ7FcCHeYSGP7sWxfqtX5L/1btg4iWeRS5Yzok
 E+
X-Google-Smtp-Source: ACHHUZ4HVqTN5aQTIOFwWrFM7i5OeEE9Htu9OE0Tdq4Dox3zocumDupXzJmvQj6tDYFusCU3rJqfow==
X-Received: by 2002:a17:902:7487:b0:1b0:307c:e6fe with SMTP id
 h7-20020a170902748700b001b0307ce6femr13075964pll.10.1687450687346; 
 Thu, 22 Jun 2023 09:18:07 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 c1-20020a170902d48100b001b3f039f8a8sm5609683plg.61.2023.06.22.09.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:18:07 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 08/17] tcg: Fix temporary variable in tcg_gen_gvec_andcs
Date: Fri, 23 Jun 2023 00:16:24 +0800
Message-Id: <20230622161646.32005-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230622161646.32005-1-max.chou@sifive.com>
References: <20230622161646.32005-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The 5th parameter of tcg_gen_gvec_2s should be replaces by the temporary
tmp variable in the tcg_gen_gvec_andcs function.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tcg/tcg-op-gvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 95a588d6d2..a062239804 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2774,7 +2774,7 @@ void tcg_gen_gvec_andcs(unsigned vece, uint32_t dofs, uint32_t aofs,
 
     TCGv_i64 tmp = tcg_temp_ebb_new_i64();
     tcg_gen_dup_i64(vece, tmp, c);
-    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g);
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &g);
     tcg_temp_free_i64(tmp);
 }
 
-- 
2.31.1



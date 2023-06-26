Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8D73E3D3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKi-0001KO-5L; Mon, 26 Jun 2023 11:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJs-0000Jg-EL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJp-0002rU-9R
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313f2a24cb6so1144085f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793996; x=1690385996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVZhBdoa6t8LsyKUPS+d+sGukihmPgjTFeL73xSC6MM=;
 b=zxcoJcnhVcZJXLy79jdrfZ5lxLINWUrXGcM2iZ/nbxMuO4/XsVaprg8QJNPPvuZM9C
 vQZES8ncolHRNuP+iBTfVPjyc48pe6eQbM4PRlyDcKtV9gIVHNzlYWh60ELVc2VRridF
 oHukmnrJcyrdXi23ENjwyLJRV/QcZvr7WfWMMTLeWs6TnkKTx+YkDI0Xs6oxwSEkMumj
 Jh1APP1AnfrRwo94eUKWLaQ9k+I11JMh82eV91dKwrb9l1OWSQ6IdiViUrTVXvGe13hy
 IJeIslXg9IAV9Vqkfc9F5gk3DP+SsqKcdzot8D7yfNqJcgeb/KsVkqJ+rJa0aiRBY/2R
 ThwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793996; x=1690385996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVZhBdoa6t8LsyKUPS+d+sGukihmPgjTFeL73xSC6MM=;
 b=GYp4MyARF3LZiHqpeapHQrgcawlIrpOabPIoskrkrdUS9HjKMc8OGoBJzP3/t/IL+N
 IB+kRGxVAo1FArO6KufsF5hdMT3Ybz5XlgH8z0mTb/cysITe2E1Num1zpAovHViFgaoK
 fTBiIbu1yhXVXo7Ed/8iGUycyQUMOex9LOds6by5+xmxWskIHOtLlwcWGy5mfr2UVQIb
 nMH5HtILPXRwmyIVeN1EWIGPqUbo5oZw8D7f6z5YYMD1ZmqY+5/YoNlGB1bIcNOn8GEh
 PbAOP+gCSh5z/WLm9/r541y7gLLYkYgQS/CfvWbOioa+XKfM4vqJSBKuDFfpzAH75Cxd
 eflA==
X-Gm-Message-State: AC+VfDzRzVIzqZhCYlvjLEPWM4mWoeI0jfZZyMbQoixKh7OAx7+rEzTl
 c3FmkWDyN24rgE+jlr2ULO+XMzTHCjUpneBRc86Gk63+
X-Google-Smtp-Source: ACHHUZ4LNZFUzKqiNvgsa9A5jssv/Ac3n46Dfp7BcVyHGVxeGR/bJDVxUnDfeYm5y7HVXoFU7DPEYw==
X-Received: by 2002:a5d:5344:0:b0:313:df09:ad04 with SMTP id
 t4-20020a5d5344000000b00313df09ad04mr6684470wrv.57.1687793995983; 
 Mon, 26 Jun 2023 08:39:55 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 15/22] tcg: Fix temporary variable in tcg_gen_gvec_andcs
Date: Mon, 26 Jun 2023 17:39:38 +0200
Message-Id: <20230626153945.76180-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

From: Max Chou <max.chou@sifive.com>

The 5th parameter of tcg_gen_gvec_2s should be replaced by the
temporary tmp variable in the tcg_gen_gvec_andcs function.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-Id: <20230622161646.32005-9-max.chou@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1



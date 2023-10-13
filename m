Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8267C7FA6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxv-0001H0-Ki; Fri, 13 Oct 2023 03:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwt-00063B-8K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwf-0004sZ-BA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso244046f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183451; x=1697788251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMx3/5vgsTaEtEgPUucXxRgTomEP574B32d5MnG3ZJk=;
 b=U3gdZZfT56I9FlhBfIF0/5HcAwfSF7P7AWqQLR2EY6lIsPBraEHXlAIJMP1iWg+MZZ
 cTpqaK9IeA1FBAvs1X9SV21V3fbkOkoGXewuNxDRNgqktdPuKc4sh4aurtMNWZJxWitD
 qEk134lPBk+E5bQeSeQm/FSONQEPIktgogWGGzNgvnDQhjRT2TlmVXIkf/TVp9bVAXmV
 KtscAT1BXWalOvX+VIveJ6cWGmtLOIlKKtLTLgHsKwJfBGgfeJoiyey+G9P3hS1myzH0
 lkOx8Ck5SEp5RjiuT8YgrbSz2HYl4Hlh7d76R/IjVkxoB46E45HyZLPAEzdoDjcopUmn
 x9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183451; x=1697788251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMx3/5vgsTaEtEgPUucXxRgTomEP574B32d5MnG3ZJk=;
 b=hZ9mcn+4tpQkmnKT3QxZdne4Q3a6Q1Lj+9LKhjoodINoadzBBluU+cep6Vu8yYf+kJ
 FHHkxoeOt5X8sQY4tohLcHDQVHUVOxQTCttos/HbzyHIiGpQT9TlGbyrJsLqJqz+kRW9
 9ZMclwSussWgXSciAJGl5q+r1T1EYuhixc1qHYpOyB1IJ4yzKYQfl9QhRpb6C0e4CpZx
 nJYsSunBPuP4LbZ1psHhNY9LQCSj4uUNNotSxI/58PRYY+ZUD4oIwh1akm1fU9IfdNZp
 yj/vxD+iXatuux9/hXVMdZD1fPXe9i2AJZ+AeQDa/LjkzWrOWqr9tyD8rEOS0jCyE9YC
 0YTw==
X-Gm-Message-State: AOJu0YwH12nYB9ol1hGuO4DSTe8Mr4lm6FH/RtLHdzGDknOenJvb2qX3
 loQW3DGtxPqxHhmH7m0Vc1k4+4cTsWuu2aYzYXk=
X-Google-Smtp-Source: AGHT+IH74tX55+eVxos6B3aiTDMwZ+9zHW5wdLog5zc3SnGPGyy9bAZhbl1paGodOAzOVSrKIpWYpA==
X-Received: by 2002:a5d:4f10:0:b0:316:ee7f:f9bb with SMTP id
 c16-20020a5d4f10000000b00316ee7ff9bbmr22502309wru.65.1697183451684; 
 Fri, 13 Oct 2023 00:50:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH 33/78] target/rx: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:37 +0300
Message-Id: <8e229ef043423876a2c0fc906a513382cf6f9205.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/rx/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index f8860830ae..b00c0a21fb 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2232,24 +2232,24 @@ static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     switch (ctx->base.is_jmp) {
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, dcbase->pc_next);
         break;
     case DISAS_JUMP:
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_UPDATE:
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     case DISAS_NORETURN:
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2



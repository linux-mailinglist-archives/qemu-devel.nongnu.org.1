Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328E7CBB7C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlw-0007wR-2S; Tue, 17 Oct 2023 02:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdld-0007tR-CW
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlb-0001sS-Jl
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so10587935ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524882; x=1698129682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXf3xiousk5WHR4e71h22tpjt54xl4eP0lZ+PfizJBM=;
 b=ElS1HURPdAUq16lSAUwxpKcOjwKKagdfguSdVMCsjILXa4PC4j2RwqR5sVFSDszC5/
 S++wSJ/We3sUEY9GrhLZf7LpN0MPFjWhwwCq9OWOPMQqlSey/M0BrSZDyZvVwgsv1eO/
 NqCrcTspGHh56t7Qwd7jtXz65FWRgkxhnhBwKLBqpq+VXsBqSmsN/JCO8yFN4JKF3Xgv
 ZvxqrVawVwmrb4lWBk6SQuy0oB/AM5AO3LTnlMCNGE+KEm2nDiGgmwIuMePLPnxqmi1b
 2fzxMUM36hxD6o5mdGzzJnZxFIDkvQS2G6R2KIEUL/POUBcTy+QOcj1P8KTRjTv3negX
 pfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524882; x=1698129682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXf3xiousk5WHR4e71h22tpjt54xl4eP0lZ+PfizJBM=;
 b=TzfuVvcST2zN2IR6yqtl4x58DqpU8KVdw8J/zyXS4v4MqvKgzpEv6YN3w3dyriOOUq
 U82yPTXPHEJIQKWXMmfS7PTdMtQp05ywvkDbPfyR4AytB5Q7+LK/Z+trgkS2ynSSLT4i
 AnXOvhN0Zh9DtbPOquy0iSsBVLcw3Gabx5qeqtcLMx/ZMyrbHWTjFzYwVeua5mSPs9Jv
 qQqjFGadCGDVHZMbPmc9p1+deni5Qy1H9kUO5WGGDGjUMhstFDV9GOX8KC+tA/Db2PUW
 YxBVMFCp2+uvLbmH8y1YYKEFER2QyCdnZq6s68d6EpOCg46Kuu+BuI9s4Ad9b+kaZrtn
 O1NQ==
X-Gm-Message-State: AOJu0Yym1Vc+GB0nLG4Y2AF6FVxGP5eH9O4pPRPPWitNPGkTX0rmeDcb
 77JS5Z8uUMYHyMrhKInhmri8H9I6ZDZno514d5s=
X-Google-Smtp-Source: AGHT+IFjal3lwb6JAfD/XO8PE5prvUK+QkHWq+AZGz+TiZ+gIImZpY/om309pg2e4/VFFnos7yRIIA==
X-Received: by 2002:a17:903:11cc:b0:1ca:362b:1482 with SMTP id
 q12-20020a17090311cc00b001ca362b1482mr1646060plh.67.1697524881998; 
 Mon, 16 Oct 2023 23:41:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 15/20] target/sparc: Use DISAS_EXIT in do_wrpsr
Date: Mon, 16 Oct 2023 23:41:04 -0700
Message-Id: <20231017064109.681935-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/sparc/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 53a755874e..18546d3bd2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3207,10 +3207,7 @@ TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 static void do_wrpsr(DisasContext *dc, TCGv src)
 {
     gen_helper_wrpsr(tcg_env, src);
-    save_state(dc);
-    gen_op_next_insn();
-    tcg_gen_exit_tb(NULL, 0);
-    dc->base.is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_EXIT;
 }
 
 TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
-- 
2.34.1



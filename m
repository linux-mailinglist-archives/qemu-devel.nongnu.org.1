Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF47A0BEC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqOT-0000d0-U1; Thu, 14 Sep 2023 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOQ-0000bj-1P
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOO-0006yf-6b
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:41 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb6fd2836so1106112b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713478; x=1695318278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb3D6IYlr6FrNnYuqfFzbMBO24dvl8EEYuTIpJQPqlk=;
 b=la3VoVzmanelI08fi9wr2QWMmRfqryf0RoUTGFnplj9pmEd8A1ygTjWAIIP/2xxmuJ
 M51icUZ3jrVN5BWm2aj5TZd8VhDAS9ovq5eF0cvghilTFFfad6eC66aNyVjo410tYmfQ
 CllDqO0Ow7EUlt+SPzCYSdfOQpR5j3NNislhjmkEQuFaacRPUD+bY+iUc9Ji7BU2fbfB
 Cxa+eSGzKvPIZY1WfMECUnQLLaOfSaCMtHEhkZB3x98KwjyqfoUIe/ZNxSCRYNpDDjah
 /8iCis0YinIR9SCZIA5CQS3hqrHtrVVkwsvhgTTVoTbrBqF6p9g/NDPMxv9sLt7k1zko
 d8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713478; x=1695318278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cb3D6IYlr6FrNnYuqfFzbMBO24dvl8EEYuTIpJQPqlk=;
 b=cPxbC2C4fBfck6CRgdN8NkQSR56FfkP2zJUW06p3qw/KimecsYz0ELHTGH/3SpD8cT
 iROFmAdYSVx5bn6VB62olIp8zO3M7llu8pmBJnpkHGyRoCciB4Ke6jyVz+TCTCeDudUg
 lnuMt6Sk3HtXhfr1JolwKlwKOxQgKAFEfs9IoYNjPKuPoKDHAQr6msclTMPy/7d1GzqP
 AtY1DIr2Qi3x0LRLYTHrAPMzUicPsyImk5qMzpFm5w7UR0FWK5sGytPaCcwLbQqlNX7D
 lOFGtfg3wCa+37PbMKVtJc8Hia8Mk2aL4qZtueaL//YR18MRq0IQUlPftUhQyrS4F13t
 ixzQ==
X-Gm-Message-State: AOJu0YzOkZBd5EScj0bh8RFuRQx3YuI5Jj5qwbpxGeWoSIX8OcFDNv2a
 03W0NYpsUVGnnnuBSCkNUeFFhoTmDDXgdx2kQA0=
X-Google-Smtp-Source: AGHT+IFOU+jfh6IQkzwGl/6ZWU1AEHPpTtaU2bQ8YJ05YIdjEGbsbfEvPV4/t3UY4HUEgw0Gqm9RiA==
X-Received: by 2002:a05:6a20:8e22:b0:158:7fdf:66df with SMTP id
 y34-20020a056a208e2200b001587fdf66dfmr6037635pzj.18.1694713478490; 
 Thu, 14 Sep 2023 10:44:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0068c5bd3c3b4sm1588933pfn.206.2023.09.14.10.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:44:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 1/6] accel/tcg: Avoid load of icount_decr if unused
Date: Thu, 14 Sep 2023 10:44:31 -0700
Message-Id: <20230914174436.1597356-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174436.1597356-1-richard.henderson@linaro.org>
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
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

With CF_NOIRQ and without !CF_USE_ICOUNT, the load isn't used.
Avoid emitting it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 1a6a5448c8..a3983019a5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -49,12 +49,15 @@ bool translator_io_start(DisasContextBase *db)
 
 static TCGOp *gen_tb_start(uint32_t cflags)
 {
-    TCGv_i32 count = tcg_temp_new_i32();
+    TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
 
-    tcg_gen_ld_i32(count, cpu_env,
-                   offsetof(ArchCPU, neg.icount_decr.u32) -
-                   offsetof(ArchCPU, env));
+    if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
+        count = tcg_temp_new_i32();
+        tcg_gen_ld_i32(count, cpu_env,
+                       offsetof(ArchCPU, neg.icount_decr.u32) -
+                       offsetof(ArchCPU, env));
+    }
 
     if (cflags & CF_USE_ICOUNT) {
         /*
-- 
2.34.1



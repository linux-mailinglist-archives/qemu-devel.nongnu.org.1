Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E067D5952
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKkm-0000Zp-IN; Tue, 24 Oct 2023 12:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkk-0000Yx-JA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:38 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkj-0002q2-1l
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:38 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso676048266b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166775; x=1698771575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/LpTsjaMG5I45mnJYlkVBvGwoC5bfHGgJpyoEShYgg=;
 b=OiJQ/nm1LrlDX5vGH80epI34WlTlgn8nFSvcV8DqYURO48oWHdUBFYBYdSP/9gpsqg
 inS14PSQzDBmY5d0DegbDZ0V4iu0561GSZbw4N1FIVq1ecuIZn4ApVErKbpv66MhQHp4
 ffI1DgXO0nOV2/nvOKVJxoV1kNszIXLJXJs5U8ptaUenSyZOtsPjHmEphqplDC6krIIk
 3gFtSCA3l8DzViZGIlKZZ1VG9cOTPX4I6CNF5Hskpi64nnLdQ94+webY3hQz6rVpMb3p
 7PH1cky+937aBM4J1HN6f2tC9pfjUVixxa0bPPdyke+pAlB/kFEKeUdrLbymrDPuo/rV
 pnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166775; x=1698771575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/LpTsjaMG5I45mnJYlkVBvGwoC5bfHGgJpyoEShYgg=;
 b=uGCCTsUqIFzXbbm4WwICWQ8srqXt2QVawbBsoddZk0hZwx7xMnLZTdOh/SkfXsvUqu
 haB5APt9o9WX1arpjQgxEMgNg4UhO9BvLaEQmBkKQSH6q7HdBUEGcxZfj0OnNzLEnbd5
 l6wl3LNg75NjL9cZCFn1ZkgO2xv9JKCkHvksqdFg3bdSvfP50S+vNVGmjuQrvGzZU+eD
 TzECIMn/dqhBsu1F2USnR1h0fXz3UbAyNZ9qm6/7zWGFuUwyV6Rid2Y4pD8jKjPVGSOO
 wxVEqrvgVbOStH+KKtj3JRkXVPxhgH45MDB8idaIe/rdKfzlxeFmpkWEeVG3JRpr6k6P
 ra0A==
X-Gm-Message-State: AOJu0Yyog8qX31v6XVYSz7HSX9vUGwx9Cq2qVdAK8syb1G7S5ubTE4H9
 khdA/kImGnh3hjbXomflchUT2hmeZR2iwHymTN8=
X-Google-Smtp-Source: AGHT+IH8Q6hSWu/3qjiL5pNeS3rSyuVBnWNxwFDbV53Dgje3F+kk6molqmM/huCPOwbMvRsU8V2dJQ==
X-Received: by 2002:a17:907:8691:b0:9be:4bb0:650 with SMTP id
 qa17-20020a170907869100b009be4bb00650mr8566644ejc.73.1698166774719; 
 Tue, 24 Oct 2023 09:59:34 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 n17-20020a170906089100b009c3f8f46c22sm8546630eje.77.2023.10.24.09.59.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Subject: [PATCH v2 5/9] target/ppc: Use tcg_gen_extract_i32
Date: Tue, 24 Oct 2023 18:58:58 +0200
Message-ID: <20231024165903.40861-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..c696fedbcc 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4802,16 +4802,14 @@ static void gen_mtcrf(DisasContext *ctx)
             TCGv_i32 temp = tcg_temp_new_i32();
             crn = ctz32(crm);
             tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
-            tcg_gen_shri_i32(temp, temp, crn * 4);
-            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
+            tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
         }
     } else {
         TCGv_i32 temp = tcg_temp_new_i32();
         tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
         for (crn = 0 ; crn < 8 ; crn++) {
             if (crm & (1 << crn)) {
-                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
-                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
+                tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
             }
         }
     }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EC7799B6
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsO-0003Gs-RW; Fri, 11 Aug 2023 17:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsH-0003BU-Im
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00028l-JX
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2680f27b52dso1490668a91.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790039; x=1692394839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUziizuOUDp3zr/tYK6Nc+GQsbSzhH4p5nzwWQ/YUAg=;
 b=CFPGbTa0vWaNv4R3ujhCqZGrEUEqxmFfyvb9s1uznQa2IrkM03HwjAD5sk1s79vrJo
 I4XzbGDv+b6EfZVdkkmzq3PKqc0uStc89RaRMWqtJIhQr/QczjZCTQMXYAUru4CirYQD
 LNKbEIq7FJHBqs9CKy7FkvOZiNWqz6Twn3HoDVAmjM+2/fs8UNHwSFUswGWav4zZS7V7
 Rzxr++lTlrP+qIHtcQdc1Q+nb4/VwhZ7TN0XOAPebAd5VkW/kz9Mbp5ASRmGFR6DkFVW
 ULYTQgw1WtLr3M7BD5tbCEye1uGu7lukQ+eXMEFuxK2WHdvGYkrzr9y8iIhpqafPkIe8
 UEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790039; x=1692394839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUziizuOUDp3zr/tYK6Nc+GQsbSzhH4p5nzwWQ/YUAg=;
 b=IN8ZIi+TvrJpl5F5Bjjpxby6m3F5dO9a+xxjeyXeQV0krqbADc/YV+0oeqZt1VtgrI
 /YXv1KcYr86UTTJV+hnNQrRC/c+f6p3hoWNKWJ0RwS8AbNMxFSW4UAdwdbpCKx2T38Lz
 OQqVXwgGIwi7PEk+CPtrNTQx5YKhFPLHPFFrnlpjd9GI86sSmuXKLCLBsVc6UKFZDJ58
 JLokis6ESYk4l7iurv6YNqYYkyu0HMdmxas2Cw2b5l+1FhAGN2WAzAArKK06K3F+gBHW
 7e6lAvrfRMs2EGoGvcS8gsoTW2E/XSlrK+oRedxFyD+OjfldWI51rI+Peelcxa8i2BEA
 KMLA==
X-Gm-Message-State: AOJu0YxMH3IhqdbARiaq6t9keMpBhGoOkcpMuLuxBeNplUQZTbp2nOER
 LTRgTcv057NqbRy6KcguXWKsz/I8vrlathBotB8=
X-Google-Smtp-Source: AGHT+IFYjbAI5TpuVpoUW674vPViBnlJkwCYZav0CZ1EUInRQtY7Ita5d1Nk/3n0sUQ4pDYUP3MPkQ==
X-Received: by 2002:a17:90a:fb50:b0:26b:365b:e59e with SMTP id
 iq16-20020a17090afb5000b0026b365be59emr841527pjb.26.1691790039105; 
 Fri, 11 Aug 2023 14:40:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 07/11] target/arm: Apply access checks to neoverse-v1
 special registers
Date: Fri, 11 Aug 2023 14:40:27 -0700
Message-Id: <20230811214031.171020-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

There is only one additional EL1 register modeled, which
also needs to use access_actlr_w.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bc3db798f0..b0cac05be6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -560,7 +560,8 @@ static void define_neoverse_n1_cp_reginfo(ARMCPU *cpu)
 static const ARMCPRegInfo neoverse_v1_cp_reginfo[] = {
     { .name = "CPUECTLR2_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 5,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "CPUPPMCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 0,
       .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
-- 
2.34.1



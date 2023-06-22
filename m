Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E573A47E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLyo-0006l8-0j; Thu, 22 Jun 2023 11:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyl-0006kX-U3
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:11 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyk-0000Fk-8U
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:11 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b46f5f4d79so9536971fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687446728; x=1690038728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNQxNM+X/9et0gxYk0zQKZupNp4oqf6HxOnV5h8wxLw=;
 b=gdi6maUL2epezfn3klrOivgtT2f/8FIz6EM2IxFL3Ntn9FXho1hDaDNz8g8kKj4juX
 MPk11not16RbAhKvDlGEGrSPjS3qhBgDrgw4omkHitrXPhsjCJpNZAKN7V2ZyHaZdPta
 DSfeQxX9djSVXW/6NzgI7VYHZTCI2LnXLODsjCVXSP1TFHAXPjeg6++Co9EojVy404Vd
 cupTJ1ac09/jplNBwGXIlWxV+agKYsgOsJ1NkJ37yHmDUwe0xldihe6qOeIJ9pQnXiQv
 7CCt4oMXKHUlMpc5MuaoofFJ5CzcSYGKBqUlcBkGCSOZKtwtqPCc6yOp07likf1R+tPh
 bk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687446728; x=1690038728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNQxNM+X/9et0gxYk0zQKZupNp4oqf6HxOnV5h8wxLw=;
 b=e9IyX6fm/L9ZlI+YHa/YNa+9psTABaMNM05EAkO0qaAYh6nvXUJO3vWmN702zyeIpb
 PENhuuwWXThCA0hJwsB8AbzDVbQ67uvcsfEcplACvGYqModkz9JpIZXxOExxIjnCUmBN
 A+lnHZ9lmUIVxFXaimGViAqu1SRwWntaJAN8cqGGCsViywKyQlSivX/n2jtJQfZh9xRm
 xppTA8jedCEj44jd21C3xHcG3PVEgNXMm4zgdDKKDkI8PG9b0Z1ZI6JkvoQkAIw9cP8l
 R04GLBj9hSLqiN7YoijtqkoXxSelvHb1iQNzfBjSz7Ldcs3eYsA/hw2D5ScJ+1SbRiJ5
 pH+A==
X-Gm-Message-State: AC+VfDxvI42zdPxWNKBE/wyuFrQsbR4aHH7gRWxmMh7OG+qLOdg3SF5P
 6S4WySdfTaIFj5fjA83d1VBYujtj/n3fKUNxFMusX5hl
X-Google-Smtp-Source: ACHHUZ7WCTQf58wHvN5SWyuPShRWP1fhH+lCYUoZyRpGSUC6Jj+Ooa1onJp3O0d9AQ5ZmF+HGiyWQg==
X-Received: by 2002:a2e:8e2b:0:b0:2b4:5d74:d760 with SMTP id
 r11-20020a2e8e2b000000b002b45d74d760mr5103734ljk.25.1687446728250; 
 Thu, 22 Jun 2023 08:12:08 -0700 (PDT)
Received: from stoup.. ([91.223.100.38]) by smtp.gmail.com with ESMTPSA id
 v3-20020a2e9f43000000b002b47fc5219dsm1320276ljk.67.2023.06.22.08.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:12:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 2/4] target/arm: Dump ZA[] when active
Date: Thu, 22 Jun 2023 17:11:59 +0200
Message-Id: <20230622151201.1578522-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622151201.1578522-1-richard.henderson@linaro.org>
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
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

Always print each matrix row whole, one per line, so that we
get the entire matrix in the proper shape.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7cb70f9727..3da811bc5e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1082,6 +1082,24 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                          i, q[1], q[0], (i & 1 ? "\n" : " "));
         }
     }
+
+    if (cpu_isar_feature(aa64_sme, cpu) &&
+        FIELD_EX64(env->svcr, SVCR, ZA) &&
+        sme_exception_el(env, el) == 0) {
+        int zcr_len = sve_vqm1_for_el_sm(env, el, true);
+        int svl = (zcr_len + 1) * 16;
+        int svl_lg10 = svl < 100 ? 2 : 3;
+
+        for (i = 0; i < svl; i++) {
+            qemu_fprintf(f, "ZA[%0*d]=", svl_lg10, i);
+            for (j = zcr_len; j >= 0; --j) {
+                qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%c",
+                             env->zarray[i].d[2 * j + 1],
+                             env->zarray[i].d[2 * j],
+                             j ? ':' : '\n');
+            }
+        }
+    }
 }
 
 #else
-- 
2.34.1



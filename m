Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA997476E1
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1D-0001J1-MC; Tue, 04 Jul 2023 12:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001HQ-J3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj15-0001o5-1T
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso44744545e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488597; x=1691080597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kTYABhSkRPbMfHK4MqNnIuIncwaUJ0xXtOeHrnGp338=;
 b=h5wSPoS2/Q/8BMCP0t4cxH/SMk5RnztokAaememdIDeTUgep8lanNs04LwOUQFqhJQ
 UjjuWPQW2M5lYyzKrHq8m0touV6v5VD/qJiRyj4hC8nFyDNckIOjeNdkFgpQtnNcYZI8
 m14qkhHCxaQuhEU4PMnlT3ac3IGknDrt/FOXmKg0EoS6m8TLBoKWMiYwD7woJK6PWYxs
 ExzJanKZHhAeSWG+75PthCRMsomDOtansZ1Et3uaKVutMfYxPv+gT4xEVf8R9pFshzo2
 gF3WRTNTakV4v5aTPcYm8Ybzu6ZnoU30+jfItUPsuzVMi4zqHRJCoWSsMDAlWNTagM8y
 guSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488597; x=1691080597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTYABhSkRPbMfHK4MqNnIuIncwaUJ0xXtOeHrnGp338=;
 b=XGcBztFg0jTd7dWe81sy7WvvXDP7XmQJRiVQyO1rKEjYmfdY+ZK7ZOEVjP1bibjYoo
 GO5b87Mx+XzjJ62XISO7S0UW5Uxezv01rqjL4WAzIW29FXO1nExkVHRHjQr5WEOn4Zp3
 PruEIJiHnFtFsP8HHqFd1tMqUzVzxXUj3+gI5+cyWFgz2JEP9mJGEgZyCLRao3uto7Zo
 3SUYcW36KRUUz6XDqj73mPWpcG49+bo2SfMsXXYnpTgbeRUPg54j1SZWgLdZXik6Mchu
 j3m2gMeoZq/SZL2dLdI6g/M3y3RWMwDA9A5Y1u3Hg7bRqjdtS6rBlnqd9EzHvEV268EB
 63/w==
X-Gm-Message-State: ABy/qLYr2v70PhbxowQz2g3pE1cAmwbIy/dnzXVbUq8HSxDpZ3Dol1bX
 aWM1jW6nhpjXvQKbjHThZOs4AZj3MCyUV2E0W7E=
X-Google-Smtp-Source: APBJJlEwts7PqVPNBOwainE2KZ+y+T9P7iK2mtiZwr0U+Mmho09YVmXkd8Ti+jv/VjRhs8InS8uLjQ==
X-Received: by 2002:a1c:e913:0:b0:3fb:e356:b60d with SMTP id
 q19-20020a1ce913000000b003fbe356b60dmr1513784wmc.38.1688488597475; 
 Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] target/arm: Dump ZA[] when active
Date: Tue,  4 Jul 2023 17:36:27 +0100
Message-Id: <20230704163634.3188465-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Always print each matrix row whole, one per line, so that we
get the entire matrix in the proper shape.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230622151201.1578522-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f12c714bc43..adf84f96860 100644
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



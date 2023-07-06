Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD153749D97
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzc-0005E7-6w; Thu, 06 Jul 2023 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzP-0004sG-EE
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzM-0000rR-1F
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so7582835e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649916; x=1691241916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kTYABhSkRPbMfHK4MqNnIuIncwaUJ0xXtOeHrnGp338=;
 b=H3umnWHWDBIXVy6Bnx4og1aOwr5TnkX2OiHshU2ZRhVpjOPMzJRyMqCfPNtbH4/MEp
 4dME/MxuDimzzhQIcaOMo2s2moB6f7TvPBwYEr+AmACJ93ECbm2FG0sgjFnlBp76Xs1V
 UJytsB9PG3VMvgAl7xB5PTcUWUWAgdst2IZEW2lKoCq0mN/6Dw0+nzZchosr6MPcZ9l3
 eC5WpdRpt8EHePI3mr1Hs+BCTmy6di7leXpYRALEVgCxAxqIjUWhy8OWZDtf+EG3KyJ5
 x+SJefEaloQetNmAhjpOlaVvK9XNWV/7qAISGLM9wgkQn9Xk+sFkNF9+qZ5lqB5kHL9U
 Rblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649916; x=1691241916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTYABhSkRPbMfHK4MqNnIuIncwaUJ0xXtOeHrnGp338=;
 b=ArXjFt/yEf2/1n5dLARjiIXHnE1FDVvDA56xyQTPUCeys0vqOBZB9KeEzwOm5ENhT3
 SwzvBt+oO2tUgzUL0VcgsOluCOqfocbCh2O0uhXW31NjKh6rjKf1mcQROaMbVw0JaGhZ
 DzqDo+KGVxlnxqryy4kUoqONPHaP80gCknN3wrdGaia+jolkM+ZILDjvZq6GzMh91kKq
 ccSdbSPQ560KizljwhVnPJH4H1KqLbanFf9MLWlbtr3L7fg3RAUMZzM/2qmZfJ5HkTq/
 NaBspuEkSK2WIwYodwCy9Toen4b0Dcjy1+CIb7iLOQgMR7BAYYJ3cHm5qUxWyao2aO34
 lqLw==
X-Gm-Message-State: ABy/qLY/MlpLwOXS+oTIxzCAtxvXzcNVnL10zhRyd3ZsRKWmFuQRZcmC
 9KfZRAVPto8KusfCcFphqeHMtsejyLZOvIGfNKE=
X-Google-Smtp-Source: APBJJlHt/Dh0U3qfATORj4XSpGY66jdh+MDJqgA+BY0WBhVjAcZ9GhEy59H8Ki9c4BvYtm4tQW1Ykw==
X-Received: by 2002:a7b:c8d1:0:b0:3fa:8fb1:50fe with SMTP id
 f17-20020a7bc8d1000000b003fa8fb150femr1352408wml.15.1688649916396; 
 Thu, 06 Jul 2023 06:25:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] target/arm: Dump ZA[] when active
Date: Thu,  6 Jul 2023 14:25:03 +0100
Message-Id: <20230706132512.3534397-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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



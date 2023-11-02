Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D627DEA4C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:43:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeU-0006do-44; Wed, 01 Nov 2023 21:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeL-0006Ev-8W
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeH-0004Il-BX
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so496441b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889048; x=1699493848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kd6/eT9J299b8JKalao90u4vBcVmHm6G2kVANEbq6n8=;
 b=y+ztHnoME3T+rZeEhZQkQyTjNyrongAvfAb6AnE/KjFIcgyCZXu+6oLtCOMC+eWOvW
 kpW57xrW+qXJIWCJ70I3pBx245hlsPe2a4NcJEm8P3JINmzpoxR4ZVFi4bsq6fljc+s2
 uwEOVoNx/uSj6NO0UPeoRQvdCxyQYuyodeUb8wcRQG8+gDpSG9gCIDUZCI7EWwQ/XZGF
 RbEXfG0JB5k3YZcBqhy5++RdE7pfYjQAxHqGgTApzSfk4O8kvL+S47m68YVDrI0OOCmB
 6NJOvMJlEtt5xSG9FovrzvshLRerb2tCC4aQZx3KvzggxVa/6f0WsTgb919eeuIZZbOC
 fWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889048; x=1699493848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kd6/eT9J299b8JKalao90u4vBcVmHm6G2kVANEbq6n8=;
 b=SSV87yLM9UyAxQ71aLt7tjNKuUQ8JtNXHqAeXzJLA1nApIEDj3RTeERltDyRHdZANz
 r8OMDY01iURyHNJUtKg3o1QVGTsni8c9ka4KMlRvE5IODQMHNvSOR9vCaqyYoGeHRCBa
 7HzTxIK0xz2dkxVVAaYIQlwj9oM8nH7m+2/KcdlAV9TpQ9Oi/AqO3IDHdFL+MwIeHbpb
 LiA9fOpeD5uBUe0AwsancmEGI1vO84YFQexU5ghVj5WUwogYRhzYfVek90AQyPGfWefH
 keBPV+Ifp+J+zEvhMjJb6W8u0+DJWkTZ/b1fLxudQEEMU+RdKBweyg4URdK8KrC8aACd
 lifA==
X-Gm-Message-State: AOJu0YxoAPGScwqvDHp5Oj4U9+/fshvJEHaahp+uSZp2oiUMXBYavSaO
 cpd+k+WUONOUf9mq09UgR1j/JUXZO8YCe1czhfQ=
X-Google-Smtp-Source: AGHT+IHMADuSEgfPbXpG57npbXHcoWlHW+AtEOJDmBRN1FHH2m4Fxm4OpueNp4wVH1k2AIR0KA5Dgw==
X-Received: by 2002:a05:6a00:1410:b0:6ba:bd35:9efd with SMTP id
 l16-20020a056a00141000b006babd359efdmr14791538pfu.5.1698889048051; 
 Wed, 01 Nov 2023 18:37:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 83/88] target/hppa: Improve interrupt logging
Date: Wed,  1 Nov 2023 18:30:11 -0700
Message-Id: <20231102013016.369010-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 54875442e7..467ee7daf5 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -258,14 +258,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             snprintf(unknown, sizeof(unknown), "unknown %d", i);
             name = unknown;
         }
-        qemu_log("INT %6d: %s @ " TARGET_FMT_lx "," TARGET_FMT_lx
-                 " -> " TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-                 ++count, name,
-                 hppa_form_gva(env, env->iasq_f, env->iaoq_f),
-                 hppa_form_gva(env, env->iasq_b, env->iaoq_b),
-                 env->iaoq_f,
-                 hppa_form_gva(env, (uint64_t)env->cr[CR_ISR] << 32,
-                               env->cr[CR_IOR]));
+        qemu_log("INT %6d: %s @ " TARGET_FMT_lx ":" TARGET_FMT_lx
+                 " for " TARGET_FMT_lx ":" TARGET_FMT_lx "\n",
+                 ++count, name, env->cr[CR_IIASQ], env->cr[CR_IIAOQ],
+                 env->cr[CR_ISR], env->cr[CR_IOR]);
     }
     cs->exception_index = -1;
 }
-- 
2.34.1



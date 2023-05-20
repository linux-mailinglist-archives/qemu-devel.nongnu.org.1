Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FAA70A91D
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:29:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PPp-0003Yp-3Q; Sat, 20 May 2023 12:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPn-0003Wr-8G
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPk-00034U-77
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae4c5e1388so43575155ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684599999; x=1687191999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wi2bOWjMyVLEFUf4QBGubplY21YXqeLF4j5hewlIPc=;
 b=NlifBBE1Sa6pTUAOl4gfdmRW6vLX2I8IGs1+HiFEjYALEjk2ZZ+t2KUXd6lGZ7hQDZ
 EBknP+1txz5J7xK7VkWQ584fETgPX0yzmEz2hZFq7GDBepVh+tITghv81Bei7o3PhA9W
 O+C4DJCrcWg+KDdXZn1FUuS1SPiqo/gykqI4P7/UV+s0ud09xP37yPQggAqAb9jm+lH0
 KVMUKydJc05VUgNfN2ieVYHbOVoLAZNx8T7t9Z3w0GzthFLLgoweuRflwUI0fK4BbcvD
 yGy+TU3SusHeH9DiY+fMz3tX4qTsnknrsxj/JcKIkK2sbSAeHg3LVlHiLvzG1LDsqMfR
 3ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684599999; x=1687191999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wi2bOWjMyVLEFUf4QBGubplY21YXqeLF4j5hewlIPc=;
 b=fLHQBXyQ+/thsqQSvT+G2Klai/dOKiHOguJnA5wuO7OL533kdpwGI6t66W9X/0yWBF
 n/Znv0WCsQh7GahmwgOlD9BenSVaHGA6aSuLl58RkhZieNcXBubVzsSBJXBu42dHSu2D
 OeZjzWsrI0VqpBNQLZJ8iPdo7OHWjvd+AdfIDZ6Nt3EbJg8g9xJBVLllOt9jVM2PfhLx
 fAZ4yvZOcBymPsiQ6C204X+NR398Y1xI57AjyE7qSql8Si+nS7RI0KUn48kSZblMr0QT
 7gpCyOXTmZ4R67A04ITx9AJ8bNHAvdd2zYyqn0OxwdVAAc7/9H2iQcL6MAuN9O5aATIh
 Og1Q==
X-Gm-Message-State: AC+VfDwrIXfWqeniCJRC1iSu8YiKQPivar5T2mM4E8myX/Hf1NWZcj7E
 o7OcVBo+CaL1xSq4LNFHXhuYlwNldQ7LzWcVehM=
X-Google-Smtp-Source: ACHHUZ5RVziOdDETpVIxlT9TcloYozXSsQxTHMEmbhuaIWLiwjMVc31RpkmW1QkDc1fLjY1GRk+WYA==
X-Received: by 2002:a17:902:ec90:b0:1ad:e633:ee8f with SMTP id
 x16-20020a170902ec9000b001ade633ee8fmr7592178plg.32.1684599998981; 
 Sat, 20 May 2023 09:26:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 03/27] util: Add i386 CPUINFO_ATOMIC_VMOVDQU
Date: Sat, 20 May 2023 09:26:10 -0700
Message-Id: <20230520162634.3991009-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Add a bit to indicate when VMOVDQU is also atomic if aligned.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h | 1 +
 util/cpuinfo-i386.c              | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index e6f7461378..a6537123cf 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -25,6 +25,7 @@
 #define CPUINFO_AVX512DQ        (1u << 14)
 #define CPUINFO_AVX512VBMI2     (1u << 15)
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
+#define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 434319aa71..ab6143d9e7 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -77,8 +77,10 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
                  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
                  */
                 __cpuid(0, a, b, c, d);
-                if (c == signature_INTEL_ecx || c == signature_AMD_ecx) {
+                if (c == signature_INTEL_ecx) {
                     info |= CPUINFO_ATOMIC_VMOVDQA;
+                } else if (c == signature_AMD_ecx) {
+                    info |= CPUINFO_ATOMIC_VMOVDQA | CPUINFO_ATOMIC_VMOVDQU;
                 }
             }
         }
-- 
2.34.1



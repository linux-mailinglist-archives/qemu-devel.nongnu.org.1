Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107A70E9FC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btQ-0004A5-6p; Tue, 23 May 2023 19:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btN-00049C-2D
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:13 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btL-0001lx-6K
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso103255b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886289; x=1687478289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKNcUlS+jlCWq7+Fad+OkxpU1yvQUoyJQ2LbUV5SS1s=;
 b=cquaSiaOcprG0bGUsTM2Clzcl210IPOulVn5QWVWpeGSw0rBR939mu/P/pVyOkjx65
 S9q2bGIEIR4q8qEVK4ecWGBGhgqssj0IoFJUfBIYx1n/h7C9zLnIEudj5Ap5HdWRUtUv
 FuP1t9+ku/oYkLYO6P/oxIP7vt5W07miLNOitI6Uxpk013LM8nTY8cuGW24KXUTUt2YK
 +WiK5MuirP1yXHsIHesZdXno9df27Ts8QMCITro/4oq0c7KE7KDsL+T4P8IdoTq0T3gw
 BrdVYgQYNl23xflDElfDbeeuvun6WtfcEyzf4JqsXCuZmM4Rj1HgsLVCzwqieFjeP+Ug
 SA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886289; x=1687478289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKNcUlS+jlCWq7+Fad+OkxpU1yvQUoyJQ2LbUV5SS1s=;
 b=Rgo3zyR5VeImXyOFQ1ycD8CposYsg/tc6HXHg/0IHZLhYAWWWoIAsEo03FgN5U6eMN
 viTPpSzI/OwHw6baR9olPvyf5/n+UzQ9mSPx/zjBeER+L5SIirMEpnbX6YV0+KIu/ESp
 sRwiPHKs8y9ijdBIKgZ0H4c/QmYCfcr6RYRdDIEWpUAGhpmUliS1Ol7YV8mAymQ/bj5G
 WVWYhuIKKR5E+H6espGnSgFflyMlqLVw0NuDUBw9o9KW2D2X+cN5qUS8e+dN0k7b3Z8D
 TFgIpmeeI55XeahnFUqOMevezVwX3flqfmuHO2qX/tco2Dam16T0YBr6mCxnN2/OdJz/
 HSMQ==
X-Gm-Message-State: AC+VfDzqVXskb/nfhgHiLxNko/kXXCfyKR1C0UXOQ3wWWksflvl4PedQ
 pT0uIfpKEPygIowYtFHlGIIbxWM3GT1bEao+2jE=
X-Google-Smtp-Source: ACHHUZ65xfktdE82Q6Ql+MSQzmNm13mbXt349D0LMoi7x7zX8pESm7aS++a7LZl1Qojw4zgMoywAtg==
X-Received: by 2002:a05:6a20:9144:b0:10c:9773:5e6 with SMTP id
 x4-20020a056a20914400b0010c977305e6mr3346690pzc.47.1684886288781; 
 Tue, 23 May 2023 16:58:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/28] util: Add i386 CPUINFO_ATOMIC_VMOVDQU
Date: Tue, 23 May 2023 16:57:39 -0700
Message-Id: <20230523235804.747803-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a bit to indicate when VMOVDQU is also atomic if aligned.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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



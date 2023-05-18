Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B3707936
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVRv-00067T-Hd; Thu, 18 May 2023 00:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRt-00066l-4M
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRr-00077T-CU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae4c5e12edso12879145ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384863; x=1686976863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeLfr1x/hpOvqEFLAFvBSjcAQ68yDAXj5gO5I/OdT1g=;
 b=oe547tRIKHQD0ZJghgulV9NAl+VuChR174VYYFbqAPAMilpJRQYIHtUyR6CDWE/E76
 LxkXBBXn971der8EKRX59Mp+IPPmkXb6mvd/OUaHw8u5GVQL68HjSPb1xG1XKZmszjhv
 1/dBAOc569mpMSH/dgqMI5UWvU713dafd++p9y7HffAp7Q8d7wRwCd6wmWRQhvghSJAQ
 Du3Nkq2orVgAtEkHZrECMS3doLg+oL8nWYqUZT7mE5EBju1yYrYR2ims3JdjUk9aQRA3
 20neayq+7dKMExBJpMygx+uK6Py9s2ou8QBSH0onjqwfoeS9dK0QM2m0jg/rcBQckPjl
 DIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384863; x=1686976863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeLfr1x/hpOvqEFLAFvBSjcAQ68yDAXj5gO5I/OdT1g=;
 b=c8JKSwDRoe7TWjiFvGSTgmIG2/2qxcrufvVYKs8O6ywcBU3sACXwMXFNFtWZCSgS6Q
 dg2JXNgMA485jETNQGf67NhcG7B51LqNWCPUb6fk6yDOywag0ZfiLlkJHE73lD9rbpLe
 qlab+Wp34pa1kVXRcQQC4nhEOk3yymM5zWOKBGQHjXJ93TFyBChuc9O22hsVSmI6EefR
 ebk1RO8rZbOynEoY6K9Y8+/ZX9XEVYil/H22xl+b7yDflei0fb8CUpJgWMD0n7Y/Jttx
 aUp2XCMUgFJnMJkCzaR4LmzhzKoWOuqoe2ORe4mJh3xYmxYSkCCwIgmeYceC0pciACsB
 kq8Q==
X-Gm-Message-State: AC+VfDyi1hApK7yt+/n/dRhYNIe+l6M1WBEb5unsGDAcglSj5TumREyd
 uM7/r/ksEh3vshTUmUlivXLgsHIXMlCGEcGTrOM=
X-Google-Smtp-Source: ACHHUZ7dJtBHZsHkP4afjyfX+EPHrJJ0BIxYf3krNFtoxjnnJNWKMTDh16p6TGbQ4lOxIH/hzIg0vg==
X-Received: by 2002:a17:902:ead4:b0:1ac:b52e:f3e5 with SMTP id
 p20-20020a170902ead400b001acb52ef3e5mr1338000pld.43.1684384863345; 
 Wed, 17 May 2023 21:41:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:41:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 3/9] util: Add i386 CPUINFO_ATOMIC_VMOVDQU
Date: Wed, 17 May 2023 21:40:52 -0700
Message-Id: <20230518044058.2777467-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518044058.2777467-1-richard.henderson@linaro.org>
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/host/i386/cpuinfo.h | 1 +
 util/cpuinfo-i386.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/host/i386/cpuinfo.h b/include/host/i386/cpuinfo.h
index e6f7461378..a6537123cf 100644
--- a/include/host/i386/cpuinfo.h
+++ b/include/host/i386/cpuinfo.h
@@ -25,6 +25,7 @@
 #define CPUINFO_AVX512DQ        (1u << 14)
 #define CPUINFO_AVX512VBMI2     (1u << 15)
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
+#define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index cb9475c688..b72374362f 100644
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



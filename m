Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104B7A2DD0
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1D-0006Am-P2; Fri, 15 Sep 2023 23:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1C-0006AA-0B
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:50 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1A-00087p-Ep
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:49 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5717f7b932aso1697444eaf.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835047; x=1695439847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxYJcRT+ApT8daGSsr/KMFMBCHy6Uv2L7Z2orIOqHHk=;
 b=s+f1ui1BJ8K95+7G9F6gYuXfnZgrklTYEBcWfkNPWjZ771FEZ0omkHlKf5NUG0r3KQ
 RJiOGbmlRBlGIMZfaKxIxQ3AUZAAkzKizRXy3+an7JPvY3XBIpgiWk/kfwzW+CxJLWHq
 hGQkg82E9CPeJaPOT9gvqvnSaE3Fdo4DMDM5Vn+szAiGozlNOBan6ML/t8pPpjI3WTjJ
 tBVm96+bn+EkSCbQP2Nz49SvKvMUlHpVYwxuN2EmKmiEgdTGJtHQfEoreq6uNvO0J/rS
 dm/2Zcj1U7iEM+LC9NCZot+UMXsz0H8LAo1y3h995fwB96R8INYR8+SVJxCDoM4iHGFI
 aIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835047; x=1695439847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxYJcRT+ApT8daGSsr/KMFMBCHy6Uv2L7Z2orIOqHHk=;
 b=RSw5Ffap0W3Tu9nhTiSQH4Xe7St+ezEgqoxwzgsUD6jaEzyBaqveuk4Db86Wku+v2G
 qdtGauBsQN+EHqMjRG95hjcs/FEL4t14RZ2CEXGtoFhrzpNRzFBS+sdekOsucxhgnpHy
 jlFfCGWfD0N8bu/mgBfYmo1EHZ/VX3+pzPFOgveSME430o8oPKfHl+UoXrEOL5WmZ8N9
 RDym1pH8/10jR+lx5uyONh7rUQ4Vq/etkFONbGlpkR9KCXW3ndMEvCB7UYYMH+9S5zU4
 BEe08IRMdOqYP42AQg9/ywOFpY86HSUcrHcrVgavyIXXLWxye3j4OMjOEWWymSwdrfC1
 4qbw==
X-Gm-Message-State: AOJu0YwQ+GxWfIoghHP1PyH3hi+pk1KDL+SN15NYxMZw2je9F0/LG7Yb
 RwOR3QztJdAUykjrTfb0zBmgGbKVayAnuCMP0V4=
X-Google-Smtp-Source: AGHT+IG0FPkcEC6r/OEd2+sQsrIpjwLSNZn0Teb+saRG+WuLDHI3MB4qrR1LxXokxurqJXgSMKUb6Q==
X-Received: by 2002:a05:6870:2422:b0:1bf:4f5e:55e2 with SMTP id
 n34-20020a056870242200b001bf4f5e55e2mr3998518oap.53.1694835047071; 
 Fri, 15 Sep 2023 20:30:47 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/39] util/cpuinfo-aarch64: Add CPUINFO_BTI
Date: Fri, 15 Sep 2023 20:30:09 -0700
Message-Id: <20230916033011.479144-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h | 1 +
 util/cpuinfo-aarch64.c              | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 769626b098..a59c8418d2 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -10,6 +10,7 @@
 #define CPUINFO_LSE             (1u << 1)
 #define CPUINFO_LSE2            (1u << 2)
 #define CPUINFO_AES             (1u << 3)
+#define CPUINFO_BTI             (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 7d39f47e3b..e11b76491c 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -13,6 +13,9 @@
 #  include <asm/hwcap.h>
 #  include "elf.h"
 # endif
+# ifndef HWCAP2_BTI
+#  define HWCAP2_BTI 0  /* added in glibc 2.32 */
+# endif
 #endif
 #ifdef CONFIG_DARWIN
 # include <sys/sysctl.h>
@@ -57,11 +60,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
     info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
+
+    unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+    info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE2") * CPUINFO_LSE2;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
 #endif
 
     cpuinfo = info;
-- 
2.34.1



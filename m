Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC58B12E78
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Jul 2025 10:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwST-0006us-5q; Sun, 27 Jul 2025 04:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPs-0004Zr-Nl
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPp-0004v7-La
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:31 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso31849945ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603648; x=1754208448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttkkqJwyeBJ9IX9rZE+f+UWiZ+lSEPmZ2iQQAJpTW94=;
 b=D6TQ9pkblBJm2KKWsiKyEEB3GjafG6+6t1zDw3XtRqUpiGBJtYnRsgepGY2RMbkut+
 RPtA08HrHnl2Vanxn5LSq0Jrb1nCBYZHFYvjYujkuqm6he+7yyPnP9YubB/804u+Qgsd
 1kWZRIsLdh0fixhKryTIGL6fsQ/TryXl+++zYYOBUnxvSxykDoOc6vfpNyFVPx2Hv8Xx
 jOCh/2mSuhjMaqvIBQSNrvhUvTVFBEFpVLUSPcUfg8HWa2kwddC72ve0BOTCohu0HoWE
 QYKO5O5T4bn6DyP7b7WECvOXF1Knaz7gOMBbk6QYuxX1+6X+ze2bjwcuB4wuNF4YMfRU
 Y/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603648; x=1754208448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttkkqJwyeBJ9IX9rZE+f+UWiZ+lSEPmZ2iQQAJpTW94=;
 b=K92WYCwcDZl1EaP6QKYM/5gc4kmAHq4uLJiWJXh/zgje/iYBG5LLY1fJhNpJrS9QIA
 yNrYL7yiYqjygTu3bepFrBxMpfWXQZUI2kzfVN5iaGp5fP7xjFkKcPqMklbGJK6Kxg0b
 AwWD5pfYGcpJeUt60eEvZ1thY1yKd4LHeuJhCKWKPrzOHSO+FtbJBcb4BRlE416Oa1Ht
 Znb5k3iBRNpg6AvyZuJ2B9aSO5pPYiALzjJd7zZFPruvxxYyk3h60mA2L9Py5ZOVR1wr
 +K0AYNT4whyG7CECX7WxL2Wr5O6KimWBTr4auRsMCI3daRgyu+ZrBxKdagDdsg8NE+Qe
 QQ2Q==
X-Gm-Message-State: AOJu0YxbZpln5iEXLAa6eOlpaiUc4AJE8tVmhKeSSlQed5H3ZMdrH0gA
 TKk9MV0CPzsA/y6BZcRVjlq5rPNdKH4QVLrD5/UY8rVNViwugXy25uAONXs2lgQTY/TPuEK9uUr
 3/yS2
X-Gm-Gg: ASbGncvPoJFDwigN2ZlcC0C8oZTLqLNdUD3WJjxhDXwxSTDOcdyBK/x9IJ1QgwzN5c4
 sa+a3MUlfYEZWeA6bLImAFhlmflcPjYiy7Z70sLmWQkXCozThZ6nP2DCloJNHxQ0j89DZ0evLCz
 VKVyEHb0KYoTjwbU0PbugbWHICwHVfNuNme/Qyp3on4zd9sptmFEu6HaUopBnjXHgj1tKCHp3xb
 KLWSJAJ+3dDbQvOqLkWcMRjN8OtFj/aAVVZkC6A9/OF49KVDfnsPZ4d6pQv+/KzDEfj9Fgy8J38
 fRVpgxS2Lhg+0pS+UxeG8LK0DHFmmuuj+OnJeox8uvICuVPikGt8d93iJwvGnDlLW9pCxq2ifem
 5yrYjiuXw1vtbO5XBxiR+LS6TIgw51191JaFjBeYnO7BROX+M5ldLU+wKVLBShOn4NgOxObZJEn
 5XuHEgpuuzVg==
X-Google-Smtp-Source: AGHT+IHY+Ei+C0Le24QEZiwIk+aLUKXjm5k1X3rMgGPUrNCzC/ftqq/o7bTOisG8Z+n8sTet5krJLw==
X-Received: by 2002:a17:903:22cf:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-23ff707feaemr37067355ad.17.1753603648050; 
 Sun, 27 Jul 2025 01:07:28 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 76/82] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Sat, 26 Jul 2025 22:02:48 -1000
Message-ID: <20250727080254.83840-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd..e509ac1032 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7e9788abfb..00ff51c883 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,6 +89,11 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_ILL_ILLOPN;
         break;
 
+    case EC_GCS:
+        si_signo = TARGET_SIGSEGV;
+        si_code = TARGET_SEGV_CPERR;
+        break;
+
     case EC_MOP:
         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBF82164A
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3y-0004cG-R3; Mon, 01 Jan 2024 20:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3w-0004Sf-5X
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:25 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3u-00077M-Ki
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:23 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dbdbf680d6so3213197a34.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160761; x=1704765561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UM3G3JW9WxcLT5Dzb3w4vT9giwKkE+uVqc4Wz3d/fxQ=;
 b=JmG/eE9xS4jfimcftYUo7w61UlVwPRi+yzdC9gArNjlg2EM/XBQB+YGLbKcbtkskl9
 JXrEfywIQIhWs3nwxZWiGYTi9jeCptG0dYedLgFUZ8YyuLHkr2LhQqetCRHYDIZ+aSqg
 42zMxwvltjih5PKXnqzhPLpwLqN59d0Uk7dLnLE8xYcgN/3KORQAcVB9PNs8qitLz6ZB
 z5iZgnIv3jpMjknnywEO4nLno+fP5OVm7TvYfEmeCjbRH3fuGX5uDwrIT/8tNOGdd/kB
 YJ/h0/eS5GbF9cnFL9k8nnu9GFRhGlzcOnKZrZzlAXwU6DPT21LoUpZ+95btYPqw5bd7
 Igiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160761; x=1704765561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UM3G3JW9WxcLT5Dzb3w4vT9giwKkE+uVqc4Wz3d/fxQ=;
 b=S4fKHbZyBklG7Z8/5YrjUq3ISuy8J96m4O/TQQR0/Igb3nu/zZ9NdtixPKczRvlXAo
 rIEtAhLh1fMtgLSn88A3UHqZvFZIApDmO1OgUFdEGX+sTEW3hW34XIKY+mspkuVHyBJ8
 6/57kFRfBbQBSVTSwbJ2TVwtlmx97Lmn84E4Bk8yKq6mhBr3F+LzUwTcLMuHpMs4dygk
 4A1hirDgd62OUinavk8QhQUV40Oa4EeYtm0T2h6AtI8vCdS29S70LSiNmY/vcSEtz/j7
 x29b9sDmMqFGbSeNNiTT3TP0Okw1NQZYTNV5GNxxLUWMTH4m8qiLm3XJOEo7JW7okpWW
 ar/g==
X-Gm-Message-State: AOJu0YyX+GBg+a8EznqALmhI+CuGBJD/xg0/EO+y+v7efcSvtCs+FfUQ
 HJVXTBv9sz6QhAzSSmHVcTjnKuZWoMJevvIXEiL8RBt7FSw=
X-Google-Smtp-Source: AGHT+IHM6swGndq9IOkuhVAJsq033Gtk1O84E17zQVSVAfy+dy7TEEhX4NG1dANepxXORvt6CP+Eog==
X-Received: by 2002:a05:6808:13c5:b0:3bc:1169:d467 with SMTP id
 d5-20020a05680813c500b003bc1169d467mr1140810oiw.65.1704160761612; 
 Mon, 01 Jan 2024 17:59:21 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 33/33] target/alpha: Enable TARGET_PAGE_BITS_VARY for
 user-only
Date: Tue,  2 Jan 2024 12:58:08 +1100
Message-Id: <20240102015808.132373-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Since alpha binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu-param.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 68c46f7998..c969cb016b 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -9,10 +9,22 @@
 #define ALPHA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 64
-#define TARGET_PAGE_BITS 13
 
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
-#define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+
+#ifdef CONFIG_USER_ONLY
+/*
+ * Allow user-only to vary page size.  Real hardware allows only 8k and 64k,
+ * but since any variance means guests cannot assume a fixed value, allow
+ * a 4k minimum to match x86 host, which can minimize emulation issues.
+ */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_VIRT_ADDR_SPACE_BITS  63
+#else
+# define TARGET_PAGE_BITS 13
+# define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+#endif
 
 #endif
-- 
2.34.1



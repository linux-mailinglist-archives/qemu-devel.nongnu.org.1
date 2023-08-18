Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC078116B
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX32e-0001Fi-V0; Fri, 18 Aug 2023 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX325-0008Pa-05
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX323-00088N-GJ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so9674595ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378786; x=1692983586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UM3G3JW9WxcLT5Dzb3w4vT9giwKkE+uVqc4Wz3d/fxQ=;
 b=ZJqAMs62dxfOFUdRMgJhDC9NDpT+tox6sTixb3P7dzJMiM3+3AOzn0VSBnvzJDVD4n
 tjvpiIww4h9yYjli9rMxcnXKw7g5omkkJnmtNLrdMgNIifLfLqUzlXQMfuqoP/pnMMWw
 hZYtboIFCji5P1F553x5IUf7mV2+56Pa8xC0ZrcjwqxKgzGnQcuGzhp3RBkHIqegRUeR
 PqHpGFb3BdVmyd5dEe5FEkgpFIds4qNrd8qkHOVzlmLx8VSNte1uy0GbOQiCIW3IfDCH
 lp2gOoXzs30PCwAUVuF9DeLP6spOvmy8Szm9d+n3tn3OXGTgREMB5FQ4QoYq7EPX/lqv
 +xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378786; x=1692983586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UM3G3JW9WxcLT5Dzb3w4vT9giwKkE+uVqc4Wz3d/fxQ=;
 b=PiQ9YMz9gxdCgYtPSAZdClk7RTHNpCr5bgysRs6wPhRNm0Aw88qoTnbrXBjqY1Bg2L
 VXuStDZp2ESlq6/l1KP/p1popYkVTsRpR/9SnRm5IOayS65JL6A5AqEzvgdpsbGxrsqg
 2HDJ+myz9a55H+ScdnjhsQdMlEjblpdjbtozCAyyLnHogrX/nEoIQ+Y5MMp0V8OFlQ1V
 elryymOGlcMmJ+r4DDa7bP2mI4Jl35V2BXmPbVZH+KitBQm/AIhDWxccoOF99YOTGr0u
 VErk2D+QHhya3OjqH0lr7s6tMf2e8W2k4iB2fW0Tk7rFGYB396TUMM+UeIloPlRmuiRq
 /nOA==
X-Gm-Message-State: AOJu0YyMhSgoml9rihhJs4j9Uov/pqrhUf6MjimE4n72Ey0UuKjaD7ZZ
 R7B98hgazcadcQIYvdBd9/CFs6mY1MepH/ht0JQ=
X-Google-Smtp-Source: AGHT+IG8/UJfKbduZUjlh7/5/idHc8CmiyX1TtoEU9nESiP1YhNqpwCButQN2R7sR4KPkiJFi99kcQ==
X-Received: by 2002:a17:902:c14b:b0:1bb:7d2f:7c19 with SMTP id
 11-20020a170902c14b00b001bb7d2f7c19mr3143140plj.64.1692378786282; 
 Fri, 18 Aug 2023 10:13:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/33] target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
Date: Fri, 18 Aug 2023 10:12:27 -0700
Message-Id: <20230818171227.141728-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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



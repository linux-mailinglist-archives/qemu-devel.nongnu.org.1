Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25180705825
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0fc-0005q0-1v; Tue, 16 May 2023 15:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0fM-0005mi-8a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:49:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0fK-0004Lg-NK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:49:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ab1ce53ca6so529945ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266537; x=1686858537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zI9fsHzivwwTbDjNnN4jTG49Yza6ytpst3ZQDVjthU=;
 b=g6JdDYWasT+SIIL3iUOf4qecqUOOxw5eor5KoNaKhzOZucpwwe8BcEm8NDVYutp01X
 HRtBv9bILLXNvOS4px4PRwM6Q+lNSElbcqO3O2Yb8DFT2d6pU8Ykdp/Im69aA0lxZ56R
 tPRsSO1XwWmKCCgbLCX8IcSTIITRY/zdzENzKnDGKitTbQFdVdXoPVO4BLf0DGO6cTmt
 T2L73lMFNfQaP//bZJa6AXy1TxmDibED5Kn705WqlsMy5CzgAqkQBmq/2RcaFHleyuqn
 RFO+9+mbbUWHwI9JVeG/qpwO+XB15F0NQLqtJcmr0o2cOugml7hB/r7UwOG1Vt4b2+yB
 a9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266537; x=1686858537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zI9fsHzivwwTbDjNnN4jTG49Yza6ytpst3ZQDVjthU=;
 b=k41tp4HjDUvVZZ4uZJTx1c2qff5US3fPCf5Oaz1PqsNOM0lylbOMbcJlrbb44J60rK
 WscPoUaioQIIBm7Fb8Y3E+xNmW0AJvQmKv+psuDuqIdEW3x7u0DaKFPCvbuudxRAlXdn
 gLb3J6DzJOPqsvEasxAHgWm3m44gtNMpbLWIS8DFYrYW4R3jS1QoWC4Qdr76cARKV+Qq
 TbCXaru/TK0Geawh/EcOBokWERKxJKgbw/JNhRhxvOe1tnBakwIna0v6hqH9FyEgbRvy
 pcKWsBDjeg8md4ya7WWAcQmwxcTKOZVJZS8qxlPW8cl8Rw/6oLiJBvvEou9M4NzJNh2g
 l7fA==
X-Gm-Message-State: AC+VfDweEDmxjQI01gnGSzpGyXhYNRkvD7tEZ91TONDs1NLpyxqMX6HZ
 4S1l9pxmSRn6PnvshNHz/W02nzMZmMgac1aB1mY=
X-Google-Smtp-Source: ACHHUZ5n93r2llhLSSBmJRyDSqYOvDGlb/QtpwHR8VYOtIyEsYrJ7z78OG073PPoflmbhmBekD2LnQ==
X-Received: by 2002:a17:90a:bc88:b0:24f:13ec:ecac with SMTP id
 x8-20020a17090abc8800b0024f13ececacmr37937326pjr.26.1684266537122; 
 Tue, 16 May 2023 12:48:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 78-20020a630351000000b0051815eae23esm13843233pgd.27.2023.05.16.12.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:48:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 80/80] tcg: Split out exec/user/guest-base.h
Date: Tue, 16 May 2023 12:41:45 -0700
Message-Id: <20230516194145.1749305-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

TCG will need this declaration, without all of the other
bits that come with cpu-all.h.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h         |  5 +----
 include/exec/user/guest-base.h | 12 ++++++++++++
 tcg/tcg.c                      |  3 +++
 3 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 include/exec/user/guest-base.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ad824fee52..78d258af44 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -84,11 +84,8 @@
 
 #if defined(CONFIG_USER_ONLY)
 #include "exec/user/abitypes.h"
+#include "exec/user/guest-base.h"
 
-/* On some host systems the guest address space is reserved on the host.
- * This allows the guest address space to be offset to a convenient location.
- */
-extern uintptr_t guest_base;
 extern bool have_guest_base;
 
 /*
diff --git a/include/exec/user/guest-base.h b/include/exec/user/guest-base.h
new file mode 100644
index 0000000000..afe2ab7fbb
--- /dev/null
+++ b/include/exec/user/guest-base.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * Declaration of guest_base.
+ *  Copyright (c) 2003 Fabrice Bellard
+ */
+
+#ifndef EXEC_USER_GUEST_BASE_H
+#define EXEC_USER_GUEST_BASE_H
+
+extern uintptr_t guest_base;
+
+#endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4bd598c18b..6735d3f08d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -63,6 +63,9 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
 #include "accel/tcg/perf.h"
+#ifdef CONFIG_USER_ONLY
+#include "exec/user/guest-base.h"
+#endif
 
 /* Forward declarations for functions declared in tcg-target.c.inc and
    used here. */
-- 
2.34.1



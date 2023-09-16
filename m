Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F77A32AB
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3B-0005Dm-IS; Sat, 16 Sep 2023 17:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd32-0005CN-4g
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:52 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd30-0000UO-5h
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso3072258b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900509; x=1695505309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L57IbzicfHSbjnc3l70Se432e9VtllXVMLzXjtVZVVw=;
 b=nc7R5hiaFyZNwmvGTokFUd6P7B64GtaPdcVcmtF14YtTt8uxwOX87EBxdaAYlU77W8
 oVof0RV/Omitz6e7EFKdsQus0Ui+Udk1o711DM0OEXqLkOUfmQHwYzB5Df31DrPXXCIa
 iBZ+F5MC8J8DiQy5j0teTUwhLln+l6u4kR9U00seylSypw4H142JldJBPlkHQrOSNJm1
 QXMb9THPOs0Na13mT8YYy+PvSpebMf9XL/Cx8xzpNNX4IgLsX1jMw46fVY9wcA1JnU+C
 3AIUPv7uO5Gxz23MWVrqj/Fomh4NcYt/OOnqCUHL4mdVROOwussqQ6hwVYZ38AOk1Slr
 NuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900509; x=1695505309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L57IbzicfHSbjnc3l70Se432e9VtllXVMLzXjtVZVVw=;
 b=kbykshWaZH6SCG/xblLnPszSgylQfcKH02iz4NPE60awwd97u6Z4GQspiIw8tyC/iv
 rNrXl7KYHu+lNMmNjkhZpEZ2jpzprIVILkMfY1+QfJEV7uG3EMo3j0rS/yBB9cgjdWsG
 Ww+BI42GB5DBOnNTBLEnQ1Dj/VTuwrXgv5nnyqfTBKnyS6zlyC3wJ5qOSSPK09BXy+F7
 5I+p0GnxRByoHvzWNSIZTZCHSpv2Uu9Yq2vckpimvG5XyM7rm9IzN4E0UppsbFARorhi
 nFv/fqUj8ji5LnjX9xeQQXUF5kXFDYa184RePaWl9muCl3eIe+Za1kKCvwJawz9booyj
 iAsQ==
X-Gm-Message-State: AOJu0YwQgLA+MfQrgIIzZMef9kKFd1HqE16SN6o1ZC/wlPnby/1YPKU0
 c0baQFvxs+njq6r6bl9kgKAX+CBGKzb8/BWd8t0=
X-Google-Smtp-Source: AGHT+IFp30Onhelc6IqAUDaYE+UV401FF4q0u5mYT4dBKWIYT33JRHjy4y/0pu8qMm+eLnH9P+/u4g==
X-Received: by 2002:a05:6a00:14d5:b0:68a:5197:619f with SMTP id
 w21-20020a056a0014d500b0068a5197619fmr7130185pfu.31.1694900508859; 
 Sat, 16 Sep 2023 14:41:48 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 24/39] exec: Make EXCP_FOO definitions target agnostic
Date: Sat, 16 Sep 2023 14:41:08 -0700
Message-Id: <20230916214123.525796-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The EXCP_* definitions don't need to be target specific,
move them to "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 7 -------
 include/exec/cpu-common.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b37715c27d..6af7944a38 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -26,13 +26,6 @@
 #include "hw/core/cpu.h"
 #include "qemu/rcu.h"
 
-#define EXCP_INTERRUPT  0x10000 /* async interruption */
-#define EXCP_HLT        0x10001 /* hlt instruction reached */
-#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
-#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
-#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
-#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
-
 /* some important defines:
  *
  * HOST_BIG_ENDIAN : whether the host cpu is big endian and
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41788c0bdd..360b8298a4 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,6 +7,13 @@
 #include "exec/hwaddr.h"
 #endif
 
+#define EXCP_INTERRUPT  0x10000 /* async interruption */
+#define EXCP_HLT        0x10001 /* hlt instruction reached */
+#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
+#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
+#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
+#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
-- 
2.34.1



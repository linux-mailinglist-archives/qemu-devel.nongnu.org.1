Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC77D1AF0
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4am-00076Z-P0; Sat, 21 Oct 2023 01:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ak-00075Q-EY
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ai-0008L9-Tb
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso1417887b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866323; x=1698471123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xd5Svu0+B7OGG++QiM45a02WgNYRHjpbrT0y5ShkAgs=;
 b=xADKhV2VxELIpOxFHCoqr4/QenlP+2qUPaSow2rcsfoiD8xwZozUIqsj4YqiAVueMY
 hHjsmNPV5EX6GhtAbw8siUrNA6OBsqHYx46BQjpP05UWeLnTSOClF9jlJpXR2KUv6dyp
 sXvXFadZ5ETCC2XUZmwM/xFLyVZ3cEWrVB+txu+kxGIh3ATJMyfYt18NI1rqmAn7vzd4
 9nuKWr7am6sDtbEGucWej1vCYWa8d6jR7BxWtF74t2hj0z5XVO0VRsUFEx9o+iwKParD
 rZJAqHvTnzkxKLSiZOCfGX9MJseAkIi8HCnvvRt/n3jha9quRxjjUH+LVEIbwwn2LQ15
 niRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866323; x=1698471123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xd5Svu0+B7OGG++QiM45a02WgNYRHjpbrT0y5ShkAgs=;
 b=SY4rjRwCrD13KceL1u7mn9xoGM1H9Sae7WWZdkF3BZTZHM2C0mb4yrIh+eX8ZLWIVn
 8aqbPOFqYFTelv6Egnt+F/4wXk64ei0tFAOC9bIfAzDNHEc8GkcHoN+miqqyDGPpja74
 Ikv6OjL4oidYrVaoslKwI/BJWhQqpi4vXUv/GkbgOwQLrocdu6JKXzVi0ME1v3deMu8D
 fyJ0oRjpXUYPiu8keGp+0am7F13eZ4054O2sz7fQDSmM/lQvDg8VhXa3CNk67CKXIyXp
 /qvXAEXjr6Ija61QdugOMh3XaNsNTJ0WThlW/i7WnLJAlHcLtEFrakNJeYucYmk9ObLA
 Junw==
X-Gm-Message-State: AOJu0YyDtZd23v9oNTeX/UZFBK50jrdlo9xeneH9Gp7wtzBR6hS7Tbs5
 x68D9m3aggOVEdOmrLizUdrIjqMr0F5YKrUDTjI=
X-Google-Smtp-Source: AGHT+IEOucCXHTjDOSCaljYAhV+9yRV1jRNcMGhx0ErijvCO+UOH2vrlVb7MDjXvjvl9tQsu4u7wQA==
X-Received: by 2002:a05:6a21:7882:b0:137:74f8:62ee with SMTP id
 bf2-20020a056a21788200b0013774f862eemr4712890pzc.18.1697866323366; 
 Fri, 20 Oct 2023 22:32:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/90] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Fri, 20 Oct 2023 22:30:32 -0700
Message-Id: <20231021053158.278135-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Always use TSO, per the Oracle 2015 manual.
This is slightly less restrictive than the TCG_MO_ALL default,
and happens to match the i386 model, which will eliminate a few
extra barriers on that host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b3a98f1d74..9fc5c401d2 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -6,6 +6,29 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
+/*
+ * From Oracle SPARC Architecture 2015:
+ *
+ *   Compatibility notes: The PSO memory model described in SPARC V8 and
+ *   SPARC V9 compatibility architecture specifications was never implemented
+ *   in a SPARC V9 implementation and is not included in the Oracle SPARC
+ *   Architecture specification.
+ *
+ *   The RMO memory model described in the SPARC V9 specification was
+ *   implemented in some non-Sun SPARC V9 implementations, but is not
+ *   directly supported in Oracle SPARC Architecture 2015 implementations.
+ *
+ * Therefore always use TSO in QEMU.
+ *
+ * D.5 Specification of Partial Store Order (PSO)
+ *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+ *
+ * D.6 Specification of Total Store Order (TSO)
+ *   ... PSO with the additional requirement that all [stores] are followed
+ *   by an implied MEMBAR #StoreStore.
+ */
+#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
+
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #else
-- 
2.34.1



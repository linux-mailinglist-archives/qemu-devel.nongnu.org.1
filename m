Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179917D26FC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtH-00075c-7w; Sun, 22 Oct 2023 19:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht7-00072r-TR
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht6-0006hI-9o
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:41 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so2724751b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017378; x=1698622178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FzEYXMiYUmAnzQhyJLC08QhIql51EYsnrwBv94uD9o=;
 b=TcuWPii9aXBmmnZ1dA8K8kMzzZelRyh2z/mzEgh3d61YuQiBgu09AlrbJYSKjVdV6r
 PQrZNoioyMXl3SGLADCkROC+Xbc4+xgNWkzq2pcfzY1iqjdAL4skAxC7Tjw5Jc1cvoL4
 8a9nSUTPZLDgpG+mtbUL2l+C3oyCIiegXuCmLnDsYId+INAJ8Ewf8WNrM92iL4ex4/3r
 atVYHLYRh8X/0w3dnp+FMcnoQoMcoWVHcm1W0sGZTSjeD2n0Y45rlUqYnFpgaZwhi0Vm
 swnAVFPzmiy2OVyYs9pQ8+LNI4hsc9YOY+X9GMGm7Txo7I7POq4zHUnhBFylfWGihec1
 HOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017378; x=1698622178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FzEYXMiYUmAnzQhyJLC08QhIql51EYsnrwBv94uD9o=;
 b=TmdTV86uJcPcJJRiXI8te5EAiuPM2KHd3qrwwU7Lsqd+s4+fmHidazQlDbfLQpPj4d
 QozRW7iPwvmfC6gEEGR+l+CyDtFouQ3ZdniRSb6ZukzeoiLzGSKCGwUS4Y5J8IGYR8cX
 1JUHmiaPy+2Q0ZTnE8I7deDCeWsus/OlqxpgJsApoYXIF6ZcyyqXugO3q1DogXwk+QfN
 GI9z87nKkO4Nsqr2jR1GMd4B3vyAsl9tQPuK+roJAEqMfkl6zus0KXUIOF7l/5AW09Rm
 JW0ICn5ylkdHMpKwcpdUrRdziog7W08oypwx0+/P/xDiY8mbOu/GXpL5dHPug2GCdaY8
 4kOQ==
X-Gm-Message-State: AOJu0YyCEIRSe2DsrIi+ognYQO9AliX0f5tJPtFUonUB1TfwC12fUg+h
 QA1cCbx/9IDUSQhheUeCciPqpLYriYn+EvmUBoI=
X-Google-Smtp-Source: AGHT+IGESRMQ12G/p8QLk1w0K+vegqfCBMOFq6sU8RUd90CsliOgxuuU9Xo7pszk4jICYb4KKuaHog==
X-Received: by 2002:a05:6a20:e107:b0:158:143d:e215 with SMTP id
 kr7-20020a056a20e10700b00158143de215mr15071887pzb.1.1698017377769; 
 Sun, 22 Oct 2023 16:29:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/94] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Sun, 22 Oct 2023 16:28:02 -0700
Message-Id: <20231022232932.80507-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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



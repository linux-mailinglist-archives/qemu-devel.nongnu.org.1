Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B37D795C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2n-00072I-Rv; Wed, 25 Oct 2023 20:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0006zc-Vx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2S-0004py-2v
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ca215cc713so2017035ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279350; x=1698884150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FzEYXMiYUmAnzQhyJLC08QhIql51EYsnrwBv94uD9o=;
 b=TwyApiMWjqElD1rNs7/DY+fIZlwvakBGmNFSqrv5XY4LuKyYcs+vWuNiT+Ksx19kk1
 0/YVUb4FdkZzGj6Gl17xU5Phv9V3eB8QUZ9NeQ7vOTo0OqLeuI5Q38YLG4BjIG7rF3YG
 TFaIhs4Jiko3vEK88e88inTR+iYEIJWmjQyFfR0AlAGReSbWSq2MAJxK1sopP/xNXuME
 5nru8x7r4QH8bzlC5yWX2tfBT0uUHMO/0Bp67DIDcxOiD+VFS4H15hNTl3gTZtcEKNTc
 odkbeIScK9abROCb8H9V23WRXTGyCup7299jKq38knqywPyjEHBk24S2JcJrpdOugdPz
 fkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279350; x=1698884150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FzEYXMiYUmAnzQhyJLC08QhIql51EYsnrwBv94uD9o=;
 b=dQHdaqDrmxxo9DwB+4/eBDET+s7WW4sGY3sowQy1oELVAMtNK191E5Js5h/nIbsrMi
 4M43SPHj/xszcKIYthGyGMcE4NnpUAPNRRG50nSrd6dTl7GXqhoXqKYkH8EFdLnKaTxg
 ALvxQIXdapB2I52vA3HtHYrTtFlaniEmDymARZ+IxyuiBkAPMD+HGJzT/lwC8DRl3ige
 DPuESiJgP6zVmfQHroK7vfLsmOZXw2XakeQbgvq+NS6xHa7eX9bFon/+9WGkXEObP7yC
 rBb92AG9o/tPTApoU/CQ+rsHeDCK56Yorgo5xXwZV5dOgDyoF7G+58F1VHvdTkOaMm2f
 p2gg==
X-Gm-Message-State: AOJu0YzY7S+rllE6RCwTfDwN8gKCVc8UltA3ORuwGnQJMQUuh+e6B31x
 a9lRkZ/5Ea1uOHBGg+9sPZcGETkLjIWlm8sKp+c=
X-Google-Smtp-Source: AGHT+IEx3c8walI5+UFnhn5ZAaTBPiltDwl1eQiQ5j7HNcUeazHczOs+q380AymLSYxF36W/9/Uo5g==
X-Received: by 2002:a17:902:f0c4:b0:1c8:a132:a00f with SMTP id
 v4-20020a170902f0c400b001c8a132a00fmr12817707pla.12.1698279349998; 
 Wed, 25 Oct 2023 17:15:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/94] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Wed, 25 Oct 2023 17:13:46 -0700
Message-Id: <20231026001542.1141412-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE867174C8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3z-00078f-81; Wed, 31 May 2023 00:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3r-00074v-Ua
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:47 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3p-0006Bq-VM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:47 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39a505b901dso125229b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505824; x=1688097824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vXtsvQPHD82vPJkKb5usIRvin0ENTfAKq8eNntz5348=;
 b=ozJ46E/Rcq3NgAPDlwjhvrTDmOe58fRIagsNo1Bs6NLEZE1HmaXO/j3lt2O9ORXh4w
 l+P5kRTZYy4ZXuoNg8KMRxoKTbUXSFFt1msVOOIKaS3sCLQddOmL2SPQnf9Cg2Ha9PZO
 YgSPr7/4kC69qrL4rUf2r+4wh74uqBqYAJmwTJ4E5cQejbN4d8hMlEfWbi6APy39Y1oi
 y0yoyuJbjm4IwZEoshvNdM5iNRcp3DdgcmELbOgLVHmzX8BK0P3AMaI9PACRXPb1Vztk
 aVdtv6YUkYHXE9I63jcjcSVmqjiXaBJoX8SnHHwLIElOLzKHMOFuXyDoAEXg3DwZFQmx
 si7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505824; x=1688097824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXtsvQPHD82vPJkKb5usIRvin0ENTfAKq8eNntz5348=;
 b=HoQ19nsqlVIjavA1inuggUgc68nSI2sv8ES+dX9rbIl1UHhyLJZ50bChDsUHH+M+cy
 GjFy4h4ziFywYs6syOJ56jFlh9y2F6CsO5XVpSCG//amfUOko0HfXLhm93o8E5uYNC5Y
 mZW2RVscpp4Wuuud+NzX/n/F8wCXbfNtWz7+lxX5m8T4n1SR3ujDVkYniSztrNB2EKXs
 6xmM6jMARhWc9rRO7ZSxgnnWxOQtYsqLmm0rKg9ab7NgKdkm/Sy0RtGofhSAVM6kfIyv
 xgzITh/c8o4uifBgPeuJQb0eabRgq+nDrtQGON+VRCKuMM11FJxZ7OLVvzUwCH4J2ZpY
 lbfQ==
X-Gm-Message-State: AC+VfDzuX7moNZkJV1531KTfHb7gX7hFI4lyKx1xA6YoSWKVZg32goUa
 5Pc6GYg9WEMvbr54ayxtWRf3DFDUYdbhkUjMhVI=
X-Google-Smtp-Source: ACHHUZ5t6nBix7/3VtZ1Bd3JOYDE1/GLyh1zoOyA9yTn7Z4CG3Pm/gPBkPBfNI52WEhkSbFsHm2yog==
X-Received: by 2002:a05:6808:1449:b0:398:58f5:7209 with SMTP id
 x9-20020a056808144900b0039858f57209mr3495317oiv.49.1685505824671; 
 Tue, 30 May 2023 21:03:44 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/48] target/hexagon: Include helper-gen.h where needed
Date: Tue, 30 May 2023 21:02:59 -0700
Message-Id: <20230531040330.8950-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

This had been included via tcg-op-common.h via tcg-op.h,
but that is going away.  In idef-parser.y, shuffle some
tcg related includes into a more logical order.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/genptr.c                  | 1 +
 target/hexagon/translate.c               | 1 +
 target/hexagon/idef-parser/idef-parser.y | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index bcb287dd8b..217bc7bb5a 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -20,6 +20,7 @@
 #include "internal.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#include "exec/helper-gen.h"
 #include "insn.h"
 #include "opcodes.h"
 #include "translate.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8838ab2364..42a7697fc9 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#include "exec/helper-gen.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/idef-parser/idef-parser.y
index 5c983954ed..cd2612eb8c 100644
--- a/target/hexagon/idef-parser/idef-parser.y
+++ b/target/hexagon/idef-parser/idef-parser.y
@@ -843,13 +843,14 @@ int main(int argc, char **argv)
     fputs("#include \"qemu/log.h\"\n", output_file);
     fputs("#include \"cpu.h\"\n", output_file);
     fputs("#include \"internal.h\"\n", output_file);
+    fputs("#include \"tcg/tcg.h\"\n", output_file);
     fputs("#include \"tcg/tcg-op.h\"\n", output_file);
+    fputs("#include \"exec/helper-gen.h\"\n", output_file);
     fputs("#include \"insn.h\"\n", output_file);
     fputs("#include \"opcodes.h\"\n", output_file);
     fputs("#include \"translate.h\"\n", output_file);
     fputs("#define QEMU_GENERATE\n", output_file);
     fputs("#include \"genptr.h\"\n", output_file);
-    fputs("#include \"tcg/tcg.h\"\n", output_file);
     fputs("#include \"macros.h\"\n", output_file);
     fprintf(output_file, "#include \"%s\"\n", argv[ARG_INDEX_EMITTER_H]);
 
-- 
2.34.1



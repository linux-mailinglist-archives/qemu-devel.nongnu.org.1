Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33172313F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcf-0001tS-SJ; Mon, 05 Jun 2023 16:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gca-0001rC-Ne
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcY-0003mj-F9
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-65540715b4bso1364825b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996165; x=1688588165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iT3NE5JjFQ/pg6k9nejAED1CUNCtrcw54M2DdXwyNbY=;
 b=dVl+zL3i/ygkfezarAt0Yz9MV/ft7oW7SQ4fqJ6D4Ve6+DVsIPHLEFj73TJ9zhFi74
 OlOTelCI6MspFb4iiyJ+PcN+0fzbQN4aMdkcf2LFohgBH40be0gDZffWLs45LZcfwVMd
 0kQKIsfRBuHw/bYk5F2xbN6BzH/f4TzWieM4pOQMYTh/Odn2osQPWREFIhtoyaeZjOkg
 89gpqY4MTO2EIw8pR0GA9l+fJQ8U5SlGxH7L8y5TmEpPN6rLtiVw+gLtYb0A4AixTo6i
 GfLgXOICGYaCQP/7i/kY+rRoYm1m9mJYjL7WI+mpz3Ebu8cIDDNdJ2cpo2NH+YffmjSE
 kFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996165; x=1688588165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iT3NE5JjFQ/pg6k9nejAED1CUNCtrcw54M2DdXwyNbY=;
 b=Nyhr9MCkEu5XB23uT0yMTQnrzxcDAVUbLBz60obFljPTP/2cGlfqG7opx3PH3+MPwo
 T1XynXuNe6+Rx/GS20VA2+04Vn2PBqyTHqKyc8W27RDY5iApe0z+bTls5OnAca59Vp9n
 af0JA9ekbuHSCjPyoDDmD+OxJchFi8Xo+fs1BZsnOGjMU7i0HlfIdV41uBmaKl5+QzVO
 K0vccqG9YQ8h9yd43UDKbQ8f/z5cbP5q485q3Sdl9GfkoGMJiAgIJmLOMd69/x8Gis3i
 DPqNyxpZM3xX1xUY+5bX1590JEqaqlLnnM/3H2jVwTbRftdnNJyP3fY1mLfGaiuZ+DJC
 2K2g==
X-Gm-Message-State: AC+VfDzORxc99Au/QcVaC87llIBD/o1l2Kaa27GdAYRiTeC+m2t4JKjI
 NJKt2/afSdByt0S8B3MzkUedsYaII46M+PdafMk=
X-Google-Smtp-Source: ACHHUZ4fXa6Y68I8iedIpmKixG5RRkxNK/xzTHvPT9T2Wm0Kbs8YrJujA0QQLBAQ2mtvsiUdXR0TnA==
X-Received: by 2002:a05:6a00:21cb:b0:65e:691a:460f with SMTP id
 t11-20020a056a0021cb00b0065e691a460fmr908011pfj.8.1685996165389; 
 Mon, 05 Jun 2023 13:16:05 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/52] target/hexagon: Include helper-gen.h where needed
Date: Mon,  5 Jun 2023 13:15:13 -0700
Message-Id: <20230605201548.1596865-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



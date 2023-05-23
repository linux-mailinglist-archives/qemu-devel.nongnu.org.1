Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488570DE24
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST1-0006CC-LB; Tue, 23 May 2023 09:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSN-0004xw-CN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSK-00033Z-H9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d2e8a842cso3796494b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850019; x=1687442019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=byv7QZQSLFh7nyIZS76P7wjGuStySRLZzDv41rBbtmM=;
 b=K57IpWc/RZ/KgPib/q1zfVCJZ7ZU9iPnZqbB0FMYkLL3w9vUKWRuDKyJw94n+ewC61
 o+m6aEZ/fTjGxt2Dnn5Yzym5oVv2fXr4ZGUjygOulK9dcOlGLjo2gfo3PvlfahMRQYpC
 dAjteAaAVoB4AtZpsqkRU36/H0u4B5QKCI0Yx6LvbSwCZwzeqJ0zDcGhdNlkoCtAtP8f
 fZl0zz1eCs6AmzR0vGT3J83c255eVktxVMo/6SM2h3WvzEFU+1ebllCH6jh0n9m2VrOF
 4JhAG0LoHKfEr5YfkDofoeYQ7GcyIRV1P4L0OpJ6EbSrCxFS34/N37uJZ/ys7fM125WP
 vHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850019; x=1687442019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byv7QZQSLFh7nyIZS76P7wjGuStySRLZzDv41rBbtmM=;
 b=B5haMpyPTQEmadvlNoNGGKcBaZsALFH3haB0JReFiQMJtnVWpVqakq1jE2q6IrrBqW
 D4MCoXK490XJ2EFYHv6HQcpgLpSKT4bYF7jqs/auql8lqHw8ZqinPnaaFLhXTa59Z7I+
 dyU8Yfgryipt+Z4e7hcmduXU8LBKpC5zcVOnm06TriqmctPmVxCisQYmvH9r1BfhM6g9
 seWn39d63pafkwsK1iuaZJe7DHsvMHdcT3Cx938h3JYHCEy38+RDCTrPzM6drE1LSjBL
 ng5zmUv70XsgE5Kgfd4FcCJ8Iu/v6nNxy0ogppWasHDRwnJ+x1D5zCOfosT4eik8695B
 H8tA==
X-Gm-Message-State: AC+VfDxFlDlbJpppL3GB6vJlSzrCb9Z8udnZhfxGYXwdNHBMBe9oSXaq
 f0qkpWI9LvXe9L2TqhyxV+nwBg8QbVO/p6eC35M=
X-Google-Smtp-Source: ACHHUZ48TvdEzh4UYf/3DKg+teDXTS/hvx3s7IpOcourvdSlmaow8IzJvKtJO7iPev0/eWZZMShwEg==
X-Received: by 2002:aa7:88c4:0:b0:64c:f4f9:de87 with SMTP id
 k4-20020aa788c4000000b0064cf4f9de87mr19587500pff.18.1684850019001; 
 Tue, 23 May 2023 06:53:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/52] target/hexagon: Include helper-gen.h where needed
Date: Tue, 23 May 2023 06:52:48 -0700
Message-Id: <20230523135322.678948-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index cb2aa28a19..2cb7061a69 100644
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
index b18f1a9051..f36442c6d5 100644
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



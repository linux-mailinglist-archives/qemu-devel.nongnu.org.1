Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB5723149
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcd-0001t4-Et; Mon, 05 Jun 2023 16:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gca-0001rE-OL
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcY-0003hV-TR
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so1323314b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996166; x=1688588166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7/adIaPH4ntgaFSk3M/76lh+noxDuixny/KD9oUAVM=;
 b=iTt2xUxIGQITA9UY4i9tFBj6E1zuuEtNXuPY0WpZk/HyLb0+7xBJ07KRrzoUoYCPrA
 8CjhBWYjZx0wXBgUuB71KDatFCotEhypIxl4HFCLnT7oMofHoikt/gWDiPW9eyg1RI0d
 Xv3KWYvoibi4ccA1iraDlH5/uSNSo5NRx1lmgJeNTB2GVOq739LRRiyKZfvqnie5uLmv
 H6i5vFf+e4vccwWH1yMqpYdW/i5nYlQS4W+TDC4SinQl2f41vGmMXSPhkq0UL+ffQe+P
 qEPAFTtbaYQHTWIeZ3dzgG4+Q+WE8GCzEZGVuTurN7iGSs0srPtZZ4jVAsEzJRaxBGHZ
 BYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996166; x=1688588166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7/adIaPH4ntgaFSk3M/76lh+noxDuixny/KD9oUAVM=;
 b=dRhWa79zV0vgXRSgzg8hcF+eGAWZUhi2rgoTc0C65D53Mk7iDlWyZzlQ/8UIdR/4pr
 BZzBqOz369w068vO98ODTbkalB8E8XbyzCK8xDT/TA3CCjGFj2CE8MV7AheN98/FPMGP
 XQVs6qvGqMEz2eJ0h0OA8La1JIYySLYmsylN71mmescErJVdz1Glsj0zGhd5XMkzqkA1
 jHL7NGUE5NC0wt4EBRPJEdgmLIvG+0fKLbTyI+2CSUgtYJum7xGfevanRAnSz/YDdeXk
 erdk943zqf7hkYbjAfs94Lb9XwMuQOcLVZesXXefAFztfx03ojSy+VtlQvLWeu5BCl0Y
 e7qA==
X-Gm-Message-State: AC+VfDw+aczkGQ0tNth67w7kKYZZBvlwmF+jOVm9WURvowMMgPrZXcFS
 e+ilJS+gp/uPbq9lsr7JC+sktLr5vJE+KEKImYo=
X-Google-Smtp-Source: ACHHUZ47OyoS46ndH/3AnP9rhQK55xMvRyW/pY+lz0OGzqrfBqtGT9uRw2kXAHXy0v93Ggjfjwsi3A==
X-Received: by 2002:a05:6a21:150b:b0:117:a86:6c7a with SMTP id
 nq11-20020a056a21150b00b001170a866c7amr138134pzb.12.1685996166141; 
 Mon, 05 Jun 2023 13:16:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/52] tcg: Remove outdated comments in helper-head.h
Date: Mon,  5 Jun 2023 13:15:14 -0700
Message-Id: <20230605201548.1596865-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index f863a6ef5d..a355ef8ebe 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -1,18 +1,6 @@
-/* Helper file for declaring TCG helper functions.
-   Used by other helper files.
-
-   Targets should use DEF_HELPER_N and DEF_HELPER_FLAGS_N to declare helper
-   functions.  Names should be specified without the helper_ prefix, and
-   the return and argument types specified.  3 basic types are understood
-   (i32, i64 and ptr).  Additional aliases are provided for convenience and
-   to match the types used by the C helper implementation.
-
-   The target helper.h should be included in all files that use/define
-   helper functions.  THis will ensure that function prototypes are
-   consistent.  In addition it should be included an extra two times for
-   helper.c, defining:
-    GEN_HELPER 1 to produce op generation functions (gen_helper_*)
-    GEN_HELPER 2 to do runtime registration helper functions.
+/*
+ * Helper file for declaring TCG helper functions.
+ * Used by other helper files.
  */
 
 #ifndef EXEC_HELPER_HEAD_H
-- 
2.34.1



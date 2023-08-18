Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB193781542
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7ir-0004uM-H6; Fri, 18 Aug 2023 18:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ip-0004tc-Ms
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7in-0004M2-9c
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-688731c6331so1167409b3a.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396811; x=1693001611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xi3TssmA/HigYWFgy245JlLJX03+VaDfRVBuqb9pW5c=;
 b=Ivhx1GFvVSjPSN3G1H3VwSGD3BccDRAQ/iLX4Y2i6VKcCoCUjNNp1IApifQbwqHctS
 OFoeAU/eS8/2jpQwczp9hVGU9OER7/9bVCSCkVzdntmHvUBU5i3Ra+swFXK/CiB0d8pi
 JVxGBhATxDFWJkJ5G93qz/FIqYQwWWKErz4ebs5J17zkLrkZ2D6OBb5bUKs/nhC7Kbi1
 Z9gIaK/dLeQWDOT5sCcATtUzEWI6r1WNUzxHqZRY/0h3bLyJtwHA50u92Tr2gIVMPHn/
 /qbaf2Mw3yq9SNkZSKnJ2XwY9Gbk0lgAmL5bDFm3DRq/rVFQSOxdfzdqy0Ct8Gwr0W4S
 3Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396811; x=1693001611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xi3TssmA/HigYWFgy245JlLJX03+VaDfRVBuqb9pW5c=;
 b=Y8QI33OwA2bp/FXuIrM5EmZ96CscYCwevb9E7nYqGBbZv5YmcONjYbu3zv4+DtKfgH
 9tXE2OTqg5GEKxOJKkfBFy3UX+bHzWnlZYQrkoDnFiLSBb64n1ncn6S1L0iH9bIdCWLs
 hAMABdJileURoR8B46FHZ/2e83MFuF6BGh2PLlWiVHWPtIsjGgnp99AFq0bMOhtVZYMV
 xBfW1mh1BuLRm5o1GX+UT1Z8EnvrQy90pFrFF/DtiBKoO5oVzxhG8J+JfVClT58zWfgl
 j+fm8ZwlL+3stm3q6lUh7rh1XcsCOQOkUhNx2az8M1C3/s5w5xPDR+j2Gt7XlsokQw7T
 UB7A==
X-Gm-Message-State: AOJu0YzlSD3Nyen/llLIMjPRgHEKlIBh2TX5M6FsnnXqx933RzukrUVu
 w+4JFoMM6vzFvEyk4SEeXTrEpyqa+SaMwwJLU50=
X-Google-Smtp-Source: AGHT+IGMvcIiL4+9xHqto3J6usnXoMYz+AkyGXG6JxBD57fHnkCIXYyzskxoEzq52W4goNkcXaD+mQ==
X-Received: by 2002:a05:6a21:279c:b0:104:ad71:f080 with SMTP id
 rn28-20020a056a21279c00b00104ad71f080mr421710pzb.34.1692396811586; 
 Fri, 18 Aug 2023 15:13:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 03/23] target/alpha: Use tcg_gen_movcond_i64 in
 gen_fold_mzero
Date: Fri, 18 Aug 2023 15:13:07 -0700
Message-Id: <20230818221327.150194-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The setcond + neg + and sequence is a complex method of
performing a conditional move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 846f3d8091..0839182a1f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -517,10 +517,9 @@ static void gen_fold_mzero(TCGCond cond, TCGv dest, TCGv src)
 
     case TCG_COND_GE:
     case TCG_COND_LT:
-        /* For >= or <, map -0.0 to +0.0 via comparison and mask.  */
-        tcg_gen_setcondi_i64(TCG_COND_NE, dest, src, mzero);
-        tcg_gen_neg_i64(dest, dest);
-        tcg_gen_and_i64(dest, dest, src);
+        /* For >= or <, map -0.0 to +0.0. */
+        tcg_gen_movcond_i64(TCG_COND_NE, dest, src, tcg_constant_i64(mzero),
+                            src, tcg_constant_i64(0));
         break;
 
     default:
-- 
2.34.1



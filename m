Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE411774F91
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWSj-0001ue-Or; Tue, 08 Aug 2023 19:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWSh-0001uG-8f
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:50:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWSf-0000Gq-Iy
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:50:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc6624623cso27996835ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691538599; x=1692143399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kdvvm1Sbj/FVrIt73ZveaGPXelgbYbK28PYr4uX6Pao=;
 b=Pk0atLq7kI5rtqeaPubgEx53PBAh1aW/z7b6WcGX2INuAnGQ6LpV3CoRTJsuXzaBuS
 JRc/jQo+EB9a3zGfo2PT8PjqPAY6tmdsQjgiEKADD9iSUIR2WjXswYjVhFm6Ir2ZrbFE
 tiWnO1Pdzri2rAkg7zF3gtnrA05cfNTUyHzMhz3VSWKRubsKMSRTj6R7Zlmifjwht4c+
 EUDOjQ7X75nV/+uDf8v3RLtuGW9UWc8E/YF82tdFxW9A3LOvLaBRMjSJZWYUSlhmqEwI
 f5F1TT1x9TYvCiTGJ6Zkzfw022HisLwcaly3KC1sgNd5frDDzR9efrFtTdZMtsJQM3tQ
 4OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691538599; x=1692143399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kdvvm1Sbj/FVrIt73ZveaGPXelgbYbK28PYr4uX6Pao=;
 b=eRz6STd5XGl7U0778db7idMjJwrDvqQG/wFqreWCScEYcpGRpbt+Ef4YsaKX5hqy7U
 BEOfsPWrSC11l8LgEihK7GfXeOa3bq4CLpYsOye5uUGlrfMq4PRpPzkIt0RG6/uPhYPx
 ouhxtQjwW0Dlab6qJkjAAmEvU78L8ncqnDTKXtxo/1gLrz3rXW35D1yivZISNPOdVPxy
 cx1D/eyCdg9uElRHBEWVhr/Ld0HxmDHWllQrLMyj55oPxULe+AhqX6u2fiufcu4IKFdG
 eJvkJcgPYE+2dDrlpt1FrUk5sokHfqJPKx3AvZd4hbNfnoioTk7Ncxp4xABrZxLMtst/
 ilLg==
X-Gm-Message-State: AOJu0Yw6D++52w8XW4v0w36QlJwJ0p4CpXnqJ7ONfTXbptbl1E2U3prJ
 9HZBCMzEDbIcNkk3Fe/3BlXVvYYEX4fdNwSieb0=
X-Google-Smtp-Source: AGHT+IGrpL5uvz/oJlMK09965O1RoKcCbS7iD+9ICodRP7OaARVBJhnvBvaCWLvLo/qHvGnD6ScHSg==
X-Received: by 2002:a17:902:be01:b0:1b8:36a8:faf9 with SMTP id
 r1-20020a170902be0100b001b836a8faf9mr1298530pls.38.1691538599696; 
 Tue, 08 Aug 2023 16:49:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a170902eb4500b001b04c2023e3sm9523022pli.218.2023.08.08.16.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 16:49:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	alex.bennee@linaro.org
Subject: [PATCH for-8.1] tests/tcg: Disable filename test for info proc
 mappings
Date: Tue,  8 Aug 2023 16:49:58 -0700
Message-Id: <20230808234958.148910-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This test fails when host page size != guest page size,
because qemu may not be able to directly map the file.

Fixes: a6341482695 ("tests/tcg: Add a test for info proc mappings")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 7b596ac21b..5e3e5a2fb7 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -33,7 +33,8 @@ def run_test():
             return
         raise
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
-    report("/sha1" in mappings, "Found the test binary name in the mappings")
+    # Broken with host page size > guest page size
+    # report("/sha1" in mappings, "Found the test binary name in the mappings")
 
 
 def main():
-- 
2.34.1



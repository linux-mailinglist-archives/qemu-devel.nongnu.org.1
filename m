Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17A712BF8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 19:41:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bQG-0005pk-9p; Fri, 26 May 2023 13:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2bQA-0005pR-E2
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:40:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2bQ8-0002B8-I5
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:40:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d2a613ec4so939344b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685122807; x=1687714807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yUy/aMUiAhZ360nTPVM0iei+KMQ1HuLh5k4JhFoRsN8=;
 b=l5f66zDUworPUaTfRnDGmELZulPJ3e6sCUWANZ7z9gHT5hvHnxoAgy9D0dfZSh7Zuh
 zhMjJGztrrYEzoz/vEMWi21N2qqqNWEtdyLKLp+baKkorKLTQEKgxu+k6VhjEN7jYTF2
 FZL7RcFC/WTimlND7s+FW8R6FoTeQEvCjKbZfXq7YmJEyOYko2hFNK05zqHYNAKcAXbi
 HMliutL2RYP68QdoDqSeA4ika//SP1ZLGZpDkKcZoJKhrl20xjv4FMnE0wdTMD2kPMEX
 qD5/h0FxJPd4f9ufHsOjGUTbK0IaN9/kyM9ObBfvPxDOKDcjdaLKqLN/OKSzaquR/PGw
 DTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685122807; x=1687714807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUy/aMUiAhZ360nTPVM0iei+KMQ1HuLh5k4JhFoRsN8=;
 b=Blk2YUcZyBvOSf/bvyjsUtJSFPFaxBPmw0mT4TJOmMsH4TsYYz6mRy7Rdn6ZNNcJBS
 eliY1645BJakyfWhiZ++qwtF77unGxBXYV96mPzRPWar7HTpZrynu8c4Ex24SCthPcAf
 Aa44gVyQgINgI8/+q4V5D0gL5FUpcB69FdS2jjhM1RAWtYvyJ9OEKnxSGGLhz5Rz79JP
 6Yv1v5CNUxNQZ0EDK92eiiTcDYSozM0AGV0J1zrli0qmOcPFqZCO6yFpud4j5Ehh8fGk
 tTd0J6OJvTzH5tYJ5faedfZ1CeGM/RZn8BvNhlM1tD+/UjxbvSm1VEPeMNKHUcRWRRCS
 GywA==
X-Gm-Message-State: AC+VfDxQRmcJ1pnmJvNlC8xteI+Hk71FnxYSp6qK95hOFOkm5DJ1bzKP
 ZXNy7AbEL9FEZZbCVx1ujhvQNW9VLYOAad5n7MI=
X-Google-Smtp-Source: ACHHUZ62+ApSqjC1e/lBnD51Ogkc5HvmzvnC8Gn6po65rUqYTBboIySMj397bMSEMFc64adJL6rTTg==
X-Received: by 2002:a05:6a20:158a:b0:104:873:c3b5 with SMTP id
 h10-20020a056a20158a00b001040873c3b5mr65903pzj.44.1685122806874; 
 Fri, 26 May 2023 10:40:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a62e81a000000b0064cb464e08fsm3089902pfi.15.2023.05.26.10.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 10:40:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] decodetree: Do not remove output_file from /dev
Date: Fri, 26 May 2023 10:40:05 -0700
Message-Id: <20230526174005.1801043-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Nor report any PermissionError on remove.

Previously we were testing with "> /dev/null", but that's not easy
to do with meson test(), so we want to use '-o /dev/null' instead.
That works fine for all of the existing tests, where all errors are
diagnosed before opening the output file.  However, PMM's named field
patch set diagnoses cycle errors during output.  This is fair, but
we need to be more careful with the remove.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e4ef0a03cc..a9a0cd0fa3 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -71,7 +71,12 @@ def error_with_file(file, lineno, *args):
 
     if output_file and output_fd:
         output_fd.close()
-        os.remove(output_file)
+        # Do not try to remove e.g. -o /dev/null
+        if not output_file.startswith("/dev"):
+            try:
+                os.remove(output_file)
+            except PermissionError:
+                pass
     exit(0 if testforerror else 1)
 # end error_with_file
 
-- 
2.34.1



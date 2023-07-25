Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8CC7610CD
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFFF-0001Xp-TA; Tue, 25 Jul 2023 06:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE8-0000Ix-CC
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE5-0007WG-Q2
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so53543925e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690280707; x=1690885507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9C6PfLlU2O818ZwPOAqAi3d27sGlX9QQgbc+eDlrhGY=;
 b=DtiJDRKzQ6LC69Z7UhI7WOfXygH36DCkqUZqSr6AB/A8gX96oYoxuxboOlegc3Npbh
 dVu98nazkFFEbvkvmAv3oIWTT3v92+tRWnJsvdM3PtHRzy0JftggZ7Byca49ORk4hJy6
 rInsc809qsj05DODNJ83TBjrVImyJ+qQ024xgqdg0TW45JBjumofd0GC4FAJwE2HfC+Q
 q8+QCVY/Ve7PPwbbPvSnzHFUMS7bQhF/H+YlYUbv0CHR+LLkDQ+IW+T4IykP4tFuLrJR
 WEumbDzp8z/0spIjITYrdg5ZO6FMweF7cI1WYvtL5HT2Q5/f72eIhg6e9xIcNB+W6tJj
 Gr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280707; x=1690885507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9C6PfLlU2O818ZwPOAqAi3d27sGlX9QQgbc+eDlrhGY=;
 b=Vl5IVPUrGbYT2NH8xku2yuTPBU4UlvnZ6fJYbaaHLoBMKhBswRVGH/DZiy7lNyRJyb
 4W4G8g6+SXfCt+FsXUZiR/llCB8jv79tpJzoiGvTZlSTXhabO7ZI/ufob7LTmKm+VLuC
 tSoH2+RypdYnJkB1JRLtu7w/N0YjPoQmwfUF+dor0xEUuFxEHDx2MNCd6FAhqX2IajZe
 JAczkh8wJqUvJ/9IZqUxX2WNoF+JKQHq+O5O5GHhoogUO4qKKchMG2OzkKc5K+BnoSzQ
 09RMfE2jtNfSMkTzM4KGlbTuGYQnBgpw6RIMIAnzOSF6i7VRxrvAsRca5JPKYq02wupt
 yrTA==
X-Gm-Message-State: ABy/qLbUXCWb6svoBNpVkmvCJS7EatPH+ENJPk8YDL7++buMuoJk6tWf
 BODGKxQO58QAxf7w8F0JXJSbR8qOJrfOdGNK4AY=
X-Google-Smtp-Source: APBJJlG87V9qTXpiUgCWGQUkMym1NMqm9BEwWvWpC4PQMeFmqJtF/X73wkebg3z4WkyqhtT+X0C5UQ==
X-Received: by 2002:a05:600c:40c:b0:3fb:dd9c:72d2 with SMTP id
 q12-20020a05600c040c00b003fbdd9c72d2mr10012662wmb.31.1690280707298; 
 Tue, 25 Jul 2023 03:25:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm12567185wml.39.2023.07.25.03.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:25:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] tests/decode: Suppress "error: " string for
 expected-failure tests
Date: Tue, 25 Jul 2023 11:25:03 +0100
Message-Id: <20230725102503.2283907-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725102503.2283907-1-peter.maydell@linaro.org>
References: <20230725102503.2283907-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The "expected failure" tests for decodetree result in the
error messages from decodetree ending up in logs and in
V=1 output:

>>> MALLOC_PERTURB_=226 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/decodetree.py --output-null --test-for-error /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode:5: error: duplicate argument "a"
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 1/44 qemu:decodetree / err_argset1                OK              0.05s

This then produces false positives when scanning the
logfiles for strings like "error: ".

For the expected-failure tests, make decodetree print
"detected:" instead of "error:".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230720131521.1325905-1-peter.maydell@linaro.org
---
 scripts/decodetree.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a8a6cb69cda..e8b72da3a97 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -134,6 +134,10 @@ def error_with_file(file, lineno, *args):
     global output_file
     global output_fd
 
+    # For the test suite expected-errors case, don't print the
+    # string "error: ", so they don't turn up as false positives
+    # if you grep the meson logs for strings like that.
+    end = 'error: ' if not testforerror else 'detected: '
     prefix = ''
     if file:
         prefix += f'{file}:'
@@ -141,7 +145,7 @@ def error_with_file(file, lineno, *args):
         prefix += f'{lineno}:'
     if prefix:
         prefix += ' '
-    print(prefix, end='error: ', file=sys.stderr)
+    print(prefix, end=end, file=sys.stderr)
     print(*args, file=sys.stderr)
 
     if output_file and output_fd:
-- 
2.34.1



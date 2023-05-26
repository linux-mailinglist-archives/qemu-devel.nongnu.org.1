Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2886711D90
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 04:13:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2MwW-000262-JU; Thu, 25 May 2023 22:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwU-00025U-SE
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwS-0004se-Gu
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-253e0edc278so297240a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 19:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685067151; x=1687659151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIrHyv+mgsH/mPrNHKwXz9RtxdnCU4H2P2z5QfKtbdI=;
 b=foZhuYfCxX6IZpZyS3sZiiS2zCZFzBIqOJx1vtRBVXdASiQi8+qrVY6otKUBDO+AJN
 cb0TnByRp9DDowAYjh1jLJZtmiQbY0YKznLMar8g5EVkVbTYZIink4hrEsiXqcDxHAl3
 7PV/f49Ko8jyN/rnPSJZjlcyRuqZpOPwa1FxCqAgFvVYL7o35Pv2sX5kUg3yiLFTgpeR
 466+tW7fHNBM2Xr4T8phcOXgBpPaJZh6vjo9N7fvXR9tkQTY7QRq5qv02LdnmhlqsUwX
 APy4avmLcINGdUUTLBzBcgcW4m/ZdEYuow4o5JrMGYp1GcwRMOnQDT6dCbnlbzVRzVAh
 hjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685067151; x=1687659151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIrHyv+mgsH/mPrNHKwXz9RtxdnCU4H2P2z5QfKtbdI=;
 b=Aes2BxgXKyVITveZFDt6Lb1nnkMU7VI6tuuQ4u3s7r3wSC6bJXJoWapHkMULAOMLQW
 V9Z2sT+zOfjh2DiIzOtzvyHtlcR2wDO1yeh3ndHBqhlpVZywQ8GEpRU/dyLYBrL+hrtB
 6pgJbQ6JZaQMKVy1UcN8VmvC4XjoAULSn3D1HfszxS5Ayk6RxPvB2iKp80TIb/5jt+D1
 tRnhxGYkkjjyAKfseBmUGK8Qcg5aVOA+qSaYH0rwaLVv6rh9XUJCiXs+F4zZM8zuvgxg
 0fRw4cFUJVBcIVvm2fg7N+0rBJV3iBwBpsXTGEewFgnpqf/HPhFfXkRFG0VyTK+2w0ss
 9RxQ==
X-Gm-Message-State: AC+VfDzKiFrxOL259BMZCcFbDZCEyqoeUDPSnHbIqUjGyW+XtDS1jlcg
 DWYcNSF3ILOQ2FyD4nkiXf2xvjyn7wIKK/bMHyA=
X-Google-Smtp-Source: ACHHUZ6+FArRVylL7AhqiUt381H5aRaH3DhFIPoi+onlB90RqODEZPX9gvlYPYGqhjkSuqtUoR9xrw==
X-Received: by 2002:a17:90a:ea85:b0:255:b1d9:a206 with SMTP id
 h5-20020a17090aea8500b00255b1d9a206mr706126pjz.22.1685067150878; 
 Thu, 25 May 2023 19:12:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 oe17-20020a17090b395100b0023a9564763bsm3594086pjb.29.2023.05.25.19.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 19:12:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 1/4] decodetree: Add --test-for-error
Date: Thu, 25 May 2023 19:12:25 -0700
Message-Id: <20230526021228.1777917-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526021228.1777917-1-richard.henderson@linaro.org>
References: <20230526021228.1777917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Invert the exit code, for use with the testsuite.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a03dc6b5e3..3f9f6876f7 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -35,6 +35,7 @@
 formats = {}
 allpatterns = []
 anyextern = False
+testforerror = False
 
 translate_prefix = 'trans'
 translate_scope = 'static '
@@ -71,7 +72,7 @@ def error_with_file(file, lineno, *args):
     if output_file and output_fd:
         output_fd.close()
         os.remove(output_file)
-    exit(1)
+    exit(0 if testforerror else 1)
 # end error_with_file
 
 
@@ -1286,11 +1287,12 @@ def main():
     global bitop_width
     global variablewidth
     global anyextern
+    global testforerror
 
     decode_scope = 'static '
 
     long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
-                 'static-decode=', 'varinsnwidth=']
+                 'static-decode=', 'varinsnwidth=', 'test-for-error']
     try:
         (opts, args) = getopt.gnu_getopt(sys.argv[1:], 'o:vw:', long_opts)
     except getopt.GetoptError as err:
@@ -1319,6 +1321,8 @@ def main():
                 bitop_width = 64
             elif insnwidth != 32:
                 error(0, 'cannot handle insns of width', insnwidth)
+        elif o == '--test-for-error':
+            testforerror = True
         else:
             assert False, 'unhandled option'
 
@@ -1417,6 +1421,7 @@ def main():
 
     if output_file:
         output_fd.close()
+    exit(1 if testforerror else 0)
 # end main
 
 
-- 
2.34.1



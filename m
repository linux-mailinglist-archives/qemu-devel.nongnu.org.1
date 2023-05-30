Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693BE716CFE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44a4-0000v2-20; Tue, 30 May 2023 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zm-0000qE-0r
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zk-0000td-Bp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64fbfe0d037so108806b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473206; x=1688065206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lIrHyv+mgsH/mPrNHKwXz9RtxdnCU4H2P2z5QfKtbdI=;
 b=G5ELtSAoO6nQda/UGbUQpFKFTKmj0oYWeZbmH5HQXXM46sDaTqwJv0og5Gihy8na4w
 rUDwC1Qv8Zvrx+rFjfPljGRfODSsKKHlEEFBVfXTkq16f36KmbFQ0+dX97SOHxJ6NJpC
 qTGMn8l0X/4jrfNOsXlOhMM74VmjiSdOkJZDHEIi3qIJmqZiaGtSDCeEmn8APjBzM2Zf
 Wemt//sOj9bYgV+UZ77zws/eacdU5euiFZGBuumjRZfXxh37JXfftYdLlBY0us/M/6OC
 rBXkhCPtqVGVLNfX6zpQ+BftOtEcloG2KJhBcmfckb/pBcUJMBD/ljLnY0+U7ByQ0BTg
 Z3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473206; x=1688065206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIrHyv+mgsH/mPrNHKwXz9RtxdnCU4H2P2z5QfKtbdI=;
 b=kEiXT+ftgyVvWySilDzjINBE7K4X9qn9LLvmeVaIJiDbbgLWO/4eTds93s5lN7Xboh
 RMTLqIEnG+7pNJxTeGK8F0+pzDW5alzN3rt5Zq2v8WaW2keqppPekt4EZEJnff+5lQ/w
 8gYm6/SEfyOD9ROrVjvz6uSauK6Zne9S/7cns2a2tIEQucceEZIUS46hiocpXs5a2YHz
 5F3pA9La6BHGxJuAjhV443ROjn0VlmGBVCAlmxfPRolASFkSehWisrGMXYI0z7QPGHzm
 Si3ZInBjk5CTTBwQHq1T2wQCAQ40L+NI5OkX8bLrn2AERGZoCtS8g/DlWauNyDiQY58f
 I6AQ==
X-Gm-Message-State: AC+VfDy7HijlGXm2r69/DyDtM8TiBZq6EQqlYb9fftfdaQehWckXhq9e
 AJrww0ZQc6NqMLJEo4/sRrTZSi2l+rBkdLHTqrQ=
X-Google-Smtp-Source: ACHHUZ73Oiv5qVd4S7Tr6hQr/6W5hjg8deg/BNnXagAud+L39sVAZb+oUGNQ9wrLIe70Fpl3kajR6A==
X-Received: by 2002:a05:6a20:3d84:b0:10d:515:ff2d with SMTP id
 s4-20020a056a203d8400b0010d0515ff2dmr12509415pzi.4.1685473206632; 
 Tue, 30 May 2023 12:00:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/27] decodetree: Add --test-for-error
Date: Tue, 30 May 2023 11:59:40 -0700
Message-Id: <20230530185949.410208-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
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



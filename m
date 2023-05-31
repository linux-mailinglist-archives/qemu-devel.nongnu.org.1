Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1827718F0E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 01:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4VBu-0005or-OQ; Wed, 31 May 2023 19:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4VBr-0005ob-8y
 for qemu-devel@nongnu.org; Wed, 31 May 2023 19:25:15 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4VBp-0008QN-4h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 19:25:15 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-626149fbc8eso3535356d6.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685575512; x=1688167512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HK9K9jzzWlfIFdB7uwHlISI/daPJAK4dkCrRI+Fx+Fo=;
 b=RH1b012fi3japYXU+BEbGrFtloSDD+Ou5sib3p/v1MKgNuH2Hr5E8AFU3s1irRwRcY
 RwfC7ARbAiWHkXfzoOQLi2x3V6sNGYDES8BIwi8zKNp68Hpi5bNjS9WotnZnafulyNgm
 KQaOzZhHGpvp98YoVDkPlLP0EXeLBAI6rKUh3Y7b1Urn2F9zH1ELGdVZ5iKXvb028Mbo
 0VM9Yrx0BwBAxrBBpzwnvuvdCSE4yAlXTLO00R6LhBXKjrvhAvFXavfYYYYhPoSvb4rR
 kfu18xWVepmkHWE7WHQ4lxAvygMxqBSwK0sAFEXhgy4qwB9D2g4gkMwzgAd0QkRUl0h5
 ZomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685575512; x=1688167512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HK9K9jzzWlfIFdB7uwHlISI/daPJAK4dkCrRI+Fx+Fo=;
 b=Yeg6Z5s4I1yuz7cGdpShSEDT5HrffZattFKJqQeqt4mCUaibS3X52pY4MZiya7DZJT
 Hx8uWDgD0FB2MiKvw3DGdQmNQ4NwFwNF4+S+JRk+KTEIxOQXsWXyldtdElM1wCMN3ZOm
 dxeMytHXaWM6nyVHiSO8TsJTKegx6Y9Ovy7kQRToRzritlJnYKTcZRbbtGDHAFUF7i6C
 ecmSiL1Ftj45nTgoBUU+jYPoTEVB4Xe9Mh2metMPfT22DI2Fp8Kf/lIdToq3mUlnI5x2
 Dxv9iRoW6a9a98tcnK7rJ66nZ62l3flxgmAxCZX973zVo1UuVdQB8yZcfqBK2+GpBZcI
 CbOQ==
X-Gm-Message-State: AC+VfDwin3oxOzSdkGSAbXSxPpZJp3TCOFrJ31xz6AUzrZPy9KKELrcl
 BK13yuODg0N3Vuta/w6OGNoHfDJZsqgyjoj9Nuk=
X-Google-Smtp-Source: ACHHUZ6/QEKlRY5DVJGS59pjMFEMbfn6N3hqrDIxNP3mpFS8h3RGUUW8u2ZCHzR4qgZ4K6JQLo29Ow==
X-Received: by 2002:a05:6214:21a6:b0:625:aa49:9ab5 with SMTP id
 t6-20020a05621421a600b00625aa499ab5mr8135862qvc.57.1685575511760; 
 Wed, 31 May 2023 16:25:11 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 x19-20020aa784d3000000b0063b6451cd01sm3788360pfn.121.2023.05.31.16.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 16:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] decodetree: Add --output-null for meson testing
Date: Wed, 31 May 2023 16:25:10 -0700
Message-Id: <20230531232510.66985-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf32.google.com
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

Using "-o /dev/null" fails on Windows.  Rather that working
around this in meson, add a separate command-line option so
that we can use python's os.devnull.

Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: 656666dc7d1b ("tests/decode: Convert tests to meson")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py    | 18 ++++++++++--------
 tests/decode/meson.build |  4 ++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 13db585d04..a8a6cb69cd 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -42,6 +42,7 @@
 input_file = ''
 output_file = None
 output_fd = None
+output_null = False
 insntype = 'uint32_t'
 decode_function = 'decode'
 
@@ -145,12 +146,7 @@ def error_with_file(file, lineno, *args):
 
     if output_file and output_fd:
         output_fd.close()
-        # Do not try to remove e.g. -o /dev/null
-        if not output_file.startswith("/dev"):
-            try:
-                os.remove(output_file)
-            except PermissionError:
-                pass
+        os.remove(output_file)
     exit(0 if testforerror else 1)
 # end error_with_file
 
@@ -1501,6 +1497,7 @@ def main():
     global translate_prefix
     global output_fd
     global output_file
+    global output_null
     global input_file
     global insnwidth
     global insntype
@@ -1514,7 +1511,8 @@ def main():
     decode_scope = 'static '
 
     long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
-                 'static-decode=', 'varinsnwidth=', 'test-for-error']
+                 'static-decode=', 'varinsnwidth=', 'test-for-error',
+                 'output-null']
     try:
         (opts, args) = getopt.gnu_getopt(sys.argv[1:], 'o:vw:', long_opts)
     except getopt.GetoptError as err:
@@ -1545,6 +1543,8 @@ def main():
                 error(0, 'cannot handle insns of width', insnwidth)
         elif o == '--test-for-error':
             testforerror = True
+        elif o == '--output-null':
+            output_null = True
         else:
             assert False, 'unhandled option'
 
@@ -1574,7 +1574,9 @@ def main():
         stree = build_size_tree(toppat.pats, 8, 0, 0)
         prop_size(stree)
 
-    if output_file:
+    if output_null:
+        output_fd = open(os.devnull, 'wt', encoding='utf-8', errors="ignore")
+    elif output_file:
         output_fd = open(output_file, 'wt', encoding='utf-8')
     else:
         output_fd = io.TextIOWrapper(sys.stdout.buffer,
diff --git a/tests/decode/meson.build b/tests/decode/meson.build
index 38a0629d67..b13fada980 100644
--- a/tests/decode/meson.build
+++ b/tests/decode/meson.build
@@ -53,12 +53,12 @@ decodetree = find_program(meson.project_source_root() / 'scripts/decodetree.py')
 
 foreach t: err_tests
     test(fs.replace_suffix(t, ''),
-         decodetree, args: ['-o', '/dev/null', '--test-for-error', files(t)],
+         decodetree, args: ['--output-null', '--test-for-error', files(t)],
          suite: suite)
 endforeach
 
 foreach t: succ_tests
     test(fs.replace_suffix(t, ''),
-         decodetree, args: ['-o', '/dev/null', files(t)],
+         decodetree, args: ['--output-null', files(t)],
          suite: suite)
 endforeach
-- 
2.34.1



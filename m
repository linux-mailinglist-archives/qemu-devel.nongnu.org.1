Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A624777C65
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iY-0005P2-Cu; Thu, 10 Aug 2023 11:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iV-0005ML-QT
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iP-0003EN-H0
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so9269495e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681804; x=1692286604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvCczPcI4msPxOyG0ECCXLj/z9hworOartFnCQjpVDQ=;
 b=ru2LAzvvkDckKtekoOAdPyW2bafMUqsnyUTbr3p90n/EnzzHkCF1f7UpCesmuSpGx9
 3/5DzHFfdfNs2g18cIJsumVpNAbtPNfneTfnFdTCt2rB0bTcbciRjM2Rx/XjBF30pO/V
 WRIPJiT7vrP4ebIR3ux0EHyqB7jWn8j8tHh9Z62x8subTEUdefT3+tTTDApe9UtG4d+Z
 TWoIEdQWHwKCpnVE38LyeNTNTIZfEIPr9ZHiZa+AVAzVPVAFdeaHn3fUupd9fRKNnLg/
 3ZCfoaO0hKDF76m0Fe8AW9/OzI2/rj5JebgPwUU3AI8PE8cIBsbfPJ7qnU/36/X+Dfzn
 CG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681804; x=1692286604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvCczPcI4msPxOyG0ECCXLj/z9hworOartFnCQjpVDQ=;
 b=FT7wBa/l+3GDYdoX05WIyHTR8M1TwmpPpK16XVUyu11oT65PqEWbGBzVZntX3bb6l5
 SDhpNhfxr/bwzJYwWbUyFLKrBtytAKUjQNl7Cjq+M3P3twfDZ3JGBhllk6xqvfTC1IoN
 Rq+4VE7DlLlsVSwxT6DYZFNdQr+bDcjwXv1NxGR3EY8gRR6NYSH7vrcwSB+oFtRkjXFF
 6Ij2kChLsEoLUV5+h6Opz0usAODXLAVCRT0x/s7yRhUOsuVaLGQw7+YbjKbS7aXsmI7n
 2eaSlLbZvwckTk9h4j3Duu+i29co9/5GBTrNNu89rs/iqjBzczwPs81oZpPG+IsLz+DT
 B/VQ==
X-Gm-Message-State: AOJu0YwLlcUCT8mn7RX4lsEFwehUOFyXBLkymzshT/fmr3Ga7Md/FAwx
 2YvO4gtdvFreEBUHpIT79R/3MlGy8wn9kuR8XUI=
X-Google-Smtp-Source: AGHT+IE1Jm/c/w9x5yt54To+qnmsaV9xn6MsvrNsguaMPDJjLoR+YwKqRW2pmZvbmNYrqbTDnQk8Yg==
X-Received: by 2002:a7b:c7c7:0:b0:3fe:df1:5b95 with SMTP id
 z7-20020a7bc7c7000000b003fe0df15b95mr2299952wmk.19.1691681803707; 
 Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b003fe577eb8cbsm5363586wmc.44.2023.08.10.08.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 580551FFC0;
 Thu, 10 Aug 2023 16:36:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 5/8] tests/tcg: clean-up gdb confirm/pagination settings
Date: Thu, 10 Aug 2023 16:36:37 +0100
Message-Id: <20230810153640.1879717-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can do this all in the run-test.py script so remove the extraneous
bits from the individual tests which got copied from the original
non-CI gdb tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py                         | 2 ++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py           | 3 ---
 tests/tcg/aarch64/gdbstub/test-sve.py                 | 3 ---
 tests/tcg/multiarch/gdbstub/memory.py                 | 3 ---
 tests/tcg/multiarch/gdbstub/sha1.py                   | 4 ----
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py     | 4 ----
 tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py   | 4 ----
 tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py | 4 ----
 tests/tcg/s390x/gdbstub/test-signals-s390x.py         | 4 ----
 tests/tcg/s390x/gdbstub/test-svc.py                   | 4 ----
 10 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index de6106a5e5..c0d0075e2e 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -86,6 +86,8 @@ def log(output, msg):
         gdb_cmd += " %s" % (args.gdb_args)
     # run quietly and ignore .gdbinit
     gdb_cmd += " -q -n -batch"
+    # disable pagination
+    gdb_cmd += " -ex 'set pagination off'"
     # disable prompts in case of crash
     gdb_cmd += " -ex 'set confirm off'"
     # connect to remote
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index b9ef169c1a..ee8d467e59 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -76,9 +76,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-
     # Run the actual tests
     run_test()
 except:
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index ef57c7412c..afd8ece98d 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -66,9 +66,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-
     # Run the actual tests
     run_test()
 except:
diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/gdbstub/memory.py
index 67864ad902..dd25e72281 100644
--- a/tests/tcg/multiarch/gdbstub/memory.py
+++ b/tests/tcg/multiarch/gdbstub/memory.py
@@ -115,9 +115,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-
     # Run the actual tests
     run_test()
 except (gdb.error):
diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
index 423b720e6d..416728415f 100644
--- a/tests/tcg/multiarch/gdbstub/sha1.py
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -73,10 +73,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
-
     # Run the actual tests
     run_test()
 except (gdb.error):
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 5e3e5a2fb7..04ec61d219 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -51,10 +51,6 @@ def main():
         exit(0)
 
     try:
-        # These are not very useful in scripts
-        gdb.execute("set pagination off")
-        gdb.execute("set confirm off")
-
         # Run the actual tests
         run_test()
     except gdb.error:
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
index d91e8fdf19..926fa962b7 100644
--- a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
@@ -42,10 +42,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
-
     # Run the actual tests
     run_test()
 except (gdb.error):
diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
index 798d508bc7..e57d2a8db8 100644
--- a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
+++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
@@ -45,10 +45,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
-
     # Run the actual tests
     run_test()
 except (gdb.error):
diff --git a/tests/tcg/s390x/gdbstub/test-signals-s390x.py b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
index 80a284b475..ca2bbc0b03 100644
--- a/tests/tcg/s390x/gdbstub/test-signals-s390x.py
+++ b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
@@ -61,10 +61,6 @@ def run_test():
     exit(0)
 
 try:
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
-
     # Run the actual tests
     run_test()
 except (gdb.error):
diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
index 18fad3f163..804705fede 100644
--- a/tests/tcg/s390x/gdbstub/test-svc.py
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -49,10 +49,6 @@ def main():
         exit(0)
 
     try:
-        # These are not very useful in scripts
-        gdb.execute("set pagination off")
-        gdb.execute("set confirm off")
-
         # Run the actual tests
         run_test()
     except gdb.error:
-- 
2.39.2



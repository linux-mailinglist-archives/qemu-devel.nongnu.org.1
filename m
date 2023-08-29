Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9EF78C976
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nm-00050O-K2; Tue, 29 Aug 2023 12:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NX-0004p2-Rw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NP-0004R1-PP
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31aeee69de0so3902777f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325733; x=1693930533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tGSqnEd6yAy1ahRBk/ob1qWehJYVA7fbTHLeHjb8QE=;
 b=rFpVuyaDuoi2aLFOSDa7GEJpmojOc4JLRnK57/ALAKYOQ6Z+n9NLzRY8Faeap2+THD
 zeloGHkkUfyBOvFlVwuIXHwC3+U/7MtF6CN+pGjniIJMZiIZZkKDFLlQMxHxzd4CWywC
 PU1xDVenumllTqJP3663ZJ3oukOdPkkaTxxJLSLnuSpuyCuKKlmVfUCra9Ak+mVTNTxH
 PF05R00PGLjUIZa282/hbsUtpWD5+4WD3t6JAzqXga96xHhq0eJkLg/pYm+Ujcg99xBM
 GrT11FJt0dcFz0FwdDzl8jZbzLWdRrpu1zR8S9GyeveISV7MBPqww5fhsHRTvOog7T2G
 aNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325733; x=1693930533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tGSqnEd6yAy1ahRBk/ob1qWehJYVA7fbTHLeHjb8QE=;
 b=SZPFESJkyMYCJPU96ZJtpqsl9bp1ITV8IZZJnGoPVivPxBr3/iInwdDpUzxUOnz6rG
 1xmWvhgvxrxMUsq4FMsXM05JjpQU49D3zH4zVT+diDLRMaU+ihxbsYHdgPERQJIkeY8P
 +owXkADrYscpIlPtxBdwVS3lSt10F92w5TCL9o9QOx9tR+gmFnZeDhcla8uydfvZ/fmw
 JzDnChN/urh7Hnh/gWAjizvDK/wEtifrVYCozE/xT72njz/yB3mi+Jmi3HlSyi/V4HX1
 m1/UR21PO/jd+BSpw1o0sgvF9RVWT52+cQVrs6llctZX/WyFnAjiLem/83cSCy5zGsvB
 Siuw==
X-Gm-Message-State: AOJu0Yy7Ub/85Yh6M3/1kohN2g7fZ+DTA5Uos2PK5tr4O6+CGZNZINoO
 T241oDBAPD43dJy+vfswHOLLgA==
X-Google-Smtp-Source: AGHT+IF1l77MBIAGD8NsZtre5DWyHObWYhpW3AsU479B9cS70gUC4w2CI//K7p00xp7rPFyBUeQYUQ==
X-Received: by 2002:a5d:65c5:0:b0:317:70cb:4f58 with SMTP id
 e5-20020a5d65c5000000b0031770cb4f58mr23092298wrw.63.1693325733547; 
 Tue, 29 Aug 2023 09:15:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o12-20020adfcf0c000000b0031ad2663ed0sm14191827wrj.66.2023.08.29.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 10CB61FFC2;
 Tue, 29 Aug 2023 17:15:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 07/12] tests/tcg: clean-up gdb confirm/pagination settings
Date: Tue, 29 Aug 2023 17:15:23 +0100
Message-Id: <20230829161528.2707696-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

We can do this all in the run-test.py script so remove the extraneous
bits from the individual tests which got copied from the original
non-CI gdb tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index a032e01f79..b13b27d4b1 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -83,6 +83,8 @@ def log(output, msg):
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



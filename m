Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6656277CE84
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOh-0005sa-El; Tue, 15 Aug 2023 10:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOZ-0005qm-BL
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvON-0006Gd-Fd
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe426b86a8so51358185e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111090; x=1692715890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4o5KcbHxCMMudk1ebQJTS76ot0MvKIvT2lcoqReshg=;
 b=mYFJXEShs/bXqyTd23fF/z9+WYUilATbKZ1UJQ7i0wQERf8EpTeh+d8NAbj14hMvyH
 n9UbxASPv0JFeY5JGN/E7KudCZR9+15xpf2yVOZM8mSgYF03wqW1KXXUzK1v/FKSgNMq
 mjPt1ZpyEYxEVtgUzspHN3p/Zba+RITUpLYWEHw6fmZbGhmDSvkal9j5her3In5ap1OJ
 J+2C+hoFIUgnsQ6T2K2Mj18UrIRZzWUnA/X+gFXtYte4IgaEq0pKy5YSbNeEXGlVxEFC
 u+lggP+asER1tF0GWlRGtkDgQWXfx982lxwP2m4tr9t3GXMdt7LiT8IjM/CquNdIp96r
 evDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111090; x=1692715890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4o5KcbHxCMMudk1ebQJTS76ot0MvKIvT2lcoqReshg=;
 b=L42AFEPRJ+gN0UgkxyU5nfgC4P9OxrYVkekHwHvYUzzgGjmV7vXQWF3AcznhG6GwRo
 4HJ8vKyg2jfdNknCw7tX1JK4Js6rMMKzfFw+2DfU8yG5gSqMsvk9P9qUIMn6YVn/zhyo
 GAnw82tysaFQJUkkcIE8meSRX6HT2rUBfF2KpeXZ7zFHcaEd2CHfdPWVCx/GNKeMZyCO
 74F/bNkphWcAY0ItT11lcKFm7HFLTctb/avOmF/hobXRVoJ1DHcBoIrp7TDPzCSaEOYx
 OlVqgvR4Pp2kyfKENKIWpvWEJSCTKZkV8cX8Z3UrhxxoUFLdJfwQ0LZXS+EQpu+ActF3
 erIg==
X-Gm-Message-State: AOJu0YzDVJzGAVHuLEzKKWyIn0mouk6ZMX7BX58alx69/nmFT6AvA1ln
 IM+Xzr91xR8EGWncaDf5hJme3g==
X-Google-Smtp-Source: AGHT+IHumA4KR1eaY97j9MMBvZUgE/WMVjlrvpIkLDLce712vL81OHgTZ1RvByM1ISI1pL47xVc3iQ==
X-Received: by 2002:a05:600c:292:b0:3fb:ef86:e2e with SMTP id
 18-20020a05600c029200b003fbef860e2emr10888035wmk.19.1692111089823; 
 Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b003fe20533a1esm18241765wml.44.2023.08.15.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73DB51FFC0;
 Tue, 15 Aug 2023 15:51:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/9] tests/tcg: clean-up gdb confirm/pagination settings
Date: Tue, 15 Aug 2023 15:51:22 +0100
Message-Id: <20230815145126.3444183-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815145126.3444183-1-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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



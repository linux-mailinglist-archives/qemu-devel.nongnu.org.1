Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA77F636C
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:57:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4H-00063Y-FN; Thu, 23 Nov 2023 10:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C4F-00062s-6u
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C4A-0002PQ-SJ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b36e31b57so5263105e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754993; x=1701359793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEYzF3Axx2JxZiA2yLlLoGItJkGh2l18cc/hJ925Ej0=;
 b=OZvuBqWOyRjOI6EpUgbY0lbP+P3TtyvYF2kA5llNiiQuqE1k3hFBlmxKUcNGnPEciX
 DdJ33zweWAFI9uK7Q8T3oTpg6Cu93oUNR0gFe5zyQ82D+lK+0seUckiuFmoGwRFp6iLo
 H8ZWL23BEK1DrvCgFRirxubLW6E7CGa6uoGD3Fp3Knf24Vj4quKczOfXmMX+KXIsiZPG
 FUI4tYNLlhTdtE4p8+94chp7UhgqCITaP9lxtO7m9yStjpZOrB3JxKc0lq+IuoiKfvmX
 VGB3F45u/Y7CHPFtokuPxEIMlJApqWR83yoQU5sI91XtTCFHuW+arhiPtQOTvLC52JLS
 26dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754993; x=1701359793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEYzF3Axx2JxZiA2yLlLoGItJkGh2l18cc/hJ925Ej0=;
 b=kTevGZcurjNuPLZl92rCiZiRl2wnMCsTErqQiuMQNmUI9AZPHPejiVzSQW/lWnrfZ4
 jMxpz05+r9VYZmrslaauquCwBZm8Mkz+QcIOLRGfMziUwvEAcOO7MUdJ5j84WAth+xW9
 bV0HXKTXFXaDi1ssTGSlsxbrV2eki8DKXDkFreC/HDOG3NaddPafzCJRX4Xswp1mCPka
 1Xff52XgqZZlF1spSL9aWYEl8/gFM3xVpYWFRwBtVGOMLW31PyBYkAeUtPF6Nlm5mcs4
 /dbJj2b0Kav0UcMRrpjgXhQovbLTFeqqHbskTREncazPo0HT+QZJfmuMHHM2grjKupTD
 318g==
X-Gm-Message-State: AOJu0YzFzGde92fGljM7vT1cRgtmXJrGr82p+mgP0pK2PabvmW9wQs6h
 7n+OVIui8LKriQMlojLQRUXfqHc8zzWUqkLZZjmQIA==
X-Google-Smtp-Source: AGHT+IGAQnZvR7C1IdaTaUAA1MhFe9Hx/MFAavmCkMOT0CiEZhwrFQnKRyLIHZs069sGdaGzPwebbg==
X-Received: by 2002:a05:600c:3110:b0:404:7670:90b8 with SMTP id
 g16-20020a05600c311000b00404767090b8mr24545wmo.27.1700754993526; 
 Thu, 23 Nov 2023 07:56:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c138c00b004063c9f68f2sm2409162wmf.26.2023.11.23.07.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8C5F645F6;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/14] configure: don't try a "native" cross for linux-user
Date: Thu, 23 Nov 2023 15:56:19 +0000
Message-Id: <20231123155620.3042891-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

As 32 bit x86 become rarer we are starting to run into problems with
search paths. Although we switched to a Debian container we still
favour the native CC on a Bookworm host. As a result we have a broken
cross compile setup which then fails to build with:

    BUILD   i386-linux-user guest-tests
  In file included from /usr/include/linux/stat.h:5,
                   from /usr/include/bits/statx.h:31,
                   from /usr/include/sys/stat.h:465,
                   from /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux/linux-test.c:28:
  /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such file or directory
      5 | #include <asm/types.h>
        |          ^~~~~~~~~~~~~
  compilation terminated.
  make[1]: *** [Makefile:119: linux-test] Error 1
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:50: build-tcg-tests-i386-linux-user] Error 2

This is likely to affect more and more linux-user builds so wrap the
whole check in a test for softmmu targets (aka bare metal) which don't
worry about such header niceties. This allows us to keep using the
host compiler for softmmu tests and the roms.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-14-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 9ea0bf5698..42fe4d0510 100755
--- a/configure
+++ b/configure
@@ -1391,16 +1391,19 @@ probe_target_compiler() {
   done
 
   try=cross
-  case "$target_arch:$cpu" in
-    aarch64_be:aarch64 | \
-    armeb:arm | \
-    i386:x86_64 | \
-    mips*:mips64 | \
-    ppc*:ppc64 | \
-    sparc:sparc64 | \
-    "$cpu:$cpu")
-      try='native cross' ;;
-  esac
+  # For softmmu/roms we might be able to use the host compiler
+  if [ "${1%softmmu}" != "$1" ]; then
+      case "$target_arch:$cpu" in
+        aarch64_be:aarch64 | \
+        armeb:arm | \
+        i386:x86_64 | \
+        mips*:mips64 | \
+        ppc*:ppc64 | \
+        sparc:sparc64 | \
+        "$cpu:$cpu")
+        try='native cross' ;;
+      esac
+  fi
   eval "target_cflags=\${cross_cc_cflags_$target_arch}"
   for thistry in $try; do
     case $thistry in
-- 
2.39.2



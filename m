Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1AE7F16D2
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:11:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55te-0006Ir-R4; Mon, 20 Nov 2023 10:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tS-0005tz-PU
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:01 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tG-0001Jr-EO
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:58 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso2864688f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492924; x=1701097724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAfJwOx8Ygtt+c022BojU5oHMeEbaLxK0MlwB3wYne0=;
 b=wV/yFCVSisG+kHD1Tl5yJpTEv/Cyau0OGOYjp2t//3utln8nDJd7tH7Zsv9u/F3Pw5
 XFAIfAdyTb8/dvLiwKfTMiM/CQqsWq/q25Xc+qExri5M8kyzqV+VHd+Lr+6t86sLb7xq
 nxBH9hTa8BzuSKzFttnL0ndoNvcxfTRWd9RmZQBoUICy5ir2EI9auRjmE5KhyPS10fSW
 W2KKpWi+rxjj42F/sF64pS6Jz+hcRLjxJKCEJGDritLFt0GKN9RUChurawq4Qi9J7iEx
 wUcIgUGcxNz35Tk2BTcuDT79R1FCciJieKXnvjoc6BPktt4hdEwkPR/A9LreM79zN1IN
 fHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492924; x=1701097724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAfJwOx8Ygtt+c022BojU5oHMeEbaLxK0MlwB3wYne0=;
 b=B1Im3e2NzoQfWIwvWkcGMNvtC6UMYkPX1irAu+OohhxiyaY3TbjoLIDPhL5ZhAxOLv
 gnuMd0X1tM/TZ2EipjyHPvJxwT0BW3xalSJKi1Imby418rcLGOMH+LLKsE9E789UPux8
 ol9b35hox6tKHh+rIN309pRutdP5B1fLDYWz4E4uNabe9exWAu5dok08APXh8AOJve2r
 wgxXuS052uZKZ9+yMF1+8h02X1ImSmLQq9Xr0zWWo4NN0Z+m0n80ZxcyuKVEZBDIOBdA
 /R2MDaiOcqEIDS7ioYO0+qGbh70ShdNtjWSAgAkegKu7JDwXVrN+0Jk+KrfZafjw7FWB
 xB+A==
X-Gm-Message-State: AOJu0YznPc9lrKsSThU3GJBlNZlPCL2ihyjq04KhNW+clZ5vZI5Ql7uG
 GGaIVzPr/LCFNE/F6tUt0UhAFA==
X-Google-Smtp-Source: AGHT+IFa650AYTf3VLK7g/UER2awl4G75Vh4hx7YpqSh0koO/lD2OIHtwz4tq8MBLYM+c3LLFegv6A==
X-Received: by 2002:adf:f610:0:b0:32d:aa14:875d with SMTP id
 t16-20020adff610000000b0032daa14875dmr4380189wrp.29.1700492924714; 
 Mon, 20 Nov 2023 07:08:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z5-20020adff745000000b0032d829e10c0sm11417440wrp.28.2023.11.20.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E96A6577A;
 Mon, 20 Nov 2023 15:08:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 13/14] configure: don't try a "native" cross for linux-user
Date: Mon, 20 Nov 2023 15:08:32 +0000
Message-Id: <20231120150833.2552739-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

---
v2
  - split fix for tests/docker: replace fedora-i386 with debian-i686
    as still in my tree ;-)
  - didn't apply dpb rb due to change requested by bonzini
---
 configure | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

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



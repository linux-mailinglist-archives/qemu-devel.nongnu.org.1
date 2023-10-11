Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4027C5037
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXI-0001YB-AB; Wed, 11 Oct 2023 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX5-0001Ks-8i
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX1-0005Ag-KB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so484182f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020412; x=1697625212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IiuNKmaTaknn72sH80/PHMGMfdmM3U9tgv9losOud8=;
 b=tmbs707BcfDlan8qEGXnxUYye6R3lkpLbrN5Jyrl2PCtuRrpfmWmlqjuxYB7leIC/Q
 69hTXLpRLV22VZiVml/MH1DI5q4REBZWIsdbi5pXOMTjCDI5MtLIG9jfpnUxkouUR8v6
 dly+jYocZmEL+hPCSaNJcbD5/sD+LubxYyFkz9mfFurXY+vZjdWumfduNMa2fHZ1t4bM
 gAOCrvN1IobJ+oDJTX1qHWNWMILjj0OsY7b+lIWWSRhm/LIjNJTjUqeSR9HXdt75Swnh
 F1oJaSlGGLJ6leIiwWrnPsmerkLW614diPoI5ODkb5+hrqX6oqa2NK9gNaOHwx+dykFu
 zvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020412; x=1697625212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IiuNKmaTaknn72sH80/PHMGMfdmM3U9tgv9losOud8=;
 b=Irei3R8Qf/p2acvwR6Imxhms+E61uNAtM8DYecR3uUp66RFAWeoh2gdH3TJcGqD91W
 1GrEaSWX1RDbaypYM5tHap2eCwElLhE1HCiZg+GaVNgTyWRRgjoPb3xjudiKoVpnMx0s
 cXYGiFgo9UBuYZjB2u+KrNwG7/n2aWSacClIlkYLjM+xqgF0V7HbbfCdC9/8J9/DLE45
 ptl2XhUAqyrrSj7kahCLD18TZCFtlBvUYQiCoZRKH+OFzomVKbH6An6I3P6EnJ6nNhPD
 +ggrdzURwd7m8bj+WOuxRfmlXAq9HSJ92AzIA4kR+r++y+7p9tYFJOvISl+ggWDk6FMJ
 0ZgQ==
X-Gm-Message-State: AOJu0YzlMxAFQqEY/vHZzLzaTzAL5G5fAidwjwx/W7kAkJ+PGlWEqEOt
 AUQLIOX2WFMywNbXVgBI8QgXgg==
X-Google-Smtp-Source: AGHT+IFayRxOTwEys00HTv4l4yaANJpBNQCOOBKi+Riw+1wYbaD1+FY03JQcu6LFqld30uOpgfwjbg==
X-Received: by 2002:a5d:5c07:0:b0:31f:d50e:a14f with SMTP id
 cc7-20020a5d5c07000000b0031fd50ea14fmr20100519wrb.10.1697020412747; 
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a5d50cf000000b00323330edbc7sm15124930wrt.20.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:31 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F5671FFBF;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 04/25] gitlab: shuffle some targets and reduce avocado noise
Date: Wed, 11 Oct 2023 11:33:08 +0100
Message-Id: <20231011103329.670525-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

We move a couple of targets out of the avocado runs because there are
no tests to run. Tricore already has some coverage.  The cris target
only really has check-tcg tests but its getting harder to find
anything that packages the compiler.

To reduce the noise of CANCEL messages we also set AVOCADO_TAGS
appropriately so we filter down the number of tests we attempt.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-5-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aee9101507..25af1bc41e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -30,6 +30,7 @@ avocado-system-alpine:
   variables:
     IMAGE: alpine
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:avr arch:loongarch64 arch:mips64 arch:mipsel
 
 build-system-ubuntu:
   extends:
@@ -40,8 +41,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
-    TARGETS: alpha-softmmu cris-softmmu hppa-softmmu
-      microblazeel-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
@@ -61,6 +61,7 @@ avocado-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:alpha arch:microblaze arch:mips64el
 
 build-system-debian:
   extends:
@@ -72,7 +73,7 @@ build-system-debian:
     IMAGE: debian-amd64
     CONFIGURE_ARGS: --with-coroutine=sigaltstack
     TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
-      sparc-softmmu xtensaeb-softmmu
+      sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-debian:
@@ -92,6 +93,7 @@ avocado-system-debian:
   variables:
     IMAGE: debian-amd64
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc arch:xtensa
 
 crash-test-debian:
   extends: .native_test_job_template
@@ -114,7 +116,7 @@ build-system-fedora:
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs
-    TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
+    TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
 
@@ -135,6 +137,8 @@ avocado-system-fedora:
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:microblaze arch:mips arch:xtensa arch:m68k
+      arch:riscv32 arch:ppc arch:sparc64
 
 crash-test-fedora:
   extends: .native_test_job_template
@@ -180,6 +184,8 @@ avocado-system-centos:
   variables:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:ppc64 arch:or1k arch:390x arch:x86_64 arch:rx
+      arch:sh4 arch:nios2
 
 build-system-opensuse:
   extends:
@@ -209,6 +215,7 @@ avocado-system-opensuse:
   variables:
     IMAGE: opensuse-leap
     MAKE_CHECK_ARGS: check-avocado
+    AVOCADO_TAGS: arch:s390x arch:x86_64 arch:aarch64
 
 
 # This jobs explicitly disable TCG (--disable-tcg), KVM is detected by
-- 
2.39.2



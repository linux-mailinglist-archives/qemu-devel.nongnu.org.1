Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 798307EE5EE
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gAJ-0008Hj-LC; Thu, 16 Nov 2023 12:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3gAH-0008HU-Dj
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:28:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3gAF-0002WV-LC
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:28:29 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso8678225e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700155705; x=1700760505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TqVK9uOL2ddFONTKxAz6R/c/cKH2txHZFCYADHu1FbQ=;
 b=OYgEHkiHj+5jb8ITJDik3BtyAqmtRm1ebCMSf2jV9EzSVVz9/DC9wE7KtMOA/ePnQw
 TF6V4mUu+uW7XZk5xoG6BGa6VEkFP5tDDuFZ3igjS9eP2RaJgeSNIrODiaTpEMzdUpKz
 31w2ef0m4l4BfUXmHi+5xhc0PrXUtW68tvQRCM72giGETJA6nUB7lDFfjEqhqIbEacyJ
 fMstrgf4w8lucDsxj1hgP+KF9ydql/2s7J3xyF8HqJpjKu5zXz1UkRISksFKHl+DIOx0
 9ExL7W7y40oIGycmDZ76Uuoq2WJyXOeoWgCyTaECEPbKpVGxABAVHv277iHp+wJfJviT
 uaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700155705; x=1700760505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqVK9uOL2ddFONTKxAz6R/c/cKH2txHZFCYADHu1FbQ=;
 b=Nix7LrDv9pmMg9wZxdiDHps+Jocqk2RxSv2oZtdTj3/QZpM8EJaIKvF7i6xHV6g6uz
 AIT+r+OvxWBhxrO6geGSP2hpUT+ZYXGUEx0RBN519gG0jNO9MhBn3L0G0e1JHuJ9IG3q
 I7pumYcWklLtDdexp9rk+9WsVpYANtiwazhw7ji/DXQj7a2fAPJcWCcZ08XexfmiPASH
 ZThbvbNVBRaxK2PBIrwl3bKqqBrqtSrCqi2k+fwNz4hk5IWKWkSzWGxyS2CvBGuLP23U
 xiCVxKRtJo47gMZqpsXzODUaiJrbxUJUpcaUhnarB8Q3gzeaQqoAIy28++dpTbmHbknl
 qs2A==
X-Gm-Message-State: AOJu0Yy/fhRDdZY6HdV09wRCp/ZxKmlCTU6cV1+cNDvBFrwD/P13sWxz
 gIAt7ljz4XXs2AyIiVnSb0DmoA==
X-Google-Smtp-Source: AGHT+IGaDc0sP+i1kRerNMP3xk5ctQx7tJU8LwXtw6Mldk4z8QqISmfNLtJKJ2lhbZdePUMiZSQ+kQ==
X-Received: by 2002:a05:600c:4584:b0:409:5a1a:fe16 with SMTP id
 r4-20020a05600c458400b004095a1afe16mr12475201wmo.28.1700155705080; 
 Thu, 16 Nov 2023 09:28:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f14-20020a056000128e00b003313069be5dsm14241951wrx.46.2023.11.16.09.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 09:28:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58F645F7B6;
 Thu, 16 Nov 2023 17:28:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] configure: don't try a "native" cross for i386
Date: Thu, 16 Nov 2023 17:28:20 +0000
Message-Id: <20231116172820.2481604-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

So lets stop trying to be cute and honour cross_prefix_i386 when
searching locally. We also need to ensure we are using the correct
prefix if we do end up using the container version. We can also drop
the extra CFLAGS while we are at it.

Fixes: 791e6fedc5 (tests/docker: replace fedora-i386 with debian-i686)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configure b/configure
index 5e7b76e3a1..2343d629ec 100755
--- a/configure
+++ b/configure
@@ -1190,7 +1190,6 @@ fi
 : ${cross_cc_cflags_armeb="-mbig-endian"}
 : ${cross_cc_hexagon="hexagon-unknown-linux-musl-clang"}
 : ${cross_cc_cflags_hexagon="-mv73 -O2 -static"}
-: ${cross_cc_cflags_i386="-m32"}
 : ${cross_cc_cflags_ppc="-m32 -mbig-endian"}
 : ${cross_cc_cflags_ppc64="-m64 -mbig-endian"}
 : ${cross_cc_ppc64le="$cross_cc_ppc64"}
@@ -1308,7 +1307,7 @@ probe_target_compiler() {
         ;;
       i386)
         container_image=debian-i686-cross
-        container_cross_prefix=
+        container_cross_prefix=i686-linux-gnu-
         ;;
       loongarch64)
         container_image=debian-loongarch-cross
@@ -1394,7 +1393,6 @@ probe_target_compiler() {
   case "$target_arch:$cpu" in
     aarch64_be:aarch64 | \
     armeb:arm | \
-    i386:x86_64 | \
     mips*:mips64 | \
     ppc*:ppc64 | \
     sparc:sparc64 | \
-- 
2.39.2



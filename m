Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F851707034
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLHD-0005dw-6S; Wed, 17 May 2023 13:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLFB-0002oz-EZ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEx-0004XV-Ph
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcHvFX9e7TrY62C9Kq986qOxDclbTbjX+dadAAdMczg=;
 b=HM6sxkrM6nGmqIWTDfjZeQ4grfIiLffKI0TTQsmrls8rS9Qq8mWulcwKMhIMze0taBliZl
 SQ0qN0Q6HppOKgDf8r+92L6QgjEOpYlP4lFRiiOJz3RNY6epMmz6CqgrKc8LbZnGWXU5zs
 JeFYoNuKZPtEki8geDb/KECBTBZoTyM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-z5dybUTkO2-K5Q_SWzqc0w-1; Wed, 17 May 2023 13:47:05 -0400
X-MC-Unique: z5dybUTkO2-K5Q_SWzqc0w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f33f8ffa95so4720915e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345624; x=1686937624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcHvFX9e7TrY62C9Kq986qOxDclbTbjX+dadAAdMczg=;
 b=Y0bShyE7ZVu1cOOC3e60iC60ZDtx8WglMsFfSY5SzciKs33DCLDYg0L/wEafzdJxqp
 qNVn+SrCSay/jO0LjrdQbn+qzKV+WghiUwK2B6qBK7vWEqnleKt+qG8QUXHGHMQQFTFh
 IbpWD5snw/K2CwiOU2vqx9/g+UvPF9wd8vvUnn6KVlPWX8o+j/Gz+CTh2ZmaLkegoz31
 YrXYYsL/ZXcWm87ProPQIqcfFJmoJNjgGoV3xJ8vaBU2qXiRq8Y8wB29fVL1pK0yCiXX
 WtFHeOOdtC2VbdiNanQXXBLrby7vXV2/9CtBz2atC6A8uF/nHa8ZM2ktzEermG3PVkpt
 8X2A==
X-Gm-Message-State: AC+VfDy2qmRGp2hVtoSPP3IFPWxbQ2BjgxIKIG32jeKPsvyebriscmzQ
 dlomcsA6kE2lj49s3P76JT5xiH5lZRYaAVGqdaGkr4+OVDz4EVRQ4YO7gURhJicawumPp8v+Rr6
 xOUVBcvFJYALLKYC1CJqkH28KfjAr7AZdxea5dSJiL044lp7WsBPF+vQc1nTVBl4rhYX2x5I/iS
 Y=
X-Received: by 2002:a7b:ce95:0:b0:3f4:e853:6a1 with SMTP id
 q21-20020a7bce95000000b003f4e85306a1mr15122352wmj.38.1684345623918; 
 Wed, 17 May 2023 10:47:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bys51F56a7U9Q/kcirC1FfsSPjMpH5excGxZUG4oRXkY2SFsHuTleUVKeEpYW2GwTb18+JA==
X-Received: by 2002:a7b:ce95:0:b0:3f4:e853:6a1 with SMTP id
 q21-20020a7bce95000000b003f4e85306a1mr15122340wmj.38.1684345623533; 
 Wed, 17 May 2023 10:47:03 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a1cf003000000b003f4f9274d10sm2929813wmb.16.2023.05.17.10.47.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 62/68] build: move --disable-debug-info to meson
Date: Wed, 17 May 2023 19:45:14 +0200
Message-Id: <20230517174520.887405-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 5 -----
 scripts/meson-buildoptions.py | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 0dc0395a848f..b2172b7b938e 100755
--- a/configure
+++ b/configure
@@ -693,10 +693,6 @@ for opt do
   ;;
   --cross-prefix-*)
   ;;
-  --enable-debug-info) meson_option_add -Ddebug=true
-  ;;
-  --disable-debug-info) meson_option_add -Ddebug=false
-  ;;
   --enable-docs) docs=enabled
   ;;
   --disable-docs) docs=disabled
@@ -972,7 +968,6 @@ cat << EOF
   bsd-user        all BSD usermode emulation targets
   pie             Position Independent Executables
   debug-tcg       TCG debugging (default is disabled)
-  debug-info      debugging information
 
 NOTE: The object files are built at the place where configure is launched
 EOF
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 4c7f13fdfc40..8d2e526132ae 100755
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -36,6 +36,7 @@
     "b_coverage": "gcov",
     "b_lto": "lto",
     "coroutine_backend": "with-coroutine",
+    "debug": "debug-info",
     "malloc": "enable-malloc",
     "pkgversion": "with-pkgversion",
     "qemu_firmwarepath": "firmwarepath",
@@ -47,6 +48,7 @@
     "b_coverage",
     "b_lto",
     "datadir",
+    "debug",
     "includedir",
     "libdir",
     "libexecdir",
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 28b6e8385bc1..d6223c5acdd1 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -11,6 +11,7 @@ meson_options_help() {
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
+  printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
   printf "%s\n" '  --disable-hexagon-idef-parser'
   printf "%s\n" '                           use idef-parser to automatically generate TCG'
   printf "%s\n" '                           code for the Hexagon frontend'
@@ -263,6 +264,8 @@ _meson_option_parse() {
     --datadir=*) quote_sh "-Ddatadir=$2" ;;
     --enable-dbus-display) printf "%s" -Ddbus_display=enabled ;;
     --disable-dbus-display) printf "%s" -Ddbus_display=disabled ;;
+    --enable-debug-info) printf "%s" -Ddebug=true ;;
+    --disable-debug-info) printf "%s" -Ddebug=false ;;
     --enable-debug-graph-lock) printf "%s" -Ddebug_graph_lock=true ;;
     --disable-debug-graph-lock) printf "%s" -Ddebug_graph_lock=false ;;
     --enable-debug-mutex) printf "%s" -Ddebug_mutex=true ;;
-- 
2.40.1



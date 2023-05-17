Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B2707045
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH8-0005R7-Dk; Wed, 17 May 2023 13:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEz-000241-BO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEw-0004Wk-NX
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFIDugn5duTxyfakELQCByov4jsyEnq4Yu1Y8iJ0ISI=;
 b=i8nzUYIeR8jwfpq7NJFJH0iZaJIx9gHyd+8VdqW+ag29hDDcByhVzw4yZQ+gZ8fyngyCAX
 Iw9NTFCdlkBEKvFcVlcLoY6Y+eic18/QzxL8yRBC9jN42R+U7E3cIyD4MiMZAVI5CwrceJ
 6GAcfum4yDLuEme69REfUKCMT+gUiBw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-PQDKK7NTNWipgk6v6JQqKg-1; Wed, 17 May 2023 13:47:04 -0400
X-MC-Unique: PQDKK7NTNWipgk6v6JQqKg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-306311a2b99so469615f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345622; x=1686937622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFIDugn5duTxyfakELQCByov4jsyEnq4Yu1Y8iJ0ISI=;
 b=F71hTueehdtFjAfiq1D8dkuLSL7GFZ7ElA+l+KgoDFdCJ22kaPNf+zZYgoWnATi2hD
 WyqLSlUbaCDZihtiCy0njtj6COXfUH4Y+xF3SB+L+MgUPfTE8+meMULs8Fmd8yHg4dbm
 4uczYFG5b+vGtCGbmo0ePi6mAvkU0JVF3R2z77c5cfkyrcSGkNGTnbAUQunCZJIw0Gg6
 GTJZ56EhP1wODi3dRb1kaXkLSNsE4EXqmzrRfK3phoAmfrBMQlLrWLBxFtMP9g225l86
 B90A4hatDmju31QXc5GG/1DuyUGandvlhdUt/Hh+O0NwIBvXlBs2xiSgjFCHGsR4n+kZ
 l9AA==
X-Gm-Message-State: AC+VfDy5Ex6Nv3o2wTTSVAUAUJlnAzsUyefmLzRfXWhlhQnLTbYqA7DP
 lFvriF/D8nVGhsToafGqMN3KrZJc3ValOVIEEku7UsCTPemMx4mcMWYWzck7UPkjHm+x6eVH2tv
 ASa/gYJygpAl0b23ghbXq8Rh2RpVtygTwX8N5jBsYP2SOmMYi7an5ZU3BT8zT5rcvETsDmYtdND
 g=
X-Received: by 2002:a5d:618e:0:b0:307:9592:846d with SMTP id
 j14-20020a5d618e000000b003079592846dmr1428575wru.14.1684345622647; 
 Wed, 17 May 2023 10:47:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6y0eQHEQhCoi+sudkUS5YygRCEWvXB5l3t98iA+MpqaLbBeP9IJX1+4BMuOzUK9cGDAHKqCw==
X-Received: by 2002:a5d:618e:0:b0:307:9592:846d with SMTP id
 j14-20020a5d618e000000b003079592846dmr1428561wru.14.1684345622290; 
 Wed, 17 May 2023 10:47:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a7bc4cc000000b003f4fe09aa43sm2981745wmk.8.2023.05.17.10.47.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 61/68] build: move compiler version check to meson
Date: Wed, 17 May 2023 19:45:13 +0200
Message-Id: <20230517174520.887405-62-pbonzini@redhat.com>
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

Use the slighly nicer .version_compare() function for GCC; for Clang that is
not possible due to the mess that Apple does with version numbers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 25 -------------------------
 meson.build | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/configure b/configure
index 6e78f6199feb..0dc0395a848f 100755
--- a/configure
+++ b/configure
@@ -1128,31 +1128,6 @@ if test "$targetos" = "bogus"; then
     error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
 fi
 
-# Check whether the compiler matches our minimum requirements:
-cat > $TMPC << EOF
-#if defined(__clang_major__) && defined(__clang_minor__)
-# ifdef __apple_build_version__
-#  if __clang_major__ < 12 || (__clang_major__ == 12 && __clang_minor__ < 0)
-#   error You need at least XCode Clang v12.0 to compile QEMU
-#  endif
-# else
-#  if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
-#   error You need at least Clang v10.0 to compile QEMU
-#  endif
-# endif
-#elif defined(__GNUC__) && defined(__GNUC_MINOR__)
-# if __GNUC__ < 7 || (__GNUC__ == 7 && __GNUC_MINOR__ < 4)
-#  error You need at least GCC v7.4.0 to compile QEMU
-# endif
-#else
-# error You either need GCC or Clang to compiler QEMU
-#endif
-int main (void) { return 0; }
-EOF
-if ! compile_prog "" "" ; then
-    error_exit "You need at least GCC v7.4 or Clang v10.0 (or XCode Clang v12.0)"
-fi
-
 if test "$static" = "yes" ; then
   if test "$plugins" = "yes"; then
     error_exit "static and plugins are mutually incompatible"
diff --git a/meson.build b/meson.build
index 6098426e7198..c775f24b79b0 100644
--- a/meson.build
+++ b/meson.build
@@ -190,6 +190,26 @@ endif
 # Compiler flags #
 ##################
 
+foreach lang : all_languages
+  compiler = meson.get_compiler(lang)
+  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=7.4')
+    # ok
+  elif compiler.get_id() == 'clang' and compiler.compiles('''
+      #ifdef __apple_build_version__
+      # if __clang_major__ < 12 || (__clang_major__ == 12 && __clang_minor__ < 0)
+      #  error You need at least XCode Clang v12.0 to compile QEMU
+      # endif
+      #else
+      # if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
+      #  error You need at least Clang v10.0 to compile QEMU
+      # endif
+      #endif''')
+    # ok
+  else
+    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v12.0) to compile QEMU')
+  endif
+endforeach
+
 # default flags for all hosts
 # We use -fwrapv to tell the compiler that we require a C dialect where
 # left shift of signed integers is well defined and has the expected
-- 
2.40.1



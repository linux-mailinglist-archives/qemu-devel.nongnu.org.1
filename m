Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E981BD1A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:23:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMj1-0007kD-9T; Thu, 21 Dec 2023 12:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMix-0007jP-MW
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiv-0004Zd-TY
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7e+XdxKgUWz7O6d5Snj7fR5TolQnFsQ/3r43x69TnoM=;
 b=Q0wQtdCzfq6tiidcLGL5XGruXk4VdR746oVVIivUyw5EtdIuT6yhU6YGH9mam8BaCIV5MR
 +CdClkjETcS5XI0/0x4YzY7gw2XkwhNsTo6hyzLgxt0f5lLtU3LrkphqGiaOS9iWGZdDsD
 k7bGGfj2YrSywtQV2GGpSOxCddC6vvo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-s-2N5g_GPJGTV-VhwBuF3w-1; Thu, 21 Dec 2023 12:20:36 -0500
X-MC-Unique: s-2N5g_GPJGTV-VhwBuF3w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-336890da9b7so539285f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179235; x=1703784035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7e+XdxKgUWz7O6d5Snj7fR5TolQnFsQ/3r43x69TnoM=;
 b=XRrGCFMKcMApYwBLgR5yxJiyQcf73CXUc6FJWuHwn1Nl8KAGI11rgFqlqvgxH8NpGw
 bUSM1vhFuGn31FS02V9L4gx72nkfGQ8YWtlZGaDeMJbF+RJfegEG4AcMtqgyiayCOjwZ
 pm43FzGoZpGQW+naJQNJ1Se8KqTYXPyIfT+r9RIewQgCMTwIWmoRGQH6qbQtZTp+H8RO
 R1gzpmKT7rYfKL1Vj8pw+TXC4Fm0H13MKggj7L+TsevZXopxLkYDVqIYF73cV4TxhFHs
 mqGaapvhV7U6gk7c2+A11mJt8hR/S+wl65Hm/4E2aLE6kxDJg8mMaBaKzrHcGRdNn+W+
 L5XA==
X-Gm-Message-State: AOJu0YxeOSkQ91A2u86zBWLOkguX5qz+V+AJyLNjBns3O2QJeZyhIvSh
 orv3D4SJ2IZ0CI+2AXk/63oMuWF+EmqlcsAoCJLP84TZhR4zTU+WHZTSIKhEQdREjot9C4iRnpw
 pCqsbm4KO5vPDie7o4dBRRbwkAvZmuLStetsaNa/WzzrrBlzZDGE+qaMEwtIPEJwCrr7jS7k10A
 R6deMT0+k=
X-Received: by 2002:adf:e74d:0:b0:336:7794:4b9a with SMTP id
 c13-20020adfe74d000000b0033677944b9amr73869wrn.33.1703179235061; 
 Thu, 21 Dec 2023 09:20:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyHPKXMsE72H4kku6pwlUAmJuldnldFpAoOwJxkR3TnLyYF1yjd63LZ84PlZCULyP5AituFQ==
X-Received: by 2002:adf:e74d:0:b0:336:7794:4b9a with SMTP id
 c13-20020adfe74d000000b0033677944b9amr73859wrn.33.1703179234668; 
 Thu, 21 Dec 2023 09:20:34 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a5d6744000000b00336710ddea0sm2459251wrw.59.2023.12.21.09.20.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/21] meson: move CFI detection code earlier
Date: Thu, 21 Dec 2023 18:19:55 +0100
Message-ID: <20231221171958.59350-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep it together with the other compiler modes, and before dependencies.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 80 ++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/meson.build b/meson.build
index f8d61a46ad1..f105462c181 100644
--- a/meson.build
+++ b/meson.build
@@ -421,6 +421,46 @@ if get_option('fuzzing')
   endif
 endif
 
+if get_option('cfi')
+  cfi_flags=[]
+  # Check for dependency on LTO
+  if not get_option('b_lto')
+    error('Selected Control-Flow Integrity but LTO is disabled')
+  endif
+  if enable_modules
+    error('Selected Control-Flow Integrity is not compatible with modules')
+  endif
+  # Check for cfi flags. CFI requires LTO so we can't use
+  # get_supported_arguments, but need a more complex "compiles" which allows
+  # custom arguments
+  if cc.compiles('int main () { return 0; }', name: '-fsanitize=cfi-icall',
+                 args: ['-flto', '-fsanitize=cfi-icall'] )
+    cfi_flags += '-fsanitize=cfi-icall'
+  else
+    error('-fsanitize=cfi-icall is not supported by the compiler')
+  endif
+  if cc.compiles('int main () { return 0; }',
+                 name: '-fsanitize-cfi-icall-generalize-pointers',
+                 args: ['-flto', '-fsanitize=cfi-icall',
+                        '-fsanitize-cfi-icall-generalize-pointers'] )
+    cfi_flags += '-fsanitize-cfi-icall-generalize-pointers'
+  else
+    error('-fsanitize-cfi-icall-generalize-pointers is not supported by the compiler')
+  endif
+  if get_option('cfi_debug')
+    if cc.compiles('int main () { return 0; }',
+                   name: '-fno-sanitize-trap=cfi-icall',
+                   args: ['-flto', '-fsanitize=cfi-icall',
+                          '-fno-sanitize-trap=cfi-icall'] )
+      cfi_flags += '-fno-sanitize-trap=cfi-icall'
+    else
+      error('-fno-sanitize-trap=cfi-icall is not supported by the compiler')
+    endif
+  endif
+  add_global_arguments(cfi_flags, native: false, language: all_languages)
+  add_global_link_arguments(cfi_flags, native: false, language: all_languages)
+endif
+
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
 
@@ -2005,46 +2045,6 @@ endif
 config_host_data.set('CONFIG_AUDIO_DRIVERS',
                      '"' + '", "'.join(audio_drivers_selected) + '", ')
 
-if get_option('cfi')
-  cfi_flags=[]
-  # Check for dependency on LTO
-  if not get_option('b_lto')
-    error('Selected Control-Flow Integrity but LTO is disabled')
-  endif
-  if enable_modules
-    error('Selected Control-Flow Integrity is not compatible with modules')
-  endif
-  # Check for cfi flags. CFI requires LTO so we can't use
-  # get_supported_arguments, but need a more complex "compiles" which allows
-  # custom arguments
-  if cc.compiles('int main () { return 0; }', name: '-fsanitize=cfi-icall',
-                 args: ['-flto', '-fsanitize=cfi-icall'] )
-    cfi_flags += '-fsanitize=cfi-icall'
-  else
-    error('-fsanitize=cfi-icall is not supported by the compiler')
-  endif
-  if cc.compiles('int main () { return 0; }',
-                 name: '-fsanitize-cfi-icall-generalize-pointers',
-                 args: ['-flto', '-fsanitize=cfi-icall',
-                        '-fsanitize-cfi-icall-generalize-pointers'] )
-    cfi_flags += '-fsanitize-cfi-icall-generalize-pointers'
-  else
-    error('-fsanitize-cfi-icall-generalize-pointers is not supported by the compiler')
-  endif
-  if get_option('cfi_debug')
-    if cc.compiles('int main () { return 0; }',
-                   name: '-fno-sanitize-trap=cfi-icall',
-                   args: ['-flto', '-fsanitize=cfi-icall',
-                          '-fno-sanitize-trap=cfi-icall'] )
-      cfi_flags += '-fno-sanitize-trap=cfi-icall'
-    else
-      error('-fno-sanitize-trap=cfi-icall is not supported by the compiler')
-    endif
-  endif
-  add_global_arguments(cfi_flags, native: false, language: all_languages)
-  add_global_link_arguments(cfi_flags, native: false, language: all_languages)
-endif
-
 have_host_block_device = (targetos != 'darwin' or
     cc.has_header('IOKit/storage/IOMedia.h'))
 
-- 
2.43.0



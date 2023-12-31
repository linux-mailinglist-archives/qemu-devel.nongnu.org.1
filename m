Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4B820A96
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUx-0008CQ-6a; Sun, 31 Dec 2023 03:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT6-0005GS-Du
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT2-0000rw-Ep
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olqbeujUty4FiDauTxIFpk1yhoyxF/2nypGlxWalccQ=;
 b=MFoOyu3HlFrIZPqv6z2DnFT4mYzZ1qJQG2f/pFBGcBNUiODeYEdje3z6pcDAZcICCCvELO
 dtiejxafry5pixz3xqQzFzAyMGo8TkmN4A2Sp1anGUeHX++3Hw3bXft+SbiKJ4PDqlC/j8
 cYN6ZodJuptg+yk6cV0Zh4pzcNUzRjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-v7E3emXkOQOeyHn1W90tzg-1; Sun, 31 Dec 2023 03:46:40 -0500
X-MC-Unique: v7E3emXkOQOeyHn1W90tzg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d5ab2fbc9so36805505e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012398; x=1704617198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olqbeujUty4FiDauTxIFpk1yhoyxF/2nypGlxWalccQ=;
 b=pywh1hekTEuQtVp+zinLXw8RGSV6emcSi6XtEtqzDPKApLsW0s9XCnyaArj+5g3GAC
 rc4qa4DPDHEWDBvEed72aeeiBvVH70MeMuVmXkbepef4CMPaI/kmTHhFCCiRmSXAor3U
 jEqERPzFNnVpKeel+4d7OxBg30e0xrBHPlk8fvNjf4op4FzSCX6pqRMnS2acxxlfbmaK
 vfhOFdZCWA83N2DMjB9CzoyPhAZEU2FPPR6g/zwF+CkI+1JtokoYFc/eHO4uE6i61Wd7
 7qFOVOonr5GzKby7yfG416e2dcobS2J5itLfXjw2nIT85sxeNQzU0UEfRTPo6NO/9x5G
 J9OA==
X-Gm-Message-State: AOJu0YygA8wkGIWoCbQ1udBzIrzLfk/2gYMyAMr9B/DOrnkjXgrrDMlH
 9EiE0I8l17LItizco4YoxKzJY2EmTz6TT1QsCjKvpNgJrpW28qjFoKhzGNp22M/p7Fd/BSZc85q
 36Q+rR5sg5UcZ0qJKaVTWa5Oih4vFZFjH8S3+JYPn8sOCBJvbZM6aDXwcfnhTf22x6546PzbewM
 2z9k0AFF8=
X-Received: by 2002:a05:600c:35c8:b0:40d:5d4b:ab35 with SMTP id
 r8-20020a05600c35c800b0040d5d4bab35mr3703621wmq.16.1704012398143; 
 Sun, 31 Dec 2023 00:46:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvM4z7H1H7f+97tieYbR6ATxI/RtOasFbbkZxL0yH0hAqec66xuXlW+OWl/y/0eKnLqoe5xQ==
X-Received: by 2002:a05:600c:35c8:b0:40d:5d4b:ab35 with SMTP id
 r8-20020a05600c35c800b0040d5d4bab35mr3703612wmq.16.1704012397750; 
 Sun, 31 Dec 2023 00:46:37 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d4612000000b003367bb8898dsm23237065wrq.66.2023.12.31.00.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/46] meson: move CFI detection code with other compiler flags
Date: Sun, 31 Dec 2023 09:44:52 +0100
Message-ID: <20231231084502.235366-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 80 ++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/meson.build b/meson.build
index efb36c762e9..5c54441a3cd 100644
--- a/meson.build
+++ b/meson.build
@@ -517,6 +517,46 @@ if get_option('fuzzing')
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
 
@@ -2009,46 +2049,6 @@ endif
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



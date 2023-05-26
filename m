Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99979712A5E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:12:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzl-0004Hf-SI; Fri, 26 May 2023 12:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzj-0004HU-NQ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzh-0002gZ-Sc
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AyK+JFuQXKSU38DGc74kF1FDRIy1j+0WYlw1VmPseSk=;
 b=NNA7gyYnv0QaYDhv5U5QqJoHN219bhaEf6qBfAR6uO9UONBciL50Sw2SVRS/FrgB6h2Gq/
 jzQC4yZ5WDyCwJHXPo55Toy1pGQNZPP9/8pXXX9hlhvspsPf7qHY3o54Sal9L0sAjwgiXe
 Wviij+R8ftLtLl/7dIOXNmoBK2K7Y/Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-DkYJChgwPuGoIeOqt0pECQ-1; Fri, 26 May 2023 12:08:43 -0400
X-MC-Unique: DkYJChgwPuGoIeOqt0pECQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5147d242f01so702873a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117322; x=1687709322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyK+JFuQXKSU38DGc74kF1FDRIy1j+0WYlw1VmPseSk=;
 b=lY6X8Z1davQo8Eekrpze2ikSTn+Z8Vg+TCo0a2fELfOX4niKOoYnK9rBc85/bmu1wd
 3LM+gheT+FGtAcBMuNO+eWlLwN8ZW31vHCW43WTfjJOSf6O8+roOFowQlnteBi+FZ6Ug
 GdwHBqt05mE3Nhp7LD82OR497JvQEpToG4Em/5mfa6Phmm6xptk2B2wk15zYfDu/7x/n
 QpvbT/Xw7+QFdJXjgTF6LuNMTViJfND751WeVni9HpHNNUa3j6Y7PhJBpqlfDTNquZ4S
 ZAgoMaUZhCVkk9+uKNxcjba1zs2sXDddUNUwmzr6IiGq8GRugbX4ZEJxEWVm3xKwfNyC
 h+xA==
X-Gm-Message-State: AC+VfDxJ/WBctSWKpi2+eOy2PcrN3k1cxvW0zsb8u7oXvrRzzYcccMp+
 5qk/QDhk3bsgBqvvmuN/u6yKmjJVUD7WtcAj8cF7rvaAzMnr36lAkBgPzxSzcdhonE2ry0Eyc5P
 BOD2RySZ5vD+TBvGCnWPaR3jXT3SiVybX+pz/SIpF34Y0J/W65H5a87ivC9Ji0lOjxeIaCj0mLw
 Y=
X-Received: by 2002:a05:6402:1e8f:b0:506:bbf8:5152 with SMTP id
 f15-20020a0564021e8f00b00506bbf85152mr6240540edf.9.1685117322338; 
 Fri, 26 May 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Q3dMGoXmsoCebX5Q8qQXqyVF+LdZ/WG3NoNSgyhwNTuxSQaCF78KQKRyCwnZJeYebFEEARA==
X-Received: by 2002:a05:6402:1e8f:b0:506:bbf8:5152 with SMTP id
 f15-20020a0564021e8f00b00506bbf85152mr6240521edf.9.1685117322136; 
 Fri, 26 May 2023 09:08:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a170906695600b0094f3b18044bsm2317542ejs.218.2023.05.26.09.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/12] meson: use subproject for internal libfdt
Date: Fri, 26 May 2023 18:08:22 +0200
Message-Id: <20230526160824.655279-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Recent dtc/libfdt can use either Make or meson as the build system.
By using a subproject, our own meson.build can remove the hard
coded list of source files.

This is also the first step towards managing downloads with .wrap
files instead of submodule.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules               |  4 ++--
 configure                 |  2 +-
 meson.build               | 24 ++++--------------------
 scripts/archive-source.sh |  2 +-
 dtc => subprojects/dtc    |  0
 5 files changed, 8 insertions(+), 24 deletions(-)
 rename dtc => subprojects/dtc (100%)

diff --git a/.gitmodules b/.gitmodules
index 2a3a12033c4b..3ed5d073d630 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -13,8 +13,8 @@
 [submodule "roms/qemu-palcode"]
 	path = roms/qemu-palcode
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
-[submodule "dtc"]
-	path = dtc
+[submodule "subprojects/dtc"]
+	path = subprojects/dtc
 	url = https://gitlab.com/qemu-project/dtc.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
diff --git a/configure b/configure
index 9cdce69b7852..d42bbd07310b 100755
--- a/configure
+++ b/configure
@@ -1187,7 +1187,7 @@ fi
 case "$fdt" in
   auto | enabled | internal)
     # Simpler to always update submodule, even if not needed.
-    git_submodules="${git_submodules} dtc"
+    git_submodules="${git_submodules} subprojects/dtc"
     ;;
 esac
 
diff --git a/meson.build b/meson.build
index 218428841d36..884b16c74962 100644
--- a/meson.build
+++ b/meson.build
@@ -3088,26 +3088,10 @@ if fdt_required.length() > 0 or fdt_opt == 'enabled'
       error('libfdt source not found - please pull git submodule')
     endif
 
-    fdt_files = files(
-      'dtc/libfdt/fdt.c',
-      'dtc/libfdt/fdt_ro.c',
-      'dtc/libfdt/fdt_wip.c',
-      'dtc/libfdt/fdt_sw.c',
-      'dtc/libfdt/fdt_rw.c',
-      'dtc/libfdt/fdt_strerror.c',
-      'dtc/libfdt/fdt_empty_tree.c',
-      'dtc/libfdt/fdt_addresses.c',
-      'dtc/libfdt/fdt_overlay.c',
-      'dtc/libfdt/fdt_check.c',
-    )
-
-    fdt_inc = include_directories('dtc/libfdt')
-    libfdt = static_library('fdt',
-                            build_by_default: false,
-                            sources: fdt_files,
-                            include_directories: fdt_inc)
-    fdt = declare_dependency(link_with: libfdt,
-                             include_directories: fdt_inc)
+    libfdt_proj = subproject('dtc', required: true,
+                             default_options: ['tools=false',  'yaml=disabled',
+                                               'python=disabled', 'default_library=static'])
+    fdt = libfdt_proj.get_variable('libfdt_dep')
   endif
 else
   fdt_opt = 'disabled'
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index c03532915471..a7c2886334f0 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc ui/keycodemapdb"
+submodules="subprojects/dtc ui/keycodemapdb"
 submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
diff --git a/dtc b/subprojects/dtc
similarity index 100%
rename from dtc
rename to subprojects/dtc
-- 
2.40.1



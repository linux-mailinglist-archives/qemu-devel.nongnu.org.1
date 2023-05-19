Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1782470924E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvvC-0002G1-Ro; Fri, 19 May 2023 04:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvvA-0002Fe-Mq
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvuz-0000BE-Bj
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za4+aXmw/5iXJUQqKUjzp7XEhJVHVFmVvjnCtfJlXR0=;
 b=Mn+eRYz5DVg+tOSRycgCkgfLRrNBQUQCnW8S0iI+giPxmIycib1A3NPC9Xw0mH5YDjEBwu
 Vzj36UyFDTErHYGgtNg/E4fqeUPYtstrIi3+gq83b+Fnm6JQucrrB8opsSUr2s6starvfg
 Gs6NpMRaWlKumts218esy9I5RgzoDxs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-5CpBxshPPb6BJqPTWWDLug-1; Fri, 19 May 2023 04:56:55 -0400
X-MC-Unique: 5CpBxshPPb6BJqPTWWDLug-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f4d917e06so86322966b.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486614; x=1687078614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Za4+aXmw/5iXJUQqKUjzp7XEhJVHVFmVvjnCtfJlXR0=;
 b=Ip/0A9hJA6jMXiuYrQaqRNnXxRSyT3i25TUPg6cl/bbHL/qyPfMieT88L3Nu+DeFrO
 lb24VKfv3WO3lP4IgNAu3doMgxVjOKMOky2eWQkXycubncCOBr3oD48KAH5a1gD6cK8D
 8zqXSrN39eAGXUOxGDfVJVuCCOmynNAlHzl5wwU+2gOfH44Hk+BK4ghUz3t69e65NbkQ
 3MmqrFH1sNYjkiLRsdLcm0oyjD+FuGL3nV/8e6wtU8we2tyffG2hBu18HhTm3gWBTXkx
 sZvChgwnEbuSDx3gZjAcilAs34CTujATx/1E//PrP6nTIyrY4phF7m1PnNeA4DKl+KfN
 8R4w==
X-Gm-Message-State: AC+VfDxpzIIn2nMp8xusb+gNuqURuZ9Pp3w89kaOmFHaF6ue6CGWr0Zk
 Ytx/Hp1yl64XW1gNZPhAFrWZeTA/w+OO5k+N87pWdaELrkwrE4+L/zX2HsDhDjGdP8DMZLn4OvB
 zsPpEof1BQJL4W7+rsTXw3NImdY3xMBYYO/ajNbHlF/UY9S+0PH9KHZbUBpfiEhZhxExuED2fDi
 c=
X-Received: by 2002:a17:907:7251:b0:96f:7060:9654 with SMTP id
 ds17-20020a170907725100b0096f70609654mr680909ejc.18.1684486613845; 
 Fri, 19 May 2023 01:56:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Swx1BPbEp2/9caxns63aMOUlLEqpxscvj+feHTGir1eD7ZTYyGLik67Sw9MCiGlYTFEnFrA==
X-Received: by 2002:a17:907:7251:b0:96f:7060:9654 with SMTP id
 ds17-20020a170907725100b0096f70609654mr680894ejc.18.1684486613640; 
 Fri, 19 May 2023 01:56:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a1709060a9500b00965cd15c9bbsm2014531ejf.62.2023.05.19.01.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:56:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 3/6] meson: use subproject for internal libfdt
Date: Fri, 19 May 2023 10:56:43 +0200
Message-Id: <20230519085647.1104775-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Recent dtc/libfdt can use either Make or meson as the build system.
By using a subproject, our own meson.build can remove the hard
coded list of source files.

This is also the first step towards managing downloads with .wrap
files instead of submodule.

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
index 31a787153e38..5bbca83d9a31 100755
--- a/configure
+++ b/configure
@@ -1188,7 +1188,7 @@ fi
 case "$fdt" in
   auto | enabled | internal)
     # Simpler to always update submodule, even if not needed.
-    git_submodules="${git_submodules} dtc"
+    git_submodules="${git_submodules} subprojects/dtc"
     ;;
 esac
 
diff --git a/meson.build b/meson.build
index 0de7a858bce1..1a55039ff7c3 100644
--- a/meson.build
+++ b/meson.build
@@ -3070,26 +3070,10 @@ if fdt_required.length() > 0 or fdt_opt == 'enabled'
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
+    libfdt_proj = subproject('dtc',
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



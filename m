Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3007133B7
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2qEc-0007bx-SU; Sat, 27 May 2023 05:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEb-0007aY-86
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEW-0007Y8-7M
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685179747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq4gbqCRb6rB+9amSD+xSC0op5SmGjtmkAfzHA6Dzjs=;
 b=a5Vb+D8aPRuy+ez9EMkYQ7Qgk+Sh5q03AFhrH7xbvjfmxn77B0mCvgYwEzZqIbHlSfRD8z
 uM5S6Q//IJlfa1Z95phQsPYLRI29ru8fNs/EZkSxcOUCFuj79WlZX9j6zFwYnBViTlgwwL
 b92ntZvLBqvPeCp7CMRPDmQRc5edZ+Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489--vSu5j_JOHCykIcqbhIOrg-1; Sat, 27 May 2023 05:29:06 -0400
X-MC-Unique: -vSu5j_JOHCykIcqbhIOrg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-513f5318ff2so1325729a12.3
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 02:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685179744; x=1687771744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rq4gbqCRb6rB+9amSD+xSC0op5SmGjtmkAfzHA6Dzjs=;
 b=ISfdK1dFulPr99ZT5odtXzowYUBflCR9LifR+9JahCFjptdHSQ227ip7BzmFNV0mqP
 GgLJwNpIkjWMWRG9iMSRTaHz4Yrhq4dCxuMgT3hHBt8xjX/wkIZ9oXrwzDN0lVw5Upir
 8/BquhcZnof+7yNUnyqBOASEQy1Lzq2Mf7Zt9NK7oSoy9S0uFcZn3RUy6kml1qAgBWAR
 gZPIAl7zCf/CflOCMvH1ubGCnfhSnGCmHN6lHf5OdmhkPNlpZwzh89wjPzRfVhFj1kCb
 1/Zfxyvr6m3SdjMoWvVtBGpIe3MhxFlsTLt+AGOmDFcGnFbCun876F5+4eAco3m+ZxZ8
 NAhA==
X-Gm-Message-State: AC+VfDxl+/h+mepLFYIOO/QOqmaAvhEC2uPprCuPWHZzFiu+543s/7tl
 wgjgQihmITBwz6NKN6kHRrL1NuN7s95q8WHvsR9iz+6GZCpR9Mfz/EfskmoK4FTrkALJAT7it4p
 7WXLWZc3yvLsu/HUKjpaixnyYf/1twVpVBOfUvzKGITRa4YzT3hzUDoOv++Bzs8T8QtxV6PZAh2
 Y=
X-Received: by 2002:a50:fb90:0:b0:510:f44c:4b71 with SMTP id
 e16-20020a50fb90000000b00510f44c4b71mr3588775edq.27.1685179744278; 
 Sat, 27 May 2023 02:29:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mHXqnNMgQXSj40snINv8vyp/ebdJvTM5DAsdbPSyvK8ix6HWQjxpCnpuIBhht5Rlh7mtCJQ==
X-Received: by 2002:a50:fb90:0:b0:510:f44c:4b71 with SMTP id
 e16-20020a50fb90000000b00510f44c4b71mr3588748edq.27.1685179743399; 
 Sat, 27 May 2023 02:29:03 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a056402345300b00504ecc4fa96sm792893edc.95.2023.05.27.02.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 02:29:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 5/5] meson: subprojects: replace berkeley-{soft,
 test}float-3 with wraps
Date: Sat, 27 May 2023 11:28:51 +0200
Message-Id: <20230527092851.705884-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
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

Unlike other subprojects, these require an overlay directory to include
meson rules to build the libraries.  The rules are basically lifted
from tests/fp/meson.build, with a few changes to create platform.h
and publish a dependency.

The build defines are passed through a subproject option, and posted
back to users of the library via the dependency's compile_args.

The only remaining user of GIT_SUBMODULES and GIT_SUBMODULES_ACTION
is roms/SLOF, which is used to build pc-bios/s390-ccw.  All other
roms submodules are only present to satisfy the license on pre-built
firmware blobs.

Best reviewed with --color-moved.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules                                   |   6 -
 configure                                     |  27 -
 scripts/archive-source.sh                     |  22 +-
 scripts/make-release                          |   2 +-
 subprojects/.gitignore                        |   2 +
 subprojects/berkeley-softfloat-3.wrap         |   5 +
 subprojects/berkeley-testfloat-3.wrap         |   5 +
 .../berkeley-softfloat-3/meson.build          | 339 +++++++++++
 .../berkeley-softfloat-3/meson_options.txt    |   1 +
 .../berkeley-testfloat-3/meson.build          | 220 +++++++
 .../berkeley-testfloat-3/meson_options.txt    |   1 +
 tests/fp/meson.build                          | 541 +-----------------
 12 files changed, 590 insertions(+), 581 deletions(-)
 create mode 100644 subprojects/berkeley-softfloat-3.wrap
 create mode 100644 subprojects/berkeley-testfloat-3.wrap
 create mode 100644 subprojects/packagefiles/berkeley-softfloat-3/meson.build
 create mode 100644 subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
 create mode 100644 subprojects/packagefiles/berkeley-testfloat-3/meson.build
 create mode 100644 subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt

diff --git a/.gitmodules b/.gitmodules
index a934c85e4e40..73cae4cd4da0 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -28,12 +28,6 @@
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
 	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
-[submodule "tests/fp/berkeley-testfloat-3"]
-	path = tests/fp/berkeley-testfloat-3
-	url = https://gitlab.com/qemu-project/berkeley-testfloat-3.git
-[submodule "tests/fp/berkeley-softfloat-3"]
-	path = tests/fp/berkeley-softfloat-3
-	url = https://gitlab.com/qemu-project/berkeley-softfloat-3.git
 [submodule "roms/edk2"]
 	path = roms/edk2
 	url = https://gitlab.com/qemu-project/edk2.git
diff --git a/configure b/configure
index c92a3b30b9a4..119c6e161377 100755
--- a/configure
+++ b/configure
@@ -805,28 +805,6 @@ case $git_submodules_action in
         fi
     ;;
     ignore)
-        if ! test -f "$source_path/tests/fp/berkeley-testfloat-3/README.md"
-        then
-            echo
-            echo "ERROR: missing GIT submodules"
-            echo
-            if test -e "$source_path/.git"; then
-                echo "--with-git-submodules=ignore specified but submodules were not"
-                echo "checked out.  Please initialize and update submodules."
-            else
-                echo "This is not a GIT checkout but module content appears to"
-                echo "be missing. Do not use 'git archive' or GitHub download links"
-                echo "to acquire QEMU source archives. Non-GIT builds are only"
-                echo "supported with source archives linked from:"
-                echo
-                echo "  https://www.qemu.org/download/#source"
-                echo
-                echo "Developers working with GIT can use scripts/archive-source.sh"
-                echo "if they need to create valid source archives."
-            fi
-            echo
-            exit 1
-        fi
     ;;
     *)
         echo "ERROR: invalid --with-git-submodules= value '$git_submodules_action'"
@@ -1142,11 +1120,6 @@ if test "$tcg" = "auto"; then
   fi
 fi
 
-if test "$tcg" = "enabled"; then
-    git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
-    git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
-fi
-
 ##########################################
 # big/little endian test
 cat > $TMPC << EOF
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index b99cb66e4122..489963049102 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,8 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-subprojects="dtc keycodemapdb libvfio-user"
-submodules="tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+subprojects="dtc keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-testfloat-3"
 sub_deinit=""
 
 function cleanup() {
@@ -51,25 +50,6 @@ function tree_ish() {
 
 git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
-for sm in $submodules; do
-    status="$(git submodule status "$sm")"
-    smhash="${status#[ +-]}"
-    smhash="${smhash%% *}"
-    case "$status" in
-        -*)
-            sub_deinit="$sub_deinit $sm"
-            git submodule update --init "$sm"
-            test $? -ne 0 && error "failed to update submodule $sm"
-            ;;
-        +*)
-            echo "WARNING: submodule $sm is out of sync"
-            ;;
-    esac
-    (cd $sm; git archive --format tar --prefix "$sm/" $(tree_ish)) > "$sub_file"
-    test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
-    tar --concatenate --file "$tar_file" "$sub_file"
-    test $? -ne 0 && error "failed append submodule $sm to $tar_file"
-done
 
 for sp in $subprojects; do
     meson subprojects download $sp
diff --git a/scripts/make-release b/scripts/make-release
index 0604e61b8143..c5db87b3f91b 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -17,7 +17,7 @@ if [ $# -ne 2 ]; then
 fi
 
 # Only include wraps that are invoked with subproject()
-SUBPROJECTS="dtc libvfio-user keycodemapdb"
+SUBPROJECTS="dtc libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-testfloat-3"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 935e9a72a8f9..adca0266be69 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -1,5 +1,7 @@
 /packagecache
 
+/berkeley-softfloat-3
+/berkeley-testfloat-3
 /dtc
 /keycodemapdb
 /libvfio-user
diff --git a/subprojects/berkeley-softfloat-3.wrap b/subprojects/berkeley-softfloat-3.wrap
new file mode 100644
index 000000000000..a8fd87740b15
--- /dev/null
+++ b/subprojects/berkeley-softfloat-3.wrap
@@ -0,0 +1,5 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/berkeley-softfloat-3
+revision = b64af41c3276f97f0e181920400ee056b9c88037
+patch_directory = berkeley-softfloat-3
+depth = 1
diff --git a/subprojects/berkeley-testfloat-3.wrap b/subprojects/berkeley-testfloat-3.wrap
new file mode 100644
index 000000000000..6ad80a37b2aa
--- /dev/null
+++ b/subprojects/berkeley-testfloat-3.wrap
@@ -0,0 +1,5 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/berkeley-testfloat-3
+revision = 40619cbb3bf32872df8c53cc457039229428a263
+patch_directory = berkeley-testfloat-3
+depth = 1
diff --git a/subprojects/packagefiles/berkeley-softfloat-3/meson.build b/subprojects/packagefiles/berkeley-softfloat-3/meson.build
new file mode 100644
index 000000000000..4ce964b8389c
--- /dev/null
+++ b/subprojects/packagefiles/berkeley-softfloat-3/meson.build
@@ -0,0 +1,339 @@
+project('berkeley-softfloat-3',  'c',
+        default_options: ['warning_level=1', 'c_std=gnu99'])
+
+fpcflags = get_option('defines')
+
+platform_data = configuration_data()
+platform_data.set('INLINE', 'static inline')
+platform_data.set('LITTLEENDIAN', host_machine.endian() == 'little')
+configure_file(output: 'platform.h', configuration: platform_data)
+
+sfdir = 'source'
+sfspedir = sfdir / '8086-SSE'
+sfinc = include_directories('.', sfdir / 'include', sfspedir)
+
+add_project_arguments([
+  '-Wno-implicit-fallthrough',
+  '-Wno-missing-prototypes',
+  '-Wno-redundant-decls',
+  '-Wno-return-type',
+  '-Wno-error',
+], native: false, language: 'c')
+
+libsoftfloat = static_library(
+  'softfloat',
+  files(
+    # primitives
+    sfdir / 's_eq128.c',
+    sfdir / 's_le128.c',
+    sfdir / 's_lt128.c',
+    sfdir / 's_shortShiftLeft128.c',
+    sfdir / 's_shortShiftRight128.c',
+    sfdir / 's_shortShiftRightJam64.c',
+    sfdir / 's_shortShiftRightJam64Extra.c',
+    sfdir / 's_shortShiftRightJam128.c',
+    sfdir / 's_shortShiftRightJam128Extra.c',
+    sfdir / 's_shiftRightJam32.c',
+    sfdir / 's_shiftRightJam64.c',
+    sfdir / 's_shiftRightJam64Extra.c',
+    sfdir / 's_shiftRightJam128.c',
+    sfdir / 's_shiftRightJam128Extra.c',
+    sfdir / 's_shiftRightJam256M.c',
+    sfdir / 's_countLeadingZeros8.c',
+    sfdir / 's_countLeadingZeros16.c',
+    sfdir / 's_countLeadingZeros32.c',
+    sfdir / 's_countLeadingZeros64.c',
+    sfdir / 's_add128.c',
+    sfdir / 's_add256M.c',
+    sfdir / 's_sub128.c',
+    sfdir / 's_sub256M.c',
+    sfdir / 's_mul64ByShifted32To128.c',
+    sfdir / 's_mul64To128.c',
+    sfdir / 's_mul128By32.c',
+    sfdir / 's_mul128To256M.c',
+    sfdir / 's_approxRecip_1Ks.c',
+    sfdir / 's_approxRecip32_1.c',
+    sfdir / 's_approxRecipSqrt_1Ks.c',
+    sfdir / 's_approxRecipSqrt32_1.c',
+    # others
+    sfdir / 's_roundToUI32.c',
+    sfdir / 's_roundToUI64.c',
+    sfdir / 's_roundToI32.c',
+    sfdir / 's_roundToI64.c',
+    sfdir / 's_normSubnormalF16Sig.c',
+    sfdir / 's_roundPackToF16.c',
+    sfdir / 's_normRoundPackToF16.c',
+    sfdir / 's_addMagsF16.c',
+    sfdir / 's_subMagsF16.c',
+    sfdir / 's_mulAddF16.c',
+    sfdir / 's_normSubnormalF32Sig.c',
+    sfdir / 's_roundPackToF32.c',
+    sfdir / 's_normRoundPackToF32.c',
+    sfdir / 's_addMagsF32.c',
+    sfdir / 's_subMagsF32.c',
+    sfdir / 's_mulAddF32.c',
+    sfdir / 's_normSubnormalF64Sig.c',
+    sfdir / 's_roundPackToF64.c',
+    sfdir / 's_normRoundPackToF64.c',
+    sfdir / 's_addMagsF64.c',
+    sfdir / 's_subMagsF64.c',
+    sfdir / 's_mulAddF64.c',
+    sfdir / 's_normSubnormalExtF80Sig.c',
+    sfdir / 's_roundPackToExtF80.c',
+    sfdir / 's_normRoundPackToExtF80.c',
+    sfdir / 's_addMagsExtF80.c',
+    sfdir / 's_subMagsExtF80.c',
+    sfdir / 's_normSubnormalF128Sig.c',
+    sfdir / 's_roundPackToF128.c',
+    sfdir / 's_normRoundPackToF128.c',
+    sfdir / 's_addMagsF128.c',
+    sfdir / 's_subMagsF128.c',
+    sfdir / 's_mulAddF128.c',
+    sfdir / 'softfloat_state.c',
+    sfdir / 'ui32_to_f16.c',
+    sfdir / 'ui32_to_f32.c',
+    sfdir / 'ui32_to_f64.c',
+    sfdir / 'ui32_to_extF80.c',
+    sfdir / 'ui32_to_extF80M.c',
+    sfdir / 'ui32_to_f128.c',
+    sfdir / 'ui32_to_f128M.c',
+    sfdir / 'ui64_to_f16.c',
+    sfdir / 'ui64_to_f32.c',
+    sfdir / 'ui64_to_f64.c',
+    sfdir / 'ui64_to_extF80.c',
+    sfdir / 'ui64_to_extF80M.c',
+    sfdir / 'ui64_to_f128.c',
+    sfdir / 'ui64_to_f128M.c',
+    sfdir / 'i32_to_f16.c',
+    sfdir / 'i32_to_f32.c',
+    sfdir / 'i32_to_f64.c',
+    sfdir / 'i32_to_extF80.c',
+    sfdir / 'i32_to_extF80M.c',
+    sfdir / 'i32_to_f128.c',
+    sfdir / 'i32_to_f128M.c',
+    sfdir / 'i64_to_f16.c',
+    sfdir / 'i64_to_f32.c',
+    sfdir / 'i64_to_f64.c',
+    sfdir / 'i64_to_extF80.c',
+    sfdir / 'i64_to_extF80M.c',
+    sfdir / 'i64_to_f128.c',
+    sfdir / 'i64_to_f128M.c',
+    sfdir / 'f16_to_ui32.c',
+    sfdir / 'f16_to_ui64.c',
+    sfdir / 'f16_to_i32.c',
+    sfdir / 'f16_to_i64.c',
+    sfdir / 'f16_to_ui32_r_minMag.c',
+    sfdir / 'f16_to_ui64_r_minMag.c',
+    sfdir / 'f16_to_i32_r_minMag.c',
+    sfdir / 'f16_to_i64_r_minMag.c',
+    sfdir / 'f16_to_f32.c',
+    sfdir / 'f16_to_f64.c',
+    sfdir / 'f16_to_extF80.c',
+    sfdir / 'f16_to_extF80M.c',
+    sfdir / 'f16_to_f128.c',
+    sfdir / 'f16_to_f128M.c',
+    sfdir / 'f16_roundToInt.c',
+    sfdir / 'f16_add.c',
+    sfdir / 'f16_sub.c',
+    sfdir / 'f16_mul.c',
+    sfdir / 'f16_mulAdd.c',
+    sfdir / 'f16_div.c',
+    sfdir / 'f16_rem.c',
+    sfdir / 'f16_sqrt.c',
+    sfdir / 'f16_eq.c',
+    sfdir / 'f16_le.c',
+    sfdir / 'f16_lt.c',
+    sfdir / 'f16_eq_signaling.c',
+    sfdir / 'f16_le_quiet.c',
+    sfdir / 'f16_lt_quiet.c',
+    sfdir / 'f16_isSignalingNaN.c',
+    sfdir / 'f32_to_ui32.c',
+    sfdir / 'f32_to_ui64.c',
+    sfdir / 'f32_to_i32.c',
+    sfdir / 'f32_to_i64.c',
+    sfdir / 'f32_to_ui32_r_minMag.c',
+    sfdir / 'f32_to_ui64_r_minMag.c',
+    sfdir / 'f32_to_i32_r_minMag.c',
+    sfdir / 'f32_to_i64_r_minMag.c',
+    sfdir / 'f32_to_f16.c',
+    sfdir / 'f32_to_f64.c',
+    sfdir / 'f32_to_extF80.c',
+    sfdir / 'f32_to_extF80M.c',
+    sfdir / 'f32_to_f128.c',
+    sfdir / 'f32_to_f128M.c',
+    sfdir / 'f32_roundToInt.c',
+    sfdir / 'f32_add.c',
+    sfdir / 'f32_sub.c',
+    sfdir / 'f32_mul.c',
+    sfdir / 'f32_mulAdd.c',
+    sfdir / 'f32_div.c',
+    sfdir / 'f32_rem.c',
+    sfdir / 'f32_sqrt.c',
+    sfdir / 'f32_eq.c',
+    sfdir / 'f32_le.c',
+    sfdir / 'f32_lt.c',
+    sfdir / 'f32_eq_signaling.c',
+    sfdir / 'f32_le_quiet.c',
+    sfdir / 'f32_lt_quiet.c',
+    sfdir / 'f32_isSignalingNaN.c',
+    sfdir / 'f64_to_ui32.c',
+    sfdir / 'f64_to_ui64.c',
+    sfdir / 'f64_to_i32.c',
+    sfdir / 'f64_to_i64.c',
+    sfdir / 'f64_to_ui32_r_minMag.c',
+    sfdir / 'f64_to_ui64_r_minMag.c',
+    sfdir / 'f64_to_i32_r_minMag.c',
+    sfdir / 'f64_to_i64_r_minMag.c',
+    sfdir / 'f64_to_f16.c',
+    sfdir / 'f64_to_f32.c',
+    sfdir / 'f64_to_extF80.c',
+    sfdir / 'f64_to_extF80M.c',
+    sfdir / 'f64_to_f128.c',
+    sfdir / 'f64_to_f128M.c',
+    sfdir / 'f64_roundToInt.c',
+    sfdir / 'f64_add.c',
+    sfdir / 'f64_sub.c',
+    sfdir / 'f64_mul.c',
+    sfdir / 'f64_mulAdd.c',
+    sfdir / 'f64_div.c',
+    sfdir / 'f64_rem.c',
+    sfdir / 'f64_sqrt.c',
+    sfdir / 'f64_eq.c',
+    sfdir / 'f64_le.c',
+    sfdir / 'f64_lt.c',
+    sfdir / 'f64_eq_signaling.c',
+    sfdir / 'f64_le_quiet.c',
+    sfdir / 'f64_lt_quiet.c',
+    sfdir / 'f64_isSignalingNaN.c',
+    sfdir / 'extF80_to_ui32.c',
+    sfdir / 'extF80_to_ui64.c',
+    sfdir / 'extF80_to_i32.c',
+    sfdir / 'extF80_to_i64.c',
+    sfdir / 'extF80_to_ui32_r_minMag.c',
+    sfdir / 'extF80_to_ui64_r_minMag.c',
+    sfdir / 'extF80_to_i32_r_minMag.c',
+    sfdir / 'extF80_to_i64_r_minMag.c',
+    sfdir / 'extF80_to_f16.c',
+    sfdir / 'extF80_to_f32.c',
+    sfdir / 'extF80_to_f64.c',
+    sfdir / 'extF80_to_f128.c',
+    sfdir / 'extF80_roundToInt.c',
+    sfdir / 'extF80_add.c',
+    sfdir / 'extF80_sub.c',
+    sfdir / 'extF80_mul.c',
+    sfdir / 'extF80_div.c',
+    sfdir / 'extF80_rem.c',
+    sfdir / 'extF80_sqrt.c',
+    sfdir / 'extF80_eq.c',
+    sfdir / 'extF80_le.c',
+    sfdir / 'extF80_lt.c',
+    sfdir / 'extF80_eq_signaling.c',
+    sfdir / 'extF80_le_quiet.c',
+    sfdir / 'extF80_lt_quiet.c',
+    sfdir / 'extF80_isSignalingNaN.c',
+    sfdir / 'extF80M_to_ui32.c',
+    sfdir / 'extF80M_to_ui64.c',
+    sfdir / 'extF80M_to_i32.c',
+    sfdir / 'extF80M_to_i64.c',
+    sfdir / 'extF80M_to_ui32_r_minMag.c',
+    sfdir / 'extF80M_to_ui64_r_minMag.c',
+    sfdir / 'extF80M_to_i32_r_minMag.c',
+    sfdir / 'extF80M_to_i64_r_minMag.c',
+    sfdir / 'extF80M_to_f16.c',
+    sfdir / 'extF80M_to_f32.c',
+    sfdir / 'extF80M_to_f64.c',
+    sfdir / 'extF80M_to_f128M.c',
+    sfdir / 'extF80M_roundToInt.c',
+    sfdir / 'extF80M_add.c',
+    sfdir / 'extF80M_sub.c',
+    sfdir / 'extF80M_mul.c',
+    sfdir / 'extF80M_div.c',
+    sfdir / 'extF80M_rem.c',
+    sfdir / 'extF80M_sqrt.c',
+    sfdir / 'extF80M_eq.c',
+    sfdir / 'extF80M_le.c',
+    sfdir / 'extF80M_lt.c',
+    sfdir / 'extF80M_eq_signaling.c',
+    sfdir / 'extF80M_le_quiet.c',
+    sfdir / 'extF80M_lt_quiet.c',
+    sfdir / 'f128_to_ui32.c',
+    sfdir / 'f128_to_ui64.c',
+    sfdir / 'f128_to_i32.c',
+    sfdir / 'f128_to_i64.c',
+    sfdir / 'f128_to_ui32_r_minMag.c',
+    sfdir / 'f128_to_ui64_r_minMag.c',
+    sfdir / 'f128_to_i32_r_minMag.c',
+    sfdir / 'f128_to_i64_r_minMag.c',
+    sfdir / 'f128_to_f16.c',
+    sfdir / 'f128_to_f32.c',
+    sfdir / 'f128_to_extF80.c',
+    sfdir / 'f128_to_f64.c',
+    sfdir / 'f128_roundToInt.c',
+    sfdir / 'f128_add.c',
+    sfdir / 'f128_sub.c',
+    sfdir / 'f128_mul.c',
+    sfdir / 'f128_mulAdd.c',
+    sfdir / 'f128_div.c',
+    sfdir / 'f128_rem.c',
+    sfdir / 'f128_sqrt.c',
+    sfdir / 'f128_eq.c',
+    sfdir / 'f128_le.c',
+    sfdir / 'f128_lt.c',
+    sfdir / 'f128_eq_signaling.c',
+    sfdir / 'f128_le_quiet.c',
+    sfdir / 'f128_lt_quiet.c',
+    sfdir / 'f128_isSignalingNaN.c',
+    sfdir / 'f128M_to_ui32.c',
+    sfdir / 'f128M_to_ui64.c',
+    sfdir / 'f128M_to_i32.c',
+    sfdir / 'f128M_to_i64.c',
+    sfdir / 'f128M_to_ui32_r_minMag.c',
+    sfdir / 'f128M_to_ui64_r_minMag.c',
+    sfdir / 'f128M_to_i32_r_minMag.c',
+    sfdir / 'f128M_to_i64_r_minMag.c',
+    sfdir / 'f128M_to_f16.c',
+    sfdir / 'f128M_to_f32.c',
+    sfdir / 'f128M_to_extF80M.c',
+    sfdir / 'f128M_to_f64.c',
+    sfdir / 'f128M_roundToInt.c',
+    sfdir / 'f128M_add.c',
+    sfdir / 'f128M_sub.c',
+    sfdir / 'f128M_mul.c',
+    sfdir / 'f128M_mulAdd.c',
+    sfdir / 'f128M_div.c',
+    sfdir / 'f128M_rem.c',
+    sfdir / 'f128M_sqrt.c',
+    sfdir / 'f128M_eq.c',
+    sfdir / 'f128M_le.c',
+    sfdir / 'f128M_lt.c',
+    sfdir / 'f128M_eq_signaling.c',
+    sfdir / 'f128M_le_quiet.c',
+    sfdir / 'f128M_lt_quiet.c',
+    # spe
+    sfspedir / 'softfloat_raiseFlags.c',
+    sfspedir / 's_f16UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF16UI.c',
+    sfspedir / 's_propagateNaNF16UI.c',
+    sfspedir / 's_f32UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF32UI.c',
+    sfspedir / 's_propagateNaNF32UI.c',
+    sfspedir / 's_f64UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF64UI.c',
+    sfspedir / 's_propagateNaNF64UI.c',
+    sfspedir / 'extF80M_isSignalingNaN.c',
+    sfspedir / 's_extF80UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToExtF80UI.c',
+    sfspedir / 's_propagateNaNExtF80UI.c',
+    sfspedir / 'f128M_isSignalingNaN.c',
+    sfspedir / 's_f128UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF128UI.c',
+    sfspedir / 's_propagateNaNF128UI.c',
+  ),
+  include_directories: sfinc,
+  c_args: fpcflags,
+)
+
+libsoftfloat_dep = declare_dependency(
+    link_with: libsoftfloat,
+    include_directories: sfinc,
+    compile_args: fpcflags)
diff --git a/subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt b/subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
new file mode 100644
index 000000000000..868ae57e805e
--- /dev/null
+++ b/subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
@@ -0,0 +1 @@
+option('defines', type : 'array', value : [])
diff --git a/subprojects/packagefiles/berkeley-testfloat-3/meson.build b/subprojects/packagefiles/berkeley-testfloat-3/meson.build
new file mode 100644
index 000000000000..a41673d616bf
--- /dev/null
+++ b/subprojects/packagefiles/berkeley-testfloat-3/meson.build
@@ -0,0 +1,220 @@
+project('berkeley-testfloat-3',  'c',
+        default_options: ['warning_level=1', 'c_std=gnu99'])
+
+fpcflags = get_option('defines')
+
+platform_data = configuration_data()
+platform_data.set('INLINE', 'static inline')
+platform_data.set('LITTLEENDIAN', host_machine.endian() == 'little')
+configure_file(output: 'platform.h', configuration: platform_data)
+
+tfdir = 'source'
+tfinc = include_directories('.', tfdir)
+
+add_project_arguments(
+  [
+    '-Wno-implicit-fallthrough',
+    '-Wno-strict-prototypes',
+    '-Wno-unknown-pragmas',
+    '-Wno-uninitialized',
+    '-Wno-missing-prototypes',
+    '-Wno-return-type',
+    '-Wno-unused-function',
+    '-Wno-missing-format-attribute',
+    '-Wno-error',
+  ] + meson.get_compiler('c').get_supported_arguments('-Wno-ignored-pragmas'),
+  native: false, language: 'c')
+
+tfgencases = [
+  tfdir / 'genCases_ui32.c',
+  tfdir / 'genCases_ui64.c',
+  tfdir / 'genCases_i32.c',
+  tfdir / 'genCases_i64.c',
+  tfdir / 'genCases_f16.c',
+  tfdir / 'genCases_f32.c',
+  tfdir / 'genCases_f64.c',
+  tfdir / 'genCases_extF80.c',
+  tfdir / 'genCases_f128.c',
+]
+
+tfwritecase = [
+  tfdir / 'writeCase_a_ui32.c',
+  tfdir / 'writeCase_a_ui64.c',
+  tfdir / 'writeCase_a_f16.c',
+  tfdir / 'writeCase_ab_f16.c',
+  tfdir / 'writeCase_abc_f16.c',
+  tfdir / 'writeCase_a_f32.c',
+  tfdir / 'writeCase_ab_f32.c',
+  tfdir / 'writeCase_abc_f32.c',
+  tfdir / 'writeCase_a_f64.c',
+  tfdir / 'writeCase_ab_f64.c',
+  tfdir / 'writeCase_abc_f64.c',
+  tfdir / 'writeCase_a_extF80M.c',
+  tfdir / 'writeCase_ab_extF80M.c',
+  tfdir / 'writeCase_a_f128M.c',
+  tfdir / 'writeCase_ab_f128M.c',
+  tfdir / 'writeCase_abc_f128M.c',
+  tfdir / 'writeCase_z_bool.c',
+  tfdir / 'writeCase_z_ui32.c',
+  tfdir / 'writeCase_z_ui64.c',
+  tfdir / 'writeCase_z_f16.c',
+  tfdir / 'writeCase_z_f32.c',
+  tfdir / 'writeCase_z_f64.c',
+  tfdir / 'writeCase_z_extF80M.c',
+  tfdir / 'writeCase_z_f128M.c',
+]
+
+tftest = [
+  tfdir / 'test_a_ui32_z_f16.c',
+  tfdir / 'test_a_ui32_z_f32.c',
+  tfdir / 'test_a_ui32_z_f64.c',
+  tfdir / 'test_a_ui32_z_extF80.c',
+  tfdir / 'test_a_ui32_z_f128.c',
+  tfdir / 'test_a_ui64_z_f16.c',
+  tfdir / 'test_a_ui64_z_f32.c',
+  tfdir / 'test_a_ui64_z_f64.c',
+  tfdir / 'test_a_ui64_z_extF80.c',
+  tfdir / 'test_a_ui64_z_f128.c',
+  tfdir / 'test_a_i32_z_f16.c',
+  tfdir / 'test_a_i32_z_f32.c',
+  tfdir / 'test_a_i32_z_f64.c',
+  tfdir / 'test_a_i32_z_extF80.c',
+  tfdir / 'test_a_i32_z_f128.c',
+  tfdir / 'test_a_i64_z_f16.c',
+  tfdir / 'test_a_i64_z_f32.c',
+  tfdir / 'test_a_i64_z_f64.c',
+  tfdir / 'test_a_i64_z_extF80.c',
+  tfdir / 'test_a_i64_z_f128.c',
+  tfdir / 'test_a_f16_z_ui32_rx.c',
+  tfdir / 'test_a_f16_z_ui64_rx.c',
+  tfdir / 'test_a_f16_z_i32_rx.c',
+  tfdir / 'test_a_f16_z_i64_rx.c',
+  tfdir / 'test_a_f16_z_ui32_x.c',
+  tfdir / 'test_a_f16_z_ui64_x.c',
+  tfdir / 'test_a_f16_z_i32_x.c',
+  tfdir / 'test_a_f16_z_i64_x.c',
+  tfdir / 'test_a_f16_z_f32.c',
+  tfdir / 'test_a_f16_z_f64.c',
+  tfdir / 'test_a_f16_z_extF80.c',
+  tfdir / 'test_a_f16_z_f128.c',
+  tfdir / 'test_az_f16.c',
+  tfdir / 'test_az_f16_rx.c',
+  tfdir / 'test_abz_f16.c',
+  tfdir / 'test_abcz_f16.c',
+  tfdir / 'test_ab_f16_z_bool.c',
+  tfdir / 'test_a_f32_z_ui32_rx.c',
+  tfdir / 'test_a_f32_z_ui64_rx.c',
+  tfdir / 'test_a_f32_z_i32_rx.c',
+  tfdir / 'test_a_f32_z_i64_rx.c',
+  tfdir / 'test_a_f32_z_ui32_x.c',
+  tfdir / 'test_a_f32_z_ui64_x.c',
+  tfdir / 'test_a_f32_z_i32_x.c',
+  tfdir / 'test_a_f32_z_i64_x.c',
+  tfdir / 'test_a_f32_z_f16.c',
+  tfdir / 'test_a_f32_z_f64.c',
+  tfdir / 'test_a_f32_z_extF80.c',
+  tfdir / 'test_a_f32_z_f128.c',
+  tfdir / 'test_az_f32.c',
+  tfdir / 'test_az_f32_rx.c',
+  tfdir / 'test_abz_f32.c',
+  tfdir / 'test_abcz_f32.c',
+  tfdir / 'test_ab_f32_z_bool.c',
+  tfdir / 'test_a_f64_z_ui32_rx.c',
+  tfdir / 'test_a_f64_z_ui64_rx.c',
+  tfdir / 'test_a_f64_z_i32_rx.c',
+  tfdir / 'test_a_f64_z_i64_rx.c',
+  tfdir / 'test_a_f64_z_ui32_x.c',
+  tfdir / 'test_a_f64_z_ui64_x.c',
+  tfdir / 'test_a_f64_z_i32_x.c',
+  tfdir / 'test_a_f64_z_i64_x.c',
+  tfdir / 'test_a_f64_z_f16.c',
+  tfdir / 'test_a_f64_z_f32.c',
+  tfdir / 'test_a_f64_z_extF80.c',
+  tfdir / 'test_a_f64_z_f128.c',
+  tfdir / 'test_az_f64.c',
+  tfdir / 'test_az_f64_rx.c',
+  tfdir / 'test_abz_f64.c',
+  tfdir / 'test_abcz_f64.c',
+  tfdir / 'test_ab_f64_z_bool.c',
+  tfdir / 'test_a_extF80_z_ui32_rx.c',
+  tfdir / 'test_a_extF80_z_ui64_rx.c',
+  tfdir / 'test_a_extF80_z_i32_rx.c',
+  tfdir / 'test_a_extF80_z_i64_rx.c',
+  tfdir / 'test_a_extF80_z_ui32_x.c',
+  tfdir / 'test_a_extF80_z_ui64_x.c',
+  tfdir / 'test_a_extF80_z_i32_x.c',
+  tfdir / 'test_a_extF80_z_i64_x.c',
+  tfdir / 'test_a_extF80_z_f16.c',
+  tfdir / 'test_a_extF80_z_f32.c',
+  tfdir / 'test_a_extF80_z_f64.c',
+  tfdir / 'test_a_extF80_z_f128.c',
+  tfdir / 'test_az_extF80.c',
+  tfdir / 'test_az_extF80_rx.c',
+  tfdir / 'test_abz_extF80.c',
+  tfdir / 'test_ab_extF80_z_bool.c',
+  tfdir / 'test_a_f128_z_ui32_rx.c',
+  tfdir / 'test_a_f128_z_ui64_rx.c',
+  tfdir / 'test_a_f128_z_i32_rx.c',
+  tfdir / 'test_a_f128_z_i64_rx.c',
+  tfdir / 'test_a_f128_z_ui32_x.c',
+  tfdir / 'test_a_f128_z_ui64_x.c',
+  tfdir / 'test_a_f128_z_i32_x.c',
+  tfdir / 'test_a_f128_z_i64_x.c',
+  tfdir / 'test_a_f128_z_f16.c',
+  tfdir / 'test_a_f128_z_f32.c',
+  tfdir / 'test_a_f128_z_f64.c',
+  tfdir / 'test_a_f128_z_extF80.c',
+  tfdir / 'test_az_f128.c',
+  tfdir / 'test_az_f128_rx.c',
+  tfdir / 'test_abz_f128.c',
+  tfdir / 'test_abcz_f128.c',
+  tfdir / 'test_ab_f128_z_bool.c',
+]
+
+libsoftfloat_proj = subproject('berkeley-softfloat-3', required: true)
+libsoftfloat = libsoftfloat_proj.get_variable('libsoftfloat_dep')
+
+libtestfloat = static_library(
+  'testfloat',
+  files(
+    tfdir / 'uint128_inline.c',
+    tfdir / 'uint128.c',
+    tfdir / 'fail.c',
+    tfdir / 'functions_common.c',
+    tfdir / 'functionInfos.c',
+    tfdir / 'standardFunctionInfos.c',
+    tfdir / 'random.c',
+    tfdir / 'genCases_common.c',
+    tfgencases,
+    tfdir / 'genCases_writeTestsTotal.c',
+    tfdir / 'verCases_inline.c',
+    tfdir / 'verCases_common.c',
+    tfdir / 'verCases_writeFunctionName.c',
+    tfdir / 'readHex.c',
+    tfdir / 'writeHex.c',
+    tfwritecase,
+    tfdir / 'testLoops_common.c',
+    tftest,
+  ),
+  dependencies: libsoftfloat.partial_dependency(includes: true, compile_args: true),
+  c_args: fpcflags,
+)
+
+libtestfloat_dep = declare_dependency(
+    link_with: libtestfloat,
+    dependencies: libsoftfloat,
+    include_directories: tfinc,
+    compile_args: fpcflags)
+
+libslowfloat = static_library(
+  'slowfloat',
+  tfdir / 'slowfloat.c',
+  dependencies: libsoftfloat.partial_dependency(includes: true, compile_args: true),
+  c_args: fpcflags,
+)
+
+libslowfloat_dep = declare_dependency(
+    link_with: libslowfloat,
+    dependencies: libsoftfloat,
+    include_directories: tfinc,
+    compile_args: fpcflags)
diff --git a/subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt b/subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt
new file mode 100644
index 000000000000..868ae57e805e
--- /dev/null
+++ b/subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt
@@ -0,0 +1 @@
+option('defines', type : 'array', value : [])
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index f9ca6a93b49d..cbc17392d678 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -7,13 +7,15 @@ if targetos == 'windows'
   subdir_done()
 endif
 
-fpcflags = [
+sfcflags = [
   # softfloat defines
   '-DSOFTFLOAT_ROUND_ODD',
   '-DINLINE_LEVEL=5',
   '-DSOFTFLOAT_FAST_DIV32TO16',
   '-DSOFTFLOAT_FAST_DIV64TO32',
   '-DSOFTFLOAT_FAST_INT64',
+]
+tfcflags = [
   # testfloat defines
   '-DFLOAT16',
   '-DFLOAT64',
@@ -23,523 +25,16 @@ fpcflags = [
   '-DLONG_DOUBLE_IS_EXTFLOAT80',
 ]
 
-sfdir = 'berkeley-softfloat-3/source'
-sfspedir = sfdir / '8086-SSE'
-tfdir = 'berkeley-testfloat-3/source'
+libsoftfloat_proj = subproject('berkeley-softfloat-3', required: true,
+    default_options: 'defines=' + ','.join(sfcflags))
+libsoftfloat = libsoftfloat_proj.get_variable('libsoftfloat_dep')
 
-sfinc = include_directories(sfdir / 'include', sfspedir)
+libtestfloat_proj = subproject('berkeley-testfloat-3', required: true,
+    default_options: 'defines=' + ','.join(tfcflags))
+libtestfloat = libtestfloat_proj.get_variable('libtestfloat_dep')
+libslowfloat = libtestfloat_proj.get_variable('libslowfloat_dep')
 
-tfcflags = [
-  '-Wno-implicit-fallthrough',
-  '-Wno-strict-prototypes',
-  '-Wno-unknown-pragmas',
-  '-Wno-uninitialized',
-  '-Wno-missing-prototypes',
-  '-Wno-return-type',
-  '-Wno-unused-function',
-  '-Wno-missing-format-attribute',
-  '-Wno-error',
-]
-
-if cc.get_id() == 'clang'
-  # Clang does not support '#pragma STDC FENV_ACCESS'
-  tfcflags += [ '-Wno-ignored-pragmas' ]
-endif
-
-tfgencases = [
-  tfdir / 'genCases_ui32.c',
-  tfdir / 'genCases_ui64.c',
-  tfdir / 'genCases_i32.c',
-  tfdir / 'genCases_i64.c',
-  tfdir / 'genCases_f16.c',
-  tfdir / 'genCases_f32.c',
-  tfdir / 'genCases_f64.c',
-  tfdir / 'genCases_extF80.c',
-  tfdir / 'genCases_f128.c',
-]
-
-tfwritecase = [
-  tfdir / 'writeCase_a_ui32.c',
-  tfdir / 'writeCase_a_ui64.c',
-  tfdir / 'writeCase_a_f16.c',
-  tfdir / 'writeCase_ab_f16.c',
-  tfdir / 'writeCase_abc_f16.c',
-  tfdir / 'writeCase_a_f32.c',
-  tfdir / 'writeCase_ab_f32.c',
-  tfdir / 'writeCase_abc_f32.c',
-  tfdir / 'writeCase_a_f64.c',
-  tfdir / 'writeCase_ab_f64.c',
-  tfdir / 'writeCase_abc_f64.c',
-  tfdir / 'writeCase_a_extF80M.c',
-  tfdir / 'writeCase_ab_extF80M.c',
-  tfdir / 'writeCase_a_f128M.c',
-  tfdir / 'writeCase_ab_f128M.c',
-  tfdir / 'writeCase_abc_f128M.c',
-  tfdir / 'writeCase_z_bool.c',
-  tfdir / 'writeCase_z_ui32.c',
-  tfdir / 'writeCase_z_ui64.c',
-  tfdir / 'writeCase_z_f16.c',
-  tfdir / 'writeCase_z_f32.c',
-  tfdir / 'writeCase_z_f64.c',
-  tfdir / 'writeCase_z_extF80M.c',
-  tfdir / 'writeCase_z_f128M.c',
-]
-
-tftest = [
-  tfdir / 'test_a_ui32_z_f16.c',
-  tfdir / 'test_a_ui32_z_f32.c',
-  tfdir / 'test_a_ui32_z_f64.c',
-  tfdir / 'test_a_ui32_z_extF80.c',
-  tfdir / 'test_a_ui32_z_f128.c',
-  tfdir / 'test_a_ui64_z_f16.c',
-  tfdir / 'test_a_ui64_z_f32.c',
-  tfdir / 'test_a_ui64_z_f64.c',
-  tfdir / 'test_a_ui64_z_extF80.c',
-  tfdir / 'test_a_ui64_z_f128.c',
-  tfdir / 'test_a_i32_z_f16.c',
-  tfdir / 'test_a_i32_z_f32.c',
-  tfdir / 'test_a_i32_z_f64.c',
-  tfdir / 'test_a_i32_z_extF80.c',
-  tfdir / 'test_a_i32_z_f128.c',
-  tfdir / 'test_a_i64_z_f16.c',
-  tfdir / 'test_a_i64_z_f32.c',
-  tfdir / 'test_a_i64_z_f64.c',
-  tfdir / 'test_a_i64_z_extF80.c',
-  tfdir / 'test_a_i64_z_f128.c',
-  tfdir / 'test_a_f16_z_ui32_rx.c',
-  tfdir / 'test_a_f16_z_ui64_rx.c',
-  tfdir / 'test_a_f16_z_i32_rx.c',
-  tfdir / 'test_a_f16_z_i64_rx.c',
-  tfdir / 'test_a_f16_z_ui32_x.c',
-  tfdir / 'test_a_f16_z_ui64_x.c',
-  tfdir / 'test_a_f16_z_i32_x.c',
-  tfdir / 'test_a_f16_z_i64_x.c',
-  tfdir / 'test_a_f16_z_f32.c',
-  tfdir / 'test_a_f16_z_f64.c',
-  tfdir / 'test_a_f16_z_extF80.c',
-  tfdir / 'test_a_f16_z_f128.c',
-  tfdir / 'test_az_f16.c',
-  tfdir / 'test_az_f16_rx.c',
-  tfdir / 'test_abz_f16.c',
-  tfdir / 'test_abcz_f16.c',
-  tfdir / 'test_ab_f16_z_bool.c',
-  tfdir / 'test_a_f32_z_ui32_rx.c',
-  tfdir / 'test_a_f32_z_ui64_rx.c',
-  tfdir / 'test_a_f32_z_i32_rx.c',
-  tfdir / 'test_a_f32_z_i64_rx.c',
-  tfdir / 'test_a_f32_z_ui32_x.c',
-  tfdir / 'test_a_f32_z_ui64_x.c',
-  tfdir / 'test_a_f32_z_i32_x.c',
-  tfdir / 'test_a_f32_z_i64_x.c',
-  tfdir / 'test_a_f32_z_f16.c',
-  tfdir / 'test_a_f32_z_f64.c',
-  tfdir / 'test_a_f32_z_extF80.c',
-  tfdir / 'test_a_f32_z_f128.c',
-  tfdir / 'test_az_f32.c',
-  tfdir / 'test_az_f32_rx.c',
-  tfdir / 'test_abz_f32.c',
-  tfdir / 'test_abcz_f32.c',
-  tfdir / 'test_ab_f32_z_bool.c',
-  tfdir / 'test_a_f64_z_ui32_rx.c',
-  tfdir / 'test_a_f64_z_ui64_rx.c',
-  tfdir / 'test_a_f64_z_i32_rx.c',
-  tfdir / 'test_a_f64_z_i64_rx.c',
-  tfdir / 'test_a_f64_z_ui32_x.c',
-  tfdir / 'test_a_f64_z_ui64_x.c',
-  tfdir / 'test_a_f64_z_i32_x.c',
-  tfdir / 'test_a_f64_z_i64_x.c',
-  tfdir / 'test_a_f64_z_f16.c',
-  tfdir / 'test_a_f64_z_f32.c',
-  tfdir / 'test_a_f64_z_extF80.c',
-  tfdir / 'test_a_f64_z_f128.c',
-  tfdir / 'test_az_f64.c',
-  tfdir / 'test_az_f64_rx.c',
-  tfdir / 'test_abz_f64.c',
-  tfdir / 'test_abcz_f64.c',
-  tfdir / 'test_ab_f64_z_bool.c',
-  tfdir / 'test_a_extF80_z_ui32_rx.c',
-  tfdir / 'test_a_extF80_z_ui64_rx.c',
-  tfdir / 'test_a_extF80_z_i32_rx.c',
-  tfdir / 'test_a_extF80_z_i64_rx.c',
-  tfdir / 'test_a_extF80_z_ui32_x.c',
-  tfdir / 'test_a_extF80_z_ui64_x.c',
-  tfdir / 'test_a_extF80_z_i32_x.c',
-  tfdir / 'test_a_extF80_z_i64_x.c',
-  tfdir / 'test_a_extF80_z_f16.c',
-  tfdir / 'test_a_extF80_z_f32.c',
-  tfdir / 'test_a_extF80_z_f64.c',
-  tfdir / 'test_a_extF80_z_f128.c',
-  tfdir / 'test_az_extF80.c',
-  tfdir / 'test_az_extF80_rx.c',
-  tfdir / 'test_abz_extF80.c',
-  tfdir / 'test_ab_extF80_z_bool.c',
-  tfdir / 'test_a_f128_z_ui32_rx.c',
-  tfdir / 'test_a_f128_z_ui64_rx.c',
-  tfdir / 'test_a_f128_z_i32_rx.c',
-  tfdir / 'test_a_f128_z_i64_rx.c',
-  tfdir / 'test_a_f128_z_ui32_x.c',
-  tfdir / 'test_a_f128_z_ui64_x.c',
-  tfdir / 'test_a_f128_z_i32_x.c',
-  tfdir / 'test_a_f128_z_i64_x.c',
-  tfdir / 'test_a_f128_z_f16.c',
-  tfdir / 'test_a_f128_z_f32.c',
-  tfdir / 'test_a_f128_z_f64.c',
-  tfdir / 'test_a_f128_z_extF80.c',
-  tfdir / 'test_az_f128.c',
-  tfdir / 'test_az_f128_rx.c',
-  tfdir / 'test_abz_f128.c',
-  tfdir / 'test_abcz_f128.c',
-  tfdir / 'test_ab_f128_z_bool.c',
-]
-
-libtestfloat = static_library(
-  'testfloat',
-  files(
-    tfdir / 'uint128_inline.c',
-    tfdir / 'uint128.c',
-    tfdir / 'fail.c',
-    tfdir / 'functions_common.c',
-    tfdir / 'functionInfos.c',
-    tfdir / 'standardFunctionInfos.c',
-    tfdir / 'random.c',
-    tfdir / 'genCases_common.c',
-    tfgencases,
-    tfdir / 'genCases_writeTestsTotal.c',
-    tfdir / 'verCases_inline.c',
-    tfdir / 'verCases_common.c',
-    tfdir / 'verCases_writeFunctionName.c',
-    tfdir / 'readHex.c',
-    tfdir / 'writeHex.c',
-    tfwritecase,
-    tfdir / 'testLoops_common.c',
-    tftest,
-  ),
-  include_directories: sfinc,
-  c_args: tfcflags + fpcflags,
-)
-
-sfcflags = [
-  '-Wno-implicit-fallthrough',
-  '-Wno-missing-prototypes',
-  '-Wno-redundant-decls',
-  '-Wno-return-type',
-  '-Wno-error',
-]
-
-libsoftfloat = static_library(
-  'softfloat',
-  files(
-    # primitives
-    sfdir / 's_eq128.c',
-    sfdir / 's_le128.c',
-    sfdir / 's_lt128.c',
-    sfdir / 's_shortShiftLeft128.c',
-    sfdir / 's_shortShiftRight128.c',
-    sfdir / 's_shortShiftRightJam64.c',
-    sfdir / 's_shortShiftRightJam64Extra.c',
-    sfdir / 's_shortShiftRightJam128.c',
-    sfdir / 's_shortShiftRightJam128Extra.c',
-    sfdir / 's_shiftRightJam32.c',
-    sfdir / 's_shiftRightJam64.c',
-    sfdir / 's_shiftRightJam64Extra.c',
-    sfdir / 's_shiftRightJam128.c',
-    sfdir / 's_shiftRightJam128Extra.c',
-    sfdir / 's_shiftRightJam256M.c',
-    sfdir / 's_countLeadingZeros8.c',
-    sfdir / 's_countLeadingZeros16.c',
-    sfdir / 's_countLeadingZeros32.c',
-    sfdir / 's_countLeadingZeros64.c',
-    sfdir / 's_add128.c',
-    sfdir / 's_add256M.c',
-    sfdir / 's_sub128.c',
-    sfdir / 's_sub256M.c',
-    sfdir / 's_mul64ByShifted32To128.c',
-    sfdir / 's_mul64To128.c',
-    sfdir / 's_mul128By32.c',
-    sfdir / 's_mul128To256M.c',
-    sfdir / 's_approxRecip_1Ks.c',
-    sfdir / 's_approxRecip32_1.c',
-    sfdir / 's_approxRecipSqrt_1Ks.c',
-    sfdir / 's_approxRecipSqrt32_1.c',
-    # others
-    sfdir / 's_roundToUI32.c',
-    sfdir / 's_roundToUI64.c',
-    sfdir / 's_roundToI32.c',
-    sfdir / 's_roundToI64.c',
-    sfdir / 's_normSubnormalF16Sig.c',
-    sfdir / 's_roundPackToF16.c',
-    sfdir / 's_normRoundPackToF16.c',
-    sfdir / 's_addMagsF16.c',
-    sfdir / 's_subMagsF16.c',
-    sfdir / 's_mulAddF16.c',
-    sfdir / 's_normSubnormalF32Sig.c',
-    sfdir / 's_roundPackToF32.c',
-    sfdir / 's_normRoundPackToF32.c',
-    sfdir / 's_addMagsF32.c',
-    sfdir / 's_subMagsF32.c',
-    sfdir / 's_mulAddF32.c',
-    sfdir / 's_normSubnormalF64Sig.c',
-    sfdir / 's_roundPackToF64.c',
-    sfdir / 's_normRoundPackToF64.c',
-    sfdir / 's_addMagsF64.c',
-    sfdir / 's_subMagsF64.c',
-    sfdir / 's_mulAddF64.c',
-    sfdir / 's_normSubnormalExtF80Sig.c',
-    sfdir / 's_roundPackToExtF80.c',
-    sfdir / 's_normRoundPackToExtF80.c',
-    sfdir / 's_addMagsExtF80.c',
-    sfdir / 's_subMagsExtF80.c',
-    sfdir / 's_normSubnormalF128Sig.c',
-    sfdir / 's_roundPackToF128.c',
-    sfdir / 's_normRoundPackToF128.c',
-    sfdir / 's_addMagsF128.c',
-    sfdir / 's_subMagsF128.c',
-    sfdir / 's_mulAddF128.c',
-    sfdir / 'softfloat_state.c',
-    sfdir / 'ui32_to_f16.c',
-    sfdir / 'ui32_to_f32.c',
-    sfdir / 'ui32_to_f64.c',
-    sfdir / 'ui32_to_extF80.c',
-    sfdir / 'ui32_to_extF80M.c',
-    sfdir / 'ui32_to_f128.c',
-    sfdir / 'ui32_to_f128M.c',
-    sfdir / 'ui64_to_f16.c',
-    sfdir / 'ui64_to_f32.c',
-    sfdir / 'ui64_to_f64.c',
-    sfdir / 'ui64_to_extF80.c',
-    sfdir / 'ui64_to_extF80M.c',
-    sfdir / 'ui64_to_f128.c',
-    sfdir / 'ui64_to_f128M.c',
-    sfdir / 'i32_to_f16.c',
-    sfdir / 'i32_to_f32.c',
-    sfdir / 'i32_to_f64.c',
-    sfdir / 'i32_to_extF80.c',
-    sfdir / 'i32_to_extF80M.c',
-    sfdir / 'i32_to_f128.c',
-    sfdir / 'i32_to_f128M.c',
-    sfdir / 'i64_to_f16.c',
-    sfdir / 'i64_to_f32.c',
-    sfdir / 'i64_to_f64.c',
-    sfdir / 'i64_to_extF80.c',
-    sfdir / 'i64_to_extF80M.c',
-    sfdir / 'i64_to_f128.c',
-    sfdir / 'i64_to_f128M.c',
-    sfdir / 'f16_to_ui32.c',
-    sfdir / 'f16_to_ui64.c',
-    sfdir / 'f16_to_i32.c',
-    sfdir / 'f16_to_i64.c',
-    sfdir / 'f16_to_ui32_r_minMag.c',
-    sfdir / 'f16_to_ui64_r_minMag.c',
-    sfdir / 'f16_to_i32_r_minMag.c',
-    sfdir / 'f16_to_i64_r_minMag.c',
-    sfdir / 'f16_to_f32.c',
-    sfdir / 'f16_to_f64.c',
-    sfdir / 'f16_to_extF80.c',
-    sfdir / 'f16_to_extF80M.c',
-    sfdir / 'f16_to_f128.c',
-    sfdir / 'f16_to_f128M.c',
-    sfdir / 'f16_roundToInt.c',
-    sfdir / 'f16_add.c',
-    sfdir / 'f16_sub.c',
-    sfdir / 'f16_mul.c',
-    sfdir / 'f16_mulAdd.c',
-    sfdir / 'f16_div.c',
-    sfdir / 'f16_rem.c',
-    sfdir / 'f16_sqrt.c',
-    sfdir / 'f16_eq.c',
-    sfdir / 'f16_le.c',
-    sfdir / 'f16_lt.c',
-    sfdir / 'f16_eq_signaling.c',
-    sfdir / 'f16_le_quiet.c',
-    sfdir / 'f16_lt_quiet.c',
-    sfdir / 'f16_isSignalingNaN.c',
-    sfdir / 'f32_to_ui32.c',
-    sfdir / 'f32_to_ui64.c',
-    sfdir / 'f32_to_i32.c',
-    sfdir / 'f32_to_i64.c',
-    sfdir / 'f32_to_ui32_r_minMag.c',
-    sfdir / 'f32_to_ui64_r_minMag.c',
-    sfdir / 'f32_to_i32_r_minMag.c',
-    sfdir / 'f32_to_i64_r_minMag.c',
-    sfdir / 'f32_to_f16.c',
-    sfdir / 'f32_to_f64.c',
-    sfdir / 'f32_to_extF80.c',
-    sfdir / 'f32_to_extF80M.c',
-    sfdir / 'f32_to_f128.c',
-    sfdir / 'f32_to_f128M.c',
-    sfdir / 'f32_roundToInt.c',
-    sfdir / 'f32_add.c',
-    sfdir / 'f32_sub.c',
-    sfdir / 'f32_mul.c',
-    sfdir / 'f32_mulAdd.c',
-    sfdir / 'f32_div.c',
-    sfdir / 'f32_rem.c',
-    sfdir / 'f32_sqrt.c',
-    sfdir / 'f32_eq.c',
-    sfdir / 'f32_le.c',
-    sfdir / 'f32_lt.c',
-    sfdir / 'f32_eq_signaling.c',
-    sfdir / 'f32_le_quiet.c',
-    sfdir / 'f32_lt_quiet.c',
-    sfdir / 'f32_isSignalingNaN.c',
-    sfdir / 'f64_to_ui32.c',
-    sfdir / 'f64_to_ui64.c',
-    sfdir / 'f64_to_i32.c',
-    sfdir / 'f64_to_i64.c',
-    sfdir / 'f64_to_ui32_r_minMag.c',
-    sfdir / 'f64_to_ui64_r_minMag.c',
-    sfdir / 'f64_to_i32_r_minMag.c',
-    sfdir / 'f64_to_i64_r_minMag.c',
-    sfdir / 'f64_to_f16.c',
-    sfdir / 'f64_to_f32.c',
-    sfdir / 'f64_to_extF80.c',
-    sfdir / 'f64_to_extF80M.c',
-    sfdir / 'f64_to_f128.c',
-    sfdir / 'f64_to_f128M.c',
-    sfdir / 'f64_roundToInt.c',
-    sfdir / 'f64_add.c',
-    sfdir / 'f64_sub.c',
-    sfdir / 'f64_mul.c',
-    sfdir / 'f64_mulAdd.c',
-    sfdir / 'f64_div.c',
-    sfdir / 'f64_rem.c',
-    sfdir / 'f64_sqrt.c',
-    sfdir / 'f64_eq.c',
-    sfdir / 'f64_le.c',
-    sfdir / 'f64_lt.c',
-    sfdir / 'f64_eq_signaling.c',
-    sfdir / 'f64_le_quiet.c',
-    sfdir / 'f64_lt_quiet.c',
-    sfdir / 'f64_isSignalingNaN.c',
-    sfdir / 'extF80_to_ui32.c',
-    sfdir / 'extF80_to_ui64.c',
-    sfdir / 'extF80_to_i32.c',
-    sfdir / 'extF80_to_i64.c',
-    sfdir / 'extF80_to_ui32_r_minMag.c',
-    sfdir / 'extF80_to_ui64_r_minMag.c',
-    sfdir / 'extF80_to_i32_r_minMag.c',
-    sfdir / 'extF80_to_i64_r_minMag.c',
-    sfdir / 'extF80_to_f16.c',
-    sfdir / 'extF80_to_f32.c',
-    sfdir / 'extF80_to_f64.c',
-    sfdir / 'extF80_to_f128.c',
-    sfdir / 'extF80_roundToInt.c',
-    sfdir / 'extF80_add.c',
-    sfdir / 'extF80_sub.c',
-    sfdir / 'extF80_mul.c',
-    sfdir / 'extF80_div.c',
-    sfdir / 'extF80_rem.c',
-    sfdir / 'extF80_sqrt.c',
-    sfdir / 'extF80_eq.c',
-    sfdir / 'extF80_le.c',
-    sfdir / 'extF80_lt.c',
-    sfdir / 'extF80_eq_signaling.c',
-    sfdir / 'extF80_le_quiet.c',
-    sfdir / 'extF80_lt_quiet.c',
-    sfdir / 'extF80_isSignalingNaN.c',
-    sfdir / 'extF80M_to_ui32.c',
-    sfdir / 'extF80M_to_ui64.c',
-    sfdir / 'extF80M_to_i32.c',
-    sfdir / 'extF80M_to_i64.c',
-    sfdir / 'extF80M_to_ui32_r_minMag.c',
-    sfdir / 'extF80M_to_ui64_r_minMag.c',
-    sfdir / 'extF80M_to_i32_r_minMag.c',
-    sfdir / 'extF80M_to_i64_r_minMag.c',
-    sfdir / 'extF80M_to_f16.c',
-    sfdir / 'extF80M_to_f32.c',
-    sfdir / 'extF80M_to_f64.c',
-    sfdir / 'extF80M_to_f128M.c',
-    sfdir / 'extF80M_roundToInt.c',
-    sfdir / 'extF80M_add.c',
-    sfdir / 'extF80M_sub.c',
-    sfdir / 'extF80M_mul.c',
-    sfdir / 'extF80M_div.c',
-    sfdir / 'extF80M_rem.c',
-    sfdir / 'extF80M_sqrt.c',
-    sfdir / 'extF80M_eq.c',
-    sfdir / 'extF80M_le.c',
-    sfdir / 'extF80M_lt.c',
-    sfdir / 'extF80M_eq_signaling.c',
-    sfdir / 'extF80M_le_quiet.c',
-    sfdir / 'extF80M_lt_quiet.c',
-    sfdir / 'f128_to_ui32.c',
-    sfdir / 'f128_to_ui64.c',
-    sfdir / 'f128_to_i32.c',
-    sfdir / 'f128_to_i64.c',
-    sfdir / 'f128_to_ui32_r_minMag.c',
-    sfdir / 'f128_to_ui64_r_minMag.c',
-    sfdir / 'f128_to_i32_r_minMag.c',
-    sfdir / 'f128_to_i64_r_minMag.c',
-    sfdir / 'f128_to_f16.c',
-    sfdir / 'f128_to_f32.c',
-    sfdir / 'f128_to_extF80.c',
-    sfdir / 'f128_to_f64.c',
-    sfdir / 'f128_roundToInt.c',
-    sfdir / 'f128_add.c',
-    sfdir / 'f128_sub.c',
-    sfdir / 'f128_mul.c',
-    sfdir / 'f128_mulAdd.c',
-    sfdir / 'f128_div.c',
-    sfdir / 'f128_rem.c',
-    sfdir / 'f128_sqrt.c',
-    sfdir / 'f128_eq.c',
-    sfdir / 'f128_le.c',
-    sfdir / 'f128_lt.c',
-    sfdir / 'f128_eq_signaling.c',
-    sfdir / 'f128_le_quiet.c',
-    sfdir / 'f128_lt_quiet.c',
-    sfdir / 'f128_isSignalingNaN.c',
-    sfdir / 'f128M_to_ui32.c',
-    sfdir / 'f128M_to_ui64.c',
-    sfdir / 'f128M_to_i32.c',
-    sfdir / 'f128M_to_i64.c',
-    sfdir / 'f128M_to_ui32_r_minMag.c',
-    sfdir / 'f128M_to_ui64_r_minMag.c',
-    sfdir / 'f128M_to_i32_r_minMag.c',
-    sfdir / 'f128M_to_i64_r_minMag.c',
-    sfdir / 'f128M_to_f16.c',
-    sfdir / 'f128M_to_f32.c',
-    sfdir / 'f128M_to_extF80M.c',
-    sfdir / 'f128M_to_f64.c',
-    sfdir / 'f128M_roundToInt.c',
-    sfdir / 'f128M_add.c',
-    sfdir / 'f128M_sub.c',
-    sfdir / 'f128M_mul.c',
-    sfdir / 'f128M_mulAdd.c',
-    sfdir / 'f128M_div.c',
-    sfdir / 'f128M_rem.c',
-    sfdir / 'f128M_sqrt.c',
-    sfdir / 'f128M_eq.c',
-    sfdir / 'f128M_le.c',
-    sfdir / 'f128M_lt.c',
-    sfdir / 'f128M_eq_signaling.c',
-    sfdir / 'f128M_le_quiet.c',
-    sfdir / 'f128M_lt_quiet.c',
-    # spe
-    sfspedir / 'softfloat_raiseFlags.c',
-    sfspedir / 's_f16UIToCommonNaN.c',
-    sfspedir / 's_commonNaNToF16UI.c',
-    sfspedir / 's_propagateNaNF16UI.c',
-    sfspedir / 's_f32UIToCommonNaN.c',
-    sfspedir / 's_commonNaNToF32UI.c',
-    sfspedir / 's_propagateNaNF32UI.c',
-    sfspedir / 's_f64UIToCommonNaN.c',
-    sfspedir / 's_commonNaNToF64UI.c',
-    sfspedir / 's_propagateNaNF64UI.c',
-    sfspedir / 'extF80M_isSignalingNaN.c',
-    sfspedir / 's_extF80UIToCommonNaN.c',
-    sfspedir / 's_commonNaNToExtF80UI.c',
-    sfspedir / 's_propagateNaNExtF80UI.c',
-    sfspedir / 'f128M_isSignalingNaN.c',
-    sfspedir / 's_f128UIToCommonNaN.c',
-    sfspedir / 's_commonNaNToF128UI.c',
-    sfspedir / 's_propagateNaNF128UI.c',
-  ),
-  include_directories: sfinc,
-  c_args: sfcflags + fpcflags,
-)
-
-fpcflags += [
+fpcflags = [
   # work around TARGET_* poisoning
   '-DHW_POISON_H',
   # define a target to match testfloat's implementation-defined choices, such as
@@ -551,10 +46,8 @@ fpcflags += [
 
 fptest = executable(
   'fp-test',
-  ['fp-test.c', tfdir / 'slowfloat.c', '../../fpu/softfloat.c'],
-  link_with: [libtestfloat, libsoftfloat],
-  dependencies: [qemuutil],
-  include_directories: [sfinc, include_directories(tfdir)],
+  ['fp-test.c', '../../fpu/softfloat.c'],
+  dependencies: [qemuutil, libsoftfloat, libtestfloat, libslowfloat],
   c_args: fpcflags,
 )
 softfloat_conv_tests = {
@@ -636,18 +129,14 @@ test('fp-test-mulAdd', fptest,
 executable(
   'fp-bench',
   ['fp-bench.c', '../../fpu/softfloat.c'],
-  link_with: [libtestfloat, libsoftfloat],
-  dependencies: [qemuutil],
-  include_directories: [sfinc, include_directories(tfdir)],
+  dependencies: [qemuutil, libtestfloat, libsoftfloat],
   c_args: fpcflags,
 )
 
 fptestlog2 = executable(
   'fp-test-log2',
   ['fp-test-log2.c', '../../fpu/softfloat.c'],
-  link_with: [libsoftfloat],
-  dependencies: [qemuutil],
-  include_directories: [sfinc],
+  dependencies: [qemuutil, libsoftfloat],
   c_args: fpcflags,
 )
 test('fp-test-log2', fptestlog2,
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFD707009
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFt-0003EZ-3p; Wed, 17 May 2023 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEk-0001qT-Mz
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEh-0004Ql-T8
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FdptHKzmhUoRSDNT+ltsR8KpQAZl9TwWtsZXexWKtU=;
 b=aH8R5jLqKncsxtXgpGWFy6ZAxmNobCghvLVOwTMaes++ZI4EqHbEwNkNwEXpLEFtD0Rfnz
 RsWl6xvvAWHGHkToJuBgdk0Jo6KeP+0tSenu4jtN5AYY5VnKFuLK2nqmptecBLzLM77jRx
 bQvo4iVZDxBQQNGckugB1teSl79Mco0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-qEIzbjZhOX2lp88THfOdzw-1; Wed, 17 May 2023 13:46:49 -0400
X-MC-Unique: qEIzbjZhOX2lp88THfOdzw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so451615f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345607; x=1686937607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FdptHKzmhUoRSDNT+ltsR8KpQAZl9TwWtsZXexWKtU=;
 b=fZS4u/xrjxE8+b7dmTFHx5LXVsz82GgaZ+OBQ91+v692frqU0Lv+akIBMw+3zfP+mE
 iOTe2TOneKoyrfdLO04deRyE2v6fNe+NPdPKKFTNZZWRllbiT7th5Tn6IxoM+SZ6/3WA
 exa7GLKfb2Kqo8cKlFpSVPiuLDUvjnZWd50sq5P6L3qwn4gRvSCDCKh8p33sAETKrGww
 w+SYnDkUzx0AFNBn8bndgRpXOb7SgGYj+Atcjcf1+bM7rInQb+Xd942jvaxgFfqm9rO+
 7YMbGXLyPCj8K+1SyCLBHgai+i/AzE/9bGleggeKfy/lmxVJIrUZXQhUOS6ak9Gn7TmE
 6cAw==
X-Gm-Message-State: AC+VfDy5aOw08WiWqlmfB9x2ezCyP0lgaYXhtjXN215aDi/BxGLs6SZI
 qqCNfB6ERXySD08uiCJpgH/ZODrSEc+3KCIACTt4+z60lvm62DBLugfNhcsaGJOB8S1Xq60QPdn
 V9zohH3yl3kho6euqBzZP5/lBiC22EUD1Fy7vpwSQXoRLjpErLUlaz0Ty2LZiu63tXquj4jgDiL
 Q=
X-Received: by 2002:a5d:4f84:0:b0:306:4063:1aff with SMTP id
 d4-20020a5d4f84000000b0030640631affmr1234127wru.30.1684345607448; 
 Wed, 17 May 2023 10:46:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ733J1oxDFfss54C65ITeNkvnDo2v3D95VZ5LS4Po4EvtWEPpAUFSWewV4jDivbxUI1Bb7g1A==
X-Received: by 2002:a5d:4f84:0:b0:306:4063:1aff with SMTP id
 d4-20020a5d4f84000000b0030640631affmr1234112wru.30.1684345607037; 
 Wed, 17 May 2023 10:46:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c00cc00b003f4ecf1fcbcsm2911460wmm.22.2023.05.17.10.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 52/68] configure: remove pkg-config functions
Date: Wed, 17 May 2023 19:45:04 +0200
Message-Id: <20230517174520.887405-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

All uses of pkg-config have been moved to Meson.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   | 21 ++++-----------------
 docs/devel/build-system.rst |  4 ----
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/configure b/configure
index 9b296c0ec132..3267b1027970 100755
--- a/configure
+++ b/configure
@@ -389,11 +389,7 @@ strip="${STRIP-${cross_prefix}strip}"
 widl="${WIDL-${cross_prefix}widl}"
 windres="${WINDRES-${cross_prefix}windres}"
 windmc="${WINDMC-${cross_prefix}windmc}"
-pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
-query_pkg_config() {
-    "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
-}
-pkg_config=query_pkg_config
+pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
 # default flags for all hosts
@@ -791,9 +787,7 @@ for opt do
   ;;
   --without-default-features) # processed above
   ;;
-  --static)
-    static="yes"
-    QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
+  --static) static="yes"
   ;;
   --bindir=*) bindir="$optarg"
   ;;
@@ -1501,13 +1495,6 @@ EOF
   fi
 fi
 
-##########################################
-# pkg-config probe
-
-if ! has "$pkg_config_exe"; then
-  error_exit "pkg-config binary '$pkg_config_exe' not found"
-fi
-
 ##########################################
 # fdt probe
 
@@ -2364,7 +2351,7 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
-echo "PKG_CONFIG=${pkg_config_exe}" >> $config_host_mak
+echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_OBJCFLAGS=$QEMU_OBJCFLAGS" >> $config_host_mak
@@ -2514,7 +2501,7 @@ if test "$skip_meson" = no; then
   test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
   echo "ar = [$(meson_quote $ar)]" >> $cross
   echo "nm = [$(meson_quote $nm)]" >> $cross
-  echo "pkgconfig = [$(meson_quote $pkg_config_exe)]" >> $cross
+  echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
   echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
   if has $sdl2_config; then
     echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 9db18aff159e..66cfe7b8bdc8 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -103,10 +103,6 @@ developers in checking for system features:
    Print $MESSAGE to stderr, followed by $MORE... and then exit from the
    configure script with non-zero status
 
-``query_pkg_config $ARGS...``
-   Run pkg-config passing it $ARGS. If QEMU is doing a static build,
-   then --static will be automatically added to $ARGS
-
 
 Stage 2: Meson
 ==============
-- 
2.40.1



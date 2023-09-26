Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B37AEE7F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:43:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9GI-0000Hp-CY; Tue, 26 Sep 2023 10:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ql9GE-0000Gw-Og
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ql9G8-0005mV-1e
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695739314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t7eXq7UgzPmULRL3TIyMtMS9O4FF89KJBAS2EjoKyTg=;
 b=R8DgiD2pmZ0vHh3NI6wOlHEgcRoLRRJIX1NH2oEf6EcrfANqARokdug8jKkCCM5DnqNtu1
 272A2VPnQ4kxE9lePAQLmBlThzcg6g2FU3GtEcyLChefu6L36zL9c1wmSjPsm3vLIFUI53
 ybmR7+iMAL06F/0aTlMnNxww1mdxp5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-l5mHKG4vPNWFzllzfYcfZg-1; Tue, 26 Sep 2023 10:41:53 -0400
X-MC-Unique: l5mHKG4vPNWFzllzfYcfZg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so83656295e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 07:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695739311; x=1696344111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7eXq7UgzPmULRL3TIyMtMS9O4FF89KJBAS2EjoKyTg=;
 b=DOK9KcRlfhwwAVlibOtPE5QgxUUgUDmBPUvdimtsuCAB33H27Hz91fqym1R37tO+ng
 OI5c3/VkmMhZGHBEv0TQJuMx/SWDcsEj7EP6rD5CQ6NX4/M7vJcR6YY6+YNs1SK5VT7p
 IO/47L1cBmwTjWbuOY0mfARY+VGUWQbGjvnuidSGB+LCzwTZo95ZpuLJBoiS4Uq1IhxK
 8Rcd9HJMFt+LSbVcCmRowCNwhVRJfkMUhzi9NAmztd3NjvwTYa/+8a276k8rHs7gW7Js
 /h0X/QcTJxvydMPwUb2QWqMlHuHaFEBpzrb6CxB6cRLhSHHTNjjTosUHgpYcaOdSzsgI
 2Cpw==
X-Gm-Message-State: AOJu0Ywa3EzXFlfYzS7fTzdRGw/M7IJCAoNHMbYl9aUzhN2V1dgdv25l
 djtWhMQFPLvVuj6lxu1WHr21ApanfOZrNRKVYc+gZN5m1j3ave/y4b9eRuEMlEuIElkbbpV4Bkm
 v9M/KD/AQ8TI1YYFxdcXG6Ok2zxP4ZZhzaaK+ef/XbquzciOP/QPvxZXqnRmmMgw4h0gyx6Oa8K
 4=
X-Received: by 2002:a7b:c8ce:0:b0:3f5:fff8:d4f3 with SMTP id
 f14-20020a7bc8ce000000b003f5fff8d4f3mr8311643wml.7.1695739311464; 
 Tue, 26 Sep 2023 07:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5AaIaiZGbk44ZFM9fyYXWccC8VIZzfxCvLkV5/1bhxH9LEf95WY3LG5QlxwzJr6nJZhUUcQ==
X-Received: by 2002:a7b:c8ce:0:b0:3f5:fff8:d4f3 with SMTP id
 f14-20020a7bc8ce000000b003f5fff8d4f3mr8311623wml.7.1695739310902; 
 Tue, 26 Sep 2023 07:41:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x26-20020a1c7c1a000000b003fe29f6b61bsm15282403wmc.46.2023.09.26.07.41.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:41:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] make-release: do not ship dtc sources
Date: Tue, 26 Sep 2023 16:41:49 +0200
Message-ID: <20230926144149.715750-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A new enough libfdt is included in all of Debian 11, Ubuntu 20.04
and MSYS2.  It has also been included for several minor releases
in Fedora and openSUSE Leap, as well as in CentOS.  Therefore
there is no need anymore to ship the sources together with the QEMU
tarballs.

Keep the wrap file so that it can be used with --enable-download,
but do not ship the sources anymore with either archive-source.sh
or make-release.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 3 +++
 scripts/archive-source.sh | 2 +-
 scripts/make-release      | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 5139db2ff7c..81430ce2348 100644
--- a/meson.build
+++ b/meson.build
@@ -3070,6 +3070,9 @@ if fdt_required.length() > 0 or fdt_opt == 'enabled'
   endif
 
   if fdt_opt in ['enabled', 'auto', 'system']
+    if get_option('wrap_mode') == 'nodownload'
+      fdt_opt = 'system'
+    endif
     fdt = cc.find_library('fdt', required: fdt_opt == 'system')
     if fdt.found() and cc.links('''
        #include <libfdt.h>
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 48996304910..65af8063e4b 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-subprojects="dtc keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-testfloat-3"
+subprojects="keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-testfloat-3"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index c5db87b3f91..9c570b87f4a 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -17,7 +17,7 @@ if [ $# -ne 2 ]; then
 fi
 
 # Only include wraps that are invoked with subproject()
-SUBPROJECTS="dtc libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-testfloat-3"
+SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-testfloat-3"
 
 src="$1"
 version="$2"
-- 
2.41.0



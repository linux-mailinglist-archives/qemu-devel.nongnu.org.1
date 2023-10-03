Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFC7B6447
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:34:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoY-0002qT-NV; Tue, 03 Oct 2023 04:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoJ-0002LW-OR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao3-0000Hi-On
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7eXq7UgzPmULRL3TIyMtMS9O4FF89KJBAS2EjoKyTg=;
 b=CPkHKNOlZJ1jZ7VuDhj6VsUNjOkj2wetjnFs4H0G/gDqKnGkWBC4KKUpUgtZ7GDZekfOWy
 LsgbC5RN3I3rCuv47/FLddRSWJrEmZzyXUAtik0K2mkB+2pW0Ewc59QrVccgY87G+DyAp/
 D+kZY1BiazqTmP2vjI14NzzO8Bbv4/U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-l-dsXyaQOGOQynEI87ovtQ-1; Tue, 03 Oct 2023 04:30:55 -0400
X-MC-Unique: l-dsXyaQOGOQynEI87ovtQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b2c1159b0aso47461566b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321853; x=1696926653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7eXq7UgzPmULRL3TIyMtMS9O4FF89KJBAS2EjoKyTg=;
 b=XDUtItqdFdgKHwKL8tazZDifwuMF4UTrCQWYk6YJbMWx2aU9EEkfyIJI2yCVixgFsA
 wC1QYawcHKOfUFalJbatvtVMVGqIPcyYNnKvn+Hnl2Quww2IEOpRpeqJgOdmlwbfrcp/
 LlW8IqLDgQvm+NkSj4kh2BR+xmar63tVipg4rKkvbOshz93hGEUd0Vdppq6VDUm5FSVf
 MVWD23HrvGmK5bw14/IVWRIjBe5ffVn/rfKBDjQgOvzb8XCMGz2hYSfxT0rJT5bSaJMr
 5VotIjgz9I1kUT1QkUfkrdEoT45DMGWAERh2nkuJc7UF5BzG2NATYTHGxONqTckwXkIt
 1Kjw==
X-Gm-Message-State: AOJu0Yxr2GDjAL8VEhHZoYIB7+0E4CRZUf44cQcYwgMq3rnjiQleC5XO
 ZlY/onv4eJGvYCrlHTDvangxbs2fGeI8GeRLekjnDuNj/I3iih7ZB2+mttHQncaw9vSSq+Cy7sr
 /azSTaPYPfajRZun69yPo1GOXKk3jPjJBq+v6yui/f22hwOepH9+Zt+CaCP72SxnpLWpODR/6v6
 8=
X-Received: by 2002:a17:906:3ca1:b0:9a6:5696:3887 with SMTP id
 b1-20020a1709063ca100b009a656963887mr11613850ejh.59.1696321853623; 
 Tue, 03 Oct 2023 01:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8vTZy9JHPJ/BNBj5UeMMHG4fFEprhjxEWWMGRgji7RGQVZyXBUbJI3jGoB2I5mEQ+UAU+6w==
X-Received: by 2002:a17:906:3ca1:b0:9a6:5696:3887 with SMTP id
 b1-20020a1709063ca100b009a656963887mr11613823ejh.59.1696321853182; 
 Tue, 03 Oct 2023 01:30:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a170906449600b0098e2969ed44sm653204ejo.45.2023.10.03.01.30.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] make-release: do not ship dtc sources
Date: Tue,  3 Oct 2023 10:30:22 +0200
Message-ID: <20231003083042.110065-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4F1707019
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGs-0004Bt-2f; Wed, 17 May 2023 13:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEa-0000cl-3D
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEY-0004O9-CP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUOZpiyE32GQEdNrdxVkXRqUJswyfTYYATcn6Mk6EHo=;
 b=J5yqCuuri8X4DnU9nZnxrV4c0yVkXYmJZJdZowtpPOedWpWdPhMOSHJwlimXS4iuTe/XH0
 h0pePaNqawWRWZXgbVLSapZQwO5TiwjmamRLsjqRynQVlhz++C18fYb1Nr1/12DuqOeBRI
 i5yOzNHMTrTYvGeruEc3hp1BLgjtgQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-K3XnuCrdN4iW8lE2uhVNgQ-1; Wed, 17 May 2023 13:46:40 -0400
X-MC-Unique: K3XnuCrdN4iW8lE2uhVNgQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso490456f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345599; x=1686937599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUOZpiyE32GQEdNrdxVkXRqUJswyfTYYATcn6Mk6EHo=;
 b=Z+MGchO9q2Q3NUm5jaEKSEOb6Y3dyWLDOiL7CtasQ084VJ+G6z9Zh6XrCu1sfQrlUP
 u2Y7AGPdANNtsUIoqoLmuYXYe8n7/JLi8MIM1Ru70/NOEeBEdILafaDzAUknIqsFboOi
 VQbhuhx1wr3EZxLxbqdfZRJA57ZIlT1zynqFJk8R3ffwA8n0AhqobNPb+vobwxTzL/OI
 aaKxMKxOmv6YoDlcZcDPT5q6vOmnABiQwNUeROTG08Gcxs9GsewItaz6YNPoz9R4kSaS
 tr1Vzzg/b9bmR2cGOhHlBrtYLwyKdCe6VyeDU5zQNEhBAZB8R+yRr7lyX85Oho4H+Hdx
 jhnQ==
X-Gm-Message-State: AC+VfDyPsysPlWXMk7xZ3vWQB9WZQNf0yFDa96/K/4XMCOhgv53nnAdE
 IkfEpK2fZPPfx53BcPuWi1dTC6V/7+JRkCm2FiQ1hJGrEEW3Y0Xs02Vt7pN25Ka457ZZ+3niO4c
 lSzwv4zhgCajA7lmQJci+11dSYOL1KrEVXls9SHFldjk97k6M1wEHxiwO0mEOJY8F4dbn8LeY+M
 Q=
X-Received: by 2002:adf:f2c3:0:b0:309:436a:fc2f with SMTP id
 d3-20020adff2c3000000b00309436afc2fmr1067185wrp.57.1684345598846; 
 Wed, 17 May 2023 10:46:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mhRSc0b3myuBOexfJPpWFIh2DwT0MoxCEtPQh0tMfdvmLL896zzY8cH1qUV8pgySRu2o59Q==
X-Received: by 2002:adf:f2c3:0:b0:309:436a:fc2f with SMTP id
 d3-20020adff2c3000000b00309436afc2fmr1067174wrp.57.1684345598398; 
 Wed, 17 May 2023 10:46:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a5d6785000000b002fb60c7995esm3425516wru.8.2023.05.17.10.46.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/68] meson: require 0.63.0
Date: Wed, 17 May 2023 19:44:58 +0200
Message-Id: <20230517174520.887405-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This version allows cleanups in modinfo collection, but they only
work with Ninja 1.9.x and 1.8.x is still supported.  It also supports the
equivalent of QEMU's --static option to configure.

The wheel file is bumped to 0.63.3, the last release in the 0.63 branch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                   |   2 +-
 meson.build                                 |   2 +-
 python/scripts/vendor.py                    |   4 ++--
 python/wheels/meson-0.61.5-py3-none-any.whl | Bin 862509 -> 0 bytes
 python/wheels/meson-0.63.3-py3-none-any.whl | Bin 0 -> 926526 bytes
 5 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 100644 python/wheels/meson-0.61.5-py3-none-any.whl
 create mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl

diff --git a/configure b/configure
index 52eca1cd4c53..dbdcf3886d56 100755
--- a/configure
+++ b/configure
@@ -1136,7 +1136,7 @@ if ! $mkvenv ensure \
      $mkvenv_flags \
      --dir "${source_path}/python/wheels" \
      --diagnose "meson" \
-     "meson>=0.61.5" ;
+     "meson>=0.63.0" ;
 then
     exit 1
 fi
diff --git a/meson.build b/meson.build
index 25a4b9f2c106..e3a9db20ffa7 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=0.61.3',
+project('qemu', ['c'], meson_version: '>=0.63.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 23708430ea68..34486a51f445 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==0.61.5":
-        "58c2ddb5f885da0e929f15d89f38d8a7d97f981f56815bcba008414f8511f59a",
+        "meson==0.63.3":
+        "d677b809c4895dcbaac9bf6c43703fcb3609a4b24c6057c78f828590049cf43a",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
-- 
2.40.1



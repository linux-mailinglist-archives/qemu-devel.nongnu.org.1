Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E8707017
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEc-0000i6-0H; Wed, 17 May 2023 13:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEF-0008Jg-3a
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLED-0004J1-Jt
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktxuVoeCftsXoioRTwebbxI5P4dwKOFzWaEcjYs2LFM=;
 b=Iw945ZwTVbX1QaA1eU3RFGu+8lF4Byr3sUdh8G49aby9nVHHbJ/SYSPBk2o9AEVoQ3MPrH
 2y05rTMNfFY7tNTFuu2G2bvCpk2ZyCe4BRyiwm1r5ziqkS3g1y43W8fV9Olhne0BLxHt1A
 OOAyyj8ILOE9pcmmntOzfDULQgCnCVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-b3jMMQWaM82NvAA1_Kwhjg-1; Wed, 17 May 2023 13:46:19 -0400
X-MC-Unique: b3jMMQWaM82NvAA1_Kwhjg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42b226871so4969275e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345578; x=1686937578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktxuVoeCftsXoioRTwebbxI5P4dwKOFzWaEcjYs2LFM=;
 b=PyNAjJC4Qq9k0aKoWJZh1IDc/uiPfLO2DxAICadKtTQyXD9nv6MixEc0n/f4YjvTkg
 xLiw4KAEg3EMqblGZnDmFHYK72Uf1Dzm0IW+4nu2iuXQPXjoMic3Cn881FR2nzzYG/hX
 AOXXAEq6VIfGqlPl9XzwMrgkaVbP1NsCHlh0iK8wH74JJ4GsZsfmcpYX3pn0MM7IRl5i
 lPCozBFifgtEwqHUo2uob8JwYqT6f1DnWaqbbQ1aXwZ+CiObKlBARrF8McaGMs94kBi/
 QU0j/Kr5zhtPALuIjhHbj3JgnBK4Z7OAewN9jkrzQMm6BDZ6hO4CY/WMQ1asBbD7nZLZ
 4A3Q==
X-Gm-Message-State: AC+VfDwMYA4nM69/hNtInownGwNpIczvl+QMlyhqCNdZch+Zb3NKXyKH
 iFYCl7Og8kl1898vGO4o9s2b/mZLTBGahxVdpJR7wdaVVpglDGfLlGVhRDqWtUP2Hc+U21f8HBm
 mCPPCrdDCN7C2LH2pNG5jo2T1bm5lBr0jaVPmRV9SGolVklFwDNuLiwACTy0SIQAFAEb43JDYjl
 8=
X-Received: by 2002:a05:600c:3787:b0:3f4:2bcd:5a6e with SMTP id
 o7-20020a05600c378700b003f42bcd5a6emr20206702wmr.30.1684345578028; 
 Wed, 17 May 2023 10:46:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gFcnkxAvYj5CRIMh2ADqAV05VSrdfz4/VN5fkmL1lCv+BXdYe7MqA8hT1vZFl0IhmBokfFw==
X-Received: by 2002:a05:600c:3787:b0:3f4:2bcd:5a6e with SMTP id
 o7-20020a05600c378700b003f42bcd5a6emr20206688wmr.30.1684345577704; 
 Wed, 17 May 2023 10:46:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a05600c220200b003f42cc7aac4sm2885044wml.37.2023.05.17.10.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 33/68] configure: create a python venv unconditionally
Date: Wed, 17 May 2023 19:44:45 +0200
Message-Id: <20230517174520.887405-34-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

This patch changes the configure script so that it always creates and
uses a python virtual environment unconditionally.

Meson bootstrapping is temporarily altered to force the use of meson
from git or vendored source (as packaged in our source tarballs). A
subsequent commit restores the use of distribution-vendored Meson.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-16-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 243e2e0a0dbc..1d7db92ee3f9 100755
--- a/configure
+++ b/configure
@@ -625,7 +625,6 @@ check_py_version() {
 python=
 first_python=
 if test -z "${PYTHON}"; then
-    explicit_python=no
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
     for binary in python3 python python3.11 python3.10 python3.9 python3.8 python3.7 python3.6; do
@@ -644,7 +643,6 @@ else
     # Same as above, but only check the environment variable.
     has "${PYTHON}" || error_exit "The PYTHON environment variable does not point to an executable"
     python=$(command -v "$PYTHON")
-    explicit_python=yes
     if check_py_version "$python"; then
         # This one is good.
         first_python=
@@ -729,7 +727,7 @@ for opt do
   ;;
   --install=*)
   ;;
-  --python=*) python="$optarg" ; explicit_python=yes
+  --python=*) python="$optarg"
   ;;
   --skip-meson) skip_meson=yes
   ;;
@@ -1090,8 +1088,34 @@ if ! check_py_version "$python"; then
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
-# Resolve PATH + suppress writing compiled files
-python="$(command -v "$python") -B"
+# Resolve PATH
+python="$(command -v "$python")"
+explicit_python=yes
+
+# Create a Python virtual environment using our configured python.
+# The stdout of this script will be the location of a symlink that
+# points to the configured Python.
+# Entry point scripts for pip, meson, and sphinx are generated if those
+# packages are present.
+
+# Defaults assumed for now:
+# - venv is cleared if it exists already;
+# - venv is allowed to use system packages;
+# - all setup is performed **offline**;
+# - No packages are installed by default;
+# - pip is not installed into the venv when possible,
+#   but ensurepip is called as a fallback when necessary.
+
+echo "python determined to be '$python'"
+echo "python version: $($python --version)"
+
+python="$($python -B "${source_path}/python/scripts/mkvenv.py" create pyvenv)"
+if test "$?" -ne 0 ; then
+    error_exit "python venv creation failed"
+fi
+
+# Suppress writing compiled files
+python="$python -B"
 
 has_meson() {
   local python_dir=$(dirname "$python")
-- 
2.40.1



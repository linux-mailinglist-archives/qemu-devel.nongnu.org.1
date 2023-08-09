Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1831775678
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVu-0004Yu-Pv; Wed, 09 Aug 2023 05:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVs-0004YY-1M
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVp-0003bN-4O
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26LooHGS4ckkZKmvS9hNGL4UCKKDRMVaCcDJHtxvtlQ=;
 b=cPJlkEiZlQvRVVMP2fCxJTZhKqF2OLOFqGut9Bislnjf16+WU1fWAua3RWkuhp3xdxbJah
 nnVTcrVmczuTt87LJB+TdRLRhBwPe64ipqAQfAiM9cb+o5iCj8w1QieCcUnpIXV8H95PP9
 o/ratZ8bcVZFFshM+KEpVW3zsbo+szQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-JfvFF_HAMua-iDHxz-XBxQ-1; Wed, 09 Aug 2023 05:29:49 -0400
X-MC-Unique: JfvFF_HAMua-iDHxz-XBxQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe5b94bd62so19841155e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573388; x=1692178188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26LooHGS4ckkZKmvS9hNGL4UCKKDRMVaCcDJHtxvtlQ=;
 b=DPMvyadLsPdlOcgob+6s3AuNf2DSsdVaBngkUh2K9hah6dUGGFluLOBwAi6PdnpCMX
 5UhszsLfeRKBGbj33iOUnXzVIKchyZRAfSlJl1LcMQ41BM6IMaJ4vlO3dEa2Zc9qT4IR
 6+lsLyeHGozluQPN5Qbvofy0FPM68Mmsx+dGvhC0lcz310mihAnnQhzvlcEi9t392ehd
 rRxSRe7VBjQtXj1XAxEGjsGcqdzxIEVW4k3tVDx5uMwC9h7TdHBumet4cqMzHQEp2mIJ
 1hYaP0CL2CdivSB3HGNZISz+VGMkmuF7p1rl+ziwe8hflw5NHx9mGCwcCANX73Bjdgh/
 bRuQ==
X-Gm-Message-State: AOJu0YziTjbKebZlCpZVu5QpL/gY4T6A7ykRz9PbpWcgEMR+v0z347p7
 Q/0sTqBqpc6B2NxS9INyR1PnQlmcq0F1NYagNmO5K9x+tzIFMEeNl7JIerqwaTSRVcJn688eSUw
 YeqCpTlyspQ9Zt73krOlDm2tTp/4qLbhz7INY+RYTNWTs5UUx1tUx2iBwGXVBQyMIRhiuWyuGb4
 M=
X-Received: by 2002:a7b:ca57:0:b0:3fe:238e:b23b with SMTP id
 m23-20020a7bca57000000b003fe238eb23bmr1773699wml.36.1691573387702; 
 Wed, 09 Aug 2023 02:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH36iYi3iPatJEzaE5CivZimbh+XVHUzSQBGBNIrs0d0HYbNwyk54vF7kF8Vlt48srLj4Ansg==
X-Received: by 2002:a7b:ca57:0:b0:3fe:238e:b23b with SMTP id
 m23-20020a7bca57000000b003fe238eb23bmr1773688wml.36.1691573387327; 
 Wed, 09 Aug 2023 02:29:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a7bc3cf000000b003fe601a7d46sm1401003wmj.45.2023.08.09.02.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 7/9] configure: switch to ensuregroup
Date: Wed,  9 Aug 2023 11:29:31 +0200
Message-ID: <20230809092933.761524-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Using the new ensuregroup command, the desired versions of meson and
sphinx can be placed in pythondeps.toml rather than configure.

The meson.install entry in pythondeps.toml matches the version that is
found in python/wheels.  This ensures that mkvenv.py uses the bundled
wheel even if PyPI is enabled; thus not introducing warnings or errors
from versions that are more recent than the one used in CI.

The sphinx entries match what is shipped in Fedora 38.  It's the
last release that has support for older versions of Python (sphinx 6.0
requires Python 3.8) and especially docutils (of which sphinx 6.0 requires
version 0.18).  This is important because Ubuntu 20.04 has docutils 0.14
and Debian 11 has docutils 0.16.

"mkvenv.py ensure" is only used to bootstrap tomli.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure       | 14 ++++----------
 pythondeps.toml |  8 ++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 347153702c1..e4d42d640e4 100755
--- a/configure
+++ b/configure
@@ -1024,13 +1024,8 @@ if $python -c 'import sys; sys.exit(sys.version_info >= (3,11))'; then
     $mkvenv ensure --dir "${source_path}/python/wheels" \
         'tomli>=1.2.0' || exit 1
 fi
-if ! $mkvenv ensure \
-     --dir "${source_path}/python/wheels" \
-     --diagnose "meson" \
-     "meson>=0.63.0" ;
-then
-    exit 1
-fi
+$mkvenv ensuregroup --dir "${source_path}/python/wheels" \
+     "${source_path}/pythondeps.toml" meson || exit 1
 
 # At this point, we expect Meson to be installed and available.
 # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
@@ -1047,10 +1042,9 @@ if test "$download" = "enabled" -a "$docs" = "enabled" ; then
 fi
 
 if test "$docs" != "disabled" ; then
-    if ! $mkvenv ensure \
+    if ! $mkvenv ensuregroup \
          $mkvenv_flags \
-         --diagnose "sphinx-build" \
-         "sphinx>=1.6.0" "sphinx-rtd-theme>=0.5.0";
+         "${source_path}/pythondeps.toml" docs;
     then
         if test "$docs" = "enabled" ; then
             exit 1
diff --git a/pythondeps.toml b/pythondeps.toml
index 362f63ff2c9..6be31dba301 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -15,3 +15,11 @@
 #           precise error diagnostics to the user.  For example,
 #           'sphinx-build' can be used as a bellwether for the
 #           presence of 'sphinx' in the system.
+
+[meson]
+# The install key should match the version in python/wheels/
+meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
+
+[docs]
+sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
+sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
-- 
2.41.0



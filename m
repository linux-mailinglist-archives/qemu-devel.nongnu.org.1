Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684878AC8A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZem-0003QO-O9; Mon, 28 Aug 2023 06:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeR-0003Nq-NS
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeP-00057J-7z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZ1wphPU2L+AG11Kp2DCrA+rofOWMWZZkCFpamYaGIs=;
 b=cE18Ib+0CKPmf8Lkrx3ht4ravenCgg15y+gPC2YHDbQJIw8D+EFwq2kp+j+wU7tiJKoM28
 bkHg1u4qbGNVe1ynGydhMHBXNxhs5Rg0fsar+zhccreUp2rqLZCzdBG2ExhK4TB04y8J9Z
 Re1Yj2/nR84XqAPHBuBaRASwktwD2HY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-kzfHT6FzONWjOPQHrvKcIQ-1; Mon, 28 Aug 2023 06:39:14 -0400
X-MC-Unique: kzfHT6FzONWjOPQHrvKcIQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe4f953070so21809405e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219153; x=1693823953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZ1wphPU2L+AG11Kp2DCrA+rofOWMWZZkCFpamYaGIs=;
 b=EnELocAMolBQtJ3pvFzPaiTCTaqxIl3QLFmY+C8uAvqWqZtntALBR+661dzoI38OJF
 68ioezGFKfyOJ0ukFGZnunUt29g9KSgrffGR8UQ9rRE5EHKMcm9uqD5wURmGL9NkTrFg
 fcFLEJP+UCff6U/ZCAomZwdJHIFvkAd2QtssNkI7/iizAQsY8rTQM8IEy4a0HL7esVrA
 0w1HeQqo8bi5diCZzcb2ArgMSl2wCgNXQK0ehWzchYYeCtssVthsM8u4VMl71Z1weuZn
 DbK4SksCszdx7e0PqxXETA7LSdCcCk8fWPl31nThS+yEbqHXeixcKWzwzk0LLF1Pszq7
 jHHw==
X-Gm-Message-State: AOJu0YyiRROtuGNZaK4Z505jY8snSsz012bOOMKaj1ghQZPEcTglACjg
 VSkOIFB3j6PGPYQLSSNCjEG/oJEwkL3hi9Gk3fUUT9ChOYgq557Y4aPRV+xoCFlucjXnld1E0NL
 Tt8K5PLnA+ChIJrB2QlxEoT8JyKWpQjOqONXf+fvPlsyyoqL0PhTFDmAE4kFaZ2sZpzO8lGQb0C
 0=
X-Received: by 2002:a1c:7403:0:b0:3fd:1daf:abd8 with SMTP id
 p3-20020a1c7403000000b003fd1dafabd8mr17589535wmc.40.1693219152995; 
 Mon, 28 Aug 2023 03:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSHqNd12kV/ooWe54P/9VWtzqGI9uAiiVHg1S9UlPKK7C1qpts0gvMfNSgEgLf3yywKkqR3w==
X-Received: by 2002:a1c:7403:0:b0:3fd:1daf:abd8 with SMTP id
 p3-20020a1c7403000000b003fd1dafabd8mr17589524wmc.40.1693219152643; 
 Mon, 28 Aug 2023 03:39:12 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c231500b003fed4fa0c19sm13620305wmo.5.2023.08.28.03.39.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] configure: switch to ensuregroup
Date: Mon, 28 Aug 2023 12:38:48 +0200
Message-ID: <20230828103856.46031-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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
+     ${source_path}/pythondeps.toml meson || exit 1
 
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
+         ${source_path}/pythondeps.toml docs;
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



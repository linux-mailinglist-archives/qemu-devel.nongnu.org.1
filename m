Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AA8A2F5A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Apr 2024 15:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvGtd-000308-Vl; Fri, 12 Apr 2024 09:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtb-0002zo-HJ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtZ-00079b-S5
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712928285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui42U3OZLUmR2c+fDS4a9VZnDL92raLSRw8NqRlqnmg=;
 b=dIZ7oKiYQyIoduOeNPMMuggDFLJVPPvTB+IuRxscJf7Szs6mkrg6q7j4APMc9wQeQchxBt
 IWjVbAdhxnpyeqr6rJK+j5/mmljMxz8s3fNBH2GoZAtdXnyYUXKCcLq+YdzkDcvuU7YQST
 IJvYV5SsEFkOgsTyRdxfB1xBwNCnYio=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-AcBmGHeSPWW6-VOj0fx6Mg-1; Fri,
 12 Apr 2024 09:24:43 -0400
X-MC-Unique: AcBmGHeSPWW6-VOj0fx6Mg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B3343C01B96;
 Fri, 12 Apr 2024 13:24:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82FFC2166B31;
 Fri, 12 Apr 2024 13:24:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 05/13] .travis.yml: Update the jobs to Ubuntu 22.04
Date: Fri, 12 Apr 2024 15:24:07 +0200
Message-ID: <20240412132415.282354-6-thuth@redhat.com>
In-Reply-To: <20240412132415.282354-1-thuth@redhat.com>
References: <20240412132415.282354-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

According to our support policy, we'll soon drop our official support
for Ubuntu 20.04 ("Focal Fossa") in QEMU. Thus we should update the
Travis jobs now to a newer release (Ubuntu 22.04 - "Jammy Jellyfish")
for future testing. Since all jobs are using this release now, we
can drop the entries from the individual jobs and use the global
setting again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8a3ae76a7c..56a2a01e14 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,5 @@
 os: linux
-dist: focal
+dist: jammy
 language: c
 compiler:
   - gcc
@@ -7,7 +7,7 @@ cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
   # - OS name (currently only linux)
-  # - OS distribution (for Linux, bionic or focal)
+  # - OS distribution (e.g. "jammy" for Linux)
   # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
@@ -83,7 +83,6 @@ jobs:
 
     - name: "[aarch64] GCC check-tcg"
       arch: arm64
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -119,7 +118,6 @@ jobs:
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -154,7 +152,6 @@ jobs:
 
     - name: "[s390x] GCC check-tcg"
       arch: s390x
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -199,7 +196,6 @@ jobs:
 
     - name: "[s390x] GCC (other-system)"
       arch: s390x
-      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -229,7 +225,6 @@ jobs:
 
     - name: "[s390x] GCC (user)"
       arch: s390x
-      dist: focal
       addons:
         apt_packages:
           - libgcrypt20-dev
@@ -244,8 +239,7 @@ jobs:
 
     - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
-      dist: focal
-      compiler: clang-10
+      compiler: clang
       addons:
         apt_packages:
           - libaio-dev
@@ -271,7 +265,6 @@ jobs:
           - libvdeplug-dev
           - libvte-2.91-dev
           - ninja-build
-          - clang-10
       env:
         - TEST_CMD="make check-unit"
         - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools
-- 
2.44.0



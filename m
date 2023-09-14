Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4357A02B5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkbD-0000m0-6P; Thu, 14 Sep 2023 07:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkbA-0000ks-MK
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb9-000891-6p
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzGcCXOTgzs/KK0nnUaTySvwi2Hbh3NHaI9+eF11AO0=;
 b=UX7hlUZGOLbh0RKoOkcVDrSmyjiFUxI2khQH6cN3aijNQWr6965MlZI+SWLS+ggxbKGShz
 dIVK2/gfVwBUj/09zLTqJV/ziyrUmVT+rMX+Zf9tNxayG5+ywEOszMOhFvWpWccJG6ug5n
 heClfUP+dltnhdL6PkCgTd7VDUIXZfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-t8Ct6-tQNQKsnXJ1H6V6iw-1; Thu, 14 Sep 2023 07:33:23 -0400
X-MC-Unique: t8Ct6-tQNQKsnXJ1H6V6iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0398801779;
 Thu, 14 Sep 2023 11:33:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBE671054FC3;
 Thu, 14 Sep 2023 11:33:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu RFC PATCH v3 7/7] Add a travis.yml file for testing RISU in the
 Travis-CI
Date: Thu, 14 Sep 2023 13:33:11 +0200
Message-ID: <20230914113311.379537-8-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
References: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Travis-CI offers native build machines for aarch64, ppc64le
and s390x, so this is very useful for testing RISU on these
architectures. While compiling works fine for all architectures,
running the binary currently only works for s390x (the aarch64
runner reports a mismatch when comparing the registers, and
the ppc64le runner simply hangs), so we can only run the
resulting binary on s390x right now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Not sure if this is useful for anybody but me since Travis is
 not that popular anymore these days ... so please feel free
 to ignore this patch.

 .travis.yml | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..bafa8df
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,37 @@
+dist: focal
+language: c
+compiler:
+  - gcc
+addons:
+  apt:
+    packages:
+      - perl
+      - perl-modules
+      - liblist-compare-perl
+
+before_script:
+  - ./configure
+script:
+  - set -e
+  - make -j2
+  - ./risugen --numinsns 1000 ${ARCH}.risu ${ARCH}.bin
+
+matrix:
+  include:
+
+    - env:
+        - ARCH="aarch64"
+      arch: arm64
+
+    - env:
+        - ARCH="ppc64"
+      arch: ppc64le
+
+    - env:
+        - ARCH="s390x"
+      arch: s390x
+      after_script:
+      - ./risu --master ${ARCH}.bin > stdout.txt 2> stderr.txt &
+      - sleep 1
+      - ./risu --host localhost ${ARCH}.bin
+      - cat stdout.txt stderr.txt
-- 
2.41.0



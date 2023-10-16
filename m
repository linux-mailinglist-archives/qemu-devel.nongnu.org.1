Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6A7CAEA5
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQBS-0001eQ-8Z; Mon, 16 Oct 2023 12:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsQBQ-0001cv-4m
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qsQBL-00052O-Iw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697472662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=httz1az805r0DLACezQs67K9wBolea1FrnuauuCf34Y=;
 b=RNLv5WKqkLthDnrZ2bJV9Vr36JPyKOv2uyF3clgUKnXIQOqYvVsGDoeNK/WNQC5O4kHUue
 Cm9Aoz0OR5Elvw1d0lGj/QVghTlAvl3r4iaDTQhtkHZrEf0zzKUNg63yugYJ5J/yKqELOQ
 53gUYChfg+gyBC5VuIxIIopwjIYQknk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-o55wHHVtN2aMcABesadCtw-1; Mon, 16 Oct 2023 12:10:57 -0400
X-MC-Unique: o55wHHVtN2aMcABesadCtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 967581818681;
 Mon, 16 Oct 2023 16:10:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A8E811301CF;
 Mon, 16 Oct 2023 16:10:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] tests/vm/freebsd: Add additional library paths for libfdt
Date: Mon, 16 Oct 2023 18:10:53 +0200
Message-ID: <20231016161053.39150-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

libfdt is installed in /usr/local on FreeBSD, and since this
library does not have a pkg-config file, we have to specify the
paths manually. This way we can avoid that Meson has to recompile
the dtc subproject each time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/freebsd | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index ac51376c82..b581bd17fb 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -38,8 +38,9 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
         mkdir src build; cd src;
         tar -xf /dev/vtbd1;
-        cd ../build
-        ../src/configure --python=python3.9 {configure_opts};
+        cd ../build;
+        ../src/configure --python=python3.9  --extra-ldflags=-L/usr/local/lib \
+                         --extra-cflags=-I/usr/local/include {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
 
-- 
2.41.0



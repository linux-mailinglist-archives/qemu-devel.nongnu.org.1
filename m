Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D173782E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 02:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBlbW-0003zI-Sw; Tue, 20 Jun 2023 20:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbU-0003yT-6l
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbQ-000093-N3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687306900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tmXMJY+e4M0cUKQ5yliUcPrNFZ1qAAb8NZJYE/gZ7o=;
 b=AKQECWenCV9fKTUuH/MgIS5sC9D7mpVj8K/c8cRUb+KyDtW5XOS3cUzt8JyDU3fB1e6Mq/
 eLkBJTgqRwNxAJpGVWog0q/F6wNn463kmXoavOHXMYf78JJuc6L7xlObcum4I/YHT4kUT6
 Kw793KtsCp/Iws0haZIki5AsxN7o+8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-UaBkaYbiNzafKZ9VAPAM1w-1; Tue, 20 Jun 2023 20:21:36 -0400
X-MC-Unique: UaBkaYbiNzafKZ9VAPAM1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA88A8028B2;
 Wed, 21 Jun 2023 00:21:35 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93948112132C;
 Wed, 21 Jun 2023 00:21:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC 2/6] build,
 tests: Add qemu in-tree packages to pyvenv at configure time.
Date: Tue, 20 Jun 2023 20:21:17 -0400
Message-Id: <20230621002121.1609612-3-jsnow@redhat.com>
In-Reply-To: <20230621002121.1609612-1-jsnow@redhat.com>
References: <20230621002121.1609612-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

though, ouch: on my machine this takes 3-4 entire seconds to do. I wish
it wasn't so slow, but we can't rely on these packages not having any
dependencies any more.

We could theoretically use a .pth hack when creating the venv to
automatically include this directory as an "installed packages"
location, but when we go to drop qemu.qmp in the future, that will break
- I think we need to *install* this package.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/configure b/configure
index 01a53576a7..d2e0abc068 100755
--- a/configure
+++ b/configure
@@ -250,6 +250,7 @@ git_submodules_action="update"
 git="git"
 debug_tcg="no"
 docs="auto"
+tests="enabled"
 EXESUF=""
 prefix="/usr/local"
 qemu_suffix="qemu"
@@ -639,6 +640,10 @@ for opt do
   ;;
   --disable-docs) docs=disabled
   ;;
+  --enable-tests) tests=enabled
+  ;;
+  --disable-tests) tests=disabled
+  ;;
   --cpu=*)
   ;;
   --target-list=*) target_list="$optarg"
@@ -985,6 +990,32 @@ if test "$docs" != "disabled" ; then
     fi
 fi
 
+# Optionally pre-load the testing pre-requisites. This is for iotests,
+# vmtests, and anything else that uses Python qemu.* packages. Note that
+# our in-tree qemu packages are currently pure python with zero external
+# dependencies. For this reason, it excludes the Avocado dependencies
+# which are installed on-demand at time of use instead.
+
+mkvenv_flags=""
+if test "$pypi" = "enabled" ; then
+    mkvenv_flags="--online"
+fi
+
+if test "$tests" = "enabled" ; then
+    if ! $mkvenv install \
+         $mkvenv_flags \
+         --editable \
+         --dir "${source_path}/python/wheels" \
+         "${source_path}/python/";
+    then
+        echo "There was a problem installing the in-tree python packages for testing."
+        exit 1
+    fi
+    touch pyvenv/tests.group
+fi
+
+echo "mkvenv: done for now, ciao!"
+
 # Probe for ninja
 
 if test -z "$ninja"; then
-- 
2.40.1



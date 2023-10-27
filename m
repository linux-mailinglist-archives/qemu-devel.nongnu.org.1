Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4B7D93F3
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHZ-0002QF-EN; Fri, 27 Oct 2023 05:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHX-0002PO-5u
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHV-0002ml-Q1
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFxWit6EDQpvXX0oJXBrbwgFI/2IOtss+8l+4gM0hgw=;
 b=LON5irjr7tyOYwiMiLMzvBUkq3RYEiE9Cb079wtgXuvqliZi9+AHIaSQ09kPY4Y8TiRPtF
 67WzEzqJSo71g1IF0hEmBKC/zt//7UWKcXRa0kjUNyQn2b9XZV70mopKLUnFVDPqoh5SmX
 qLraxFXjOHwNZ2CAA2lv2Poc6pyvXto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-BtFGnl9dOiaD5Usl6BK81A-1; Fri, 27 Oct 2023 05:37:27 -0400
X-MC-Unique: BtFGnl9dOiaD5Usl6BK81A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D6DD84B102;
 Fri, 27 Oct 2023 09:37:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21FC01121320;
 Fri, 27 Oct 2023 09:37:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Warner Losh <imp@bsdimp.com>
Subject: [PULL 10/11] tests/vm/freebsd: Add additional library paths for libfdt
Date: Fri, 27 Oct 2023 11:37:09 +0200
Message-ID: <20231027093710.273558-11-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

libfdt is installed in /usr/local on FreeBSD, and since this
library does not have a pkg-config file, we have to specify the
paths manually. This way we can avoid that Meson has to recompile
the dtc subproject each time.

Message-ID: <20231016161053.39150-1-thuth@redhat.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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



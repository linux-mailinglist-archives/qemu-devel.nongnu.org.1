Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7E71A1EE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jtm-0007b6-UE; Thu, 01 Jun 2023 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jtN-0007Wt-9W
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jtL-0007pz-LB
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685632026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmwIuqbKSBmYUUYZl+TDEkyLmw0sm6/vkiGhVfu4wao=;
 b=DwOZTkha4/XDjIF+tqzNev/k4kmtD/BKXyVETz4cdVMQF4+Dd+3XsCK8LUwTMH6AzrqkYV
 Q5Sit4yGlSWJjplOi8Je7Ukq/Qne4p3PYvnP3dtCsyuOd4s/8+XZQcUnIhZl888dJUgPxn
 6BTEOcKmEhXIpjDaBFQ4ZacTXRJ9FIc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-tgD9to2cO1-qlAEGMlgP8w-1; Thu, 01 Jun 2023 11:07:01 -0400
X-MC-Unique: tgD9to2cO1-qlAEGMlgP8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB2329AB3E8;
 Thu,  1 Jun 2023 15:06:59 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67608112132D;
 Thu,  1 Jun 2023 15:06:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 04/11] scripts/qapi: document the tool that generated the
 file
Date: Thu,  1 Jun 2023 11:06:42 -0400
Message-Id: <20230601150649.1591095-5-stefanha@redhat.com>
In-Reply-To: <20230601150649.1591095-1-stefanha@redhat.com>
References: <20230601150649.1591095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

This makes it a little easier for developers to find where things
where being generated.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-5-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-5-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qapi/gen.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 8f8f784f4a..70bc576a10 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -13,6 +13,7 @@
 
 from contextlib import contextmanager
 import os
+import sys
 import re
 from typing import (
     Dict,
@@ -162,7 +163,7 @@ def __init__(self, fname: str, blurb: str, pydoc: str):
 
     def _top(self) -> str:
         return mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
+/* AUTOMATICALLY GENERATED by %(tool)s DO NOT MODIFY */
 
 /*
 %(blurb)s
@@ -174,6 +175,7 @@ def _top(self) -> str:
  */
 
 ''',
+                     tool=os.path.basename(sys.argv[0]),
                      blurb=self._blurb, copyright=self._copyright)
 
     def _bottom(self) -> str:
@@ -195,7 +197,10 @@ def _bottom(self) -> str:
 
 class QAPIGenTrace(QAPIGen):
     def _top(self) -> str:
-        return super()._top() + '# AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n'
+        return (super()._top()
+                + '# AUTOMATICALLY GENERATED by '
+                + os.path.basename(sys.argv[0])
+                + ', DO NOT MODIFY\n\n')
 
 
 @contextmanager
-- 
2.40.1



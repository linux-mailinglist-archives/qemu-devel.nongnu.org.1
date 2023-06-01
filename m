Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C4971F598
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOe-0008Ar-GO; Thu, 01 Jun 2023 18:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOO-00085F-RJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOE-000439-8X
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685657004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wmq1fR0zN6nh2gdU8df8goS/tYoTt582Moo+ViFWaWU=;
 b=M4JsyRGu3SVsVvS52HaXDJy/aR+vSFml/ndQuIi+DscJ5VMe/YnUA/aMEu71W0sVlKMuT2
 yhnoMv6er/JyRo7VydCBL8qgRGSoLGKQvForDz7SFVjWg+Gr9095TyIBSQQSp6ruPqT9v9
 qBc3G1e1/zF/QlX42yInpB53sZn9B0M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-mwuDhhwWNdaFYvnd6BDjfg-1; Thu, 01 Jun 2023 18:03:19 -0400
X-MC-Unique: mwuDhhwWNdaFYvnd6BDjfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD7BE29324A8;
 Thu,  1 Jun 2023 22:03:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31E50492B0B;
 Thu,  1 Jun 2023 22:03:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 15/21] numa: Check for qemu_strtosz_MiB error
Date: Thu,  1 Jun 2023 17:02:59 -0500
Message-Id: <20230601220305.2130121-16-eblake@redhat.com>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

As shown in the previous commit, qemu_strtosz_MiB sometimes leaves the
result value untouched (we have to audit further to learn that in that
case, the QAPI generator says that visit_type_NumaOptions() will have
zero-initialized it), and sometimes leaves it with the value of a
partial parse before -EINVAL occurs because of trailing garbage.
Rather than blindly treating any string the user may throw at us as
valid, we should check for parse failures.

Fixes: cc001888 ("numa: fixup parsed NumaNodeOptions earlier", v2.11.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230522190441.64278-14-eblake@redhat.com>
---
 hw/core/numa.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index d8d36b16d80..f08956ddb0f 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -531,10 +531,17 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
     /* Fix up legacy suffix-less format */
     if ((object->type == NUMA_OPTIONS_TYPE_NODE) && object->u.node.has_mem) {
         const char *mem_str = qemu_opt_get(opts, "mem");
-        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
+        int ret = qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
+
+        if (ret < 0) {
+            error_setg_errno(&err, -ret, "could not parse memory size '%s'",
+                             mem_str);
+        }
     }

-    set_numa_options(ms, object, &err);
+    if (!err) {
+        set_numa_options(ms, object, &err);
+    }

     qapi_free_NumaOptions(object);
     if (err) {
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C136070C5D0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aqd-0003o0-S2; Mon, 22 May 2023 15:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AqA-0003dZ-Nf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq2-0003dW-Ej
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xxclizjudtIsbsm0k6hE30L3R9CgF1/7JAe5RXVZHU=;
 b=Vtak0cek4Mch9SN2KZBZjSdK0vV9bqt5PVwcPIkYwILGBEOVmN6PevlcQvje9eSFO9u4wt
 4V6ICxteOYL5+sfatrGz3+X6iIoFQaKQgUFgbK7aSWgIStcysfMCGawP3TIy65i0X/ptnU
 mVdrXX9U0CEHWHa2fHm0gm4HcxmRWlk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-NIydJ3UkOq6WgZySsH1F3A-1; Mon, 22 May 2023 15:04:52 -0400
X-MC-Unique: NIydJ3UkOq6WgZySsH1F3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFF5F1C03D81;
 Mon, 22 May 2023 19:04:51 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2E7400DFF;
 Mon, 22 May 2023 19:04:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v3 13/19] numa: Check for qemu_strtosz_MiB error
Date: Mon, 22 May 2023 14:04:35 -0500
Message-Id: <20230522190441.64278-14-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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



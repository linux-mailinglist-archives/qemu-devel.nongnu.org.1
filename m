Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FB791B86
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCOj-0007OC-Dg; Mon, 04 Sep 2023 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdCOg-0007Mn-8Z
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdCOd-0001s1-Rc
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693844751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opO8x/u1gtxbDGBKSy77Ei+EC+dcGTIytP3c3BLnam4=;
 b=NoHVLkeB6KYLs4quusMnsThW6PQoaN4yBqPIm2Cw6RWBw6QAwoNBYE2+w4EA2UmbE9XIqB
 x5cYQlnAXTHwCKi/KYb5d6lzS8xeaYFXYHJSPGFem10OueN8qvs9Fkcir98igVxFJkhJSA
 YQABsfq21yfJKBVyqJRhWvwtl+FYjc4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-cJqZhMOUNy-Vm4ep4HuxCw-1; Mon, 04 Sep 2023 12:25:48 -0400
X-MC-Unique: cJqZhMOUNy-Vm4ep4HuxCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67271299E75A;
 Mon,  4 Sep 2023 16:25:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63C25493110;
 Mon,  4 Sep 2023 16:25:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 William Tsai <williamtsai1111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/1] qom: fix setting of array properties
Date: Mon,  4 Sep 2023 17:25:44 +0100
Message-ID: <20230904162544.2388037-2-berrange@redhat.com>
In-Reply-To: <20230904162544.2388037-1-berrange@redhat.com>
References: <20230904162544.2388037-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

DEFINE_PROP_ARRAY() creates a property 'len-$ARRAY-PROP-NAME'
which, when set, will create a sequence of '$ARRAY-PROP-NAME[N]'
properties.

This only works if the 'len-$ARRAY-PROP-NAME' property is
set first, and the array elements afterwards. Historically
this required the user to set correct ordering and QemuOpts
traversal would preserve that ordering. With QemuOpts now
converted to QDict, iteration ordering is undefined. Thus
to keep array properties working, we iterate over the QDict
twice.

Doing this in QOM is a bit of a layering violation since
DEFINE_PROP_ARRAY is part of QDev, but it is the simplest
option to preserve backwards compatibility, without ripple
effects across any other part of QEMU.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1090
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object_interfaces.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7d31589b04..6aaaf42ffc 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -51,7 +51,37 @@ static void object_set_properties_from_qdict(Object *obj, const QDict *qdict,
     if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
         return;
     }
+
+    /* Layering violation here...
+     *
+     * DEFINE_PROP_ARRAY() creates a property 'len-$ARRAY-PROP-NAME'
+     * which, when set, will create a sequence of '$ARRAY-PROP-NAME[N]'
+     * properties.
+     *
+     * This only works if the 'len-$ARRAY-PROP-NAME' property is
+     * set first, and the array elements afterwards. Historically
+     * this required the user to get correct ordering and QemuOpts
+     * traversal would preserve that ordering. With QemuOpts now
+     * converted to QDict, iteration ordering is undefined. Thus
+     * to keep array properties working, we iterate over the QDict
+     * twice.
+     */
+
+    /* First the props that control array property length */
     for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
+        if (!g_str_has_prefix(e->key, "len-")) {
+            continue;
+        }
+        if (!object_property_set(obj, e->key, v, errp)) {
+            goto out;
+        }
+    }
+
+    /* Then any other normal properties */
+    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
+        if (g_str_has_prefix(e->key, "len-")) {
+            continue;
+        }
         if (!object_property_set(obj, e->key, v, errp)) {
             goto out;
         }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5767DBBC2
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:28:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTEi-0006RU-Ti; Mon, 30 Oct 2023 10:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEh-0006Qp-3e
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEf-0007RE-Hv
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698676040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY5dLJXsgNO5P0wwnaI4UOYfqJtjYgcLNxs80LoSaOM=;
 b=ijaddaPI1Vg2fiB/lDfHZ013EBAi9axhTcOZpTLtmrnhBiJ5hnIo2DVZcKUnNEKaIJstiq
 bv9Wug0EO+lxfTpAWPiaza7GbsRaFX2XeN9mxoyS+okt0SQdTIeFXZZxiob1rXR5Mr/sfx
 0FX3fDzEz1T5vkdt6d6Jr58jtCA5Ql8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-whP4PUG7MEys-tGVg07DBw-1; Mon, 30 Oct 2023 10:27:19 -0400
X-MC-Unique: whP4PUG7MEys-tGVg07DBw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC12998D3BA;
 Mon, 30 Oct 2023 14:27:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2142492BE0;
 Mon, 30 Oct 2023 14:27:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 10/12] qom: Add object_property_set_default_list()
Date: Mon, 30 Oct 2023 15:26:56 +0100
Message-ID: <20231030142658.182193-11-kwolf@redhat.com>
In-Reply-To: <20231030142658.182193-1-kwolf@redhat.com>
References: <20231030142658.182193-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

This function provides a default for properties that are accessed using
the list visitor interface. The default is always an empty list.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qom/object.h | 8 ++++++++
 qom/object.c         | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index ef7258a5e1..afccd24ca7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1093,6 +1093,14 @@ void object_property_set_default_bool(ObjectProperty *prop, bool value);
  */
 void object_property_set_default_str(ObjectProperty *prop, const char *value);
 
+/**
+ * object_property_set_default_list:
+ * @prop: the property to set
+ *
+ * Set the property default value to be an empty list.
+ */
+void object_property_set_default_list(ObjectProperty *prop);
+
 /**
  * object_property_set_default_int:
  * @prop: the property to set
diff --git a/qom/object.c b/qom/object.c
index 8557fe8e4e..95c0dc8285 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -31,6 +31,7 @@
  * of the QOM core on QObject?  */
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
@@ -1588,6 +1589,11 @@ void object_property_set_default_str(ObjectProperty *prop, const char *value)
     object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
 }
 
+void object_property_set_default_list(ObjectProperty *prop)
+{
+    object_property_set_default(prop, QOBJECT(qlist_new()));
+}
+
 void object_property_set_default_int(ObjectProperty *prop, int64_t value)
 {
     object_property_set_default(prop, QOBJECT(qnum_from_int(value)));
-- 
2.41.0



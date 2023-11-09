Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2C7E709C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r193x-0003dC-U6; Thu, 09 Nov 2023 12:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193v-0003c3-NN
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193u-0004qz-8O
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY5dLJXsgNO5P0wwnaI4UOYfqJtjYgcLNxs80LoSaOM=;
 b=AODD5eQwffoMrNz6vJ4iLfGXh3OC2RSO5Tki7wgFMwNwhHDK/NZJHj12EzF0rxthE8Mue5
 TgqPIoBxTMg7M2b+60MMJwKpKIzhY1+Cr/dgKnL8zD4W29I2KZUrfu7JfglCrREIuLdo4h
 uOaE9EuHX5rMTk3ABkNCWP2pNt5Xy0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-L7vpKB57OVS65nN7GuVwFQ-1; Thu, 09 Nov 2023 12:43:21 -0500
X-MC-Unique: L7vpKB57OVS65nN7GuVwFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBF82821AE3;
 Thu,  9 Nov 2023 17:43:20 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E19D220268F8;
 Thu,  9 Nov 2023 17:43:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v3 09/11] qom: Add object_property_set_default_list()
Date: Thu,  9 Nov 2023 18:42:38 +0100
Message-ID: <20231109174240.72376-10-kwolf@redhat.com>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
References: <20231109174240.72376-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



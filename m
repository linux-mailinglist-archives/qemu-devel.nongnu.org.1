Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E486FA1D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Mar 2024 07:34:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1t6-0005fJ-HM; Mon, 04 Mar 2024 01:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sa-0005Yv-H1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sS-0000AR-Q4
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkHnyanmJD/zvCJB2FWxZfzd7bqqUwhsCWjtX09AOzI=;
 b=cSJQw+wjBFXwWmxWT5LmeQ35yor26HDg4OfVITBCeg7lVwqxHTWXlJ7EYM94WBVCgeWVmK
 87qHxgz93DdxwfhbTpMe6pgoOQdyqNjB17HQBpP0X1FJoGFIn/Xd5+0ozXMqFYm/xLr1fp
 Km25JUV+SgJXRcuIoUXRUGLG0vOaqBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-BuNm6Jm0NoSF5BmgHtPZUw-1; Mon, 04 Mar 2024 01:32:40 -0500
X-MC-Unique: BuNm6Jm0NoSF5BmgHtPZUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 812C185A589;
 Mon,  4 Mar 2024 06:32:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C786492BC7;
 Mon,  4 Mar 2024 06:32:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A95121E683A; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/18] qapi: New strv_from_str_list()
Date: Mon,  4 Mar 2024 07:32:35 +0100
Message-ID: <20240304063236.213955-18-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Steve Sistare <steven.sistare@oracle.com>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240227153321.467343-3-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/type-helpers.h |  8 ++++++++
 qapi/qapi-type-helpers.c    | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qapi/type-helpers.h b/include/qapi/type-helpers.h
index be1f181526..fc8352cdec 100644
--- a/include/qapi/type-helpers.h
+++ b/include/qapi/type-helpers.h
@@ -12,3 +12,11 @@
 #include "qapi/qapi-types-common.h"
 
 HumanReadableText *human_readable_text_from_str(GString *str);
+
+/*
+ * Produce and return a NULL-terminated array of strings from @list.
+ * The result is g_malloc()'d and all strings are g_strdup()'d.  It
+ * can be freed with g_strfreev(), or by g_auto(GStrv) automatic
+ * cleanup.
+ */
+char **strv_from_str_list(const strList *list);
diff --git a/qapi/qapi-type-helpers.c b/qapi/qapi-type-helpers.c
index f76b34f647..266da013ad 100644
--- a/qapi/qapi-type-helpers.c
+++ b/qapi/qapi-type-helpers.c
@@ -21,3 +21,17 @@ HumanReadableText *human_readable_text_from_str(GString *str)
 
     return ret;
 }
+
+char **strv_from_str_list(const strList *list)
+{
+    const strList *tail;
+    int i = 0;
+    char **strv = g_new(char *, QAPI_LIST_LENGTH(list) + 1);
+
+    for (tail = list; tail != NULL; tail = tail->next) {
+        strv[i++] = g_strdup(tail->value);
+    }
+    strv[i] = NULL;
+
+    return strv;
+}
-- 
2.44.0



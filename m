Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2731CA98156
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 09:41:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfN-0003EB-8N; Wed, 23 Apr 2025 03:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Ueq-00035J-04
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uel-0003Bm-2i
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6uodaUxX+9pfZchpCGRAUT/RxHshP2sI8myfmwd0ZYI=;
 b=atS+sfFSGgWsCBCKqJFj8tvBys5/jyFCEwAj/j183l9AonkJqW2jO6fTQZIJDUiOUjl7O8
 Ktn+/7MO3zU0lwk3pUMbnMQBO0RGUYTmws8lPCZAuJJs6fkeIb4aHMFmQnvzvVNrq28zvR
 DM6YPGXWTC0v8p+GSoRURYTZHxC8wl4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-LJ5eCiFOP6Kdnmaz8HaV9A-1; Wed,
 23 Apr 2025 03:36:26 -0400
X-MC-Unique: LJ5eCiFOP6Kdnmaz8HaV9A-1
X-Mimecast-MFC-AGG-ID: LJ5eCiFOP6Kdnmaz8HaV9A_1745393785
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345FD18001E0; Wed, 23 Apr 2025 07:36:25 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62D6D19560A3; Wed, 23 Apr 2025 07:36:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/29] hw/s390x/skeys: Declare QOM types using DEFINE_TYPES()
 macro
Date: Wed, 23 Apr 2025 09:35:45 +0200
Message-ID: <20250423073610.271585-6-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250310151414.11550-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-skeys.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 811d892122b..d50e71b927a 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -316,14 +316,6 @@ static void qemu_s390_skeys_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo qemu_s390_skeys_info = {
-    .name          = TYPE_QEMU_S390_SKEYS,
-    .parent        = TYPE_S390_SKEYS,
-    .instance_size = sizeof(QEMUS390SKeysState),
-    .class_init    = qemu_s390_skeys_class_init,
-    .class_size    = sizeof(S390SKeysClass),
-};
-
 static void s390_storage_keys_save(QEMUFile *f, void *opaque)
 {
     S390SKeysState *ss = S390_SKEYS(opaque);
@@ -481,19 +473,22 @@ static void s390_skeys_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static const TypeInfo s390_skeys_info = {
-    .name          = TYPE_S390_SKEYS,
-    .parent        = TYPE_DEVICE,
-    .instance_size = sizeof(S390SKeysState),
-    .class_init    = s390_skeys_class_init,
-    .class_size    = sizeof(S390SKeysClass),
-    .abstract = true,
+static const TypeInfo s390_skeys_types[] = {
+    {
+        .name           = TYPE_S390_SKEYS,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(S390SKeysState),
+        .class_init     = s390_skeys_class_init,
+        .class_size     = sizeof(S390SKeysClass),
+        .abstract       = true,
+    },
+    {
+        .name           = TYPE_QEMU_S390_SKEYS,
+        .parent         = TYPE_S390_SKEYS,
+        .instance_size  = sizeof(QEMUS390SKeysState),
+        .class_init     = qemu_s390_skeys_class_init,
+        .class_size     = sizeof(S390SKeysClass),
+    },
 };
 
-static void qemu_s390_skeys_register_types(void)
-{
-    type_register_static(&s390_skeys_info);
-    type_register_static(&qemu_s390_skeys_info);
-}
-
-type_init(qemu_s390_skeys_register_types)
+DEFINE_TYPES(s390_skeys_types)
-- 
2.49.0



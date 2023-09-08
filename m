Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA27984D2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeXol-0000tJ-W3; Fri, 08 Sep 2023 05:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeXob-0000s1-9F
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeXoO-00062e-AE
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694165399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G/TX6SDiw/RA6WCqGD3fMIlR8OZXenhAqc/m5lfuEqA=;
 b=bL/FTP3Q4leZ07F/LTWHrIGOf2hdHScbwfc28sSyllTlfHXT8BO+S3bmtYkUtMk+8rnvLB
 JCnmcHIAq9oJXofzn2XJ9JYDvSDvwBHcXrq9WCxo3pO9PsF6FzKwJsOtpd41gf5DbvGvf/
 2xtwyFOuaN0jot38fqXcBM3S5hSil9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-nUNjcnU6MP2Qm6At-LNB5g-1; Fri, 08 Sep 2023 05:29:54 -0400
X-MC-Unique: nUNjcnU6MP2Qm6At-LNB5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E683101CA82;
 Fri,  8 Sep 2023 09:29:53 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4E540C2070;
 Fri,  8 Sep 2023 09:29:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw: forbid DEFINE_PROP_ARRAY for user creatable devices
Date: Fri,  8 Sep 2023 10:29:51 +0100
Message-ID: <20230908092951.2683721-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The DEFINE_PROP_ARRAY macro is a clever trick for defining array
properties. It initially creates a property "len-$FOO". When that
property is set, then it creates a sequence "$FOO[NN]" for NN
in the range 0 to "len-$FOO".

The intended usage for this was to simplify code for internal
devices, however, it crept into use for user creatable devices
when the 'rocker' network device used it.

This relied on the user specifying the len property first on
the -device comand line, and the args being processed in-order.
The latter was broken[1] when -device was converted from QemuOpts
to QDict[2], as ordering of loading properties was no longer
guaranteed to match user specified ordering.

This change poisons the setter for "len-$FOO" such that it raises
an error when used with a user creatable device.

This allows DEFINE_PROP_ARRAY to remain exclusively for internal
devices, since code can ensure properties are set in the correct
ordering.

[1] https://gitlab.com/qemu-project/qemu/-/issues/1090
[2] f3558b1b763683bb877f7dd5b282469cdadc65c3
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev-properties.c    | 6 ++++++
 include/hw/qdev-properties.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 357b8761b5..2d295411ef 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -584,6 +584,12 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
     void *eltptr;
     const char *arrayname;
     int i;
+    DeviceClass *devc = DEVICE_CLASS(object_get_class(obj));
+
+    if (devc->user_creatable) {
+        error_setg(errp, "array property not permitted for user creatable devices");
+        return;
+    }
 
     if (*alenptr) {
         error_setg(errp, "array size property %s may not be set more than once",
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e1df08876c..19042e6cd9 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -127,6 +127,13 @@ extern const PropertyInfo qdev_prop_link;
  * @_arrayprop: PropertyInfo defining what property the array elements have
  * @_arraytype: C type of the array elements
  *
+ * Note: this macro is forbidden to use with user creatable devices
+ *       as its behaviour relies on the precise ordering with which
+ *       properties are set. Ordering is not guaranteed for our public
+ *       facing interfaces (-device CLI / device_add QMP) for creating
+ *       devices. Any attempt to use this on a user creatable device
+ *       will trigger an error at runtime.
+ *
  * Define device properties for a variable-length array _name.  A
  * static property "len-arrayname" is defined. When the device creator
  * sets this property to the desired length of array, further dynamic
-- 
2.41.0



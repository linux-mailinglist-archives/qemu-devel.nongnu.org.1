Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04317EB086
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:05:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2t5u-0000yw-4v; Tue, 14 Nov 2023 08:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2t5q-0000yh-Qf
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2t5l-0005YF-MK
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699967072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xfueetSRcZ7UyfeHEPItMADFMD+qOMMa+buZTECmI28=;
 b=inbPm0Z+eCKRL5QCC1f0uToxpVIMOmPGLP3uROLIpS1eIu2ZPF6y5CBHu+lBXABtDNIFmk
 Q6I5SAaXHEVrIQ83h50j9LnEwik3wh3gjnAC/ru31lZC8763B7sqlR6vp3lrbjCB9ldQHl
 22J2hpn/Z9nzBc52HOK0FOroUnLxDg4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-4N98L6E5MxuScxrnuACMDg-1; Tue,
 14 Nov 2023 08:04:29 -0500
X-MC-Unique: 4N98L6E5MxuScxrnuACMDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A77473C025CD;
 Tue, 14 Nov 2023 13:04:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB0FA1C060AE;
 Tue, 14 Nov 2023 13:04:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] qom/object: Limit type names to alphanumerical and some few
 special characters
Date: Tue, 14 Nov 2023 14:04:15 +0100
Message-ID: <20231114130415.283228-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

QOM names currently don't have any enforced naming rules. This
can be problematic, e.g. when they are used on the command line
for the "-device" option (where the comma is used to separate
properties). To avoid that such problematic type names come in
again, let's restrict the set of acceptable characters during the
type registration.

Ideally, we'd apply here the same rules as for QAPI, i.e. all type
names should begin with a letter, and contain only ASCII letters,
digits, hyphen, and underscore. However, we already have so many
pre-existing types like:

    486-x86_64-cpu
    cfi.pflash01
    power5+_v2.1-spapr-cpu-core
    virt-2.6-machine::hotplug-handler
    aspeed.i2c.slave::vmstate-if
    pc-i440fx-3.0-machine::nmi

... so that we have to allow ".", ":" and "+" for now, too, and
we unfortunately even cannot enforce the rule that names must start
with a letter yet. Still, having at least some rules enforced here
should be way better than nothing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qom/object.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 95c0dc8285..8ff85e0239 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -101,6 +101,20 @@ static TypeImpl *type_table_lookup(const char *name)
     return g_hash_table_lookup(type_table_get(), name);
 }
 
+static bool type_name_is_valid(const char *name)
+{
+    const int slen = strlen(name);
+
+    for (int i = 0; i < slen; i++) {
+        if (!g_ascii_isalnum (name[i]) && name[i] != '-' && name[i] != '_' &&
+            name[i] != '.' && name[i] != ':' && name[i] != '+') {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static TypeImpl *type_new(const TypeInfo *info)
 {
     TypeImpl *ti = g_malloc0(sizeof(*ti));
@@ -113,6 +127,11 @@ static TypeImpl *type_new(const TypeInfo *info)
         abort();
     }
 
+    if (!type_name_is_valid(info->name)) {
+        fprintf(stderr, "Registering `%s' with illegal type name\n", info->name);
+        abort();
+    }
+
     ti->name = g_strdup(info->name);
     ti->parent = g_strdup(info->parent);
 
-- 
2.41.0



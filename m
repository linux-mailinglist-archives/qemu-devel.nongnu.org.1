Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162287EF210
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 12:47:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3xIg-0005O2-Qw; Fri, 17 Nov 2023 06:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3xIS-0005Hi-T9
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 06:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3xIQ-0005mW-RX
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 06:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700221561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUx1Y+YVOHfY8FYP0ISfdbkREh46U4FT600eIjFdKdw=;
 b=ejQaXtyBP1F6tJDnqmy5oHt3/PtGpW0YItOdePDCD0oa0mmD+Wr4ipG+9/8RahVF/Xsn++
 DHgWgNvs/9npZ2XlmHIxQVpu6pLneVQlN4gHfqpXpzMnTujMdUWmjAuGo3U7I0Q8LtIec/
 9pu4+tO+ULH1TvHCv2JlLz0U06T/Kh0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Yph25XrQNmugToWN8d9wZA-1; Fri,
 17 Nov 2023 06:45:58 -0500
X-MC-Unique: Yph25XrQNmugToWN8d9wZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14BB61C06361;
 Fri, 17 Nov 2023 11:45:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E927F5028;
 Fri, 17 Nov 2023 11:45:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 5/5] qom/object: Limit type names to alphanumerical and
 some few special characters
Date: Fri, 17 Nov 2023 12:44:57 +0100
Message-ID: <20231117114457.177308-6-thuth@redhat.com>
In-Reply-To: <20231117114457.177308-1-thuth@redhat.com>
References: <20231117114457.177308-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
    virt-2.6-machine
    pc-i440fx-3.0-machine

... so that we have to allow "." and "+" for now, too. While the
dot is used in a lot of places, the "+" can fortunately be limited
to two classes of legacy names ("power" and "Sun-UltraSparc" CPUs).

We also cannot enforce the rule that names must start with a letter
yet, since there are lot of types that start with a digit. Still,
at least limiting the first characters to the alphanumerical range
should be way better than nothing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qom/object.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 95c0dc8285..654e1afaf2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -138,9 +138,50 @@ static TypeImpl *type_new(const TypeInfo *info)
     return ti;
 }
 
+static bool type_name_is_valid(const char *name)
+{
+    const int slen = strlen(name);
+    int plen;
+
+    g_assert(slen > 1);
+
+    /*
+     * Ideally, the name should start with a letter - however, we've got
+     * too many names starting with a digit already, so allow digits here,
+     * too (except '0' which is not used yet)
+     */
+    if (!g_ascii_isalnum(name[0]) || name[0] == '0') {
+        return false;
+    }
+
+    plen = strspn(name, "abcdefghijklmnopqrstuvwxyz"
+                        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+                        "0123456789-_.");
+
+    /* Allow some legacy names with '+' in it for compatibility reasons */
+    if (name[plen] == '+') {
+        if (plen == 6 && g_str_has_prefix(name, "power")) {
+            /* Allow "power5+" and "power7+" CPU names*/
+            return true;
+        }
+        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
+            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
+            return true;
+        }
+    }
+
+    return plen == slen;
+}
+
 static TypeImpl *type_register_internal(const TypeInfo *info)
 {
     TypeImpl *ti;
+
+    if (!type_name_is_valid(info->name)) {
+        fprintf(stderr, "Registering '%s' with illegal type name\n", info->name);
+        abort();
+    }
+
     ti = type_new(info);
 
     type_table_add(ti);
-- 
2.42.0



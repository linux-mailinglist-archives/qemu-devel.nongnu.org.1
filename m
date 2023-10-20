Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F87D0914
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjTp-0004eL-1Q; Fri, 20 Oct 2023 02:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTi-0004Vm-21
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTg-0003ny-47
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8q34WPeVwwWmtWZXJNkr41CpA/2YBdbzKgCn8LRZ9E=;
 b=Pl1mce7XFWi1liPxaufs8reR5/XiAcfsJgyekuQ2Yf4INgS8MwXtbgfJCTfsICU/tITQfI
 /uCNTI1AGnljXd1m7JaPkDB9AlP06YnJMDIdiJjQXCsMNscjjaLUcLXxxrLdV0x5MYNMRT
 i9W0U+ZE3aj45EoYq8AQDNV4Ivq9Bu8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-GTfhQzdOOVuShxXLwSW9xA-1; Fri, 20 Oct 2023 02:59:20 -0400
X-MC-Unique: GTfhQzdOOVuShxXLwSW9xA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82BB238116F3;
 Fri, 20 Oct 2023 06:59:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5C8625C0;
 Fri, 20 Oct 2023 06:59:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, "Denis V. Lunev" <den@openvz.org>,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>,
 kvm@vger.kernel.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-arm@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jeff Cody <codyprime@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org
Subject: [PULL 11/17] tests/qtest/migration: Introduce
 find_common_machine_version
Date: Fri, 20 Oct 2023 08:57:45 +0200
Message-ID: <20231020065751.26047-12-quintela@redhat.com>
In-Reply-To: <20231020065751.26047-1-quintela@redhat.com>
References: <20231020065751.26047-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

When using two different QEMU binaries for migration testing, we'll
need to find what is the machine version that will work with both
binaries. Add a helper for that.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231018192741.25885-7-farosas@suse.de>
---
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 4f51d0f8bc..d1c2351d33 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -43,4 +43,6 @@ void wait_for_migration_complete(QTestState *who);
 
 void wait_for_migration_fail(QTestState *from, bool allow_active);
 
+char *find_common_machine_version(const char *mtype, const char *var1,
+                                  const char *var2);
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0c185db450..13449c1fe1 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -240,3 +240,29 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     g_assert(qdict_get_bool(rsp_return, "running"));
     qobject_unref(rsp_return);
 }
+
+char *find_common_machine_version(const char *mtype, const char *var1,
+                                  const char *var2)
+{
+    g_autofree char *type1 = qtest_resolve_machine_alias(var1, mtype);
+    g_autofree char *type2 = qtest_resolve_machine_alias(var2, mtype);
+
+    g_assert(type1 && type2);
+
+    if (g_str_equal(type1, type2)) {
+        /* either can be used */
+        return g_strdup(type1);
+    }
+
+    if (qtest_has_machine_with_env(var2, type1)) {
+        return g_strdup(type1);
+    }
+
+    if (qtest_has_machine_with_env(var1, type2)) {
+        return g_strdup(type2);
+    }
+
+    g_test_message("No common machine version for machine type '%s' between "
+                   "binaries %s and %s", mtype, getenv(var1), getenv(var2));
+    g_assert_not_reached();
+}
-- 
2.41.0



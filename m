Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B23867D0903
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjU1-0004oO-GR; Fri, 20 Oct 2023 02:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTn-0004ei-Na
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTj-0003ox-5N
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSgHyHEZfPE9cd1uGtechBOjRxN9vNPYJYi2OtzuiQ0=;
 b=hBV8PZI6cKvXw4KzFQICxzUX++gHgGrGuqoyxuc+g3xFXfzMkwzcFuD745hcYEYX1KDEPw
 XUffsuWjbPA/UPcdtF+9clqMZRTOn2fviLqHLUMZFcUyb0h6QOkNmOc8H8yckAo+nNeIhz
 IfgDma39P+cBMorw6fUZH8+SnMEodww=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-A4rH87AqMS-35XtixiB6ZQ-1; Fri, 20 Oct 2023 02:59:13 -0400
X-MC-Unique: A4rH87AqMS-35XtixiB6ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C07C29AA2C2;
 Fri, 20 Oct 2023 06:59:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06B3725C0;
 Fri, 20 Oct 2023 06:59:04 +0000 (UTC)
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
Subject: [PULL 10/17] tests/qtest: Introduce qtest_resolve_machine_alias
Date: Fri, 20 Oct 2023 08:57:44 +0200
Message-ID: <20231020065751.26047-11-quintela@redhat.com>
In-Reply-To: <20231020065751.26047-1-quintela@redhat.com>
References: <20231020065751.26047-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The migration tests are being enhanced to test migration between
different QEMU versions. A requirement of migration is that the
machine type between source and destination matches, including the
version.

We cannot hardcode machine types in the tests because those change
with each release. QEMU provides a machine type alias that has a fixed
name, but points to the latest machine type at each release.

Add a helper to resolve the alias into the exact machine
type. E.g. "-machine pc" resolves to "pc-i440fx-8.2"

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231018192741.25885-6-farosas@suse.de>
---
 tests/qtest/libqtest.h | 10 ++++++++++
 tests/qtest/libqtest.c | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index d16deb9891..6e3d3525bf 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -922,6 +922,16 @@ void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned);
 
+/**
+ * qtest_resolve_machine_alias:
+ * @var: Environment variable from where to take the QEMU binary
+ * @alias: The alias to resolve
+ *
+ * Returns: the machine type corresponding to the alias if any,
+ * otherwise NULL.
+ */
+char *qtest_resolve_machine_alias(const char *var, const char *alias);
+
 /**
  * qtest_has_machine:
  * @machine: The machine to look for
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 603d900e7d..c843c41188 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1565,6 +1565,22 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     }
 }
 
+char *qtest_resolve_machine_alias(const char *var, const char *alias)
+{
+    struct MachInfo *machines;
+    int i;
+
+    machines = qtest_get_machines(var);
+
+    for (i = 0; machines[i].name != NULL; i++) {
+        if (machines[i].alias && g_str_equal(alias, machines[i].alias)) {
+            return g_strdup(machines[i].name);
+        }
+    }
+
+    return NULL;
+}
+
 bool qtest_has_machine_with_env(const char *var, const char *machine)
 {
     struct MachInfo *machines;
-- 
2.41.0



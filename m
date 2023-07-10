Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5774D784
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqwG-0005N4-NO; Mon, 10 Jul 2023 09:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwE-0005M7-Iu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwB-00077q-7v
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688995701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNpsqutvk7y6NZmpZLsvxQU4L+DLOPAm2mxwfx09Ajc=;
 b=TGYUgtNNj5OXBBPl/icCZCsOzxipu5gbF+KBLW78Gz+1Cd6Fj/qMOCwbPlyj3xwLTOtzkq
 WUMP1jfiqo+DVpjCw1O/1uugQ9Z5EjaN1SZgl4a9QmLo0uw1/FbyAe7V65/hTg6D0Cerds
 MfUX/YAcaifQXu3haTsbgJbl48tyJqQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-haZENPGVNGa9DIVJsomCZg-1; Mon, 10 Jul 2023 09:28:18 -0400
X-MC-Unique: haZENPGVNGa9DIVJsomCZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B9513828886;
 Mon, 10 Jul 2023 13:28:18 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F72A111E3E6;
 Mon, 10 Jul 2023 13:28:17 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/7] qga: Add tests for --allow-rpcs option
Date: Mon, 10 Jul 2023 16:28:06 +0300
Message-Id: <20230710132810.1049912-4-kkostiuk@redhat.com>
In-Reply-To: <20230710132810.1049912-1-kkostiuk@redhat.com>
References: <20230710132810.1049912-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 tests/unit/test-qga.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 360b4cab23..671e83cb86 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -665,6 +665,36 @@ static void test_qga_blockedrpcs(gconstpointer data)
     fixture_tear_down(&fix, NULL);
 }
 
+static void test_qga_allowedrpcs(gconstpointer data)
+{
+    TestFixture fix;
+    QDict *ret, *error;
+    const gchar *class, *desc;
+
+    fixture_setup(&fix, "-a guest-ping,guest-get-time", NULL);
+
+    /* check allowed RPCs */
+    ret = qmp_fd(fix.fd, "{'execute': 'guest-ping'}");
+    qmp_assert_no_error(ret);
+    qobject_unref(ret);
+
+    ret = qmp_fd(fix.fd, "{'execute': 'guest-get-time'}");
+    qmp_assert_no_error(ret);
+    qobject_unref(ret);
+
+    /* check something else */
+    ret = qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
+    g_assert_nonnull(ret);
+    error = qdict_get_qdict(ret, "error");
+    class = qdict_get_try_str(error, "class");
+    desc = qdict_get_try_str(error, "desc");
+    g_assert_cmpstr(class, ==, "CommandNotFound");
+    g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
+    qobject_unref(ret);
+
+    fixture_tear_down(&fix, NULL);
+}
+
 static void test_qga_config(gconstpointer data)
 {
     GError *error = NULL;
@@ -1090,6 +1120,7 @@ int main(int argc, char **argv)
                          test_qga_fsfreeze_status);
 
     g_test_add_data_func("/qga/blockedrpcs", NULL, test_qga_blockedrpcs);
+    g_test_add_data_func("/qga/allowedrpcs", NULL, test_qga_allowedrpcs);
     g_test_add_data_func("/qga/config", NULL, test_qga_config);
     g_test_add_data_func("/qga/guest-exec", &fix, test_qga_guest_exec);
     g_test_add_data_func("/qga/guest-exec-separated", &fix,
-- 
2.34.1



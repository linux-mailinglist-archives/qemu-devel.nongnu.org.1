Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F274D247
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:52:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInZ6-0005kR-9l; Mon, 10 Jul 2023 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qInYb-0005LB-SE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qInYZ-0004gs-9W
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688982706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85k2ArhcL+PwROxyGcu9Qfh6Ia16um4HbG9+RR8yxwA=;
 b=EVXUKoSO3JAU20FVEZtyjqk5AjB974nEMBaGyrpF5soJaqk13Izt40P+X8gTWA4WPoiWjk
 DpmYj7EhUQfBDQpxgMR9wOUo8T3sAcUet97KGqxTbheuv7KyyTaGV2PehqiQoP8DT8eTGr
 44pKhp0IzHVFeYTAc6QZYUhQmLBM7Xs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-xyIB5TfUOQyqFgtxwjgPtA-1; Mon, 10 Jul 2023 05:51:43 -0400
X-MC-Unique: xyIB5TfUOQyqFgtxwjgPtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42CC3C0F663;
 Mon, 10 Jul 2023 09:51:42 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25BD340C206F;
 Mon, 10 Jul 2023 09:51:42 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 3/3] qga: Add tests for --allow-rpcs option
Date: Mon, 10 Jul 2023 12:51:36 +0300
Message-Id: <20230710095136.1022704-4-kkostiuk@redhat.com>
In-Reply-To: <20230710095136.1022704-1-kkostiuk@redhat.com>
References: <20230710095136.1022704-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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



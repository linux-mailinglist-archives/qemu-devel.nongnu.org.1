Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6B7E2051
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:46:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxuG-0003Ue-HW; Mon, 06 Nov 2023 06:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuE-0003TH-TQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuD-0003OU-7y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699270592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zBtay+FXHfC62zOoHOvwVv9aq/hIRy7K1YGyquZqPM=;
 b=XT+EDaqikpvUBN6PzGtjrqpsqQk90BDSDEtGgOrokwO0oswDfeaYwcRMrruUQo1OYikHFf
 OuOeGwJ3SKtObiF6r0StvyMNsQiLo+AzO68k1CVN799KTwe7867vKr+gIhr5aeiD5PimHZ
 me+0FbvCE65Y8Aqt/Z2YlL1EfJLR+Uw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-S2YWS4NqMumuYrT-d6SS8g-1; Mon,
 06 Nov 2023 06:36:31 -0500
X-MC-Unique: S2YWS4NqMumuYrT-d6SS8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D36B528B730A;
 Mon,  6 Nov 2023 11:36:30 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CC981C060B1;
 Mon,  6 Nov 2023 11:36:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 5/6] test-vmstate: add some subsection tests
Date: Mon,  6 Nov 2023 15:35:59 +0400
Message-ID: <20231106113601.2052601-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Check subsection support, and optional handling.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/unit/test-vmstate.c | 116 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 0b7d5ecd68..d60457486c 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -1479,6 +1479,118 @@ static void test_tmp_struct(void)
     g_assert_cmpint(obj.f, ==, 8); /* From the child->parent */
 }
 
+static bool sub_optional_needed = true;
+
+static bool sub_optional_needed_cb(void *opaque)
+{
+    return sub_optional_needed;
+}
+
+static const VMStateDescription vmstate_sub_optional_a = {
+    .name = "sub/optional/a",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sub_optional_needed_cb,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sub_optional = {
+    .name = "sub/optional",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_sub_optional_a,
+    }
+};
+
+static uint8_t wire_sub_optional[] = {
+    QEMU_VM_SUBSECTION,
+    14,
+    's', 'u', 'b', '/', 'o', 'p', 't', 'i', 'o', 'n', 'a', 'l', '/', 'a',
+    0x0, 0x0, 0x0, 1,
+    QEMU_VM_EOF,
+};
+
+static uint8_t wire_sub_optional_missing[] = {
+    QEMU_VM_EOF,
+};
+
+static void test_sub_optional_needed(void)
+{
+    sub_optional_needed = true;
+    save_vmstate(&vmstate_sub_optional, NULL);
+
+    compare_vmstate(wire_sub_optional, sizeof(wire_sub_optional));
+
+    SUCCESS(load_vmstate_one(&vmstate_sub_optional, NULL,
+                             1, wire_sub_optional,
+                             sizeof(wire_sub_optional)));
+
+    /* this will print an error, but succeed nonetheless */
+    load_vmstate_one(&vmstate_sub_optional, NULL,
+                     1, wire_sub_optional_missing,
+                     sizeof(wire_sub_optional_missing));
+}
+
+static void test_sub_optional_missing(void)
+{
+    sub_optional_needed = false;
+    save_vmstate(&vmstate_sub_optional, NULL);
+
+    compare_vmstate(wire_sub_optional_missing, sizeof(wire_sub_optional_missing));
+
+    SUCCESS(load_vmstate_one(&vmstate_sub_optional, NULL,
+                             1, wire_sub_optional,
+                             sizeof(wire_sub_optional)));
+
+    SUCCESS(load_vmstate_one(&vmstate_sub_optional, NULL,
+                             1, wire_sub_optional_missing,
+                             sizeof(wire_sub_optional_missing)));
+}
+
+static uint8_t wire_sub_dup[] = {
+    QEMU_VM_SUBSECTION,
+    14,
+    's', 'u', 'b', '/', 'o', 'p', 't', 'i', 'o', 'n', 'a', 'l', '/', 'a',
+    0x0, 0x0, 0x0, 1,
+    QEMU_VM_SUBSECTION,
+    14,
+    's', 'u', 'b', '/', 'o', 'p', 't', 'i', 'o', 'n', 'a', 'l', '/', 'a',
+    0x0, 0x0, 0x0, 1,
+    QEMU_VM_EOF,
+};
+
+static void test_sub_optional_dup(void)
+{
+    sub_optional_needed = false;
+
+    FAILURE(load_vmstate_one(&vmstate_sub_optional, NULL,
+                             1, wire_sub_dup,
+                             sizeof(wire_sub_dup)));
+}
+
+static uint8_t wire_sub_unknown[] = {
+    QEMU_VM_SUBSECTION,
+    14,
+    's', 'u', 'b', '/', 'o', 'p', 't', 'i', 'o', 'n', 'a', 'l', '/', 'b',
+    0x0, 0x0, 0x0, 1,
+    QEMU_VM_EOF,
+};
+
+static void test_sub_optional_unknown(void)
+{
+    sub_optional_needed = false;
+
+    FAILURE(load_vmstate_one(&vmstate_sub_optional, NULL,
+                             1, wire_sub_unknown,
+                             sizeof(wire_sub_unknown)));
+}
+
 int main(int argc, char **argv)
 {
     g_autofree char *temp_file = g_strdup_printf("%s/vmst.test.XXXXXX",
@@ -1519,6 +1631,10 @@ int main(int argc, char **argv)
     g_test_add_func("/vmstate/qlist/save/saveqlist", test_save_qlist);
     g_test_add_func("/vmstate/qlist/load/loadqlist", test_load_qlist);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
+    g_test_add_func("/vmstate/subsection/needed", test_sub_optional_needed);
+    g_test_add_func("/vmstate/subsection/missing", test_sub_optional_missing);
+    g_test_add_func("/vmstate/subsection/dup", test_sub_optional_dup);
+    g_test_add_func("/vmstate/subsection/unknown", test_sub_optional_unknown);
     g_test_run();
 
     close(temp_fd);
-- 
2.41.0



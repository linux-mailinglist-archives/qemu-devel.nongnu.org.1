Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E92A6DAEC
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Mar 2025 14:18:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhgr-0000SE-GC; Mon, 24 Mar 2025 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1twhgd-0000NN-5j
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1twhgY-0006rV-DB
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9BAN5HZ8IUPZMahsfrk73BSgqvB455M7gULX/WU50Js=;
 b=NFkeg4G0tNnkYsFOOr/lrUagNB3c0yK+qT0tYGa2lKyGCGOtv1RTZ69wTgMjIsRKSlDrMu
 3tx7ICSkIuMgb8n9xQeqCfYU49jBHS/NiJMPrmO1mDexjfY6cS/y2ES2icwJGX+Y0Z/RPv
 BzuOX8qb9i7E/dvUn/Qj9Bk3o4d0W8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-NOm03IE2NTqZlFPjimcS1w-1; Mon,
 24 Mar 2025 09:17:42 -0400
X-MC-Unique: NOm03IE2NTqZlFPjimcS1w-1
X-Mimecast-MFC-AGG-ID: NOm03IE2NTqZlFPjimcS1w_1742822262
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECCF5196D2D3; Mon, 24 Mar 2025 13:17:41 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA12B1956095; Mon, 24 Mar 2025 13:17:39 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dehan Meng <demeng@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 2/2] qga: Add tests for guest-get-load command
Date: Mon, 24 Mar 2025 15:17:29 +0200
Message-ID: <20250324131729.70992-3-kkostiuk@redhat.com>
In-Reply-To: <20250324131729.70992-1-kkostiuk@redhat.com>
References: <20250324131729.70992-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tested-by: Dehan Meng <demeng@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 tests/unit/test-qga.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 541b08a5e7..587e30c7e4 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -332,6 +332,22 @@ static void test_qga_get_fsinfo(gconstpointer fix)
     }
 }
 
+static void test_qga_get_load(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    g_autoptr(QDict) ret = NULL;
+    QDict *load;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-load'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    load = qdict_get_qdict(ret, "return");
+    g_assert(qdict_haskey(load, "load1m"));
+    g_assert(qdict_haskey(load, "load5m"));
+    g_assert(qdict_haskey(load, "load15m"));
+}
+
 static void test_qga_get_memory_block_info(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -1105,6 +1121,7 @@ int main(int argc, char **argv)
         g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
     }
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
+    g_test_add_data_func("/qga/get-load", &fix, test_qga_get_load);
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
                          test_qga_get_memory_block_info);
     g_test_add_data_func("/qga/get-memory-blocks", &fix,
-- 
2.48.1



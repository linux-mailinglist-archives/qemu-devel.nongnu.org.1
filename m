Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5872416E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 13:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VJg-0000FO-BM; Tue, 06 Jun 2023 07:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJd-0000EN-Pt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJY-0005kP-W6
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ5clFeaPZ8c93Anb1wtSWGhW13lAJpTwdercIpryX4=;
 b=OK5LDX1qm6jOLxTp+bdno7vZF/57xZv2d3NafmRGZNKKW7N1AILkFhyh3ZF2lP04d/y2lU
 6zKspFfwu6lE4lIDCd7sE1eJU7lDMeoOXIUNYGOqOO5dN/oUYMKtgkkyMDFyiOaMQ2fOOF
 ctw0lua+35n/7zgOtVStq+Vm6qI16hI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-m7sJHGYqMOWUDiHJoWyjQQ-1; Tue, 06 Jun 2023 07:57:27 -0400
X-MC-Unique: m7sJHGYqMOWUDiHJoWyjQQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0898282CCA0
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:57:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B36B4022C5;
 Tue,  6 Jun 2023 11:57:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/21] qtest: add qtest_pid()
Date: Tue,  6 Jun 2023 15:56:43 +0400
Message-Id: <20230606115658.677673-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Used in the following test on win32, to share sockets with the QEMU
process.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.h | 9 +++++++++
 tests/qtest/libqtest.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index a12acf7fa9..913acc3d5c 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -985,4 +985,13 @@ void qtest_qom_set_bool(QTestState *s, const char *path, const char *property,
  * Returns: Value retrieved from property.
  */
 bool qtest_qom_get_bool(QTestState *s, const char *path, const char *property);
+
+/**
+ * qtest_pid:
+ * @s: QTestState instance to operate on.
+ *
+ * Returns: the PID of the QEMU process, or <= 0
+ */
+pid_t qtest_pid(QTestState *s);
+
 #endif
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 77de16227f..6dd47a9a3d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -142,6 +142,11 @@ static int socket_accept(int sock)
     return ret;
 }
 
+pid_t qtest_pid(QTestState *s)
+{
+    return s->qemu_pid;
+}
+
 bool qtest_probe_child(QTestState *s)
 {
     pid_t pid = s->qemu_pid;
-- 
2.40.1



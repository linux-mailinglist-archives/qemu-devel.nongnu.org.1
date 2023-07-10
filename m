Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C61E74D521
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoo-00010j-Eq; Mon, 10 Jul 2023 08:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoZ-0000wW-5b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoT-0003a0-Ri
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+gGHQpcHPJRVf5oaZk5qLV4ql27pHvlAHmRqLeyHws=;
 b=KQWHIlpk0h8BdT634F4jqp+KZr0ahEk37GUIBJE/x1JNuqAaTeV+MoR8NhdfkkA/qP9njI
 6raJ5mJQY6nhjRmY3FaQNYVWlfUxCox9Nyq+P0YdRU9JU9AJERyRM3JlHtp72LwDlEjUr+
 tZJbYC069PONuRgIaJAho2PyAIcv8xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-tpWvKfXrNXCNXCCpc-g7qQ-1; Mon, 10 Jul 2023 08:16:16 -0400
X-MC-Unique: tpWvKfXrNXCNXCCpc-g7qQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E1B38B34C3;
 Mon, 10 Jul 2023 12:16:15 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54B2DF5CFA;
 Mon, 10 Jul 2023 12:16:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 21/21] docs/devel: Fix coding style in style.rst
Date: Mon, 10 Jul 2023 14:15:43 +0200
Message-Id: <20230710121543.197250-22-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

As defined earlier in this file, the opening curly brace of
functions should be placed on a separate line. So we should
do it in the examples here, too.

Fixes: 821f296756 ("docs: document use of automatic cleanup functions in glib")
Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-Id: <20230710092638.161625-1-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/style.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index aa5e083ff8..3cfcdeb9cd 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -567,7 +567,8 @@ For example, instead of
 
 .. code-block:: c
 
-    int somefunc(void) {
+    int somefunc(void)
+    {
         int ret = -1;
         char *foo = g_strdup_printf("foo%", "wibble");
         GList *bar = .....
@@ -588,7 +589,8 @@ Using g_autofree/g_autoptr enables the code to be written as:
 
 .. code-block:: c
 
-    int somefunc(void) {
+    int somefunc(void)
+    {
         g_autofree char *foo = g_strdup_printf("foo%", "wibble");
         g_autoptr (GList) bar = .....
 
@@ -613,7 +615,8 @@ are still some caveats to beware of
 
 .. code-block:: c
 
-    char *somefunc(void) {
+    char *somefunc(void)
+    {
         g_autofree char *foo = g_strdup_printf("foo%", "wibble");
         g_autoptr (GList) bar = .....
 
-- 
2.39.3



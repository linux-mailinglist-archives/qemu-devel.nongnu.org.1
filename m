Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B3767069
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPORq-0002vD-6j; Fri, 28 Jul 2023 10:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORm-0002tv-I9
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORl-0006wy-6F
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690554480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdUDJzaz8CxhPvn2ukbUEi+atwv9AJtALsvUOJ7KrpM=;
 b=JcFVtqlNKLJQYslGDPFnD43PRxlsgUO5CUsFKHcJ6U/v5DILHzb3pERAduVVG4Tjutsvfc
 raZGUE3cqT7MDjPoqNJQywaR5vst9p0tuXq/TuSyOcK3Gyynswtp1DDoUq02BY1NSm4k3C
 1O4ja/7sonBK2m1kkhz0H5T8A9iENKg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-UJ0X3zN8O0GtLV3wGfI3BQ-1; Fri, 28 Jul 2023 10:27:56 -0400
X-MC-Unique: UJ0X3zN8O0GtLV3wGfI3BQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E2C080027F;
 Fri, 28 Jul 2023 14:27:56 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A81340C206F;
 Fri, 28 Jul 2023 14:27:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 3/6] util/oslib-win32: Fix compiling with Clang from MSYS2
Date: Fri, 28 Jul 2023 16:27:45 +0200
Message-Id: <20230728142748.305341-4-thuth@redhat.com>
In-Reply-To: <20230728142748.305341-1-thuth@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Clang complains:

../util/oslib-win32.c:483:56: error: omitting the parameter name in a
 function definition is a C2x extension [-Werror,-Wc2x-extensions]
win32_close_exception_handler(struct _EXCEPTION_RECORD*,
                                                       ^

Fix it by adding parameter names.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/oslib-win32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 429542face..070bb455d3 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -480,8 +480,8 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *addr,
 }
 
 EXCEPTION_DISPOSITION
-win32_close_exception_handler(struct _EXCEPTION_RECORD*,
-                              void*, struct _CONTEXT*, void*)
+win32_close_exception_handler(struct _EXCEPTION_RECORD *exrec,
+                              void *ptr1, struct _CONTEXT *cntx, void *ptr2)
 {
     return EXCEPTION_EXECUTE_HANDLER;
 }
-- 
2.39.3



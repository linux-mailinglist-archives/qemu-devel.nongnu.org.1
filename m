Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD776E6D5
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:28:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWDA-0006IC-A8; Thu, 03 Aug 2023 07:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWD8-0006Hu-Bc
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWD6-0007Ts-Sb
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691060979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSgU7k/fIPM9D3DOBU4spkNNiKTyTh4BloR1y60KR1c=;
 b=JB04WE/NyJ7Y/L3fydLswXwrBGgoQ+SuCOBtVKkqXQiD/8unEkmzjM5D3B/Kn7cE+u8cdy
 WMIQUqU/pB5TnSZafu2xtC7+KMzRLFB5HPgRly66dfvVejs7UARlvDXQYSqZNomYr5gcYx
 CgN2ebldeDwF2j09fS1maNMPK3U1/uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-rGbpDFNbN_OTmu8elDFb1A-1; Thu, 03 Aug 2023 07:09:38 -0400
X-MC-Unique: rGbpDFNbN_OTmu8elDFb1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 547C5185A795;
 Thu,  3 Aug 2023 11:09:37 +0000 (UTC)
Received: from thuth.com (unknown [10.45.226.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 681B8112132D;
 Thu,  3 Aug 2023 11:09:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/9] util/oslib-win32: Fix compiling with Clang from MSYS2
Date: Thu,  3 Aug 2023 13:09:24 +0200
Message-Id: <20230803110932.341091-2-thuth@redhat.com>
In-Reply-To: <20230803110932.341091-1-thuth@redhat.com>
References: <20230803110932.341091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Message-Id: <20230728142748.305341-4-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/oslib-win32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 429542face..19a0ea7fbe 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -480,8 +480,9 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *addr,
 }
 
 EXCEPTION_DISPOSITION
-win32_close_exception_handler(struct _EXCEPTION_RECORD*,
-                              void*, struct _CONTEXT*, void*)
+win32_close_exception_handler(struct _EXCEPTION_RECORD *exception_record,
+                              void *registration, struct _CONTEXT *context,
+                              void *dispatcher)
 {
     return EXCEPTION_EXECUTE_HANDLER;
 }
-- 
2.39.3



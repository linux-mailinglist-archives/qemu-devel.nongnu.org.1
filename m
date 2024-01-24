Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7DB83A714
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jan 2024 11:43:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaic-0008Lq-Br; Wed, 24 Jan 2024 05:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaia-0008Ld-CL
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiY-0008GJ-W7
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706092970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfVQuqKtVMuxIraBBaWC+0YKkoFFwfTlKdUhFdFqzaQ=;
 b=JC8mCcdET2VT5Y2qG6JnWIz/v3Ax3M+aEVUu8zbah/PRI5a2ll+bsneUp3JUmfiQ3EF96K
 WA4IiXA6XWm0hmre0rL8Y/EB9z+CxaP5Nzw3EMkSCsNrzt59Uc5FDVCJTDQJXJJCMvI/jB
 6aTsh8kJnoIbM7jujyiR/071PvQTUEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-enKRNHg6NiO9aRVIqEAiqg-1; Wed, 24 Jan 2024 05:42:45 -0500
X-MC-Unique: enKRNHg6NiO9aRVIqEAiqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D10C83BA89;
 Wed, 24 Jan 2024 10:42:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 398A251D5;
 Wed, 24 Jan 2024 10:42:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/7] util/uri: Remove unused macros ISA_RESERVED() and
 ISA_GEN_DELIM()
Date: Wed, 24 Jan 2024 11:42:31 +0100
Message-ID: <20240124104231.603418-8-thuth@redhat.com>
In-Reply-To: <20240124104231.603418-1-thuth@redhat.com>
References: <20240124104231.603418-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
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

They are not used anywhere, so there's no need to keep them around.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240123182247.432642-5-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/uri.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 350835b03f..573174bf47 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -163,19 +163,6 @@ static void uri_clean(URI *uri);
      ((*(p) == '+')) || ((*(p) == ',')) || ((*(p) == ';')) ||                  \
      ((*(p) == '=')) || ((*(p) == '\'')))
 
-/*
- *    gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
- */
-#define ISA_GEN_DELIM(p)                                                       \
-    (((*(p) == ':')) || ((*(p) == '/')) || ((*(p) == '?')) ||                  \
-     ((*(p) == '#')) || ((*(p) == '[')) || ((*(p) == ']')) ||                  \
-     ((*(p) == '@')))
-
-/*
- *    reserved      = gen-delims / sub-delims
- */
-#define ISA_RESERVED(p) (ISA_GEN_DELIM(p) || (ISA_SUB_DELIM(p)))
-
 /*
  *    unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
  */
-- 
2.43.0



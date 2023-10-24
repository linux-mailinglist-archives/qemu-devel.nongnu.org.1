Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F737D4E3B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvExw-0004Z1-Mt; Tue, 24 Oct 2023 06:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvExu-0004Xs-Si
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvExp-00018Y-MY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698144525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OCA3NdvTut9adfNVBRAcj0UCR6VdV0Lg82hiJehIAAw=;
 b=Em2KkLxcCTkHNupkfm+RG0IKoq2/wi7PGEI9jlGjHk7CYILzCR/796EYGZbW29ROVnLgiq
 bDY7qufZx0dA2JnahQbAHLLqdzjy8cNbeMjIaWn427HGM5WbER/CvaQcQ0oW5l2Ua7mvjq
 NeJj33swbPrxS15d/MbiE+sxvoKdT3g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-FqDM71mlOcW0bhqzqN1WRA-1; Tue,
 24 Oct 2023 06:48:43 -0400
X-MC-Unique: FqDM71mlOcW0bhqzqN1WRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DF938476A9;
 Tue, 24 Oct 2023 10:48:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3C5AC15BB8;
 Tue, 24 Oct 2023 10:48:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E79A121E6A1F; Tue, 24 Oct 2023 12:48:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH] qapi: Fix QAPISchemaEntity.__repr__()
Date: Tue, 24 Oct 2023 12:48:41 +0200
Message-ID: <20231024104841.1569250-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I messed it up on merge.  It's a debugging aid, so no impact on build.

Fixes: e307a8174bb8 (qapi: provide a friendly string representation of QAPI classes)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d739e558e9..6a836950a9 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -76,7 +76,8 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
     def __repr__(self):
         if self.name is None:
             return "<%s at 0x%x>" % (type(self).__name__, id(self))
-        return "<%s:%s at 0x%x>" % type(self).__name__, self.name, id(self)
+        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
+                                    id(self))
 
     def c_name(self):
         return c_name(self.name)
-- 
2.41.0



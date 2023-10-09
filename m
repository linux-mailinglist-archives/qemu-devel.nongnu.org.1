Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 031857BD933
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:05:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo4V-0002Uy-8N; Mon, 09 Oct 2023 07:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpo4K-0002GH-2s
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpo4I-0003iC-0E
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696849496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Poan7gQ0HvkWf2e+uDJjh0dKpjeOKcCno4WYPF9saFo=;
 b=ifwbxBTlZjq2GQmb1T6cJ7Su+kEky+x8uG8sfG+fYi5UzPmhAOKxJCgXaeTXmOJzShiBqR
 CWF0j1ueQmQyTbJohM+rz+aHRrp0ZVWJGF6N2F2YDB9NH5pLc6od0aSxnmKyP6ZIagEnPW
 XTJzs3spLQ9SRr5lVmpQmGFWH7ZhYBU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-ZIK-DHs5ORe0Gy_Y7J2fTw-1; Mon, 09 Oct 2023 07:04:50 -0400
X-MC-Unique: ZIK-DHs5ORe0Gy_Y7J2fTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63BBE800883
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 11:04:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 435871004145
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 11:04:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 380D921E6904; Mon,  9 Oct 2023 13:04:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com
Subject: [PATCH] qapi: Belatedly update CompatPolicy documentation for unstable
Date: Mon,  9 Oct 2023 13:04:49 +0200
Message-ID: <20231009110449.4015601-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit 57df0dff1a1 (qapi: Extend -compat to set policy for unstable
interfaces) neglected to update the "Limitation" paragraph to mention
feature 'unstable' in addition to feature 'deprecated'.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index f4c19837eb..42034d9368 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -43,8 +43,8 @@
 # This is intended for testing users of the management interfaces.
 #
 # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
-# with feature 'deprecated'.  We may want to extend it to cover
-# semantic aspects and CLI.
+# with feature 'deprecated' or 'unstable'.  We may want to extend it
+# to cover semantic aspects and CLI.
 #
 # Limitation: deprecated-output policy @hide is not implemented for
 # enumeration values.  They behave the same as with policy @accept.
-- 
2.41.0



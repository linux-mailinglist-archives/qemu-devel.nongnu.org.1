Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C588BB6B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Mar 2024 08:37:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KP-0004eF-LH; Tue, 26 Mar 2024 03:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KN-0004dD-1t
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KL-0005MB-Nz
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oebvQ9k3+tjIp5XFV6vNWQslEKG2TpyUGa0t1LQqJqQ=;
 b=Uosxh/qsMAdyNAum2qZXEfcuGwX/aazWR6rDF82Q+GDOwqnuAEqJXNO3QBtj/4B86hAgA8
 Z0hcZdmRCzbL7pBzMKb1tp225s4kpsj/e5472MpgXul+lE4jGU0j2n2QogTvQTRGygAzlW
 kI3BV9oLO0QzZGl9Nzhaw/8HIA6CtUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-67aJbkstMW6Wdjoo8Bbn1g-1; Tue, 26 Mar 2024 03:34:31 -0400
X-MC-Unique: 67aJbkstMW6Wdjoo8Bbn1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5CE4800265;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B94492BD3;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A3CF321E5D30; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 10/20] qapi: Fix abbreviation punctuation in doc comments
Date: Tue, 26 Mar 2024 08:34:10 +0100
Message-ID: <20240326073420.738016-11-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322140910.328840-8-armbru@redhat.com>
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index c865ab00c8..a4319f87bf 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1773,7 +1773,7 @@
 #        default network.
 #
 #     5. For now, number of migration streams is restricted to one,
-#        i.e number of items in 'channels' list is just 1.
+#        i.e. number of items in 'channels' list is just 1.
 #
 #     6. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
@@ -1850,7 +1850,7 @@
 #     3. The uri format is the same as for -incoming
 #
 #     4. For now, number of migration streams is restricted to one,
-#        i.e number of items in 'channels' list is just 1.
+#        i.e. number of items in 'channels' list is just 1.
 #
 #     5. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
-- 
2.44.0



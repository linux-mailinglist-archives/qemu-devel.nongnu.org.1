Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EAB788CE2
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 17:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZZDk-0001SE-3s; Fri, 25 Aug 2023 11:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZZDi-0001RT-Ae
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZZDd-0004i5-9K
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692979167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73p8xwR0d96Nyix6vnB3cwl7QN4+vXfcjkeK4cI/2ss=;
 b=MnwoxaR2yHyoWgDIK1yh2wIZBaxITOwmoFB269F1zkW+DzzVRe2tRolfSPSd8HIRJY5kQ3
 pe47tzeulCap1cou/zI5a29uCmOl5l4Fu/E6xLVHzHqmPwhP1N6jhSlThAHC+hMKW8BVAU
 leXZzXF+xGmQvBXzebD8hwi3goEpjdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-urUrj2sUPHe1CAl-KlJE4Q-1; Fri, 25 Aug 2023 11:59:25 -0400
X-MC-Unique: urUrj2sUPHe1CAl-KlJE4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4C8785D186;
 Fri, 25 Aug 2023 15:59:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A477B492C18;
 Fri, 25 Aug 2023 15:59:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E8DF21E692B; Fri, 25 Aug 2023 17:59:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, dave@treblig.org, thuth@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com, dgilbert@redhat.com,
 qemu-trivial@nongnu.org
Subject: [PATCH 2/2] tests/qtest/test-hmp: Fix migrate_set_parameter
 xbzrle-cache-size test
Date: Fri, 25 Aug 2023 17:59:23 +0200
Message-ID: <20230825155923.1983141-3-armbru@redhat.com>
In-Reply-To: <20230825155923.1983141-1-armbru@redhat.com>
References: <20230825155923.1983141-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The command always fails with "Error: Parameter 'xbzrle_cache_size'
expects a power of two no less than the target page size".  The test
passes anyway.  Change the argument from 1 to 64k to make the test a
bit more useful.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/test-hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index c0d2d70689..fc9125f8bb 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -45,7 +45,7 @@ static const char *hmp_cmds[] = {
     "log all",
     "log none",
     "memsave 0 4096 \"/dev/null\"",
-    "migrate_set_parameter xbzrle-cache-size 1",
+    "migrate_set_parameter xbzrle-cache-size 64k",
     "migrate_set_parameter downtime-limit 1",
     "migrate_set_parameter max-bandwidth 1",
     "netdev_add user,id=net1",
-- 
2.41.0



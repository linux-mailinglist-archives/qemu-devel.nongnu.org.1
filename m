Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606D783FE9
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYPpQ-0003bB-B5; Tue, 22 Aug 2023 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYPpD-0003a8-Tm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYPpB-0006gZ-Ks
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692704729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpRcHiG2MA0D3IBbjsRHxFD2YnNlDCljtBuFnCgEJ3Q=;
 b=PUrKZDXwWC3Oj7pgjdp1qBSQExPeE78k9ar3U3QhBNy8a2cmWCyAKwc1ZwjDb+ieALurCr
 Fy1zYfXT+1XCSDTYQgqn3r9P6sN928uzaf74vl24lJskwZkT9tlEJgrVeLPwTEEI6puBhF
 /tGMCQ+c5liDo5epxPnT21FWIVWRGQ0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-BHBuKCyMPqmkumeGV0UHrA-1; Tue, 22 Aug 2023 07:45:24 -0400
X-MC-Unique: BHBuKCyMPqmkumeGV0UHrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F5AF3C0C485;
 Tue, 22 Aug 2023 11:45:24 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79ACA492C13;
 Tue, 22 Aug 2023 11:45:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 5/9] softmmu/physmem: Bail out early in
 ram_block_discard_range() with readonly files
Date: Tue, 22 Aug 2023 13:44:53 +0200
Message-ID: <20230822114504.239505-6-david@redhat.com>
In-Reply-To: <20230822114504.239505-1-david@redhat.com>
References: <20230822114504.239505-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

fallocate() will fail, let's print a nicer error message.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 2ed83fcefe..817a7811ee 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3457,6 +3457,16 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * so a userfault will trigger.
              */
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+            /*
+             * fallocate() will fail with readonly files. Let's print a
+             * proper error message.
+             */
+            if (rb->flags & RAM_READONLY_FD) {
+                error_report("ram_block_discard_range: Discarding RAM"
+                             " with readonly files is not supported");
+                goto err;
+
+            }
             /*
              * We'll discard data from the actual file, even though we only
              * have a MAP_PRIVATE mapping, possibly messing with other
-- 
2.41.0



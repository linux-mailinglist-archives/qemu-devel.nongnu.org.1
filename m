Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305807B7F75
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1CX-0008A0-Q3; Wed, 04 Oct 2023 08:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Bg-0006sY-11
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BZ-0003vK-7P
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzNgig+C7xt86ccsmcbatl/y8Dqqajh4++u80bseUl8=;
 b=jPeeIDhh8BBR017mDjgm6+xqpWz5gqnpqbyl3zzh2nE89ZIw7aON/QN8jNvOI8tfFOfaw0
 Q0Bd7l8WqMTHcTCiWq2DUX+G14bSn6S89ph37kc1refxG/xRZ77mS8LhnsH5Ak7qE+CzCk
 p1uR75+ldoVeMoK7T7Koy3OWdCZHvcw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-xXgOMgHlNIitUl43pn4ckg-1; Wed, 04 Oct 2023 08:40:53 -0400
X-MC-Unique: xXgOMgHlNIitUl43pn4ckg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14B751C0514D;
 Wed,  4 Oct 2023 12:40:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4EC2026D4B;
 Wed,  4 Oct 2023 12:40:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 06/11] i386/a-b-bootblock: factor test memory addresses out
 into constants
Date: Wed,  4 Oct 2023 14:40:33 +0200
Message-ID: <20231004124038.16002-7-quintela@redhat.com>
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

So that we have less magic numbers to deal with. This also allows us to
reuse these in the following commits.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230919102346.2117963-2-d-tatianin@yandex-team.ru>
---
 tests/migration/i386/a-b-bootblock.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
index 3d464c7568..036216e4a7 100644
--- a/tests/migration/i386/a-b-bootblock.S
+++ b/tests/migration/i386/a-b-bootblock.S
@@ -34,6 +34,10 @@ start:             # at 0x7c00 ?
         mov $16,%eax
         mov %eax,%ds
 
+# Start from 1MB
+.set TEST_MEM_START, (1024*1024)
+.set TEST_MEM_END, (100*1024*1024)
+
         mov $65,%ax
         mov $0x3f8,%dx
         outb %al,%dx
@@ -41,12 +45,11 @@ start:             # at 0x7c00 ?
         # bl keeps a counter so we limit the output speed
         mov $0, %bl
 mainloop:
-        # Start from 1MB
-        mov $(1024*1024),%eax
+        mov $TEST_MEM_START,%eax
 innerloop:
         incb (%eax)
         add $4096,%eax
-        cmp $(100*1024*1024),%eax
+        cmp $TEST_MEM_END,%eax
         jl innerloop
 
         inc %bl
-- 
2.41.0



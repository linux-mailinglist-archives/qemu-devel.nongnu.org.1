Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0067B7F72
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1C2-0007Fk-11; Wed, 04 Oct 2023 08:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Bb-0006mS-B0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BW-0003uW-5H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9BhWR+oFU8JPVjfriB3k5iO7Vj+azezXNTLrwfi6IQ=;
 b=EoREPppDcZcZuJJRkDR+LaXyGUukxMjwTJMHpZRB6iySHYZsiYGDSfh7SBuy3WHxYk/mUo
 /BMDf13KfYhGiDy+o60rRuMsGccksQe2f+WxmwZR/88YNgQ3SS3VOExeHhroHXXhPsF2OP
 cIgDS8XziXfkWkHNNostZviarlOC10M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-XIOS-cWIN8m7hDPpuF_KNQ-1; Wed, 04 Oct 2023 08:40:47 -0400
X-MC-Unique: XIOS-cWIN8m7hDPpuF_KNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 680962823809;
 Wed,  4 Oct 2023 12:40:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA83B2026D4B;
 Wed,  4 Oct 2023 12:40:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 03/11] MAINTAINERS: Add entry for rdma migration
Date: Wed,  4 Oct 2023 14:40:30 +0200
Message-ID: <20231004124038.16002-4-quintela@redhat.com>
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Xu <peterx@redhat.com>

It's not obvious to many that RDMA migration is in Odd Fixes stage for a
long time.  Add an explicit sub entry for it (besides migration, which
already covers the rdma files) to be clear on that, meanwhile add Zhijian
as Reviewer, so Zhijian can see the patches and review when he still has
the bandwidth.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>

Acked-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230925133441.265455-1-peterx@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81625f036b..af730a327c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3222,6 +3222,15 @@ F: docs/devel/migration.rst
 F: qapi/migration.json
 F: tests/migration/
 F: util/userfaultfd.c
+X: migration/rdma*
+
+RDMA Migration
+M: Juan Quintela <quintela@redhat.com>
+R: Li Zhijian <lizhijian@fujitsu.com>
+R: Peter Xu <peterx@redhat.com>
+R: Leonardo Bras <leobras@redhat.com>
+S: Odd Fixes
+F: migration/rdma*
 
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
-- 
2.41.0



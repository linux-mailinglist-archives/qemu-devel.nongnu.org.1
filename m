Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161E823B66
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFPK-0000Dn-ES; Wed, 03 Jan 2024 23:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPI-0000D4-Fe
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPH-0006Xl-0r
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WktZ2LzDhP+W10mjy931IC19R4i2j3WY3KXAO/VI7i8=;
 b=We+FSNvkc5bB6ydstC766yatvZAATp4w2e4C6XAKIu5kcYQYqwqZE9m2l6pMdOAPoeSkh1
 UHIp3Ui5RSn8aY2h9kr5pT54uTa8DaW5eIjy7JLIAi8pOEmbB5UpjszYrwn894eg4XbW+F
 I3tbKbJ05AqNERx73KNXbQ2RJXWoOTI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-c0vyesrWNlqx6CG2U5wQJA-1; Wed,
 03 Jan 2024 23:32:30 -0500
X-MC-Unique: c0vyesrWNlqx6CG2U5wQJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EE841C2B662;
 Thu,  4 Jan 2024 04:32:30 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBB30C15968;
 Thu,  4 Jan 2024 04:32:25 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 02/26] MAINTAINERS: Remove myself as reviewer from Live
 Migration
Date: Thu,  4 Jan 2024 12:31:47 +0800
Message-ID: <20240104043213.431566-3-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Leonardo Bras <leobras@redhat.com>

I am currently focusing in kernel development, so I will probably not be
of much help in reviewing general Live Migration changes.

For above reason I am removing my Reviewer status from Migration and RDMA
Migration.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Link: https://lore.kernel.org/r/20231221170739.332378-1-leobras@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56464cd916..00ec1f7eca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3356,7 +3356,6 @@ F: scripts/checkpatch.pl
 Migration
 M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
-R: Leonardo Bras <leobras@redhat.com>
 S: Maintained
 F: hw/core/vmstate-if.c
 F: include/hw/vmstate-if.h
@@ -3375,7 +3374,6 @@ X: migration/rdma*
 RDMA Migration
 R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
-R: Leonardo Bras <leobras@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
 
-- 
2.41.0



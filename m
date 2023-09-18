Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1A7A4B1D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSH-0002uy-7J; Mon, 18 Sep 2023 10:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSA-0002t2-DY
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS0-0002Yh-3h
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCGxSHuWGPFauDO78J2cjgmvZQU9Lb4U+fA74G/EWJo=;
 b=Ia6iHavNAZq23lccxKv6KN5M4xxlFsotsd1nbp35PizcpNpqJuWE+MdGlR51F2AoxtdrpS
 nIdS9xq5S9OWYRb2pwV/IWkKxR61ySdr1vsX3yuVfzNiBW43t/OUcSzsPOO3e+mm3n8Xa+
 88Br/Fd+PR4qw5ftL+5rXxiwd6pej70=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-20ST3Oq7MNOk7BsJi2wFCA-1; Mon, 18 Sep 2023 10:42:08 -0400
X-MC-Unique: 20ST3Oq7MNOk7BsJi2wFCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17EEC811E7E
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0FC140E950
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E308521E6904; Mon, 18 Sep 2023 16:42:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 02/52] migration/rdma: Clean up qemu_rdma_data_init()'s return
 type
Date: Mon, 18 Sep 2023 16:41:16 +0200
Message-ID: <20230918144206.560120-3-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu_rdma_data_init() return type is void *.  It actually returns
RDMAContext *, and all its callers assign the value to an
RDMAContext *.  Unclean.

Return RDMAContext * instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 544d83be7e..3b9e21f8de 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2739,7 +2739,7 @@ static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
     rdma_return_path->is_return_path = true;
 }
 
-static void *qemu_rdma_data_init(const char *host_port, Error **errp)
+static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
 {
     RDMAContext *rdma = NULL;
     InetSocketAddress *addr;
-- 
2.41.0



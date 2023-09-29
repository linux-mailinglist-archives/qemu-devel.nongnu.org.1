Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C697B351E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEVt-0000de-2W; Fri, 29 Sep 2023 10:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qmEVp-0000ce-TR
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qmEVl-0000j9-D1
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695997831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IVZTvt3u6PJcS2sjdlhOJVBFDIuP4XD1KSgbMgmulus=;
 b=GC3pX+7ke+PgT3UF96IuY1Kn+UuZNMUPT9aScyyQIfLnKXktiI+2ADZDA5bqXvQBaIUZnL
 pLwXElW0WZ7Flb1AIAy7jhEuI/hXV8PoPGtAJtqv43YAEWARXdywspyfSJzY3LAaZz2sQo
 4jFcKtea/xswBcpdVVfTrJhKN9A9nvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-utSkJgGKMyy6xHssH0aeFA-1; Fri, 29 Sep 2023 10:30:30 -0400
X-MC-Unique: utSkJgGKMyy6xHssH0aeFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A55085A5BA
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:30:29 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.39.193.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4C5D215670B;
 Fri, 29 Sep 2023 14:30:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] MAINTAINERS: add standard-headers to Hosts/LINUX
Date: Fri, 29 Sep 2023 16:30:12 +0200
Message-ID: <20230929143012.77128-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
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

The files in there are updated via update-linux-headers.sh.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce46..95df1f3d8884 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -556,6 +556,7 @@ M: Cornelia Huck <cohuck@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: linux-headers/
+F: include/standard-headers/
 F: scripts/update-linux-headers.sh
 
 POSIX
-- 
2.41.0



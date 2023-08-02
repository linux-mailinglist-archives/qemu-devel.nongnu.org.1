Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB076C730
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6TV-0005X2-4c; Wed, 02 Aug 2023 03:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TR-0005WB-SK
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TP-000241-C9
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690962046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yr0Dx2kFg+v8eOxf6HeNS5jOdDpS9MMRAQEAlHDvYNM=;
 b=QfEbyx+5iey27az5MtS2MjeOGMoVHWlkhmhL0JY4n4l1PLEbg7KMexgfh6D31cl8b0tHyP
 01KyNE3ObGl+QNwV33yKFa6qdONzg450ZE9pGzQuoQJVYRRVK5AW4vHLbiHQ6Mm6O34TO8
 HmIFELweQXLmF1SxbIR0o2jnRU8T6xE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-RcuxCIgIOveix2XWep9HZw-1; Wed, 02 Aug 2023 03:40:43 -0400
X-MC-Unique: RcuxCIgIOveix2XWep9HZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D792D81D9EC;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA2DD1454143;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DEB321E6936; Wed,  2 Aug 2023 09:40:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 3/3] MAINTAINERS: Add section "Migration dirty limit and dirty
 page rate"
Date: Wed,  2 Aug 2023 09:40:41 +0200
Message-ID: <20230802074041.418954-4-armbru@redhat.com>
In-Reply-To: <20230802074041.418954-1-armbru@redhat.com>
References: <20230802074041.418954-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

I've built interests in dirty limit and dirty page rate
features and also have been working on projects related
to this subsystem.

Add a section to the MAINTAINERS file for migration
dirty limit and dirty page rate.

Add myself as a maintainer for this subsystem so that I
can help to improve the dirty limit algorithm and review
the patches about dirty page rate.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Message-ID: <169073570563.19893.2928364761104733482-3@git.sr.ht>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12e59b6b27..6111b6b4d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3209,6 +3209,15 @@ F: qapi/migration.json
 F: tests/migration/
 F: util/userfaultfd.c
 
+Migration dirty limit and dirty page rate
+M: Hyman Huang <yong.huang@smartx.com>
+S: Maintained
+F: softmmu/dirtylimit.c
+F: include/sysemu/dirtylimit.h
+F: migration/dirtyrate.c
+F: migration/dirtyrate.h
+F: include/sysemu/dirtyrate.h
+
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Maintained
-- 
2.41.0



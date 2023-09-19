Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E879F7A6C40
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qihC4-0001wL-5N; Tue, 19 Sep 2023 16:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBo-0001sc-9x
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBm-0003b4-TU
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695154758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y89pdSKeZgpbFhOLDYjIYVSS2ugFvteeVmqAfZgcOfg=;
 b=dv7WDNDIqKchJZsrJZFBpU3vsbV3R1dcbTnA4XjDRD5CqQuofP+qcVlYT3o3afVkr9WYKv
 R4eSAmW5jk8WVSScMBGsCf00CUXutfb64tFH87QuOfja6e8Cz5GJWUCOBHtNTOIfmkSFLJ
 0ONM77fJ2SmsmQ3H3kTxPmmUFOb/ogo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Dg51QzmfMoqV09guqffXXA-1; Tue, 19 Sep 2023 16:19:16 -0400
X-MC-Unique: Dg51QzmfMoqV09guqffXXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58141185A78E
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 20:19:16 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39EFB140E950;
 Tue, 19 Sep 2023 20:19:15 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 09/10] qapi: fix example of query-spice command
Date: Tue, 19 Sep 2023 22:18:56 +0200
Message-ID: <20230919201857.675913-10-victortoso@redhat.com>
In-Reply-To: <20230919201857.675913-1-victortoso@redhat.com>
References: <20230919201857.675913-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Example output has a comment embedded in the array. Remove it.
The end result is a list of size 2.

Signed-off-by: Victor Toso <victortoso@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/ui.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 006616aa77..6ed36c45ea 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -363,8 +363,7 @@
 #                "host": "127.0.0.1",
 #                "channel-id": 0,
 #                "tls": false
-#             },
-#             [ ... more channels follow ... ]
+#             }
 #          ]
 #       }
 #    }
-- 
2.41.0



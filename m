Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B179A759
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfeLU-0001iB-9P; Mon, 11 Sep 2023 06:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qfeLM-0001g1-SQ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qfeLJ-0006O0-R3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694428833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7LiIiA5R1kkk1AqAufFeQ+hIvCE4yE2Nt6Y873ddIA=;
 b=NCXlIGgMlh8ezVkQNxi2Vp6PRcbJqFqy1sp5paj2GdUb4WwADclgGEXS7hxF+xfg+9UxKz
 eDg3/eTiOL8QqXObBGuxN9alAZR2lLH12fpq+KSPzHk5/ITbWuPA/rbRL2ygbEz+Vuo4jX
 X8iVjIkWa86/SPTJfRdo8V5QXREnb5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-ofbGgiGMMem0fIkv3aXtIA-1; Mon, 11 Sep 2023 06:40:31 -0400
X-MC-Unique: ofbGgiGMMem0fIkv3aXtIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93D34101FAA1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 10:40:31 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.225.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE5910F1BE7;
 Mon, 11 Sep 2023 10:40:30 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/11] qapi: fix example of query-spice command
Date: Mon, 11 Sep 2023 12:40:16 +0200
Message-ID: <20230911104017.65397-9-victortoso@redhat.com>
In-Reply-To: <20230911104017.65397-1-victortoso@redhat.com>
References: <20230911104017.65397-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Example output has a comment embedded in the array. Remove it.
The end result is a list of size 2.

Signed-off-by: Victor Toso <victortoso@redhat.com>
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



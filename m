Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BA763501
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 13:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOchj-00038S-Bc; Wed, 26 Jul 2023 07:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOchV-00037d-EC
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOchT-0003zc-Qu
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690370940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=udJ0vl7NWQD5T9Aa/jRC6b7ZcYSyPfg5gk2igTn1sb8=;
 b=ZOicEAJpE78LpQZLw99SoxyXF9dLvqhmqmcoV2XT/wLVW0SFpRGOPyk2nsDOrTRsCdO9gV
 gdVwLDL7B3KxfbIvzpFt+VasGlSfNH7D7jHQ6vEWPwhiK4mF6lhjVqTs5o6QZxCEtQszwR
 s3WISApuPDcVjnFhWAPmnpqIQiIjY/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-n_7KvqSvPGq_3YflhQxMeA-1; Wed, 26 Jul 2023 07:28:57 -0400
X-MC-Unique: n_7KvqSvPGq_3YflhQxMeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A75B5185A7A4;
 Wed, 26 Jul 2023 11:28:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55DB74094DC0;
 Wed, 26 Jul 2023 11:28:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D4FA21E60F3; Wed, 26 Jul 2023 13:28:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 1/5] qapi/block-core: Tidy up BlockLatencyHistogramInfo
 documentation
Date: Wed, 26 Jul 2023 13:28:51 +0200
Message-ID: <20230726112855.155795-2-armbru@redhat.com>
In-Reply-To: <20230726112855.155795-1-armbru@redhat.com>
References: <20230726112855.155795-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Documentation for member @bin comes out like

    list of io request counts corresponding to histogram intervals.
    len("bins") = len("boundaries") + 1 For the example above, "bins"
    may be something like [3, 1, 5, 2], and corresponding histogram
    looks like:

Note how the equation and the sentence following it run together.
Replace the equation:

    list of io request counts corresponding to histogram intervals,
    same number of elements as "boundaries".  For the example above,
    "bins" may be something like [3, 1, 5, 2], and corresponding
    histogram looks like:

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20230720071610.1096458-2-armbru@redhat.com>
---
 qapi/block-core.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5dd5f7e4b0..6ca448b6e6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -652,10 +652,9 @@
 #     10), [10, 50), [50, 100), [100, +inf).
 #
 # @bins: list of io request counts corresponding to histogram
-#     intervals.
-#     len(@bins) = len(@boundaries) + 1
-#     For the example above, @bins may be something like [3, 1, 5, 2],
-#     and corresponding histogram looks like:
+#     intervals, same number of elements as @boundaries.  For the
+#     example above, @bins may be something like [3, 1, 5, 2], and
+#     corresponding histogram looks like:
 #
 # ::
 #
-- 
2.41.0



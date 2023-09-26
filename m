Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C737AF023
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlATO-0000Kg-6g; Tue, 26 Sep 2023 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATM-0000K9-35
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATK-0007xd-M1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695743978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFJfX2UbdUONwAiwbnWDg/Z2Ma5pzUtKmwKBZ6J1/3g=;
 b=OFEMX1HPIY5h+HfI80wr4PIbU/pveu+y7+9Sbw31xPnAFgTpyL9N2aIafAO+27LH9SSCvB
 l6SLc4U4bo6u1Oqvzvtn0mMa5dLzZ+AmTJzlFlTr+FGbZvndqkLZOeNe7lwyQFKiwR+6oT
 dKJdZugUkMFm73Rk5jW7nSQpIKZa1Xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-2Kg--Pc9M5ubWj_FSorSdQ-1; Tue, 26 Sep 2023 11:59:34 -0400
X-MC-Unique: 2Kg--Pc9M5ubWj_FSorSdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17113801FA9;
 Tue, 26 Sep 2023 15:59:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C7CC40C6EA8;
 Tue, 26 Sep 2023 15:59:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/5] block/fdc: 'phase' is not needed on load
Date: Tue, 26 Sep 2023 19:59:21 +0400
Message-ID: <20230926155925.1396309-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
References: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It is reconstructed during fdc_post_load()

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/block/fdc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index d7cc4d3ec1..fc71660ba0 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1005,6 +1005,11 @@ static bool fdc_phase_needed(void *opaque)
 {
     FDCtrl *fdctrl = opaque;
 
+    /* not needed on load */
+    if (fdctrl->phase == FD_PHASE_RECONSTRUCT) {
+        return false;
+    }
+
     return reconstruct_phase(fdctrl) != fdctrl->phase;
 }
 
-- 
2.41.0



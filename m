Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB27DD66F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:00:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxu-0003yw-US; Tue, 31 Oct 2023 14:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxt-0003y3-5m
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxV-000662-Vv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/zese4Un2SrXCtyjOdRUqT1WQNgqNx/q6FXGMvbhhE=;
 b=OfZeZ3+NgMwHIUvXQLYAm69rS8ONdzfDWU9T2VSl+g4D6HbkKnYFc5VJosM6C3Rbrp3sRI
 KXrJGyop+RjyuIFFgp/OCJCLjkhpDBicD5H9h40e6nzNT+0R2ZS12mOtK1/rYsw9SdaDbr
 kMWwjU8T7cYz9BD0lRN47crYY2hkBvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jD6Rhd3EOq61qQMBJja5ug-1; Tue, 31 Oct 2023 14:59:21 -0400
X-MC-Unique: jD6Rhd3EOq61qQMBJja5ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FD1A811E7D;
 Tue, 31 Oct 2023 18:59:21 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1E2C25C0;
 Tue, 31 Oct 2023 18:59:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/27] qemu-img: rebase: stop when reaching EOF of old backing
 file
Date: Tue, 31 Oct 2023 19:58:52 +0100
Message-ID: <20231031185918.346940-2-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

In case when we're rebasing within one backing chain, and when target image
is larger than old backing file, bdrv_is_allocated_above() ends up setting
*pnum = 0.  As a result, target offset isn't getting incremented, and we
get stuck in an infinite for loop.  Let's detect this case and proceed
further down the loop body, as the offsets beyond the old backing size need
to be explicitly zeroed.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230919165804.439110-2-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 585b65640f..2b2a3a86ca 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3814,6 +3814,8 @@ static int img_rebase(int argc, char **argv)
             }
 
             if (prefix_chain_bs) {
+                uint64_t bytes = n;
+
                 /*
                  * If cluster wasn't changed since prefix_chain, we don't need
                  * to take action
@@ -3826,9 +3828,18 @@ static int img_rebase(int argc, char **argv)
                                  strerror(-ret));
                     goto out;
                 }
-                if (!ret) {
+                if (!ret && n) {
                     continue;
                 }
+                if (!n) {
+                    /*
+                     * If we've reached EOF of the old backing, it means that
+                     * offsets beyond the old backing size were read as zeroes.
+                     * Now we will need to explicitly zero the cluster in
+                     * order to preserve that state after the rebase.
+                     */
+                    n = bytes;
+                }
             }
 
             /*
-- 
2.41.0



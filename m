Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B905E8FC950
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jun 2024 12:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo8l-0008LD-C6; Wed, 05 Jun 2024 06:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8k-0008Kd-7W
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8i-0007Vt-9a
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717584307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yvvHCsFGcQy3avS2tqQfsLMqNzxPdKw9AyVqslnxSY=;
 b=ONu4IcrdCfxD9xUBc1UfwJmQJXfUkGOmGvP5tfk6zKOEzJpdBJvCwNW+jwB2wlosGstSsT
 wtnWVrhBQ4FQyhccfbEIIx3HB0kzpg9++Cq6gcIxXYRqomyvTfhqbEGJo9f63ktdLXrUth
 cddrviLs8N0eJx3xZrgKKZg84AVRuGo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-NBgpX8OwM4WoDpad3TMVew-1; Wed,
 05 Jun 2024 06:45:05 -0400
X-MC-Unique: NBgpX8OwM4WoDpad3TMVew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91C1A1954B00
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:04 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A483E19560A2
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:03 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] osdep: Make qemu_madvise() to set errno in all cases
Date: Wed,  5 Jun 2024 12:44:55 +0200
Message-ID: <af17113e7c1f2cc909ffd36d23f5a411b63b8764.1717584048.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717584048.git.mprivozn@redhat.com>
References: <cover.1717584048.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The unspoken premise of qemu_madvise() is that errno is set on
error. And it is mostly the case except for posix_madvise() which
is documented to return either zero (on success) or a positive
error number. This means, we must set errno ourselves. And while
at it, make the function return a negative value on error, just
like other error paths do.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 util/osdep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..e42f4e8121 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -57,7 +57,12 @@ int qemu_madvise(void *addr, size_t len, int advice)
 #if defined(CONFIG_MADVISE)
     return madvise(addr, len, advice);
 #elif defined(CONFIG_POSIX_MADVISE)
-    return posix_madvise(addr, len, advice);
+    int rc = posix_madvise(addr, len, advice);
+    if (rc) {
+        errno = rc;
+        return -1;
+    }
+    return 0;
 #else
     errno = EINVAL;
     return -1;
-- 
2.44.1



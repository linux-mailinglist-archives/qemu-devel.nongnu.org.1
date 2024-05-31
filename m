Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5C8D6551
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 17:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3uT-00008U-AM; Fri, 31 May 2024 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD3uI-00005R-UR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD3uE-0005WZ-2n
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717168252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OVgxykSPTZ7KjJ2nv9zefemkRQks8uLwLwTeb9bnis=;
 b=a9tj3eeeYc9QlB1l61vGHOqZC1AEehbHsNm12sPK1ny8K0BpM5gwD8dl56lOV7QG78Ic94
 VJoNZ9NoKVTEVJQMn540ih8r21uvz8bm60J8CBkTOHm4o64I84k/oLwFHpqf3TT30H2uNZ
 8EAxuaWHeCCXeNRapzHe/242rQDaiSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-qnisU6TWOdaHHD_yWuSHqw-1; Fri, 31 May 2024 11:10:50 -0400
X-MC-Unique: qnisU6TWOdaHHD_yWuSHqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED6D101A525
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:10:50 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD7033C27
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 15:10:49 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] osdep: Make qemu_madvise() to set errno in all cases
Date: Fri, 31 May 2024 17:10:44 +0200
Message-ID: <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717168113.git.mprivozn@redhat.com>
References: <cover.1717168113.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

The unspoken premise of qemu_madvise() is that errno is set on
error. And it is mostly the case except for posix_madvise() which
is documented to return either zero (on success) or a positive
error number. This means, we must set errno ourselves. And while
at it, make the function return a negative value on error, just
like other error paths do.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 util/osdep.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..1345238a5c 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int advice)
 #if defined(CONFIG_MADVISE)
     return madvise(addr, len, advice);
 #elif defined(CONFIG_POSIX_MADVISE)
-    return posix_madvise(addr, len, advice);
+    /*
+     * On Darwin posix_madvise() has the same return semantics as
+     * plain madvise, i.e. errno is set and -1 is returned. Otherwise,
+     * a positive error number is returned.
+     */
+    int rc = posix_madvise(addr, len, advice);
+    if (rc) {
+        if (rc > 0) {
+            errno = rc;
+        }
+        return -1;
+    }
+    return 0;
 #else
     errno = EINVAL;
     return -1;
-- 
2.44.1



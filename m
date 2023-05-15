Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA4703DEA
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGZ-0004xB-LA; Mon, 15 May 2023 15:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGX-0004wD-F0
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGW-000482-1O
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kekzPRHFKJgpDSEAFBMlc6bgjJDBcKoCLJYFTbydaxA=;
 b=RvhKmLxlYrvHekzwC0GEPEFpiJ6aA4jeF4wdjhbYbFch7pvGB/psoen0HR+zWM1hYG3V45
 FfbHPyginmOytnqMov0nQAbMRTDWneOTWH0YFWa4PWfms/LDouw8GntXjHM0LLWoba3Osu
 TVS1+RNbgYcdz/ve2i5AvdFLGzt38go=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-_NrVXl8PNR-7mAyeHgFoqw-1; Mon, 15 May 2023 15:53:47 -0400
X-MC-Unique: _NrVXl8PNR-7mAyeHgFoqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7726B800047;
 Mon, 15 May 2023 19:53:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08F43140E917;
 Mon, 15 May 2023 19:53:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 02/14] nbd/client: Add safety check on chunk payload length
Date: Mon, 15 May 2023 14:53:31 -0500
Message-Id: <20230515195343.1915857-3-eblake@redhat.com>
In-Reply-To: <20230515195343.1915857-1-eblake@redhat.com>
References: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Our existing use of structured replies either reads into a qiov capped
at 32M (NBD_CMD_READ) or caps allocation to 1000 bytes (see
NBD_MAX_MALLOC_PAYLOAD in block/nbd.c).  But the existing length
checks are rather late; if we encounter a buggy (or malicious) server
that sends a super-large payload length, we should drop the connection
right then rather than assuming the layer on top will be careful.
This becomes more important when we permit 64-bit lengths which are
even more likely to have the potential for attempted denial of service
abuse.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/nbd/client.c b/nbd/client.c
index ff75722e487..46f476400ab 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1413,6 +1413,18 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
     chunk->handle = be64_to_cpu(chunk->handle);
     chunk->length = be32_to_cpu(chunk->length);

+    /*
+     * Because we use BLOCK_STATUS with REQ_ONE, and cap READ requests
+     * at 32M, no valid server should send us payload larger than
+     * this.  Even if we stopped using REQ_ONE, sane servers will cap
+     * the number of extents they return for block status.
+     */
+    if (chunk->length > NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData)) {
+        error_setg(errp, "server chunk %" PRIu32 " (%s) payload is too long",
+                   chunk->type, nbd_rep_lookup(chunk->type));
+        return -EINVAL;
+    }
+
     return 0;
 }

-- 
2.40.1



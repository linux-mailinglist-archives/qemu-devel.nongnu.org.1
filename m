Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F484D834
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Feb 2024 04:10:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXukr-0006pw-UI; Wed, 07 Feb 2024 22:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujt-0006Hi-HJ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujr-0004MV-Vd
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wch729pW3cWXDkHx07WlSRgxQRZ8MhkzYhr59IzkERo=;
 b=fC/lTdKX8bQYP66T5POYMmFDFyEcPMMwkYyDHGQpp38QdmqD7C18WPV4Dpd54YF6yPHSdW
 vhwrELWuv18lj+WWkDA9NwLFdWjzNl4vOn0qR2ykAphQ5FOWg1D830aSu3cjGvHGnRvfFS
 n4nhGxtWUCd3Ya8EiHhWpIzZQK+FCCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-3W1o2FTuMGaMz0r94OfvRQ-1; Wed, 07 Feb 2024 22:06:07 -0500
X-MC-Unique: 3W1o2FTuMGaMz0r94OfvRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6978B101FA2D;
 Thu,  8 Feb 2024 03:06:07 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27CA7492BC7;
 Thu,  8 Feb 2024 03:06:04 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 11/34] migration/multifd: Move total_normal_pages accounting
Date: Thu,  8 Feb 2024 11:05:05 +0800
Message-ID: <20240208030528.368214-12-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Just like the previous patch, move the accounting for total_normal_pages on
both src/dst sides into the packet fill/unfill procedures.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-11-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index eca76e2c18..94a0124934 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -290,6 +290,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
     }
 
     p->packets_sent++;
+    p->total_normal_pages += pages->num;
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -338,6 +339,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
+    p->total_normal_pages += p->normal_num;
 
     if (p->normal_num == 0) {
         return 0;
@@ -720,7 +722,6 @@ static void *multifd_send_thread(void *opaque)
             }
 
             multifd_send_fill_packet(p);
-            p->total_normal_pages += pages->num;
             trace_multifd_send(p->id, packet_num, pages->num, p->flags,
                                p->next_packet_size);
 
@@ -1124,7 +1125,6 @@ static void *multifd_recv_thread(void *opaque)
         p->flags &= ~MULTIFD_FLAG_SYNC;
         trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
                            p->next_packet_size);
-        p->total_normal_pages += p->normal_num;
         qemu_mutex_unlock(&p->mutex);
 
         if (p->normal_num) {
-- 
2.43.0



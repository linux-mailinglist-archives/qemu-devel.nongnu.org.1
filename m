Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8074AD97
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQg-0003FR-NU; Fri, 07 Jul 2023 05:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQe-0003Ey-1n
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQc-0006vL-Kw
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UB3IDNhWk0GME5aP6Y5dRZF+LxxnUyt/AX8UE6EQO+c=;
 b=LglElT6NEML2eQ6/8kD6XJ3BBrYNEDdqYSfZ8vW0hRj1VLl1rW4IN/uxUF7kg01e0xNdLr
 c5nJvblL9o1Jq+GvfJ+nOXcXvk9dort4CMHozJb93hmMMpVIW7Jj2NEiUC0eLulbfRPI4E
 MAC4xUM5kZazN/T17NrEP6TYhWCEpKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-iwItxA2rPlKe-j-suYqnmg-1; Fri, 07 Jul 2023 05:06:58 -0400
X-MC-Unique: iwItxA2rPlKe-j-suYqnmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F9FB101A54E;
 Fri,  7 Jul 2023 09:06:58 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47C451121330;
 Fri,  7 Jul 2023 09:06:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Bin Meng <bmeng@tinylab.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 09/15] hw/net: sunhme: Remove the logic of padding short frames
 in the receive path
Date: Fri,  7 Jul 2023 05:06:22 -0400
Message-Id: <20230707090628.2210346-10-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
References: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

From: Bin Meng <bmeng@tinylab.org>

Now that we have implemented unified short frames padding in the
QEMU networking codes, remove the same logic in the NIC codes.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/sunhme.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 1f3d801..391d26f 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -714,8 +714,6 @@ static inline void sunhme_set_rx_ring_nr(SunHMEState *s, int i)
     s->erxregs[HME_ERXI_RING >> 2] = ring;
 }
 
-#define MIN_BUF_SIZE 60
-
 static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
                               size_t size)
 {
@@ -724,7 +722,6 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
     dma_addr_t rb, addr;
     uint32_t intstatus, status, buffer, buffersize, sum;
     uint16_t csum;
-    uint8_t buf1[60];
     int nr, cr, len, rxoffset, csum_offset;
 
     trace_sunhme_rx_incoming(size);
@@ -775,14 +772,6 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
 
     trace_sunhme_rx_filter_accept();
 
-    /* If too small buffer, then expand it */
-    if (size < MIN_BUF_SIZE) {
-        memcpy(buf1, buf, size);
-        memset(buf1 + size, 0, MIN_BUF_SIZE - size);
-        buf = buf1;
-        size = MIN_BUF_SIZE;
-    }
-
     rb = s->erxregs[HME_ERXI_RING >> 2] & HME_ERXI_RING_ADDR;
     nr = sunhme_get_rx_ring_count(s);
     cr = sunhme_get_rx_ring_nr(s);
-- 
2.7.4



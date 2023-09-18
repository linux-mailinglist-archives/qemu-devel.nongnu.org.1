Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD17A44D2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9h0-0006mL-4X; Mon, 18 Sep 2023 04:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9gB-00069a-Cj
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9g7-0004EF-J7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tItjSfjaltQDyQlhWPGqxzpHeb/IH3Sy23ZEmmsHsDY=;
 b=CiZMeshzo9D6bQJn7cJNj+xdGxSBD5mtev72bh8+O6DzLDTw0FTfRshSuij/4iRhFGbR5h
 6qvYVL3yfczQJ9yvHbfmJAqwmsQiAdlu1DcOjqksmEiRQDKkLdZPulhk9m0ouR0x56p+Lc
 s/1UnzHiJymtJdd54c1aBeyatoeETVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-XhcJQLWANeSTmdjtQEFLqA-1; Mon, 18 Sep 2023 04:32:17 -0400
X-MC-Unique: XhcJQLWANeSTmdjtQEFLqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32083811E86;
 Mon, 18 Sep 2023 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24A102156701;
 Mon, 18 Sep 2023 08:32:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 14/17] hw/net/fsl_etsec/rings.c: Avoid variable length array
Date: Mon, 18 Sep 2023 16:31:29 +0800
Message-Id: <20230918083132.55423-15-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In fill_rx_bd() we create a variable length array of size
etsec->rx_padding. In fact we know that this will never be
larger than 64 bytes, because rx_padding is set in rx_init_frame()
in a way that ensures it is only that large. Use a fixed sized
array and assert that it is big enough.

Since padd[] is now potentially rather larger than the actual
padding required, adjust the memset() we do on it to match the
size that we write with cpu_physical_memory_write(), rather than
clearing the entire array.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/fsl_etsec/rings.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 788463f..2f2f359 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -372,6 +372,12 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
     etsec->regs[TSTAT].value |= 1 << (31 - ring_nbr);
 }
 
+/*
+ * rx_init_frame() ensures we never do more padding than this
+ * (checksum plus minimum data packet size)
+ */
+#define MAX_RX_PADDING 64
+
 static void fill_rx_bd(eTSEC          *etsec,
                        eTSEC_rxtx_bd  *bd,
                        const uint8_t **buf,
@@ -380,9 +386,11 @@ static void fill_rx_bd(eTSEC          *etsec,
     uint16_t to_write;
     hwaddr   bufptr = bd->bufptr +
         ((hwaddr)(etsec->regs[TBDBPH].value & 0xF) << 32);
-    uint8_t  padd[etsec->rx_padding];
+    uint8_t  padd[MAX_RX_PADDING];
     uint8_t  rem;
 
+    assert(etsec->rx_padding <= MAX_RX_PADDING);
+
     RING_DEBUG("eTSEC fill Rx buffer @ 0x%016" HWADDR_PRIx
                " size:%zu(padding + crc:%u) + fcb:%u\n",
                bufptr, *size, etsec->rx_padding, etsec->rx_fcb_size);
@@ -426,7 +434,7 @@ static void fill_rx_bd(eTSEC          *etsec,
         rem = MIN(etsec->regs[MRBLR].value - bd->length, etsec->rx_padding);
 
         if (rem > 0) {
-            memset(padd, 0x0, sizeof(padd));
+            memset(padd, 0x0, rem);
             etsec->rx_padding -= rem;
             *size             -= rem;
             bd->length        += rem;
-- 
2.7.4



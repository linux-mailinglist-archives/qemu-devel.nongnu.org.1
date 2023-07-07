Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949174AD99
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQd-0003Dl-4z; Fri, 07 Jul 2023 05:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQa-0003Bz-Tc
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQZ-0006f7-Dl
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJ6gLhLPLx8ltArEQwPzVntmjj2KHV+d/O/rmTF5Tcc=;
 b=h1SaC/9aBTxmN9fZp2/EL7/0IHglnTRRvd+jZZehmGtAJGZQ0n2TVw3kRdZc5Eh6K5InDw
 bN9+2PBLliqIB/PYH7n4dKrwP/jLtuQ+5vt2Mc8aSmq458+08BIBbHUuWY+PdIdRWqWhlw
 I48FB2S694BXWwqkUAOTmoM4sH1OSfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-Fygo2QnCNeGBTxOoUJUqtg-1; Fri, 07 Jul 2023 05:06:56 -0400
X-MC-Unique: Fygo2QnCNeGBTxOoUJUqtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7E2B10504AA;
 Fri,  7 Jul 2023 09:06:55 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1AE1121330;
 Fri,  7 Jul 2023 09:06:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Bin Meng <bmeng@tinylab.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/15] hw/net: sungem: Remove the logic of padding short frames
 in the receive path
Date: Fri,  7 Jul 2023 05:06:21 -0400
Message-Id: <20230707090628.2210346-9-jasowang@redhat.com>
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
 hw/net/sungem.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index eb01520..103376c 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -550,7 +550,6 @@ static ssize_t sungem_receive(NetClientState *nc, const uint8_t *buf,
     PCIDevice *d = PCI_DEVICE(s);
     uint32_t mac_crc, done, kick, max_fsize;
     uint32_t fcs_size, ints, rxdma_cfg, rxmac_cfg, csum, coff;
-    uint8_t smallbuf[60];
     struct gem_rxd desc;
     uint64_t dbase, baddr;
     unsigned int rx_cond;
@@ -584,19 +583,6 @@ static ssize_t sungem_receive(NetClientState *nc, const uint8_t *buf,
         return size;
     }
 
-    /* We don't drop too small frames since we get them in qemu, we pad
-     * them instead. We should probably use the min frame size register
-     * but I don't want to use a variable size staging buffer and I
-     * know both MacOS and Linux use the default 64 anyway. We use 60
-     * here to account for the non-existent FCS.
-     */
-    if (size < 60) {
-        memcpy(smallbuf, buf, size);
-        memset(&smallbuf[size], 0, 60 - size);
-        buf = smallbuf;
-        size = 60;
-    }
-
     /* Get MAC crc */
     mac_crc = net_crc32_le(buf, ETH_ALEN);
 
-- 
2.7.4



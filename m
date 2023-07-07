Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7874AD9A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQn-0003LO-Bv; Fri, 07 Jul 2023 05:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQk-0003KK-HQ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQi-0007LF-Te
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eW8lLnijUFFZA9pyxKB/SNw992FyPtUl4bZEjwywaUg=;
 b=XjWSL2jZw3j+4IctJyAcbEBhB9+3XQ43NZZi3Kdc9tLUPftBZhSWvQzt/esn0UZNyzknu8
 cNv4AgnWhpz0uOlS+8/iB6rGUTGBNBGj2PTwzLagOKn+m8x9gN+ieuVd46Smsjvuzr0Rlg
 WswUsqdjnrm39D0IppUMmTtq8K64DDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-ozkWR6CrMp2cTZ6vFfp4DA-1; Fri, 07 Jul 2023 05:07:01 -0400
X-MC-Unique: ozkWR6CrMp2cTZ6vFfp4DA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3844D805951;
 Fri,  7 Jul 2023 09:07:01 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5D61121330;
 Fri,  7 Jul 2023 09:06:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Bin Meng <bmeng@tinylab.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/15] hw/net: ftgmac100: Drop the small packet check in the
 receive path
Date: Fri,  7 Jul 2023 05:06:23 -0400
Message-Id: <20230707090628.2210346-11-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
References: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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
QEMU networking codes, the small packet check logic in the receive
path is no longer needed.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Bin Meng <bmeng@tinylab.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/ftgmac100.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d3bf14b..702b001 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -968,14 +968,6 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    /* TODO : Pad to minimum Ethernet frame length */
-    /* handle small packets.  */
-    if (size < 10) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped frame of %zd bytes\n",
-                      __func__, size);
-        return size;
-    }
-
     if (!ftgmac100_filter(s, buf, size)) {
         return size;
     }
-- 
2.7.4



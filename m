Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4CA7175A
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Mar 2025 14:22:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQh8-00007z-PK; Wed, 26 Mar 2025 09:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1txQh6-00007c-LH
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1txQh5-00074f-26
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742995276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U89MM7M/56L3tH8cXinYMHM+hVk7yAP1ONUFxWtbKg8=;
 b=CFHpp1Mt/aUlTa3q8OggqeJPuKWPPFAUVP3HqCHy0QEiNRmT6farxJML3fYjvhkzuXAtHp
 J1HV9kqMEld0N4SnCS/wTu1fMQO+gswUpJdzmJhZZXmUK2i+OP1qII/UDdQbS5wS04VvMI
 C/G9oBxES/XAH9Z77Imuk+YrtpBHO4o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-sczHHhRFOK6mRuVaOeV2lA-1; Wed,
 26 Mar 2025 09:21:14 -0400
X-MC-Unique: sczHHhRFOK6mRuVaOeV2lA-1
X-Mimecast-MFC-AGG-ID: sczHHhRFOK6mRuVaOeV2lA_1742995274
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3783A196B344
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 13:21:13 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16DB51956095; Wed, 26 Mar 2025 13:21:09 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 4/4] virtio_net: Add third acceptable configuration for MAC
 setup.
Date: Wed, 26 Mar 2025 21:19:33 +0800
Message-ID: <20250326132021.1215568-5-lulu@redhat.com>
In-Reply-To: <20250326132021.1215568-1-lulu@redhat.com>
References: <20250326132021.1215568-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

For VDPA devices, Allow configurations where both the hardware MAC address
and QEMU command line MAC address are zero.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1fd0403d5d..d1f44850d5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3782,6 +3782,19 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
             return true;
         }
     }
+    /*
+     * 3.The hardware MAC address is 0,
+     *  and the MAC address in the QEMU command line is also 0.
+     *  In this situation, qemu will generate a random mac address
+     *  QEMU will try to use CVQ/set_config to set this address to
+     *  device
+     */
+    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) == 0) &&
+        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0)) {
+        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
+
+        return true;
+    }
 
     error_setg(errp,
                "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
-- 
2.45.0



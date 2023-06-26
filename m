Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D132773E12A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNa-0006R8-Ou; Mon, 26 Jun 2023 08:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLn-0002xh-TL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLh-00037k-OW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttoNvuHLZ0XFMVgAHJa1QOqb26Br1HM8ci+9NAm22mw=;
 b=SI7AUJcEqpRiuRxOIbl1OKtdZCC3YeEzEYS/72ACutkxrqWPTqwb0FWA2PxnWhVcf7c0jd
 QmDNjbOTVX1DAxUy9wp8ULs5EUfKvra+52VF/ASeQqoJv5WB+nkbTtJ1R9Kj6Y7gbeIQ7M
 EDDOyKCGQygCvFhDRg5pznklMwNzq3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Tn9euGaaMRKRCVl0wJODqA-1; Mon, 26 Jun 2023 08:29:39 -0400
X-MC-Unique: Tn9euGaaMRKRCVl0wJODqA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313f10072daso525363f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782577; x=1690374577;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ttoNvuHLZ0XFMVgAHJa1QOqb26Br1HM8ci+9NAm22mw=;
 b=Vp2CkmahKl5stmUa6zrecDJzGrzP5oh+3cjtzlTluJ7NQCzYdN59nNY9aAiKoA84Vc
 U8CMIVA3GTYEF3LRMmthownCRfZQ887srfDjyV/13aB2Wrt7LrrxWd8U+V6E1ucRCCjr
 eEsgMapnWbZxCddc5ZT/fa0bl5t+tYvjTp6PsnfSyocVvTaxroYspZpMUjUzz6RhTcb3
 NufCfq0ZAL2mMJRqiStYX4O6ijC/SRbgtDtXRHAbrcV4BA1ObCO0p2+bj0m0NqpL5LC5
 Cv4cmDqyEqyfXvEJVHrlmFGyjJ7ni0ggRGPqvE5sEDzVT3GjlXe0fmEFhubkIv/wqp4c
 Mcng==
X-Gm-Message-State: AC+VfDw92Qo574PxbC1y7XyBcgZy3pTOaBkJbfco07fRh0v0slFPmen6
 rslmsGzmxgk/NPwEG+exhw5ioljoaF5gIEHYkjDZj3rXg185xKjAhgp/6fCNM8M9GPcB3Ai6GuJ
 Bw/taBm3lB5tWCDd+Ro8PsqQDRsD6rz6hdaNmX9IbElmC/rXkpH8FsRasLNIp1vMbQ0IK
X-Received: by 2002:a5d:4535:0:b0:313:e6fb:39a0 with SMTP id
 j21-20020a5d4535000000b00313e6fb39a0mr4842583wra.11.1687782577159; 
 Mon, 26 Jun 2023 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+LAvAqdJZfCBcJ7MviMZVK2JsAdo+SBE2QTo6KLeXSgquqKZ3usKd5eFsp1fXkhZn4qO8wg==
X-Received: by 2002:a5d:4535:0:b0:313:e6fb:39a0 with SMTP id
 j21-20020a5d4535000000b00313e6fb39a0mr4842569wra.11.1687782576917; 
 Mon, 26 Jun 2023 05:29:36 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm622749wrx.59.2023.06.26.05.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:36 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 35/53] vdpa: reorder vhost_vdpa_net_cvq_cmd_page_len function
Message-ID: <9446bce653f927c04098fcfe36378163ce6086f2.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

We need to call it from resource cleanup context, as munmap needs the
size of the mappings.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230602143854.1879091-3-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4345f1e6de..e425fabc34 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -120,6 +120,22 @@ VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static size_t vhost_vdpa_net_cvq_cmd_len(void)
+{
+    /*
+     * MAC_TABLE_SET is the ctrl command that produces the longer out buffer.
+     * In buffer is always 1 byte, so it should fit here
+     */
+    return sizeof(struct virtio_net_ctrl_hdr) +
+           2 * sizeof(struct virtio_net_ctrl_mac) +
+           MAC_TABLE_ENTRIES * ETH_ALEN;
+}
+
+static size_t vhost_vdpa_net_cvq_cmd_page_len(void)
+{
+    return ROUND_UP(vhost_vdpa_net_cvq_cmd_len(), qemu_real_host_page_size());
+}
+
 static bool vhost_vdpa_net_valid_svq_features(uint64_t features, Error **errp)
 {
     uint64_t invalid_dev_features =
@@ -427,22 +443,6 @@ static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
     vhost_iova_tree_remove(tree, *map);
 }
 
-static size_t vhost_vdpa_net_cvq_cmd_len(void)
-{
-    /*
-     * MAC_TABLE_SET is the ctrl command that produces the longer out buffer.
-     * In buffer is always 1 byte, so it should fit here
-     */
-    return sizeof(struct virtio_net_ctrl_hdr) +
-           2 * sizeof(struct virtio_net_ctrl_mac) +
-           MAC_TABLE_ENTRIES * ETH_ALEN;
-}
-
-static size_t vhost_vdpa_net_cvq_cmd_page_len(void)
-{
-    return ROUND_UP(vhost_vdpa_net_cvq_cmd_len(), qemu_real_host_page_size());
-}
-
 /** Map CVQ buffer. */
 static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
                                   bool write)
-- 
MST



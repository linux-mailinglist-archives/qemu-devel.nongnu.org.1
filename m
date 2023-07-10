Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC0874E1FD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwo-0004eF-AW; Mon, 10 Jul 2023 19:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwk-0004Tb-RG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwj-0004uh-5Q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IA9Q76kZr4fcEo5oRA3QJtuIiFw5g8VxB1RjNQ65Hy4=;
 b=Vc3PTFVvHffqO2FAeVhePg47edwVOQvJCJnzyQilWSSg5Rg4J/BgFyJreXtN3D6ig6fnUz
 BoFG7UfbLejzeTBp5kq7CAhkTs0lXqt8cl3VDGvIdmiMDWmzbprZsN6qntaoPBhTfqqETR
 ReAew6Xc7pnLnnwcm340tvd+7v+xoDU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-bpKJyEv5OWC-kNDcLgLVOQ-1; Mon, 10 Jul 2023 19:05:31 -0400
X-MC-Unique: bpKJyEv5OWC-kNDcLgLVOQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315a03cae87so488897f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030330; x=1691622330;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IA9Q76kZr4fcEo5oRA3QJtuIiFw5g8VxB1RjNQ65Hy4=;
 b=MzvAZtRYajQ4vtQadrSQtGpWkbbjNZRrLWXYEhV2lepBbHgb8qLDNDQyrfWS9LrZ5u
 xbHCuOzQd0M275TaMxRcYHR7Vld2tgb3n90XgtHIFCsmPnE6E9sw+t81KqjkKWTOHw2a
 dAg2CNMLf7mkDpRIkYf6IxVV7RzhZ8BzU8bh55+PUSBXe9TFH5o+Pzr0QGIlZ7pSCCEI
 gFA8hROiWS+OE7YNiMDlNSVt3fOQyNQ1efJQ3vTsvU0ji2Mdt+hITxg+xEnRJwIEYGw3
 j/aKRAbDV+j3sdhnKDJGxO7q80bYsQrzD2epUKvgNyV0l71UlrXJ1QewRhN5SRg0V3YM
 utmQ==
X-Gm-Message-State: ABy/qLYy1HWDZhELVUl4yunh4yBB1e5O28QMqI+I9tsrwUApGVMMIa1m
 BMn17Jrszypb/Xl2sTCsCa0ckC4VbZE2n9CYLTxPTYZXLuODLHERKO+VxzPeKUHLy8XTRlQYxQ6
 WcOPHggp5Cu5zFYmfiBeHuDanThaVS3JBQD3dL4r2IqdgIxgyctXJTFXnlfq4ovyQVxne
X-Received: by 2002:adf:fa89:0:b0:314:3f86:dd9f with SMTP id
 h9-20020adffa89000000b003143f86dd9fmr14838048wrr.25.1689030329940; 
 Mon, 10 Jul 2023 16:05:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGhVUyEmEBU4jLc+8sJMXd8ha834ZRA98HO1uMkJlnDQw14h+7/dTd57h3RuedLeZ8PZam6FQ==
X-Received: by 2002:adf:fa89:0:b0:314:3f86:dd9f with SMTP id
 h9-20020adffa89000000b003143f86dd9fmr14838036wrr.25.1689030329750; 
 Mon, 10 Jul 2023 16:05:29 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v2-20020adfe4c2000000b0031434c08bb7sm567559wrm.105.2023.07.10.16.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:29 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 64/66] vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ
Message-ID: <ea6eec497921f9c0db259445fc44429a743d0665.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Hawkins Jiawei <yin31149@gmail.com>

Enable SVQ with VIRTIO_NET_F_CTRL_RX feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <5d6173a6d7c4c514c98362b404c019f52d73b06c.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7610589a60..5cd671bfb9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -110,6 +110,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
MST



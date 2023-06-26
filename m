Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DAA73DF6D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlO2-0007Hh-Pb; Mon, 26 Jun 2023 08:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLx-0003l5-5K
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLv-0003Al-9O
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzBqSnaL1TseZeUKYXPr1J0Ht1sohs9lQERlrrRFx0s=;
 b=gP2I8VMbuYSJrHmjxh2+n5aKg4dornAvO/ar4qGm2Vsdbj5h0RwNnzT9omXU7tz0cY6Zx4
 Fgzlx85UIyAywczQubP3fq1u6+8NRy1YC2UhxCguVsExnloNTW2umAp2+JNo30Gfxpex9w
 F3u36p9ok1E/cSfrYa7BiaaTjvRlnqY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-PTtjwPMfO0aS-GvnzhOigQ-1; Mon, 26 Jun 2023 08:29:53 -0400
X-MC-Unique: PTtjwPMfO0aS-GvnzhOigQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc7ab63ccso2163036e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782591; x=1690374591;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzBqSnaL1TseZeUKYXPr1J0Ht1sohs9lQERlrrRFx0s=;
 b=edkmLFsns6UNkaxYdf+W9Vm9gxMNFCpxb79FKarC6U1t43Dn0Lw8edjKDBE3oyOpXh
 hmyzT/4w+TrCWWVs2MbF52d3WUhYg19l4r0gsBqtb1gel5xabXBwjOPD/B4PQD6dTjl1
 cInlRSE069A79kocmSda2w6vDU3oTJltWz2x7NjzHZXfw+XYeLI3jaQZ8MkO14ndwMCl
 EfHaJGWTh7K/dGmvQU/+k3OIEjc/+MWr4uHHfRaVXqMEvatBdsSbTvuVpLG5yWW6SmhX
 +6CqZFoO7waVbxPBuQKln0ginREAzgR+b4vJVjaXVfr8pa6MlDUIPtUZZRBMAUn91uCT
 lGRg==
X-Gm-Message-State: AC+VfDx8zm89yUCs2eRSB1sVfJUPKYdx5wKiUs1AQaiQmTyeP+1gty49
 czb6Re4nJsQyAIprf6BOK3DSRdsls4GYJroyadV0Ttp8vmeHyePKVJiQGJqbioWfnvwH6UNNAQl
 4BiQwqPN8XKzvTyf1GBuEA6SxtEyQ6fPuZ7EluhiskGyGKFDLGPAT5rXrgwpqo48e57A0
X-Received: by 2002:a05:6512:214c:b0:4f9:61a2:3592 with SMTP id
 s12-20020a056512214c00b004f961a23592mr6414650lfr.35.1687782591172; 
 Mon, 26 Jun 2023 05:29:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6my+CRhbN7WrZrl+Chzb/BDP67sRz6nn3/r92FcZhY8/dK/P9+kQU8vaZsaVHQTd7T6lz/Cg==
X-Received: by 2002:a05:6512:214c:b0:4f9:61a2:3592 with SMTP id
 s12-20020a056512214c00b004f961a23592mr6414631lfr.35.1687782590920; 
 Mon, 26 Jun 2023 05:29:50 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 h10-20020a5d504a000000b00313e8dc7facsm5445758wrt.116.2023.06.26.05.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:50 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Lei Yang <leiyang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 40/53] virtio-net: expose virtio_net_supported_guest_offloads()
Message-ID: <34110c875edb84a2b066683e1d52a554cf95b6c0.1687782442.git.mst@redhat.com>
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

From: Hawkins Jiawei <yin31149@gmail.com>

To support restoring offloads state in vdpa, it is necessary to
expose the function virtio_net_supported_guest_offloads().

According to VirtIO standard, "Upon feature negotiation
corresponding offload gets enabled to preserve backward compatibility.".
Therefore, QEMU uses this function to get the device supported offloads.
This allows QEMU to know the device's defaults and skip the control
message sending if these defaults align with the driver's configuration.

Note that the device's defaults can mismatch the driver's configuration
only at live migration.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <43679506f3f039a7aa2bdd5b49785107b5dfd7d4.1685704856.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h | 1 +
 hw/net/virtio-net.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index ef234ffe7e..5f5dcb4572 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
                                   unsigned out_num);
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
 
 #endif
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7b27dad6c4..7e8897a8bc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
+uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
-- 
MST



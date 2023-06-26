Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F873DF65
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNk-0006TQ-U1; Mon, 26 Jun 2023 08:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLv-0003Lo-3D
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLs-0003AV-EA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qokYyQAg0rMNcE+CO5M3YxYe0k2Y7hlwpAcrgDVYRLQ=;
 b=CN81W8QT73E0gFBq+Fm/oH8j39Pgi6GU/VpjO4cmKUoiVRXqJG902ZSH2sJ5rQmHa/pUjL
 SNGHiI3iB34YuGZYJno+DF25UnKm57bG9nGhljQB+lCQRGQYELX8jwpQkd6xHai0IPFhgM
 MS7MFN9pLlwMeHqSQGDmOODbikPf9aE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-NKhtLvkYOoOQd5EUd8v53w-1; Mon, 26 Jun 2023 08:29:50 -0400
X-MC-Unique: NKhtLvkYOoOQd5EUd8v53w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso2202726e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782588; x=1690374588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qokYyQAg0rMNcE+CO5M3YxYe0k2Y7hlwpAcrgDVYRLQ=;
 b=j4lysOCPZn3niN7Q2KO+hReHvlyAmCLbPM20R1xJff+j+LdS1bU6tKRqmt4tH1eoVy
 uAZaZBAPx/DllghGBkc80rHJLavbYuhsQDac/OIAUCUknrH+O6dTFFcCTgtzZhz4QuAq
 8Z2Eg4o/4jHEDh6ZPnx8RdhmRIOp/MT6wp8rkkT3IJGDAaNLJlrJVdw6a2hBDzg6/byK
 gh0snNSKwjTX2qZv00heuGCLdUu0qE9IGoby6MDtzkFHUp/olIKUu7JFF8PyDcznXru8
 6YpmXrlKsEZzMiBB4doxzDtWaW2mtalIYfvHebOOIwuiUbGSaFqQchiqa+/ZRy6xN2wr
 Phmg==
X-Gm-Message-State: AC+VfDzF2ZWlOi6FIbhWIoMND1Cwjo0+EqlRKvIrtYzpRKueVHIVe484
 LrBPpJA+r7Ydp++mnu5HCRULjz1RUpop8eCOisqxNqf9PJStv9kBqV4VSjugBfsyqjH3BNQufYm
 Ii0oBQukYcb+S0g2Cl/AYXeKHucP/8y0QRPopd49gkBSOKTGgws/eYYIk3JUwkF8QODnU
X-Received: by 2002:a19:8c49:0:b0:4f8:6e6e:4100 with SMTP id
 i9-20020a198c49000000b004f86e6e4100mr13881332lfj.52.1687782588383; 
 Mon, 26 Jun 2023 05:29:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MgwrLbl88tO80u/Ojk3U1gtnWFddzwpgknpnT/sJCXeAnudLiesc5Exg21JiDBH8V8uEd2g==
X-Received: by 2002:a19:8c49:0:b0:4f8:6e6e:4100 with SMTP id
 i9-20020a198c49000000b004f86e6e4100mr13881318lfj.52.1687782588018; 
 Mon, 26 Jun 2023 05:29:48 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c28c800b003f8ec58995fsm7581897wmd.6.2023.06.26.05.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:47 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 39/53] hw/net/virtio-net: make some VirtIONet const
Message-ID: <f1c58539f7151c66a8208d044b433658cafd0239.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

The VirtIONet structure is not modified in
virtio_net_supported_guest_offloads().
Therefore, make it const to allow this function to
accept const variables.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <489b09c3998ac09b9135e57a7dd8c56a4be8cdf9.1685704856.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d..7b27dad6c4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
+static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
-- 
MST



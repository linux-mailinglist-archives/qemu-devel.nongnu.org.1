Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C953709A83
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Sq-0004WX-8c; Fri, 19 May 2023 10:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sk-0004Hc-Ca
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sc-0003iC-34
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MG9QRbAhHmgPgErXXueTm6QmvHo2RMS9Zz4DxlsczRI=;
 b=I7Fb5CqLfhuLEXYfYW47Mo7RdTXK01YikMsENUoA3Lyy/3sLPWOQML/dQ7KKyE4Qc6rV+x
 INw+lT3WkSeedblcNw6Dxe885UeK1+ir1iZMatuTaxm1gdQdYtRny5adUcBxgQcSpvDMdp
 4o0RGgAUFRNQVy3APOYADLze3KvyaPo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-zOL3TX1oM-ilZpTVPhWNCQ-1; Fri, 19 May 2023 10:52:00 -0400
X-MC-Unique: zOL3TX1oM-ilZpTVPhWNCQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af23cfd23aso4547341fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507918; x=1687099918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MG9QRbAhHmgPgErXXueTm6QmvHo2RMS9Zz4DxlsczRI=;
 b=bQUMatfRyq0/jzl7Gsi2D6BQu0OLQt1ZK/ohKrk4BgYTClHozetdmCxOuU1xEy0i47
 MKHimvSRbBkMr3A4cLtbyR+LPkr1wt4Y/Mf2qzx5vR9sJsMTsLMZZSYYok43+lhIahTY
 c+z9N3dbCKrHrlAKmUwdT6HJtXiQOL6tQHd1HCWfdj/ui19728o8ZWA6RM8RcYnWMLAN
 37hzgQh0t2F2CZaUIQ3tSGP3W19019H0V+U4Jtml2evqxgYdk4gq3BeCTsqT/st1L1ou
 Zt1xl4Qxsl6j1zY+0XnqHLUCxkY0pu6zPaECm4FywDu8o9gOLIv49y1JsfPne4ih7xB5
 PXzg==
X-Gm-Message-State: AC+VfDzqEY9Hsp8rPHbSdhvHLO+JDS9SmlnhvDNjMXpn4za65kZLK+sC
 EosUMbJ4UJuGgJjSFUTKUXSDSyyH5S+FCBUAqtUL310+5zQRgl4ibwm84I3707gKIZNBSkgGLd5
 EBNIhuX6WkxhCml3iUpnluvVueNfowrmCAhiMKDgw0zqu//1vBwt5bcIgb9Ac2PUaKdi9
X-Received: by 2002:ac2:4949:0:b0:4f3:93ec:ffec with SMTP id
 o9-20020ac24949000000b004f393ecffecmr849230lfi.63.1684507918301; 
 Fri, 19 May 2023 07:51:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HVWKWqDquqjB68SkRi0XayeTIIqLw47+ZAGD54wq30UHaC3l1/gyCaVtWhP/X8DrkxMYkYA==
X-Received: by 2002:ac2:4949:0:b0:4f3:93ec:ffec with SMTP id
 o9-20020ac24949000000b004f393ecffecmr849219lfi.63.1684507917942; 
 Fri, 19 May 2023 07:51:57 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 x17-20020a19f611000000b004eca2b1c5b4sm622290lfe.229.2023.05.19.07.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:57 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>
Subject: [PULL 26/40] vhost-vdpa: Add check for full 64-bit in region delete
Message-ID: <2fbef6aad892a3e784041fc5a6d5f5bda0565464.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cindy Lu <lulu@redhat.com>

The unmap ioctl doesn't accept a full 64-bit span. So need to
add check for the section's size in vhost_vdpa_listener_region_del().

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20230510054631.2951812-4-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 92c2413c76..0c8c37e786 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -316,10 +316,28 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         vhost_iova_tree_remove(v->iova_tree, *result);
     }
     vhost_vdpa_iotlb_batch_begin_once(v);
+    /*
+     * The unmap ioctl doesn't accept a full 64-bit. need to check it
+     */
+    if (int128_eq(llsize, int128_2_64())) {
+        llsize = int128_rshift(llsize, 1);
+        ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
+                                   int128_get64(llsize));
+
+        if (ret) {
+            error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
+                         "0x%" HWADDR_PRIx ") = %d (%m)",
+                         v, iova, int128_get64(llsize), ret);
+        }
+        iova += int128_get64(llsize);
+    }
     ret = vhost_vdpa_dma_unmap(v, VHOST_VDPA_GUEST_PA_ASID, iova,
                                int128_get64(llsize));
+
     if (ret) {
-        error_report("vhost_vdpa dma unmap error!");
+        error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
+                     "0x%" HWADDR_PRIx ") = %d (%m)",
+                     v, iova, int128_get64(llsize), ret);
     }
 
     memory_region_unref(section->mr);
-- 
MST



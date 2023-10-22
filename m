Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C162A7D2220
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfR-0000Zp-OE; Sun, 22 Oct 2023 05:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfP-0000S0-5y
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfE-0000Cx-7M
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thscQjX5d6rsLU3psVlcnXGZdg35cG2DFqaiwAr/Wqo=;
 b=GitLNnVM4W6H8DyWgkxGJZgvS9Pr5YydX5br2nEBkKwdlIjQMrNgHFwleSj2xHKFYoyg6E
 evOjXjFssHUYnW5AW66eAz3/ZKrINdp2GqfgEwd54z8TP6eG/mC1Cq0YWS2LbRDDw57thk
 Ow9jYeIFKjUzYhKhITD1S8I4cUzk8YI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-AznYlAOXPxW7I0HlE3Zf9A-1; Sun, 22 Oct 2023 05:22:19 -0400
X-MC-Unique: AznYlAOXPxW7I0HlE3Zf9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083865e0b7so12714045e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966538; x=1698571338;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thscQjX5d6rsLU3psVlcnXGZdg35cG2DFqaiwAr/Wqo=;
 b=YzhI4zaCTeNiCf6qXpRDUBpM6YZNmRNnm9oNceQydMPeajLBsN0UNi7KdFvmMjSydm
 6S+qjUXTb17tb7kC2iMH/inHxipigyOJGpcvcsNEAmUvaUmJOUqNTT0f/br/VWDS8brl
 TDEnjJRxvEP9CzNu0acy6h42j+Rk0bJHDiKAGntN32T47eX+JlsldASXCcgosodkBshi
 7Uf7CZjsQqkIFblnLhq+j/8AruyUCyZstf2A2ZW3yg8vcWFK6ZAYwQ7SPwiSBft67mT5
 j+fgVf0YL+RM5zu/2DaR5nd9CcUw5MJgKoxzGmw8oai924UlUQwskvz5D2pxpzbj+Y4D
 0C+g==
X-Gm-Message-State: AOJu0YzlrefdhKf23Ojo0C5EV62S95Xca8UCZyGvJtVDb6Sswds8a1vO
 j7qaQpcOfhHrhN497cG4MlUCXLp3UAKERMewLspTiC6e1LFLkG/oYD4atx4sXIBo900R9JFWi2q
 aC8bMFx6Ly4P2XOLflM9wRCuEAR03EfJLwJ+ryUKUrZ1RX4qaoZKbaBlt0daxRTXUIatF
X-Received: by 2002:a05:600c:470f:b0:405:34e4:14cf with SMTP id
 v15-20020a05600c470f00b0040534e414cfmr4842114wmo.4.1697966538063; 
 Sun, 22 Oct 2023 02:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX9+F2y5/9KC2HUKB+m2JwvImjXRvvGod5n/HvGGnPWEqw4v/T545jXtjdoNmb2BPGWPRVeg==
X-Received: by 2002:a05:600c:470f:b0:405:34e4:14cf with SMTP id
 v15-20020a05600c470f00b0040534e414cfmr4842102wmo.4.1697966537766; 
 Sun, 22 Oct 2023 02:22:17 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b0040472ad9a3dsm6444643wmq.14.2023.10.22.02.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:17 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v3 06/62] vhost: Expose vhost_svq_available_slots()
Message-ID: <99d6a32469debf1a48921125879b614d15acfb7a.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

Next patches in this series will delay the polling
and checking of buffers until either the SVQ is
full or control commands shadow buffers are full,
no longer perform an immediate poll and check of
the device's used buffers for each CVQ state load command.

To achieve this, this patch exposes
vhost_svq_available_slots(), allowing QEMU to know
whether the SVQ is full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <25938079f0bd8185fd664c64e205e629f7a966be.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 1 +
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 5bce67837b..19c842a15b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
 
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
 void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
                          const VirtQueueElement *elem, uint32_t len);
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index e731b1d2ea..fc5f408f77 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
  *
  * @svq: The svq
  */
-static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
 {
     return svq->num_free;
 }
-- 
MST



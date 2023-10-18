Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158A7CE1CD
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rp-0004vo-RF; Wed, 18 Oct 2023 11:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ro-0004vO-BL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rm-0006Mp-TB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thscQjX5d6rsLU3psVlcnXGZdg35cG2DFqaiwAr/Wqo=;
 b=R4JhmTo0zSgL9+j/en6NCjQYAdLPKExfcBU4g34X53605SFIx6Oq7/VJ4rih/cVUq6NQN+
 9kfd6LamXNEVqPJ8UZB7kiV/h/FeCuUBe7tMmN31JHI1LZajRPxB2dKmX63bHlUFQN2czy
 DSFwUhY2MGWFT554Yj+Wz6Rs6TtMGPQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-1GULOs7vP-mcXnBW2rj2Eg-1; Wed, 18 Oct 2023 11:53:45 -0400
X-MC-Unique: 1GULOs7vP-mcXnBW2rj2Eg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so1648395f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644423; x=1698249223;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thscQjX5d6rsLU3psVlcnXGZdg35cG2DFqaiwAr/Wqo=;
 b=WOJiC/S2jb33VtgZH1hqlDEIjjIRdwNPPGmZNz1usfBymsBveCZO0kVh26z1I7Wo1B
 kPQVGNY7ZdJY5o5PglBozC75tmXez2r6FPOpEmZGO1W0LnwWIljCf5MVMXYQFgL/8Vxm
 lXkJVZxTiqQK54CuEYbDCmFlagDxlKF3t4e8E6vMVk9OXsQguv8BOPIrOGj48JeF0VzW
 ugJInCnxZlUX5xVO9pGjNbvcHCCFaec6xKwbfBs3yFbHeDIw6VsHSGWzJgMc6TEnqfTT
 8afcGg51XJjLSmCp6cGi4cgOVtHCbxwUdfwXRj4v3NZUcuyY/bTvAOct6rLLZefmjYjk
 dNNw==
X-Gm-Message-State: AOJu0YxVS+/wit+l2FCfCjmYYqkXLMVo0Etf19XsID9KE5kPyNv2AfbS
 XFXBilH2S5fIzMr8DQsvc/19ozuPtUF3q6BPTn2MoFVLO/yhQ0I3y5BbvayBzYxk4u86E6UlWd/
 zyBzjyhrZVMn6Ee2fLxH72Lrw0nG83ur/Oz0Zs9aTvlMVVhiN4e/FWEKWQO7g6C/1JvQE4Bk=
X-Received: by 2002:adf:a29c:0:b0:32d:a431:9045 with SMTP id
 s28-20020adfa29c000000b0032da4319045mr4707444wra.30.1697644422845; 
 Wed, 18 Oct 2023 08:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf2j6pizQYXlznqRKiP3MuRvUmFArvLb8S2+NTOyoOL4BxBb9053iTrLh17NG54xuimXNmaw==
X-Received: by 2002:adf:a29c:0:b0:32d:a431:9045 with SMTP id
 s28-20020adfa29c000000b0032da4319045mr4707429wra.30.1697644422572; 
 Wed, 18 Oct 2023 08:53:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm1995276wme.9.2023.10.18.08.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:41 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 06/83] vhost: Expose vhost_svq_available_slots()
Message-ID: <99d6a32469debf1a48921125879b614d15acfb7a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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



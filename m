Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D876F59B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRggi-0004Ev-DI; Thu, 03 Aug 2023 18:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggf-0004Dp-V8
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggd-0000O9-Oi
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BZ5eZ81+5jW0TNORG8mc8ZgUr+TZWKsdfQFMi6wlRY=;
 b=i3/JK53SUXv9tlhYgv2sMAhB+V2u3IngVKuW0uAi9UMjSlCTbkK+fUeaihaMGmcTwxWYVU
 h3PCRCTPlKG+llxOCbtS/BL2VAmL7mMfkGXpJ2KDRh5gZBDbPWVgGLQISpPi58ZPsL6FC7
 BB7uUe8wmipPF1DWtX8jyYFYojA8Tus=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-I1Csau2WMKqwPoR7JMP4bQ-1; Thu, 03 Aug 2023 18:20:49 -0400
X-MC-Unique: I1Csau2WMKqwPoR7JMP4bQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9ba3d6191so13708221fa.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101248; x=1691706048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BZ5eZ81+5jW0TNORG8mc8ZgUr+TZWKsdfQFMi6wlRY=;
 b=I8An6Gyo1P/RyidgQXkdWCU4tIlL1TcKZXWqrudI3o3QbeD9D49OZ8QcuR7zCQVC3H
 p9+vXvmFOaA8Go7D0FFHzxEZbvXH0uAlaK0BYW+xKuagux8P76a6rPB/lKwy0WhGRSnE
 YXaF4djxk//VMXAm8b5Cymri78/YO8ESkxPgwRYwksZsBfMg0pzBEPUFMCNgLk5nr5OZ
 /E2DT2zwkFrCsIhU3dY8NtPFiwZuWM8hXhyxTVCEVZxDkL/2oj4ur1iie2gUEE/UnDzW
 jeOxd23nzzWzRP+PwJmBrmlj8H7AGnhpq3YvIMySNF3hxt0KxihCP17rniQXxLGwW6E9
 8gaA==
X-Gm-Message-State: AOJu0YwOZhdJmoGDQErQtr5aJ95FdbXmmFU2X+rmFb5+Fxl76ki/kdjv
 NlJ/M0zXDSgaODyb2/RUO5ntAOai/Ixvrcb2Un7ubEm2zNaVd5yVvVDJTylm9LJWEV+bSsOX944
 sHzo1NlLBA47TSYZy61Bmq/1gtzP/A3db1gI1OwKk2BwowNsgg0sTl6EFFOlBU4cmV053
X-Received: by 2002:a2e:984f:0:b0:2b9:ac48:d7f5 with SMTP id
 e15-20020a2e984f000000b002b9ac48d7f5mr79596ljj.39.1691101248026; 
 Thu, 03 Aug 2023 15:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk99xMKZrgQzE3mczdZ/06KdsBKfhhBnfKkt5f39GNqnogOZNDZJOeaRVqOcaAcw5hBS0gWQ==
X-Received: by 2002:a2e:984f:0:b0:2b9:ac48:d7f5 with SMTP id
 e15-20020a2e984f000000b002b9ac48d7f5mr79578ljj.39.1691101247521; 
 Thu, 03 Aug 2023 15:20:47 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170906284f00b00992e265495csm367642ejc.212.2023.08.03.15.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:20:46 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:20:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org
Subject: [PULL 01/22] hw/virtio-iommu: Fix potential OOB access in
 virtio_iommu_handle_command()
Message-ID: <cf2f89edf36a59183166ae8721a8d7ab5cd286bd.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Eric Auger <eric.auger@redhat.com>

In the virtio_iommu_handle_command() when a PROBE request is handled,
output_size takes a value greater than the tail size and on a subsequent
iteration we can get a stack out-of-band access. Initialize the
output_size on each iteration.

The issue was found with ASAN. Credits to:
Yiming Tao(Zhejiang University)
Gaoning Pan(Zhejiang University)

Fixes: 1733eebb9e7 ("virtio-iommu: Implement RESV_MEM probe request")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-stable@nongnu.org

Message-Id: <20230717162126.11693-1-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 201127c488..4dcf1d5c62 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -728,13 +728,15 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
     struct virtio_iommu_req_head head;
     struct virtio_iommu_req_tail tail = {};
-    size_t output_size = sizeof(tail), sz;
     VirtQueueElement *elem;
     unsigned int iov_cnt;
     struct iovec *iov;
     void *buf = NULL;
+    size_t sz;
 
     for (;;) {
+        size_t output_size = sizeof(tail);
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             return;
-- 
MST



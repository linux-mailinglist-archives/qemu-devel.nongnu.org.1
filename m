Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61437CE1CA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8sF-0007rK-ED; Wed, 18 Oct 2023 11:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sD-0007oz-JQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sC-0006Pf-6u
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6cMudFJUQ+3yuyqk3PBF0ExHMQrvBzp4Se77OWthFE=;
 b=huCeHZ/CCHwxdjq6+jG9hB0WhsYAhc+2M1PKZ/uHkcbCVlMhqSdHIM6gMd96emwbPhLwos
 5Zt8XpAU6+EMqzV8YyA2FM5LgzgzN9I6s/sj9q7QgmTjtMet6ef77SEX3z1iVwQkj/e2iX
 YAI7y9zasCiwlYfPCRq+LHqjfj6mZxQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-9YuwAtsPO-aJV5duiG1adw-1; Wed, 18 Oct 2023 11:54:09 -0400
X-MC-Unique: 9YuwAtsPO-aJV5duiG1adw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c504f93c4eso54844601fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644447; x=1698249247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6cMudFJUQ+3yuyqk3PBF0ExHMQrvBzp4Se77OWthFE=;
 b=UwuOcOpWd5lCnL/Nr8BdeIv7bbOJ+l3bOP2O7BD6OUdtAvBGmre400sArCDhUdasud
 fXm1v5TP4bcWFyJcAwsiiHW3OM1CGNdxXemMqbt6+ZC7Ij6ydNqaAGWEhhEASgcjmwlB
 yOPAIVq0iUgd8JclrXZ9bjZeb+ActhyYnSpGy/aAtBfOk8UeHoUV+x2PdgfNa1Xmc8sr
 vURKMTbyWD4U9wvZFT8njVn1cPE/DMv8BTOKbrkcTWOWNTdsv55hO5+NtfYywJJRjzCl
 i7XX7w9cYN78rceqaBpjkpwtseow3ebSz7zP0et0XKNhL+5DKvooKXYVksBzO1mTnGu0
 SeJA==
X-Gm-Message-State: AOJu0Yyz3OR37CSoAJxR5WJyXVuCdUTEyT5Wbr578+y/uGeB25P6NZXJ
 j4Vg/xfcF73Bndi0ALXthYq0MkulfN03rgngRkY5Lph6yjhegZFiOmz03XyvKzocvdBCFxRiORA
 WlKaaK8AMniE7695Fq8fn8HO6tZVc9os7AjBCKY4LzSSjneppSVO2Cl/CZZUvf1j6comvkpg=
X-Received: by 2002:a2e:920b:0:b0:2c5:aff:f936 with SMTP id
 k11-20020a2e920b000000b002c50afff936mr3895536ljg.53.1697644446838; 
 Wed, 18 Oct 2023 08:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdTg+LWtmsQ+LOFs31BequBF8aMz2RnX499+nnOJOrvTv7AmD+Y7ypjf+DCZgQauGMPXltiA==
X-Received: by 2002:a2e:920b:0:b0:2c5:aff:f936 with SMTP id
 k11-20020a2e920b000000b002c50afff936mr3895523ljg.53.1697644446559; 
 Wed, 18 Oct 2023 08:54:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a05600c459000b00405391f485fsm2016052wmo.41.2023.10.18.08.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/83] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Message-ID: <aa3f4bcf7ea05df09c30b193e752b2d71db06148.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Enable SVQ with VIRTIO_NET_F_RSS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <2d2a378291bfac4144a0c0c473cf80415bb580b3.1693299194.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 846457129d..b2ce6ef986 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -122,6 +122,7 @@ static const uint64_t vdpa_svq_device_features =
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
     BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
+    BIT_ULL(VIRTIO_NET_F_RSS) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
MST



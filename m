Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A57B7A78
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUP-0003zb-Qv; Wed, 04 Oct 2023 04:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU7-0002xp-Pb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU5-00012l-7u
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZAf5QAqncqN0Tj7r6/rT3sDH9P2a7sWx1zkWFPC9Wo=;
 b=eGycRtCdRUkF1Q4ggycMj3C9mp2HHgfJXPIlGdbGl6Ryd37Dki5XXNhg2qn6Yb6V+Gjz+m
 707+G5MqHvnKrKMfuq/GpyYXqfMSYTS9ZKx8FAOhnm5PrxMkk3LOK1/rVFm6SIQbUyewtn
 RV9YNcVNRPtMZ2MH2SUP7uqNxxjgQmI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-D3y6IqGCM1iFmAEnAdCaIg-1; Wed, 04 Oct 2023 04:43:54 -0400
X-MC-Unique: D3y6IqGCM1iFmAEnAdCaIg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32337a3929aso1338186f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409033; x=1697013833;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BZAf5QAqncqN0Tj7r6/rT3sDH9P2a7sWx1zkWFPC9Wo=;
 b=bCFob36vYJXcHibhQBVthGzDleerC5SXxmgKWhhCi2+F0LaHgm3wxPnUdOrz/TnNhm
 df3MIwWl+Z/555I2Ty40CfinlKKjy4pO6TonupWDBEuFSRKm3i7C+jNaFoZhILh7Y2mc
 xl2fwJVyQ56+q0r+NL6WqsG9Y04RFEsx5AWkyHPfzmGE52YIimNu1kYizWCZ0uboYrsp
 hgV+XG6vHYBMvWt0dZh7WrG6bR4Aw18vGatCUsnXzUHGna7IIK2/uGGKSD0PGBsP8y+O
 nm6E7oNQEpHIgaUvav19i9w5oPlrFOlaDyrmIfNtId8DzYlivSF9NclgF0QCrgYqBn2L
 8wAg==
X-Gm-Message-State: AOJu0YyVdO3Wsb9Ud+iysHVXHtyNL3Vo0wJIBwhhGpv61vIdjTVLJbHu
 mmvdsv9blVBLtSVVej+vr0Y4BayZNtr7R0LJwger6gpJibi9BQi1BarxCAGxmq7ESk2egUjo2Az
 HsLgkt1ZBxPGktqEtSTZUQoF3XkqDNA0tgbzyKIgKdnlH3W2Flqj28y94pavSIZhXVDwo
X-Received: by 2002:a05:6000:1246:b0:317:6513:da7e with SMTP id
 j6-20020a056000124600b003176513da7emr1399235wrx.36.1696409032850; 
 Wed, 04 Oct 2023 01:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3PB7nG7WAY5Zn5R/k9WkIjnL/RSTsK06HOljZwYcQtwKO0c/jXxC0zs4E+Tgdl4B3UKxgVQ==
X-Received: by 2002:a05:6000:1246:b0:317:6513:da7e with SMTP id
 j6-20020a056000124600b003176513da7emr1399215wrx.36.1696409032501; 
 Wed, 04 Oct 2023 01:43:52 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 q3-20020a056000136300b003176aa612b1sm3444256wrz.38.2023.10.04.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:51 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 13/63] vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
Message-ID: <dca8356716919e855c8f50baec86e3bdf51efb5d.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

Enable SVQ with VIRTIO_NET_F_CTRL_VLAN feature.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <38dc63102a42c31c72fd293d0e6e2828fd54c86e.1690106284.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 8648d86f64..144b33f997 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -114,6 +114,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
-- 
MST



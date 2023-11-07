Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B13267E3877
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J39-0003qd-6U; Tue, 07 Nov 2023 05:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J34-0003AU-Nx
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J33-0002VB-1t
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk18UFl3gvhVFvUPc8Rke7I/hKZLNs+l/lUgUAmltCE=;
 b=O06KqB7DZJzxUeZOy9DMCHRntf4JKMTvB9y7h2INS5MokLK9PK0MLKSNVgjXmjbZyberwD
 dH1wXs1TV8y1viCzysm7f4wxW3ZyYBQGCSQhSF/1gaDrcSx2NUpFhZlmsQ0dO0iIh9c6Hu
 9ZlX1vYsviYiF2fjH8JgR9YzfK2E/zE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-_Fp8CfstOm2eafQoP-7JmQ-1; Tue, 07 Nov 2023 05:11:03 -0500
X-MC-Unique: _Fp8CfstOm2eafQoP-7JmQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50911cc75adso5930542e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351861; x=1699956661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fk18UFl3gvhVFvUPc8Rke7I/hKZLNs+l/lUgUAmltCE=;
 b=pZM9BPuOf74LVqPGEq2nykM4fN+BPq+W54tZh3Y5Oq6ld5D8pw/XvLA07MJY+21QY2
 G85t2f31RAd4nO+d7FSQsPeU/WeImEPDtmShffhICi5YA445Nh4DFi5LBl8Hy/TVc8If
 XcygefGA0Zy6Wez8yeYuUeUrYyoUgc/eWIZc8RJbwMyRov0LtAs/g1AIaMQ1eg1W9BBd
 J/Hbn+Xmg3Mr9Nn4Hot1kPltYTQWiIqCuxKzvT6VZs/kFGJNaUuaCk3dnPou2tkNHgiU
 pk/YYc3aAo0UG8tP8nSM5F8DJ+5C+Og+Nm69N0wXabKmhGIxcP0B4y5EprdSTsxWpV15
 TBEQ==
X-Gm-Message-State: AOJu0YzSm5Ujr3ikX7vUl2WUarv0u69e2Uzv18jq8pmMxfPbrXwKkTn2
 HFuOuApL3ICuQn9WM2NM75FhdHtlnGKyXUqcaP5/6x+A84ox15U/aBv6s/hK52qa2aezlxCD0/J
 d5rWFb/SuMCm6edTtEnw+HnFHul2OWBI4OM1m+7OjBBWysJ3qYO54o5Vfi1dwB8XqzveG
X-Received: by 2002:a19:5f50:0:b0:509:31e6:1de5 with SMTP id
 a16-20020a195f50000000b0050931e61de5mr12992025lfj.47.1699351861152; 
 Tue, 07 Nov 2023 02:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERbotreMh5K4WhsdOjBYGvmUrAemMBxp0MEtAxkvZgQSsZlinmB6D5CIqHsQQqwi8FdqZwgQ==
X-Received: by 2002:a19:5f50:0:b0:509:31e6:1de5 with SMTP id
 a16-20020a195f50000000b0050931e61de5mr12992014lfj.47.1699351860866; 
 Tue, 07 Nov 2023 02:11:00 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 t11-20020a5d49cb000000b003248a490e3asm1903339wrs.39.2023.11.07.02.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:00 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 20/63] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
Message-ID: <556b67d413a699431eadb71642033864649ea934.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

Enable SVQ with VIRTIO_NET_F_HASH_REPORT feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <d66b0aee501cdad7954231900c35a11cad1e13db.1698194366.git.yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e59d40b8ae..54f748d49d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -121,6 +121,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
+    BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
MST



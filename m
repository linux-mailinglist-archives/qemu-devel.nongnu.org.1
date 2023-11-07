Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E97E38C8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J8a-0000us-3c; Tue, 07 Nov 2023 05:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J8X-0000hC-Sv
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J8T-0003dr-8W
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNKgVV/wXkTDvg8p/RE2Zx3f5TGpx7KpGUcSvb+K8Qk=;
 b=J0G9547spEgzqRdGmszhrKd1Ugec7KhJiyL8Tf4+1we0kjZ3ip6fhqZct8BrwqmI+zK8zj
 BeM1TjRGjypOhFWBxeBpgk9kxz+f2MYXE3dwiVhjCSXX9sDbZ6X/QEebpD6wR9hsUW5TNF
 3XtAD+SU++LCTXuKm2Yu2Bg6jqI+PkA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-CG696xNKMR-u9EvhZXrAKA-1; Tue, 07 Nov 2023 05:16:20 -0500
X-MC-Unique: CG696xNKMR-u9EvhZXrAKA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so35155275e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351874; x=1699956674;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNKgVV/wXkTDvg8p/RE2Zx3f5TGpx7KpGUcSvb+K8Qk=;
 b=fNcVNNrsqy8SlUafb1MPhw2DxpElIHZ4WSSM5jR880SYMDWsR94+QbhBoRlLakdugz
 zsDzQZE6u2oQcOjrS4wKI0NprGcDNybRCxCA+5wF7Gghj/xEiTBcC95Gi2LYDRFiqmhI
 JHLXXzlY4ySPyQ8GV2SgaKsGmOuLw3XbYVEWNZ6SVsWt4Oncxownhrxah3ydhIv+deBt
 dpkZkkmG4njLi605BrSeB0M8S9HZo5Akn7UkP3MAZCw/rgZhzLUHrJUtwrgIyen74JlQ
 w8k7lMnajht6+ZiO8Hcv9qeR3ZfjDuHg44VDSwZeXDv9FwMk+X0Q4YXeVwGvHKCC3xtm
 87Bw==
X-Gm-Message-State: AOJu0YzVEJLJyWl4eFo5S7PHd2nwb+hshwhQXoPgZ1sIeumMVfTEbfsN
 gQs4ulbpHhjb1HycumDbKyIZQsWKXW2fYMyHoKaDdTZajonhF/79xcQFFYLYi4aJUnnxiWgC0Ad
 I1xPhRPMZn3HmaIcURWu9glgKAibuOSUZTpRojoCHriWRxZmfeBBkPPMrx8wv6fbhazcr
X-Received: by 2002:a05:600c:1c81:b0:405:37bb:d942 with SMTP id
 k1-20020a05600c1c8100b0040537bbd942mr1893411wms.4.1699351874242; 
 Tue, 07 Nov 2023 02:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh1DBQy7P1tILj5m5O3Ch3CInT8NzIJfYCOvQgWZSkGu5SCXFXrTlvzZaSJ0PvRZ/85xHSYQ==
X-Received: by 2002:a05:600c:1c81:b0:405:37bb:d942 with SMTP id
 k1-20020a05600c1c8100b0040537bbd942mr1893394wms.4.1699351873954; 
 Tue, 07 Nov 2023 02:11:13 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 fc13-20020a05600c524d00b004068de50c64sm15358374wmb.46.2023.11.07.02.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:13 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 23/63] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Message-ID: <07eba9493d14b3ba371e64392effc384246892ea.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Enable SVQ with VIRTIO_NET_F_RSS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <626449eb303207de408126b3dc7c155cd72b028b.1698195059.git.yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a4cc1381fc..d0614d7954 100644
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



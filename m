Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39A7E3881
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3J-00057k-Cp; Tue, 07 Nov 2023 05:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3F-0004kF-H9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3D-0002Vx-Px
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bpj29tXiqgLNxsD0wsJlUZ9eT5lcs0B4elp4WPlk0FM=;
 b=bag04e9Nu1VlbCffCFypqK+dj/T/K6iPGxjujrcM4v1b1edFIRc5lPWNuwki/okfSZXski
 VUNNdJUavYnUxLOvG0YHHtgiB4y71WpD3hAb6ROHmdWp1In11Qa6Yl9sSFN9c18mPc0Lxa
 Lqe068flOEYXOHwv+TcdcsrWV7UkM/o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-wXL2WF9UMM-iZVzF8vUhJQ-1; Tue, 07 Nov 2023 05:11:07 -0500
X-MC-Unique: wXL2WF9UMM-iZVzF8vUhJQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50bebd8dfso53492471fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351865; x=1699956665;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bpj29tXiqgLNxsD0wsJlUZ9eT5lcs0B4elp4WPlk0FM=;
 b=mx4kp/PBoKrB0AjXKZgzsbyuS38ngsMThj+BfIY4OemcbNS1zVnXeBvdTUvfzlrKCx
 Wy61xgXUgVDY3vyTWkV664887+Emm8VVFXgRwgmjxlqHj32U8N042FyeoWo+k1FWRWG4
 jxQ31WmE+YGgHYv+/Q/nZAO0ne/nhQ9mkjNYCUimVh0TntBdHhf9cCpsFoYy3AOlynIq
 xoIBqcUqp87+y2ETiXMDNLZzZ7titD54iREbIDPEGnTSKrT/2AOfK24L67OWCMpUn29g
 DQzN6D9oHomufHYX5Pf98p3zASW5R4fMHBKYjwcRjk3owTzZ7FKQKjqmK6RglsK3Ntb+
 cOpw==
X-Gm-Message-State: AOJu0Yy32e/8NNzKbRJzYOOB3lN4SKZC6VClSPXwOVeg6MpZL0NR9UOq
 57HWVXW03bIJjfzE6E6Vf9NE1szquArWjiuSl5eGtGOZ20pFcfQgyPPLzpKgP0svM7UbsUM0fl+
 fyTVUczq07elfWvDDqfLzM4xblGl8gw/lUkr2DyRd6r9grLdRuwmfH0LBCsl3UnI4E/l+
X-Received: by 2002:a05:651c:3cf:b0:2c5:1f30:ebfc with SMTP id
 f15-20020a05651c03cf00b002c51f30ebfcmr23050911ljp.38.1699351865385; 
 Tue, 07 Nov 2023 02:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCUPlFMIO3qEUQ/ZSpq2ok2/OqNQOmKDBFrq3mrkbzCDuOR3Db6sa/FNZl25b6gW/wkw2pSg==
X-Received: by 2002:a05:651c:3cf:b0:2c5:1f30:ebfc with SMTP id
 f15-20020a05651c03cf00b002c51f30ebfcmr23050894ljp.38.1699351864967; 
 Tue, 07 Nov 2023 02:11:04 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 l3-20020a05600c4f0300b003fc0505be19sm15233367wmq.37.2023.11.07.02.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:04 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 21/63] vdpa: Add SetSteeringEBPF method for NetClientState
Message-ID: <d1fd2d3118a42f36d86efae7ffbdce79f7024584.1699351720.git.mst@redhat.com>
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

At present, to enable the VIRTIO_NET_F_RSS feature, eBPF must
be loaded for the vhost backend.

Given that vhost-vdpa is one of the vhost backend, we need to
implement the SetSteeringEBPF method to support RSS for vhost-vdpa,
even if vhost-vdpa calculates the rss hash in the hardware device
instead of in the kernel by eBPF.

Although this requires QEMU to be compiled with `--enable-bpf`
configuration even if the vdpa device does not use eBPF to
calculate the rss hash, this can avoid adding the specific
conditional statements for vDPA case to enable the VIRTIO_NET_F_RSS
feature, which reduces code maintainbility.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <280e20ddce55b6de60f1552ba0865bffffe909b2.1698195059.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 54f748d49d..3466936b87 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -241,6 +241,12 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     }
 }
 
+/** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
+static bool vhost_vdpa_set_steering_ebpf(NetClientState *nc, int prog_fd)
+{
+    return true;
+}
+
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -423,6 +429,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1258,6 +1265,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
+    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
MST



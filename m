Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E647CE1C8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8s2-0006AF-Mo; Wed, 18 Oct 2023 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8s0-0005yj-C0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ry-0006O5-Kx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3Kt9GF/nMSDGe9SBcVzHg8nLaKvLM1MYgeTx0Otwtk=;
 b=WZ0n9Ah+oBjL8zJfJtZysisDpw4+frdESf+4IZaY29nKgLnUJCjxntIruDBN7gC4vK6XjQ
 siqYOHRXM4PyBEUh/kIS8iyvcsWyF7nGvEEgP56giWeEmTPnEHnXKKsrpsjfknj5q0pzQb
 vpRpTO3ZBcfh19jIt0e4J9WlvoKFsKg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-xgF5f9KFN8O3kUTJtUiI0Q-1; Wed, 18 Oct 2023 11:54:00 -0400
X-MC-Unique: xgF5f9KFN8O3kUTJtUiI0Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d83fd3765so4283280f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644439; x=1698249239;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v3Kt9GF/nMSDGe9SBcVzHg8nLaKvLM1MYgeTx0Otwtk=;
 b=QkcMJR+vBp+QRLc4XBPjuoosc7iMEENhBx/UyEucYWRgR9B7cgQqpkWy9UR+tHYxS9
 Jx/RAhTRfYQAER/XmBulfeZRwaoP2wUlkIG9+iPDCWs2WU7ggIx6sj/eeBivMCQDtBn7
 chz4zHlakT42SDb36VPkBkDtv4scn4t63lNZPhS7Qx8xwzgZkZIRuiL/0xCbJlyRY7y8
 JMqxnka0YMqYKLuEtEbOnLcFqmPNGBXrGcyWjYm6mSN3sQcD5ibD9Onn2FO/Ei1sdnNs
 yiiN1jYaWIEadSyI/J/ZE35Dz2/Q5rbXS5kpLZBnf60YuVqyO+XugEjSkFLCxKVgjnqQ
 Ebng==
X-Gm-Message-State: AOJu0YxBsXS4oJyr3ayEDQBfE0Ho/I3VUVKjt+Y/YKaTTbCp9LYPrvxk
 e3F0jmOqcl6a6krP6jYjthUcSt7fssRyXe6k/kqH6/xzgv4EBr8W4BUFtL8wWfLtkXtM0Q5KayC
 LLGLWXj3iC0W/XRjWZobWZWvTI+SzB2Sgs/Ljt72vwNOWA4NWjkZ0pf0VJq8Ap7/BFon/BEs=
X-Received: by 2002:a5d:608d:0:b0:32d:9d0e:7841 with SMTP id
 w13-20020a5d608d000000b0032d9d0e7841mr4365843wrt.6.1697644438854; 
 Wed, 18 Oct 2023 08:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gbyRcdbIWFAgM5oZzVlppyniUdkgIa+YQxMhxD/p7e6jz4DPPW8BZ5vYyJnuYu9ibCJQeA==
X-Received: by 2002:a5d:608d:0:b0:32d:9d0e:7841 with SMTP id
 w13-20020a5d608d000000b0032d9d0e7841mr4365825wrt.6.1697644438546; 
 Wed, 18 Oct 2023 08:53:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 o1-20020adfcf01000000b0031c52e81490sm2424436wrj.72.2023.10.18.08.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:58 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/83] vdpa: Add SetSteeringEBPF method for NetClientState
Message-ID: <d81b1e625ed823096e173e92b91d56f825d50fe9.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <30509e3c3b07bcadd95d5932aeb16820cb022902.1693299194.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 66afa34237..ef48b6e816 100644
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
@@ -422,6 +428,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1257,6 +1264,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
+    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
MST



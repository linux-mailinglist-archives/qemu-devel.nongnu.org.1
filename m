Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7506974E200
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwj-0004FV-Ga; Mon, 10 Jul 2023 19:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwf-0003eG-9a
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwd-0004tf-RB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQNmObWIEytSrAM/8yu+agFnazGV0A9drwm3zFDQ0PQ=;
 b=XdzN39hFmqvSJXChgYHfKnFOF8lci+R/GV6gEOgk7SQVTsCu7ov0lePycpZZfqI1L9Su6K
 xyAbF9k9VvjcYQaNN2ituFGQ345TPesjCQidgG4k+HCd7iY4DpRO9C95xkSUxn7qm/mKzN
 IMNlnKVnMUN1Q7NGx5FaPHpZ3jd4x9U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-lQ354izxP2CRTukUlu3Sfw-1; Mon, 10 Jul 2023 19:05:26 -0400
X-MC-Unique: lQ354izxP2CRTukUlu3Sfw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3142665f122so2947798f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030324; x=1691622324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQNmObWIEytSrAM/8yu+agFnazGV0A9drwm3zFDQ0PQ=;
 b=R2J5ybqlojaM57RKjKSmXQpcJ1d41/QoL1aMmgIVJ+mF7H+9VtveXB91HUWy+nwlWQ
 BzJbqM969zTQp7kZ5mg9CIdELnxjwIRekwPN88bbPgJ3Uvjdw46h4avCKdhLCzX0eyh2
 27iDvQXgMVgmdHg0BBDOgnflfXMLSPKez01nj4ndpu/d0DOM7VkgAiRylXrc7TtaUtsl
 K2gqdD/MLDdoVFBNb3k9tDGdAkkvSb02NqoMFcSHnWN1Ks588AobhwOoLa6Wr6/xTlm4
 p8VJBuyB7EQ3Mx11S9QDGBA8TXdNB3hEVvGu8lPZjDcTIZeGhvz0CIpnwrDEj1/RsHjQ
 7FAg==
X-Gm-Message-State: ABy/qLbIXDRO6tLEqVt8NJyXk+BWC2W3OZAJdDCB4qTW46S7n1YHPGQk
 KkjirZUmJzyO2M+Aemy4mjFhlFAvU+wlObBvLGBEzAnQd12u6+Y25atlHuye39+TSRUiCQ/K5Wz
 E3gNpcnPbuU2SOEdPalaxfW7upXi/6gPrAIuw5eUsH5exXm0FWwdsCUtceHDV361YvPTa
X-Received: by 2002:a5d:6601:0:b0:314:10c1:881d with SMTP id
 n1-20020a5d6601000000b0031410c1881dmr14695943wru.68.1689030324611; 
 Mon, 10 Jul 2023 16:05:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLGDYaws/Ff7XvxQR59UaHqjo75ittUi8KRw9xhXJpHDN+3bA5l9ce2pAQXFxEBkvvTDOnjA==
X-Received: by 2002:a5d:6601:0:b0:314:10c1:881d with SMTP id
 n1-20020a5d6601000000b0031410c1881dmr14695926wru.68.1689030324408; 
 Mon, 10 Jul 2023 16:05:24 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 o18-20020a5d6712000000b003113ed02080sm565863wru.95.2023.07.10.16.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:23 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 62/66] vdpa: Accessing CVQ header through its structure
Message-ID: <45c4101828a483b87863f2e2ba6d98faf0ff7d92.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Hawkins Jiawei <yin31149@gmail.com>

We can access the CVQ header through `struct virtio_net_ctrl_hdr`,
instead of accessing it through a `uint8_t` pointer,
which improves the code's readability and maintainability.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <cd522e06a4371e9d6b8a1c1a86f90a92401d56e8.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f299e446b0..eee4b2a09e 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -934,6 +934,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
 {
     VhostVDPAState *s = opaque;
     size_t in_len;
+    const struct virtio_net_ctrl_hdr *ctrl;
     virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
     /* Out buffer sent to both the vdpa device and the device model */
     struct iovec out = {
@@ -949,7 +950,9 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                              s->cvq_cmd_out_buffer,
                              vhost_vdpa_net_cvq_cmd_len());
-    if (*(uint8_t *)s->cvq_cmd_out_buffer == VIRTIO_NET_CTRL_ANNOUNCE) {
+
+    ctrl = s->cvq_cmd_out_buffer;
+    if (ctrl->class == VIRTIO_NET_CTRL_ANNOUNCE) {
         /*
          * Guest announce capability is emulated by qemu, so don't forward to
          * the device.
-- 
MST



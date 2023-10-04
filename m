Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797D7B7ACF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYS-00041R-6C; Wed, 04 Oct 2023 04:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWr-0000bK-1V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWk-0002b5-DJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYiqXRxzTWfTn4i/+SBced8bQTg6zrqu/s2l3fD1Gks=;
 b=HqKXvF+Uoezemv/rRteCJl+DN07JrGkuIGXtBwmF9eV4iSie0R+65B9IYHaGNtTTb3SEtg
 4UcE0Ek/qqsulLUg9N/dIDGZezN0hu1a0LZ/+aSd3lTA3xHx+32P2XoGRow290PEIeEIBx
 xJ27sm9iAzCt++amjVRO4N+FtHHbbrg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-I_qaptONPg2bmSYiuo_wSA-1; Wed, 04 Oct 2023 04:46:20 -0400
X-MC-Unique: I_qaptONPg2bmSYiuo_wSA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5041a779c75so1746920e87.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409178; x=1697013978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYiqXRxzTWfTn4i/+SBced8bQTg6zrqu/s2l3fD1Gks=;
 b=GiHazpYci/teWmOjQNp2Tk9t2hZkuUIqRHr4bgbHgySkMnh7RAKhYowacsEX5qUZKr
 eqT0hX9Awn4HcNIfpN5mz4HV5XbIYvo3/R0hihKYYF9PjQROU/4iQdV51tPCCzkXMsar
 cKYfb8qw13tK+3qWFo5D/ITFBMoRjEL9tGx4/x94jLJXBCXkhiGbNA0B5O6+LAOEx8Rr
 Z1BWDfK0yR0Z+2Jiu9Kq0FO9C33NW2aylrv0GkoNGRUxEbfYPM7V9rnwJ3V7F9QcodnS
 3eVewhCnKsBECinjPvF7N5nkep15nsf1wnNAM14JBJDs+mS0fJROCbzkfnE933BDzzce
 Z/iA==
X-Gm-Message-State: AOJu0YzKq11LPfiCvxKlKbz6rU5eASbA5oqar53WsT7jXFj6sjKZF679
 FDK7mTE5P0cVmVmVe96MPGnzwcmTMcz0FvwRfcCDtDMZxyybNCp5e37g2torqadr8+RlZ6Z9Fz0
 Hbox1fsyXxj+K8PCQI5iZuC9XYgrymIzqQgyLqY4ZfemhAMM2nAJsc0AUzR6OsPZ4njtg
X-Received: by 2002:a05:6512:3246:b0:505:6fed:33a0 with SMTP id
 c6-20020a056512324600b005056fed33a0mr1271883lfr.34.1696409178265; 
 Wed, 04 Oct 2023 01:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrVqDNMw+SaXTODCfHft+/JifvNVCe5L/GgMyqLXJ/GnjIaShVyua1PgiDWNCXrMeSkIZa2Q==
X-Received: by 2002:a05:6512:3246:b0:505:6fed:33a0 with SMTP id
 c6-20020a056512324600b005056fed33a0mr1271874lfr.34.1696409178026; 
 Wed, 04 Oct 2023 01:46:18 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 l15-20020a1c790f000000b00404719b05b5sm932697wme.27.2023.10.04.01.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:17 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 58/63] virtio: remove unnecessary thread fence while reading
 next descriptor
Message-ID: <4cc182dbf5ad3947812e822cea04b804fccdee5d.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Ilya Maximets <i.maximets@ovn.org>

It was supposed to be a compiler barrier and it was a compiler barrier
initially called 'wmb' when virtio core support was introduced.
Later all the instances of 'wmb' were switched to smp_wmb to fix memory
ordering issues on non-x86 platforms.  However, this one doesn't need
to be an actual barrier, as its only purpose was to ensure that the
value is not read twice.

And since commit aa570d6fb6bd ("virtio: combine the read of a descriptor")
there is no need for a barrier at all, since we're no longer reading
guest memory here, but accessing a local structure.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Message-Id: <20230927140016.2317404-2-i.maximets@ovn.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2058b838e9..87e8f990c5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1060,8 +1060,6 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
 
     /* Check they're not leading us off end of descriptors. */
     *next = desc->next;
-    /* Make sure compiler knows to grab that: we don't want it changing! */
-    smp_wmb();
 
     if (*next >= max) {
         virtio_error(vdev, "Desc next is %u", *next);
-- 
MST



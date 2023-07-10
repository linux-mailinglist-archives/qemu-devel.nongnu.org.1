Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5F74E1F2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuZ-0004GS-Mj; Mon, 10 Jul 2023 19:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuX-00047F-9o
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuV-0004CV-Px
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4eiO06RfyYnB8FTG9kZaEZOiNvCWbZsGWdYJarnqlvs=;
 b=Bsd5arX3eu7gMx62XtS6Q7VNt2Xn5RSDgIEg1bzGL4QW2H+v8LK1UhuAKlb3MiB0TLLMVi
 d6hTxCS+JqAv7OmwkEX7rn8lU2q51/xhCHsNXrzndCaOHkdwjIwZEhaAgIzS+Rz09JjQ1J
 ePhubYYzXi08dJg6e2SfuUp5brL9tyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-9pEP3WGbPNuh9aBJIKc-zA-1; Mon, 10 Jul 2023 19:03:13 -0400
X-MC-Unique: 9pEP3WGbPNuh9aBJIKc-zA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbb0c01e71so30005525e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030192; x=1691622192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eiO06RfyYnB8FTG9kZaEZOiNvCWbZsGWdYJarnqlvs=;
 b=JC6oJlf2cZWq4GTiR1+Yj1+nGYK1uhGKO/TG1wm6FTUHNTJp3EnbT8NYfwF7m5le9j
 gthIFSCdlkK+Zr6QGmMowgjGF9UYgK5ubMzTLhnhijNOwUa2ZX+O9QO5JjVP0aCiVtw6
 WaKNmckl2FmO+XmqQarO6/C6ljXdbFREdB+dip0R35Spo82ORniLwTZ5xuMMcldB2CbK
 w+E7LrUp6K3gkkrwn4qD9b2NsKvD2fi0jjpNRZFuGkWCPoS/MosnhoSWHq0gyapM22D1
 UXlFIG5Kw1xLdAGkM6QJJ6/kqVbmzOCHOazfE9AfCgZaordXMTKUMGk2TcwVa+oOItXm
 leag==
X-Gm-Message-State: ABy/qLaDds1grltJwK6RDmyQR8rGyTlV0BtPY86cnnYCwVSVpgBhnh4T
 cE6RkbgBkab9aYGJe6cqYi2hIBSunMIqYtB9yxF9ecyc+oOk/t5/fD0JBkuAzTGm3vWiGSfmUQg
 HVyLoIM+tWuZCE3KYGZBFO4+RHjUWxftWjVofyvOfUcZJDEo80gOimIblUKraiocr8lhA
X-Received: by 2002:a05:600c:452:b0:3fc:7d2:e0c0 with SMTP id
 s18-20020a05600c045200b003fc07d2e0c0mr6867296wmb.27.1689030192304; 
 Mon, 10 Jul 2023 16:03:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG2lATBC1MNJUQb+P49RSfZUPLzk9CPD30+j7zl+//O5rQlOeS+v5ECppwe0azjKNCoDdgoSw==
X-Received: by 2002:a05:600c:452:b0:3fc:7d2:e0c0 with SMTP id
 s18-20020a05600c045200b003fc07d2e0c0mr6867282wmb.27.1689030192084; 
 Mon, 10 Jul 2023 16:03:12 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 q5-20020a1ce905000000b003fc07e1908csm899629wmc.43.2023.07.10.16.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:11 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Tom Lonergan <tom.lonergan@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PULL 16/66] vhost-user: Make RESET_DEVICE a per device message
Message-ID: <667e58aef1aa7a0294f635ef070c591efebf75c1.1689030052.git.mst@redhat.com>
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

From: Tom Lonergan <tom.lonergan@nutanix.com>

A device reset is issued per device, not per VQ. The legacy device reset
message, VHOST_USER_RESET_OWNER, is already a per device message. Therefore,
this change adds the proper message, VHOST_USER_RESET_DEVICE, to per device
messages.

Signed-off-by: Tom Lonergan <tom.lonergan@nutanix.com>
Message-Id: <20230628163927.108171-3-tom.lonergan@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 65d6299343..8dcf049d42 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -375,6 +375,7 @@ static bool vhost_user_per_device_request(VhostUserRequest request)
     case VHOST_USER_SET_MEM_TABLE:
     case VHOST_USER_GET_QUEUE_NUM:
     case VHOST_USER_NET_SET_MTU:
+    case VHOST_USER_RESET_DEVICE:
     case VHOST_USER_ADD_MEM_REG:
     case VHOST_USER_REM_MEM_REG:
         return true;
-- 
MST



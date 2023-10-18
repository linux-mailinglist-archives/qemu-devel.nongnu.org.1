Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3E7CE239
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8y5-0003ub-G7; Wed, 18 Oct 2023 12:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xt-0003aH-Hg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xr-0007pY-Gc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiiYhEn2+u0WRlW+XdV6xUMe7KHlpW6+J9WCJ40wsY8=;
 b=V8d5lcilz7WBpzpEBr+UFgG53xroF5xBht1u+yTSXEEfyuzho/DuBd0ui+QzmYEuKUWlzP
 WETW2MexJbIyoKrslP83Y5qd3tLbsuTVX+ToaX7JUK/NzvUMtQzKpEQ46MW9q4FV7ByQ/V
 uVj54Tq2+7VOlH/W/VOnb3PbDzU3WS0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-1BJL-xzWN1Okq1HdZfQyRQ-1; Wed, 18 Oct 2023 11:59:54 -0400
X-MC-Unique: 1BJL-xzWN1Okq1HdZfQyRQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-407558fe418so47214185e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644791; x=1698249591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiiYhEn2+u0WRlW+XdV6xUMe7KHlpW6+J9WCJ40wsY8=;
 b=MdNbTw7h/C2B17hzPvnpaYUQRW8H9sDX6FO7YCx5dGBfKxgqFkTjvHfhRHI4gtR6q5
 NCLLXt56i75mnVntui8WTiJZmwugl39Mb7J5ZHam++e20AEODaZlGwqWaucOXylN95Mc
 A2tJTv4aik3Wb+eUeDvlStOFX8vMjP8h/o3g1l/NzleWwEdUqcAUZGuT07FCKbTTHAaw
 sqxewCnOqJxRnXwAWAgHpZW91eV1SQCbxwCDgh9gAtEhjExZAcZkHkrWgwZQbMfoOFdt
 g88j2sYxY9Q4sFdbs9AaQcpH3C46R1SeskTKQNV+WsMuHZw8lO8HeURY3J3MKO55nXnu
 iNmw==
X-Gm-Message-State: AOJu0YyaLWFW88SmUyt83mBJBawAJT4vNAqXRetp7K8/nkc1qopk75RX
 MTx3evn83nlDzGmLUfMYtjKd+4gK2kvXjyNaBHxjSj6g20D1HcSdiG6/K6l22KW1T0IAcfrQ7rr
 P1NxFFrNMBqlOS8WBiZ4rjgg8SLxD8uBiMafn1WnoH+rvadPQv+hBtJ6MQwKMwlhve9OwER4=
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id
 q3-20020a05600c46c300b004075adc4497mr4403161wmo.9.1697644791313; 
 Wed, 18 Oct 2023 08:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCBNE6ahs0MfkCRU/T2kOXiCA/qfxDRNFscrUldC7EgTkk5rEjCk5DAZRC1FEGZixORG+2zA==
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id
 q3-20020a05600c46c300b004075adc4497mr4403141wmo.9.1697644790926; 
 Wed, 18 Oct 2023 08:59:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d4b44000000b003271be8440csm2385204wrs.101.2023.10.18.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 81/83] vhost-user: Fix protocol feature bit conflict
Message-ID: <7a71e4031156d9b0c3cdf34d4b48d5724da1eeec.1697644299.git.mst@redhat.com>
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

From: Hanna Czenczek <hreitz@redhat.com>

The VHOST_USER_PROTOCOL_F_XEN_MMAP feature bit was defined in
f21e95ee97d, which has been part of qemu's 8.1.0 release.  However, it
seems it was never added to qemu's code, but it is well possible that it
is already used by different front-ends outside of qemu (i.e., Xen).

VHOST_USER_PROTOCOL_F_SHARED_OBJECT in contrast was added to qemu's code
in 16094766627, but never defined in the vhost-user specification.  As a
consequence, both bits were defined to be 17, which cannot work.

Regardless of whether actual code or the specification should take
precedence, F_XEN_MMAP is already part of a qemu release, while
F_SHARED_OBJECT is not.  Therefore, bump the latter to take number 18
instead of 17, and add this to the specification.

Take the opportunity to add at least a little note on the
VhostUserShared structure to the specification.  This structure is
referenced by the new commands introduced in 16094766627, but was not
defined.

Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
       ("vhost-user: add shared_object msg")
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016083201.23736-1-hreitz@redhat.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user.h            |  3 ++-
 subprojects/libvhost-user/libvhost-user.h |  3 ++-
 docs/interop/vhost-user.rst               | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 6b06ecb1bd..20b69d8e85 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index b36a42a7ca..c2352904f0 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -65,7 +65,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 415bb47a19..768fb5c28c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -275,6 +275,16 @@ Inflight description
 
 :queue size: a 16-bit size of virtqueues
 
+VhostUserShared
+^^^^^^^^^^^^^^^
+
++------+
+| UUID |
++------+
+
+:UUID: 16 bytes UUID, whose first three components (a 32-bit value, then
+  two 16-bit values) are stored in big endian.
+
 C structure
 -----------
 
@@ -885,6 +895,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
 
 Front-end message types
 -----------------------
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867567D016F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXi9-000283-U4; Thu, 19 Oct 2023 14:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhL-0000RR-RB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhJ-00035A-Vk
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiiYhEn2+u0WRlW+XdV6xUMe7KHlpW6+J9WCJ40wsY8=;
 b=IhENSOGSlFfBjvBRbsH7Qq+KKYl22jyitcHyJhiH56McW6SMdqfLj8Y5r9oQg8x+py4HDc
 xo2fnD22BIdaj70FAjUYXkAMmh7rAzofY4fD+VMpV7Nbk4iA97GP5TVE0NRsTyaMrXjqYh
 yjPdnf2i5d05/YHEz0+aMvrHT1Ljsgk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ttuAx4hRPSmIeItgXEafGg-1; Thu, 19 Oct 2023 14:24:40 -0400
X-MC-Unique: ttuAx4hRPSmIeItgXEafGg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c50c873604so63518281fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739876; x=1698344676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiiYhEn2+u0WRlW+XdV6xUMe7KHlpW6+J9WCJ40wsY8=;
 b=E/MurndYWbI5wSMYJJNQpTJkBI0v7tnxUa/Thn7xhwSjMZAALKiaETREFajCyHKaIe
 eZSTEpB74Qq0Tn0AeY/+GkertN1GecRw4PYqDSC0Zc5msEBcE9eN6gFiJerU74XXoBSE
 9cEIev/ePJ32i+7ZgweFP/4J92Y6yk+qbu5FPFGE4DatUhp6aBf1mMGqaV9chIAPXS+E
 FFapjMmB71n0dibuyg5TH3+89cYmCsZXsg4lD0kzf9skGDrhY8ahoaK7GtvjisVyyAoc
 YaqIrXChV88LoqEahsbImiINdPt+T/I14JoEbfr7UN7RHWMdksu3VzZ14wqkmL38ITj+
 Oc6Q==
X-Gm-Message-State: AOJu0Yz3L+ZfYhw5wdN2wZ4TxbSB7163ESJA3F2ha8uaWvWXh6od+R5J
 sD7+/6IX+sWekX/fY6B6o1M9oVqFohTrxfFDLjXvFtcVrUyAyO34yFMNkCuWptFO/ZxW7KdOjOe
 LbpwDL/REDNJEuL+553UiSsMFcdQah9vG+DYL/QOeqGtUna3S8F9dfWs4uMAA2SvooBJ+
X-Received: by 2002:a05:651c:4d2:b0:2c5:2103:604b with SMTP id
 e18-20020a05651c04d200b002c52103604bmr2841702lji.2.1697739876492; 
 Thu, 19 Oct 2023 11:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE56vj/IBSgtlmlaDLX8b/xNaNsfQMGr3z1RNacBBUdU0i3mpknJNanXKiQY2BLMHHJjyLKlQ==
X-Received: by 2002:a05:651c:4d2:b0:2c5:2103:604b with SMTP id
 e18-20020a05651c04d200b002c52103604bmr2841679lji.2.1697739876157; 
 Thu, 19 Oct 2023 11:24:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a5d4445000000b0032ddc3b88e9sm1894591wrr.0.2023.10.19.11.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:35 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 76/78] vhost-user: Fix protocol feature bit conflict
Message-ID: <b106c85080e3d31347af49db4acd4ba79d9dfc0c.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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



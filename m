Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0B97D223C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUkF-00022B-KE; Sun, 22 Oct 2023 05:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjW-0001Y6-Rj
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjV-00015p-A1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiiYhEn2+u0WRlW+XdV6xUMe7KHlpW6+J9WCJ40wsY8=;
 b=R1p088XTg2m+ozVw6GWgY75BwcjpPQpAT5acNzLnI0K45nJ51YfFaMAr9D2LM+9ZaOf18U
 pAWv+WSJ0gANgCXQfWZLDMo2RQzqoi/0/WubEGxKNa0CAahHC0X6cgXjM7jsqJ1eca0OCP
 3tFUawj0ENB4zAC/PzqI9zYBXh1staw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-nlnH1AGANuu628hz-SF-Zg-1; Sun, 22 Oct 2023 05:26:49 -0400
X-MC-Unique: nlnH1AGANuu628hz-SF-Zg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084001846eso16051535e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966807; x=1698571607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiiYhEn2+u0WRlW+XdV6xUMe7KHlpW6+J9WCJ40wsY8=;
 b=MPXiFov74vzNgZqrHKyGg8E/ynMAi/vuNg5YsKgmjWNEcUN8buu506rWvS78XSgker
 j1MV+9p+0oc1XVWt0os5nyr4hZafhe3iJEfxla5+GUa7zSBjwGTdScHwiJJ+KsrfrnEI
 EKuVhm/O+jxvIwwK/Td4GY/5sj1festSw86k5hpW7qJnptJEzFm6DHJBbcsyVSM7i24j
 1HUcl1dwRSO3ys2mKCYGNkhlDA+mK8WMbmDTEdjQywLf2kTJeD1PNPkEAyP1YgLbBvmW
 1/lKgwrHylxy9bgQW//EaLTkkOqmI16HyaB5DCVvms5dperOgW3alQ3b3ZuwKjqTK3ci
 fLUQ==
X-Gm-Message-State: AOJu0Yys/bPKby/51rOVqihO6oL6DJeE7noFNwYWYfhfOQS/GzA8j78s
 FlIEsZz70OGmLN3iw0qYwepmEde6XLx1T+v/qJFjWLJhC4nNSqV7ARM6cAUHtRALlkiKqx4XfQ2
 cAQ3g9vaczDFJsFFVc6ijolHO8TS8t5JdKWD4+nPHkKzqXRumMRjyaQ6W4QpJt5gVMUak
X-Received: by 2002:a05:600c:1396:b0:404:7659:ba39 with SMTP id
 u22-20020a05600c139600b004047659ba39mr4678840wmf.16.1697966806754; 
 Sun, 22 Oct 2023 02:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8zbPNMayJKl8tvT/npUyJbDR2TuzzXgI0zHSudEtbPTBPv7EeRQe02JLwlICY6yH0VkMd3w==
X-Received: by 2002:a05:600c:1396:b0:404:7659:ba39 with SMTP id
 u22-20020a05600c139600b004047659ba39mr4678823wmf.16.1697966806351; 
 Sun, 22 Oct 2023 02:26:46 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b004064288597bsm6529722wmq.30.2023.10.22.02.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:45 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:26:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v3 60/62] vhost-user: Fix protocol feature bit conflict
Message-ID: <d4eb50380807f5e881cbb66630f210e3e6eb9750.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


